"
NOT IMPLEMENTED YET NEW FEATURE
"
Class {
	#name : #MlCArray,
	#superclass : #MlArray,
	#category : #'Ml4St-Core'
}

{ #category : #'binary operations' }
MlCArray >> adaptSizeOfArray: anArray [ 
	| tr sameRows sameColumns newArray |
	anArray size = self size ifTrue:[^ anArray internalArray].
	"rules for broadcasting"

	sameRows := self isMultidimensional  & anArray isMultidimensional 
							ifTrue:[ self length = anArray length ] 
							ifFalse:[ self size = anArray size ].
	sameColumns := (self width = anArray width) | (anArray size = 1).
	
	(sameRows | sameColumns) ifFalse:[ MlShapeError signal:('Array ' ,anArray asString ,' could not be broadcasted') ].
	tr := self size / anArray size.
	(sameColumns) ifTrue:[ newArray := MlArrayRepeatedVector  newFrom:anArray internalArray timesRepeat:tr ].
	(sameColumns not & sameRows) ifTrue:[ newArray := MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ].
	^ newArray
	
]

{ #category : #'private-slicing' }
MlCArray >> getAdressesIntervalsOf:slices level: l list: lklst indexes: indexes [ 
	| si ei currentSlice nextLevel |

	(l = self nDim) | self isOneDimensional   
		ifTrue: [ 
			(slices at:l) isArray
			ifTrue:[
					(slices at:l) do:[ :each|
						lklst at:l put: (each first).
						si := (self getAddressForPoint: lklst asArray).
						lklst at:l put: (each last).
						ei:= (self getAddressForPoint: lklst asArray).
						indexes add: (si to:ei by:(each increment )) ] ]
			ifFalse:[
					lklst at:l put: ((slices at:l) first).
					si := (self getAddressForPoint: lklst asArray).
					lklst at:l put: ((slices at:l) last).
					ei:= (self getAddressForPoint: lklst asArray).
					indexes add: (si to:ei by:((slices at:l) increment )) ] ]
		ifFalse:[
			currentSlice := (slices at:l).
			currentSlice isInterval ifTrue:[	
				currentSlice do:[:e|
					lklst at:l put: e.
					nextLevel := l + 1.
					self getAdressesIntervalsOf: slices  level: nextLevel list: lklst  indexes: indexes ] ].
			currentSlice isArray ifTrue:[
					currentSlice do:[:each|
						"each one shoud be an interval"
						each do:[ :eachVal | 
							lklst at:l put: eachVal.
							nextLevel := l + 1.
							self getAdressesIntervalsOf: slices  level: nextLevel  list: lklst  indexes: indexes ] ] ] ]
		
	
]

{ #category : #'private-slicing' }
MlCArray >> getAdressesIntervalsOfSlices: slice [
	
	| list indexes |
	list := Array new: self nDim.
	indexes := SortedCollection new.
	indexes sortBlock:[ :a :b | a first < b first ].

	self
		getAdressesIntervalsOf: slice
		level: 1
		list: list
		indexes: indexes.
	^ indexes
]

{ #category : #'private-slicing' }
MlCArray >> jumpToNextBlockInAxis: axis [
	"called only by #concatArrays:  aMlArraysCollection axis: standarAxisNumber..."
	^ self weightOfAxis: axis-1
]

{ #category : #'private-slicing' }
MlCArray >> reduce: aSymbol axis: anAxis arguments: args [
	"Execute a reduce function (mean,max... all values from an axis to one) 
	aSymbol is the operation, anAxis, the axis, args an array with the arguments for the method
	aClass is the  "
	| axis results newShape instance realAxis|
	realAxis := self getAxisNumberFromStandard: anAxis.
	axis := self getAxisToFoldFromStandard: anAxis. 
	(axis > self nDim)|( axis < 1 )ifTrue:[ MlShapeError signal:'Axis is higher than nDim']. 

	"the operation 'aSymbol' should reduce the collection to 1, i.e. mean, std..."
	results := OrderedCollection new.

	self walkWhile:[:l :s| axis >1 ifTrue:[l < (axis -1)] ifFalse:[false]]
		when: [:l :s| (s at:realAxis)=1 ]  
		do:[:l :s| 
		| slice array|
		slice := s deepCopy.
		realAxis to: self nDim do:[:i| slice at:i put:_@_].
		1 to: (self shape at:axis)  do:[:s2|
			slice at:axis put: s2.
			array:=  self slice: slice.
			results  add:( array internalArray perform: aSymbol withEnoughArguments: args)]].
	
	newShape := OrderedCollection newFrom:self shape .
	(axis < (self nDim -1)) 
		ifTrue: [ (self nDim - axis) timesRepeat:[ newShape removeLast] ] 
		ifFalse: [newShape removeAt: realAxis]. 
	instance := self class new shape: newShape;order:#C.
	instance internalArray:results asArray.
	instance labelsDict: self labelsDict deepCopy.
	^ (self order = #C) ifTrue:[instance] ifFalse:[instance asFortranArray] 
]

{ #category : #accessing }
MlCArray >> sliceForAddress: anInteger [
	| linearIndex tmpIndex blockWeight loop blocksize |
	"the loop should be from the slower changing axis to the faster changing axis"
	linearIndex := anInteger - 1.
	
	tmpIndex := (self nDim = 1 )
			ifTrue:[linearIndex + 1] 
			ifFalse:[
				tmpIndex := Array new: self nDim withAll:0.
				loop := 1 to: self nDim.
				loop do:[:i|
					blockWeight := (self weightOfAxis:i).
					blocksize := (linearIndex / blockWeight) asInteger.
					tmpIndex at:i put:blocksize .
					linearIndex := linearIndex  - (blocksize * blockWeight)].
					tmpIndex + 1.
				].

	^tmpIndex
]

{ #category : #accessing }
MlCArray >> transposed [
	|instance|
	instance := self asFortranArray order:#C.
	self nDim >1 
		ifTrue:[
			instance shape: (self switchShapeOrder: self shape).
			instance labelsDict at:2 put:(self labelsDict first).
			instance labelsDict at:1 put:(self labelsDict at:2).]
		ifFalse:[
			instance reshape: {instance size. 1}.
			instance labelsDict:nil.
			instance labelsDict at:2 put:(self labelsDict first).].
	
	^ instance

]

{ #category : #accessing }
MlCArray >> weightOfAxis: anAxis [
	| w |
	"the weigth means the number of elements we have to jump in the internal vector to get next element in the same axis"
	"In #F order, if anAxis is the last axis weight is the product of all of the inner axis length, otherwise weight is the product of all of the outer axes.
	In #C order weight is always the product of all of the outer axes"	
	anAxis < 1 ifTrue:[^ self size].
	"one dimension so weight for any axis is 1"
	self nDim = 1 ifTrue:[ ^ 1 ]. 
	"look in the cache"
	(self weightOfAxesAt: anAxis) ifNotNil:[^ (self weightOfAxesAt: anAxis)].
	anAxis = self nDim 
		ifTrue:[ ^ 1 ]
		ifFalse:[ w:= (anAxis +1 to: self nDim) inject:1 into:[ :mul :e | mul * (self shape at:e) ] ].
	self weightOfAxesAt: anAxis put:w.
	^ w

]
