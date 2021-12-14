"
NOT IMPLEMENTED YET NEW FEATURE
"
Class {
	#name : #MlFArray,
	#superclass : #MlArray,
	#category : #'Ml4St-Core'
}

{ #category : #'binary operations' }
MlFArray >> adaptSizeOfArray: anArray [ 
	| tr sameRows sameColumns newArray |
	anArray size = self size ifTrue:[^ anArray internalArray].
	"rules for broadcasting"
	
	tr := self size / anArray size.
	sameRows := self nDim >1 & (anArray nDim > 1)
							ifTrue:[self length = anArray length ] 
							ifFalse:[self size = anArray size].
	sameColumns := (self width = anArray width) | (anArray size = 1).
	
	(sameRows | sameColumns) ifFalse:[MlShapeError signal:('Array ' ,anArray asString ,' could not be broadcasted')].
	(sameColumns) ifTrue:[newArray:=MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ].
	(sameColumns not & sameRows) ifTrue:[newArray:=MlArrayRepeatedVector newFrom:anArray internalArray timesRepeat:tr ].
	^ newArray
	
]

{ #category : #'binary operations' }
MlFArray >> getAdressesIntervalsOf:slices level: l list: lklst indexes: indexes [ 
	| si ei currentSlice nextLevel |

	(((l = (self nDim - 1)) & (self order = #F)) |
		(self nDim = 1) ) 
		ifTrue: [ 
			(slices at:l) isArray
			ifTrue:[
					(slices at:l) do:[:each|
						lklst at:l put: (each first).
						si := (self getAddressForPoint: lklst asArray).
						lklst at:l put: (each last).
						ei:= (self getAddressForPoint: lklst asArray).
						indexes add: (si to:ei by:(each increment ))]]
			ifFalse:[
					lklst at:l put: ((slices at:l) first).
					si := (self getAddressForPoint: lklst asArray).
					lklst at:l put: ((slices at:l) last).
					ei:= (self getAddressForPoint: lklst asArray).
					indexes add: (si to:ei by:((slices at:l) increment ))]]
		ifFalse:[
			currentSlice := (slices at:l).
			currentSlice isInterval ifTrue:[	
				currentSlice do:[:e|
					lklst at:l put: e.
					
					nextLevel := 	((l + 2) = self nDim ) 
												ifTrue:[ l + 2] 
												ifFalse:[((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]].
					
					self getAdressesIntervalsOf: slices  level: nextLevel list: lklst  indexes: indexes.
					]].
			currentSlice isArray ifTrue:[
					currentSlice do:[:each|
						"each one shoud be an interval"
						each do:[:eachVal|
							lklst at:l put: eachVal.
							nextLevel := ((l + 2) = self nDim ) ifTrue:[ l + 2] ifFalse:[
											((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]].
					
							self getAdressesIntervalsOf: slices  level: nextLevel  list: lklst  indexes: indexes.
							]]]
			]
		
]

{ #category : #'binary operations' }
MlFArray >> getAdressesIntervalsOfSlices: slice [
	
	| list indexes startLevel |
	list := Array new: self nDim.
	indexes := SortedCollection new.
	indexes sortBlock:[:a :b| a first < b first].
	startLevel := (self nDim ~= 2)
		ifTrue: [ 1 ]
		ifFalse: [ 2 ].
	self
		getAdressesIntervalsOf: slice
		level: startLevel
		list: list
		indexes: indexes.
	^ indexes
]

{ #category : #'binary operations' }
MlFArray >> jumpToNextBlockInAxis: axis [
	"called only by #concatArrays:  aMlArraysCollection axis: standarAxisNumber..."
	^ (self weightOfAxis: axis) * (self shape at:axis)
]

{ #category : #'binary operations' }
MlFArray >> reduce: aSymbol axis: anAxis arguments: args [
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
		| slide array|
		slide := s deepCopy.
		realAxis to: self nDim do:[:i| slide at:i put:_@_].
		1 to: (self shape at:axis)  do:[:s2|
			slide at:axis put: s2.
			array:=  self slice: slide.
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

{ #category : #'binary operations' }
MlFArray >> sliceForAddress: anInteger [
	| linearIndex tmpIndex blockWeight loop blocksize |
	"the loop should be from the slower changing axis to the faster changing axis"
	linearIndex := anInteger - 1.
	
	tmpIndex := (self nDim = 1 )
			ifTrue:[linearIndex + 1] 
			ifFalse:[
				tmpIndex := Array new: self nDim withAll:0.
				loop := {self nDim} , (1 to:(self nDim -1)).
				loop do:[:i|
					blockWeight := (self weightOfAxis:i).
					blocksize := (linearIndex / blockWeight) asInteger.
					tmpIndex at:i put:blocksize .
					linearIndex := linearIndex  - (blocksize * blockWeight)].
					tmpIndex + 1.
				].

	^tmpIndex
]

{ #category : #'binary operations' }
MlFArray >> transposed [
	|instance|
	self order = #F ifTrue:[instance := self asCArray order:#F].
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

{ #category : #'binary operations' }
MlFArray >> weightOfAxis: anAxis [
	| w |
	"the weigth means the number of elements we have to jump in the internal vector to get next element in the same axis"
	"In #F order, if anAxis is the last axis weight is the product of all of the inner axis length, otherwise weight is the product of all of the outer axes.
	In #C order weight is always the product of all of the outer axes"

	
	anAxis < 1 ifTrue:[^ self size].
	"one dimension so weight for any axis is 1"
	self nDim = 1 ifTrue:[^ 1]. 
	(self weightOfAxesAt: anAxis) ifNotNil:[^ (self weightOfAxesAt: anAxis)].
	anAxis = (self nDim - 1) ifTrue:[^ 1]. "column dim weight is 1"
	w := anAxis = self nDim 
			ifTrue:[ (1 to: anAxis -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]]
			ifFalse:[ (anAxis +1 to: self nDim -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]].
	self weightOfAxesAt: anAxis put:w.
	^ w

]
