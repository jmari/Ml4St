"
I am a structure of array based on numpy Arrays.
I can slice do a lot of usefull operations for machine learning.

"
Class {
	#name : #MlArray,
	#superclass : #Object,
	#instVars : [
		'internalArray',
		'shape',
		'order',
		'dType',
		'labelsDict',
		'maxElementsToPrint',
		'index'
	],
	#classInstVars : [
		'shape',
		'plainCollection'
	],
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlArray class >> checkClassForAllElementsIn: aCollection [ 
	| firstClass |
	
	firstClass := aCollection first class.
	aCollection do:[:e| e class = firstClass ifFalse:[^false]].
	^ true
]

{ #category : #'instance creation' }
MlArray class >> detectTypeOf:aCollection [ 
	|col parent firstRowIsSameKind  firstCol firstColIsSameKind |
	aCollection isEmpty ifTrue:[^Float].
	parent := col := aCollection.
	[ self isNotACollection: col first ] whileFalse:[
		parent := col.
		col := col first].
	firstRowIsSameKind := (self checkClassForAllElementsIn: col ).
	(parent = col) 
	ifTrue:[firstColIsSameKind := true]
	ifFalse:[
		firstCol := parent collect:[:e| e first].
		firstColIsSameKind := ((self checkClassForAllElementsIn: firstCol ) & (firstCol first species = col first species )) ].
	
	^(firstRowIsSameKind  &
	firstColIsSameKind)
	ifTrue:[col first species name]
	ifFalse:[Object name]
	


]

{ #category : #'instance creation' }
MlArray class >> from: aCollection [
	^ self from: aCollection order:#F dType: (self detectTypeOf:aCollection) .
]

{ #category : #'instance creation' }
MlArray class >> from: aCollection dType: dType [
	^ self from: aCollection order: #F dType: dType
]

{ #category : #'instance creation' }
MlArray class >> from: aCollection order: CorF [
	^ self from: aCollection order: CorF dType: (self detectTypeOf:aCollection)
]

{ #category : #'instance creation' }
MlArray class >> from: aCollection order: CorF dType: dType [
	| shapeAndPlainCollection instance |
	aCollection isEmpty ifTrue:[ ^ self new:#()].
	shapeAndPlainCollection := self getShapeAndPlainCollectionOf: aCollection.
	instance := self new: (shapeAndPlainCollection at:1) order:CorF dType:dType.
	CorF = #C ifTrue:[self initializeInCStyle:instance 
									shape:(shapeAndPlainCollection at:1) 
									plainCollection:(shapeAndPlainCollection at:2)].
	CorF = #F ifTrue:[self initializeInFStyle:instance 
									shape:(shapeAndPlainCollection at:1)
									plainCollection:(shapeAndPlainCollection at:2)].

	^ instance
]

{ #category : #'as yet unclassified' }
MlArray class >> getRShapeAndPlainCollectionOf: aCollection level:l [

	(self isNotACollection:(aCollection at:1))
		ifTrue:[ plainCollection addAll: aCollection.
					shape at:l put: ((shape at:l ifAbsentPut:0) < aCollection size ifTrue:[aCollection size] ifFalse:[shape at:l]) ]
		ifFalse:[ 
			shape at:l put: ((shape at:l ifAbsentPut:0) < aCollection size ifTrue:[aCollection size] ifFalse:[shape at:l]).
			aCollection do:[:col|
				self getRShapeAndPlainCollectionOf: col level:( l+1)]]

]

{ #category : #'as yet unclassified' }
MlArray class >> getShapeAndPlainCollectionOf: aCollection [ 
	|  |
	shape := OrderedDictionary new.
	plainCollection := OrderedCollection new.
	self getRShapeAndPlainCollectionOf: aCollection level:1.
	^ Array with: shape values with: plainCollection.
	
]

{ #category : #'instance creation' }
MlArray class >> initialize [ 
	Smalltalk at:#_ put: nil.

]

{ #category : #'instance creation' }
MlArray class >> initializeFromFStyle: instance shape: aShape plainCollection: aPlainCollection [
	|  jump i |
	instance shape: aShape.
	jump := (instance shape copyFrom:1 to:(instance shape size -1)) inject:1 into:[:e :m| e*m].
	i:=0.
	1 to:jump do:[:j|
		((j) to: (j+ instance size -1) by: jump) do:[:index|
			instance internalArray at: (i+1) put: (aPlainCollection at: ((index -1)\\ (instance size ))+1).
			i:=i+1]].

	instance order:#C
]

{ #category : #'instance creation' }
MlArray class >> initializeInCStyle: instance shape: aShape plainCollection: aPlainCollection [
	1 to: instance internalArray size do:[:i| instance internalArray at:i put: (aPlainCollection at:i)].
	instance order:#C
]

{ #category : #'instance creation' }
MlArray class >> initializeInFStyle: instance shape: aShape plainCollection: aPlainCollection [
	|index |

	index:=1.
	0 to: (aShape last -1 ) do:[:i|
		(1 to: aPlainCollection size by: aShape last) do:[:j|
			instance internalArray at:index put: (aPlainCollection at:(j+i)).
			index := index + 1]].

	instance shape: aShape.
	instance order:#F
]

{ #category : #testing }
MlArray class >> isNotACollection: anObject [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	^  (anObject isCollection not) | (anObject isKindOf: String) 
]

{ #category : #'instance creation' }
MlArray class >> new: aShape [
	^ self new: aShape order:#F dType: #Float
]

{ #category : #'instance creation' }
MlArray class >> new: aShape dType:dType [
	^ self new: aShape order: #F dType: dType
]

{ #category : #'instance creation' }
MlArray class >> new: aShape order:CorF [
	^ self new: aShape order: CorF dType: #Float
]

{ #category : #'instance creation' }
MlArray class >> new: anIntOrArray order: CorF dType: dataType [
	|instance size aShape |
	aShape := anIntOrArray isNumber ifTrue:[{anIntOrArray}] ifFalse:[anIntOrArray].
	instance := self new.
	size := aShape inject:1 into:[:m :e| m*e].
	instance internalArrayOfType: dataType size:size.
	instance shape: aShape.
	instance order: CorF.
	^ instance
]

{ #category : #'instance creation' }
MlArray class >> ones: aShape [
	^ self shape: aShape fillWith: 1.0
]

{ #category : #'instance creation' }
MlArray class >> random: aShape [ 
	^  self random: aShape seed: Time now asMilliSeconds.
]

{ #category : #'instance creation' }
MlArray class >> random: aShape seed: aSeed [
	| instance generator  |
	instance := self new: aShape.
	generator := Random new seed:aSeed.
	1 to: instance size do:[:i|  instance internalArray at: i put: ((100 atRandom: generator) / 100 ) asFloat ].
	instance dType: #Float.
	^instance
]

{ #category : #'instance creation' }
MlArray class >> shape: aShape fillWith: anObject [
	|instance |

	instance := self new: aShape dType: anObject class name.
	instance fillWith: anObject.
	^ instance
]

{ #category : #'instance creation' }
MlArray class >> zeros: aShape [
	^ self shape: aShape fillWith: 0.0
]

{ #category : #'math functions' }
MlArray >> & aMlArray [
	| newInstance zip |
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray  
		ifTrue:[
			zip := MlZipper on: {self internalArray.  (self adaptSizeOfArray:(aMlArray ))}.
			newInstance internalArray:  (zip collect:[:row| row first & row last]).
			newInstance ]
		ifFalse:[
			newInstance internalArray: (self internalArray & (self adaptSizeOfArray:(aMlArray ))) .
			newInstance]
]

{ #category : #'math functions' }
MlArray >> * aMlArray [
	^ self performBinaryOp: #* on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> *= aMlArray [
	^ self performBinaryOp: #*= on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> + aMlArray [
	^ self performBinaryOp: #+ on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> += aMlArray [
	^ self performBinaryOp: #+= on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> , aMlArray [
	^ self concat: aMlArray axis: 0
]

{ #category : #'math functions' }
MlArray >> - aMlArray [
	^ self performBinaryOp: #- on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> -= aMlArray [
	^ self performBinaryOp: #-= on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> / aMlArray [
	^ self performBinaryOp: #/ on: aMlArray  
]

{ #category : #'math functions' }
MlArray >> /= aMlArray [
	^ self performBinaryOp: #/= on: aMlArray  
]

{ #category : #comparing }
MlArray >> < aNumber [
	^ self select:[:e| e< aNumber]
]

{ #category : #piping }
MlArray >> <- aMlArray [
	self shape = aMlArray shape ifFalse:[MlShapeError signal].
	self internalArray replaceFrom: 1 to: self size with: aMlArray internalArray  startingAt: 1 
]

{ #category : #piping }
MlArray >> << aTransformer [
	^ aTransformer inverseTransform: self.
]

{ #category : #comparing }
MlArray >> <= aNumber [
	^ self select:[:e| e<= aNumber]
]

{ #category : #comparing }
MlArray >> = aMlArrayOrNumber [
	^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isString) 
		ifTrue:[self select:[:e| e = aMlArrayOrNumber] ]
		ifFalse:[self internalArray = aMlArrayOrNumber internalArray and:[self order = aMlArrayOrNumber order and:[self shape= aMlArrayOrNumber shape]] ]
]

{ #category : #comparing }
MlArray >> > aNumber [
	^ self select:[:e| e> aNumber]
]

{ #category : #comparing }
MlArray >> >= aNumber [
	^ self select:[:e| e>= aNumber]
]

{ #category : #piping }
MlArray >> >> aTransformer [
	^ aTransformer fitAndTransform: self.
]

{ #category : #'math functions' }
MlArray >> \\= aMlArray [
	| newInstance |
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray   
		ifTrue:[
			newInstance internalArray: self internalArray \\= aMlArray internalArray.
			newInstance]
		ifFalse:[
			newInstance internalArray: self internalArray \\= aMlArray.
			newInstance]
]

{ #category : #'reduce operations' }
MlArray >> abs [ 
	^ self collect:[:e| e abs]
]

{ #category : #'reduce operations' }
MlArray >> accuracy: aMlArray [
	^ aMlArray isMlArray   
		ifTrue:[self internalArray accuracy: aMlArray internalArray]
		ifFalse:[self internalArray accuracy: aMlArray ]
]

{ #category : #'private-converting' }
MlArray >> adaptData: anObject for:newArrayType [
	newArrayType = Array  ifTrue:[ ^ anObject].
	^ newArrayType = FloatArray  
			ifTrue:[ anObject asFloat]
			ifFalse:[ anObject asInteger]
]

{ #category : #'math functions' }
MlArray >> adaptSizeOfArray: anArray [ 
	| tr sameRows sameColumns newArray |
	anArray size = self size ifTrue:[^ anArray internalArray].
	"rules for broadcasting"
	
	tr := self size / anArray size.
	sameRows := self nDim >1 & (anArray nDim > 1)
							ifTrue:[(self shape at:( self nDim-1)) = (anArray shape at:( anArray nDim-1))  ] 
							ifFalse:[self size = anArray size].
	sameColumns := self shape last = anArray shape last.
	
	(sameRows | sameColumns) ifFalse:[MlShapeError signal].
	self order = #F 
		ifTrue:[ 
			(sameColumns) ifTrue:[newArray:=MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ].
			(sameColumns not & sameRows) ifTrue:[newArray:=MlArrayRepeatedVector newFrom:anArray internalArray timesRepeat:tr ]]
	 	ifFalse:[ 
			(sameColumns)  ifTrue:[newArray:=MlArrayRepeatedVector  newFrom:anArray internalArray timesRepeat:tr ].
			(sameColumns not & sameRows) ifTrue:[newArray:=MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ]].
	^ newArray
	
]

{ #category : #converting }
MlArray >> addDimension [
	self shape: ({1} , self shape) 


]

{ #category : #converting }
MlArray >> addDimensionAtEnd [
	self shape: (self shape,{1}) 


]

{ #category : #enumerating }
MlArray >> allSatisfy: aBlock [ 
	^ self internalArray allSatisfy:aBlock.
]

{ #category : #enumerating }
MlArray >> anySatisfy: aBlock [ 
	^ self internalArray anySatisfy:aBlock.
]

{ #category : #'math functions' }
MlArray >> applyBooleanFilter: aBooleanMlArray on: axis [
	| ratio instance |
	
	instance := self performBinaryOp: #applyBooleanFilter: on: aBooleanMlArray.
	ratio := instance size / self size.
	instance shape at:axis put:( (self shape at:axis) * ratio).
	^ instance 
]

{ #category : #accessing }
MlArray >> arrayType [ 
	^ self internalArray bufferSpecies name
]

{ #category : #converting }
MlArray >> as1DArray [
	^ self internalArray 
]

{ #category : #converting }
MlArray >> asCArray [
	| newInstance  |
	order = #C ifTrue:[^self].
	newInstance := self newInstanceLikeMe.
	self class initializeFromFStyle: newInstance shape: self shape plainCollection: self internalArray.
	^ newInstance
]

{ #category : #converting }
MlArray >> asFortranArray [
	| newInstance |
	order = #F ifTrue:[^self].
	self nDim = 1 ifTrue:[^ self order:#F].
	newInstance := self newInstanceLikeMe.
	self class initializeInFStyle: newInstance shape: self shape plainCollection: self internalArray.
	^ newInstance
]

{ #category : #converting }
MlArray >> asMlArray [
	^  self
]

{ #category : #converting }
MlArray >> asSlices [
	| slices lastBool start end |
	slices := OrderedCollection new.
	lastBool := true.
	self internalArray doWithIndex:[:each : i|
		each not & lastBool ifTrue:[start := i].
		each  & (lastBool not) ifTrue:[end := i. slices add: start@end].
		lastBool := each].
	^ slices
	
]

{ #category : #converting }
MlArray >> asSparseMatrix [
	^ SVMSparseMatrix fromMlArray: self
]

{ #category : #converting }
MlArray >> asString [
	^ self printString
]

{ #category : #accessing }
MlArray >> at: anObject [
	| address anArrayOfInt |
	"nil returns exception"
	anObject ifNil:[MlIndexTypeError signal].
	"aBlock returns a boolean MlArray of execution of eval 
	 over the internal array, we can not know the shape of the execution..."
	anObject isBlock ifTrue:[^ self eval:anObject].
	"if nDim = 1 an array is a slice"
	
	anArrayOfInt := (self nDim = 1 & (anObject isArray)  
								and:[anObject notEmpty and:[anObject first isArray not]]) 
										ifTrue:[	{anObject}]
										ifFalse:[ anObject ].
	"if it is not an array, enclose in an array, "									
	anArrayOfInt := anArrayOfInt isArray 
										ifTrue:[anArrayOfInt]
										ifFalse:[	{anArrayOfInt}].
											
	"substitute labels by indexes"										
	anArrayOfInt := self changeLabelsByIndexes: anArrayOfInt.
	"if the array contain a slices we do slice"
	(self isAnArrayOfSlices: anArrayOfInt) 
		ifTrue:[^ self slice: anArrayOfInt]
		ifFalse:[
			"changes -1 by the last element"
			anArrayOfInt := anArrayOfInt collectWithIndex:[:e :i| e < 0 ifTrue:[(self shape at:i) + e + 1] ifFalse:[e]].
			(self validateAddress: anArrayOfInt) ifFalse:[MlShapeError signal:'Position is not valid for this shape']. "get the address in the 1D internalArray"
			address := self getAddressForPoint:anArrayOfInt.
			^ self internalArray at:address]
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 [
	^ self at:{int1. int2.}
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 [ 
	^ self at:{int1. int2. int3.} 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 at:int4 [
	^ self at:{int1. int2. int3. int4} 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 at:int4 put: aValue [
	^ self at:{int1. int2. int3. int4} put:aValue 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 put:aValue [
	^ self at:{int1. int2. int3.} put:aValue
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 put:aValue [
	^ self at:{int1. int2.} put:aValue
]

{ #category : #accessing }
MlArray >> at: anObject put: aValue [
	| address anArrayOfInt |
	
	anObject ifNil:[MlIndexTypeError signal].
	" evaluates the block on internal array, if true put the value"
	anObject isBlock ifTrue:[ 
		(self eval:anObject) doWithIndex:[:o :i| o ifTrue:[self internalArray at:i put:aValue]].
		^self].
	"if nDim = 1 an array is a slice"
	anArrayOfInt := (self nDim = 1 & (anObject isArray)  
								and:[anObject notEmpty and:[anObject first isArray not]]) 
										ifTrue:[	{anObject}]
										ifFalse:[ anObject ].
	"if it is not an array, enclose in an array, "
	anArrayOfInt := anArrayOfInt isArray 
										ifTrue:[anArrayOfInt]
										ifFalse:[	{anArrayOfInt}].
	anArrayOfInt := self changeLabelsByIndexes: anArrayOfInt.
	(self isAnArrayOfSlices: anArrayOfInt) 
		ifTrue:[^ (self slice: anArrayOfInt) replaceAllBy: aValue;yourself]
		ifFalse:[
			"changes -1 by the last element"
			anArrayOfInt := anArrayOfInt collectWithIndex:[:e :i| e < 0 ifTrue:[(self shape at:i) + e + 1] ifFalse:[e]].
			(self validateAddress: anArrayOfInt) ifFalse:[MlShapeError signal:'Position is not valid for this shape'].
			address := self getAddressForPoint:anArrayOfInt.
			^ [  self internalArray at:address put: aValue] on: Exception do:[self internalArray at:address put: Float nan]]
	
]

{ #category : #'reduce operations' }
MlArray >> buildEncoder: axis [
	^ self reduce: #buildEncoder axis: axis
]

{ #category : #accessing }
MlArray >> byteSize [
	^ self internalArray byteSize
]

{ #category : #'private-labeling' }
MlArray >> changeLabelsByIndexes: anArrayOfInt [
	"@TODO change labels  "
	anArrayOfInt doWithIndex:[:o :i| 
		anArrayOfInt at:i put: 
		(o isArray ifTrue:[ o collect:[:e| (self labelsDictAt:i) at:e]]
					 ifFalse:[(self labelsDictAt:i) at:o])].
	^ anArrayOfInt
]

{ #category : #'private-accessing' }
MlArray >> classForType: aType [
	| dTypeDic |

	dTypeDic := { #Float->FloatArray.
	 				  #BoxedFloat64->FloatArray.
					  #SmallFloat64->FloatArray.
					  #Integer -> IntegerArray.
					  #SmallInteger -> IntegerArray.
					  #LargeInteger -> IntegerArray.
					  #LargeNegativeInteger -> IntegerArray.
					  #LargePositiveInteger -> IntegerArray.
					  #Word -> WordArray.
					  #DoubleWord -> DoubleWordArray.
					  #DoubleByte -> DoubleByteArray.
					  #Byte -> ByteArray} asDictionary.
	^ dTypeDic at:aType ifAbsent:[Array]
]

{ #category : #comparing }
MlArray >> closeTo: aMlArrayOrNumber [
	^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isKindOf:String) 
		ifTrue:[self select:[:e| e = aMlArrayOrNumber] ]
		ifFalse:[
			1 to: self size do:[:i|
				((self internalArray at:i) closeTo: (aMlArrayOrNumber internalArray at:i))
				ifFalse:[^ false]].
			[self order = aMlArrayOrNumber order and:[self shape= aMlArrayOrNumber shape]] ]
]

{ #category : #enumerating }
MlArray >> collect: aBlock [ 
	^ self newInstanceButEmpty internalArray:  (self internalArray collect:aBlock)
]

{ #category : #'private-slicing' }
MlArray >> completeSlice: aSliceArray [
	"the association should contain two nDim-arrays, from->to 
	#(-1@2 2@-1 3@4)points in the right array shoud be great or equal to le left side.
	# n@-1 means from n to the end of the dimension.
	# -1@m means from the start to the end of the dimension"
	| collectionOfSlices completeSlice sliceForDim subcollection |
	aSliceArray size = self nDim  ifFalse:[ MlSliceError signal].
	collectionOfSlices:=OrderedCollection new.
	
	"BLOCK DEFINITION: EXECUTED LATER"
	completeSlice := [ :slice :i :colOfSlices|
		|si step start end  |
		si := slice.
		step :=1.
		si isInteger 
		ifTrue:[	si < 0 
						ifTrue:[start := end := ((self shape at:i) + si + 1)]
						ifFalse:[ start := end :=si	]]
		ifFalse:[	
			si isSlice ifFalse:[ MlSliceError signal].
			si:= si asSlice.
			start := (si x notNil) ifTrue:[si x] ifFalse:[self shape at:i].
			start < 0 ifTrue:[start := ((self shape at:i) + start +1)].
			end := (si y notNil) ifTrue:[si y] ifFalse:[
				si x ifNil:[1] ifNotNil:[self shape at:i]].
			end < 0 ifTrue:[end := ((self shape at:i) + end + 1)].
			step := si step].
		colOfSlices add: (start to:end by:step)].
	
	
	1 to: aSliceArray size do:[:dimIndex|
		sliceForDim := (aSliceArray at: dimIndex).
		sliceForDim isArray &  sliceForDim isSlice not
			ifTrue:[
				subcollection := OrderedCollection new.
				sliceForDim do:[:each| completeSlice value: each value:dimIndex value:subcollection].
				collectionOfSlices add:subcollection asArray
				]
			ifFalse:[
				sliceForDim isMlArray 
				ifTrue:[completeSlice value: _@_ value: dimIndex value: collectionOfSlices]
				ifFalse:[	completeSlice value: sliceForDim value: dimIndex value: collectionOfSlices]]
	].

	^	collectionOfSlices 	
		

]

{ #category : #'math functions' }
MlArray >> concat: aMlArray axis: standarAxisNumber [
	| instance axis heightOfSelf heightOfOther j i  k |
	
	axis := self getNumberForAxis: standarAxisNumber.

	(self isShapeOf: aMlArray concatenableAlongAxis: axis) ifFalse:[MlShapeError signal].
	
	instance := self newInstanceButShaped: (self shape deepCopy 
															at: axis 
															put: (self shape at:axis) + (aMlArray shape at:axis);
															yourself) .
											
	heightOfSelf :=self jumpToNextBlockInAxis: axis.
	heightOfOther := aMlArray jumpToNextBlockInAxis: axis.

	i:= j := k:= 1.
	[i < instance size] whileTrue:[
		instance internalArray replaceFrom:i  to: (i + heightOfSelf - 1) with: self internalArray  startingAt: k.
		k:= k + heightOfSelf .
		i := i + heightOfSelf .
		instance internalArray replaceFrom:i  to: (i + heightOfOther - 1) with: aMlArray internalArray  startingAt: j.
		j := j + heightOfOther .
		i := i + heightOfOther 
	].

	^ instance
]

{ #category : #'reduce operations' }
MlArray >> confusionMatrix: aMlArray [
	^ aMlArray isMlArray 
		ifTrue:[self internalArray confusionMatrix: aMlArray internalArray]
		ifFalse:[self internalArray confusionMatrix: aMlArray ]
]

{ #category : #'private-converting' }
MlArray >> convertTypeTo:aType [

	| newArray newArrayType nv |
	newArrayType := (self classForType: aType).
	newArray := newArrayType new: self internalArray size.
	1 to: newArray size do:[:i|
		nv := self adaptData:( self internalArray at:i) for:newArrayType.
		newArray at:i put: nv].
	self internalArray: newArray . 
	^ aType

]

{ #category : #slicing }
MlArray >> copyFrom: aSliceArray [
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: aSliceArray copy: true	

]

{ #category : #slicing }
MlArray >> copyFrom: aSlice to: otherSlice [ 
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: { aSlice. otherSlice } copy: true	

]

{ #category : #'math functions' }
MlArray >> copyUpToLast: aMlArray [ 
	^ self performBinaryOp: #copyUpToLast: on: aMlArray 

]

{ #category : #enumerating }
MlArray >> count: aBlock [ 
	^ self internalArray count:aBlock.
]

{ #category : #'private-slicing' }
MlArray >> createNewSlicedInstance: indexes shape: newShape [

	| newInstance i |
	
	newInstance := self newInstanceButShaped: newShape.
	i := 1.
	(indexes sort:[:a :b| a first < b first]) do:[:each|
			newInstance internalArray  replaceFrom:i  to: (i + each size -1) with: self internalArray  startingAt: each first. 
			i:=i + each size ].
	^ newInstance 
]

{ #category : #'private-slicing' }
MlArray >> createNewSlicedReference:indexes shape: newShape [

	| newInstance  |
	newInstance := self newInstanceButEmpty. 
	newInstance internalArray: (MlNonContinuousArray newFromArray: self internalArray). 
	newInstance internalArray validRanges: (indexes sort:[:a :b| a first < b first]).
	newInstance shape: newShape.
	^ newInstance

	

]

{ #category : #accessing }
MlArray >> dType [
	^ dType
]

{ #category : #accessing }
MlArray >> dType: anObject [
	"if dtype changes we have to transform each element"
	dType := dType 
					ifNil:[anObject]
					ifNotNil:[ 
						dType = anObject 
							ifTrue:[dType]
							ifFalse:[self convertTypeTo:anObject]].
]

{ #category : #'math functions' }
MlArray >> decode: aMlArray [ 
	^ self performBinaryOp: #decode: on: aMlArray 

]

{ #category : #'reduce operations' }
MlArray >> describe [
	|describeResult meanAndVariance|
	"It is done one by one...all except mean and variance not in one pass"
	describeResult := MlDescribeResult new.
	

	describeResult mean:(self mean:0).
	describeResult variance: (self variance:0).
	describeResult max: (self max:0).
	describeResult min: (self min:0).
	describeResult numberOfObs: (self nDim>1 ifTrue:[self shape at: (self nDim -1)] ifFalse:[self size]).
	describeResult skewness: (self skewness:0).
	describeResult kurtosis: (self kurtosis:0).
	
	^ describeResult
]

{ #category : #'math functions' }
MlArray >> differentiate: nSteps times:nTimes [
	"returns a collection with the Xn - Xn-steps elements n Times"
	| dest source  instance ljump |
	self order = #C 
		ifTrue:[
			instance := self transposed.
			ljump := instance shape last].
	self order = #F 
		ifTrue:[
			instance := self.
			ljump := self shape last].						
	source := instance internalArray.
		
	1 to:nTimes do:[:t|
		dest := source class new: (self internalArray size).
		(1 to:( source size - ljump +1) by: ljump) do:[:j| 
			j to:( j + ljump  - nSteps) do:[:i|
				dest at: i put: (( source at:(i+nSteps-1))- ( source at:(i-1) ifAbsent:[Float nan]) )].
			].
		(t to:( source size - ljump +1+t) by: ljump) do:[:j| dest at: j put:Float nan].
		source := dest].
	
	instance := ( instance newInstanceButEmpty internalArray: dest).
	self order = #C ifTrue:[^ instance transposed].
	self order = #F ifTrue:[^ instance ].		

]

{ #category : #enumerating }
MlArray >> do: aBlock [ 
	^ self internalArray do:aBlock
]

{ #category : #enumerating }
MlArray >> doWithIndex: aBlock [ 
	^ self internalArray doWithIndex:aBlock
]

{ #category : #'math functions' }
MlArray >> encode: aMlArray [ 
	^ self performBinaryOp: #encode: on: aMlArray 

]

{ #category : #enumerating }
MlArray >> eval: aBlock [ 
	|newInstance|
	newInstance := self newInstanceButBool.
	self internalArray doWithIndex:[:e :i|
		newInstance internalArray at:i put: (aBlock value:e)].
	^ newInstance
]

{ #category : #'private-accessing' }
MlArray >> fillWith: anObject [
		1 to:  self internalArray size  do:[:i| self internalArray at:i put: anObject].
]

{ #category : #'private-accessing' }
MlArray >> getAddressForPoint:anArrayOfInt [
	| address  adaptedAddress  |
	address := 1.
	adaptedAddress := anArrayOfInt  - 1.
	
	adaptedAddress  doWithIndex:[:each :i| address := address + (each * (self weightForAxis:i))].	
	^ address 
]

{ #category : #'private-slicing' }
MlArray >> getIndexesForBlocks: aSliceArray onArray: aMlArray [
	| b fullRange|
	fullRange := (Array new: aMlArray nDim) fillWith: _@_.
	aSliceArray collectWithIndex:[ :aSlice :i|

	].
		
	^ aSliceArray
			
]

{ #category : #'private-slicing' }
MlArray >> getIndexesForBool: aSliceArray onArray: aMlArray [
	| b fullRange|
	fullRange := (Array new: aMlArray nDim) fillWith: _@_.
	aSliceArray collectWithIndex:[ :aSlice :i|

	].
		
	^ aSliceArray
			
]

{ #category : #sorting }
MlArray >> getIndexesSortingBy: aBlock [
	| steps array buffer |
	steps :=  self nDim > 2 
		ifTrue:[(self shape copyFrom:1 to: (self nDim -2)) inject:1 into:[:e :mul| e* mul]]
		ifFalse:[self size - 1].
	array:= Array new: self size .
	(1 to: self size  by: steps + 1) do:[:e |
		buffer := self internalArray copyFrom:e  to: (e + steps ).
		array replaceFrom: e to: (e + steps ) with: ((buffer getIndexesSortingBy: aBlock) + (e-1)) startingAt: 1  ].
	
	^ array  
]

{ #category : #'private-slicing' }
MlArray >> getIntervalAdressesFor:slices level: l list: lklst indexes: indexes [ 
	| si ei currentSlice nextLevel |

	(((l = self nDim) & (self order = #C)) | 
	 ((l = (self nDim - 1)) & (self order = #F)) |
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
					
					nextLevel := (self order = #C) 
										ifTrue:[l+1] 
										ifFalse:[ 
											((l + 2) = self nDim ) ifTrue:[ l + 2] ifFalse:[
											((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]]].
					
					self getIntervalAdressesFor: slices  level: nextLevel list: lklst  indexes: indexes.
					]].
			currentSlice isArray ifTrue:[
					currentSlice do:[:each|
						"each one shoud be an interval"
						each do:[:eachVal|
							lklst at:l put: eachVal.
							nextLevel := (self order = #C) 
										ifTrue:[l+1] 
										ifFalse:[ 
											((l + 2) = self nDim ) ifTrue:[ l + 2] ifFalse:[
											((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]]].
					
							self getIntervalAdressesFor: slices  level: nextLevel  list: lklst  indexes: indexes.
							]]]
			]
		
	
]

{ #category : #'math functions' }
MlArray >> getNumberForAxis: anAxis [
	| data axis |
	axis := data := (( self nDim - anAxis - 1) \\  self nDim ) + 1 .
	axis := data = self nDim ifTrue:[self nDim -1] ifFalse:[data].
	axis := (data = (self nDim -1)) ifTrue:[self nDim] ifFalse:[axis].
	^ axis := axis >0 ifTrue:[axis] ifFalse:[1].

]

{ #category : #enumerating }
MlArray >> inject: aValue into: aBlock [ 
	^ self internalArray inject: aValue into:aBlock
]

{ #category : #'private-accessing' }
MlArray >> internalArray [
	^ internalArray 
]

{ #category : #'private-accessing' }
MlArray >> internalArray: aNewArray [ 	
	internalArray := MlNonContinuousArray newFromArray: aNewArray
]

{ #category : #'private-accessing' }
MlArray >> internalArrayOfType: aType size: size [ 	
	| dataClass |
	self dType:aType.
	dataClass :=self classForType: self dType.
	self internalArray: (dataClass new:size)
]

{ #category : #slicing }
MlArray >> isAnArrayOfSlices: arrayOfPoints [ 
	| n |
	arrayOfPoints isNumber ifTrue:[MlShapeError signal].
	arrayOfPoints ifNil:[MlIndexTypeError signal].
	n := arrayOfPoints detect:[:e | e isPoint | e isSlice | e isArray | e isMlArray] ifNone:[nil].
	^ n notNil
]

{ #category : #testing }
MlArray >> isEmpty [ 	
	^ self internalArray isEmpty 
]

{ #category : #testing }
MlArray >> isMlArray [	
	^ true
]

{ #category : #'private-converting' }
MlArray >> isShapeOf: aMlArray concatenableAlongAxis: axis [ 
	self nDim = aMlArray nDim ifFalse:[^false].
	1 to: self nDim do:[:i| (((aMlArray shape at:i) = (self shape at:i)) or:[i = axis]) ifFalse:[^ false]].   
	^ true
]

{ #category : #accessing }
MlArray >> itemSize [
	^ self internalArray byteSize / (self internalArray buffer size)
]

{ #category : #'private-slicing' }
MlArray >> jumpToNextBlockInAxis: axis [

	^ self order = #F 
		ifTrue:[(self weightForAxis: axis) * (self shape at:axis)]
		ifFalse:[(self weightForAxis: axis-1)].

]

{ #category : #'reduce operations' }
MlArray >> kurtosis [ 
	^ self internalArray kurtosis
]

{ #category : #'reduce operations' }
MlArray >> kurtosis: axis [
	^ self reduce: #kurtosis axis: axis
]

{ #category : #accessing }
MlArray >> labelsDict [ 
	"labels dict is a dictionary axis-->labels"
	^ labelsDict ifNil:[ labelsDict := SmallDictionary new]
]

{ #category : #labeling }
MlArray >> labelsDictAt: anInteger [ 
	^ self labelsDict at: anInteger ifAbsentPut:[MlLabelDict new]
]

{ #category : #'reduce operations' }
MlArray >> max [ 
	^ self internalArray max
]

{ #category : #'reduce operations' }
MlArray >> max: axis [
	^ self reduce: #max axis: axis
]

{ #category : #printing }
MlArray >> maxElementsToPrint [
	^ maxElementsToPrint ifNil:[maxElementsToPrint := 10]
]

{ #category : #printing }
MlArray >> maxElementsToPrint: anInteger [
	^ maxElementsToPrint := anInteger
]

{ #category : #'reduce operations' }
MlArray >> mean [ 
	^ self internalArray mean
]

{ #category : #'reduce operations' }
MlArray >> mean: axis [
	^ self reduce: #mean axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mean: axis exclude: anElement [
	^ self reduce: #meanExcludeElement: axis: axis arguments: {anElement} 
]

{ #category : #'reduce operations' }
MlArray >> meanAndStd [
	^ self internalArray meanAndStd 
]

{ #category : #'reduce operations' }
MlArray >> meanAndStd: axis [
	^ self reduce: #meanAndStd axis: axis
]

{ #category : #'reduce operations' }
MlArray >> meanAndVariance [ 
	^ self internalArray meanAndVariance 
]

{ #category : #'reduce operations' }
MlArray >> meanAndVariance: axis [
	^ self reduce: #meanAndVariance axis: axis
]

{ #category : #'reduce operations' }
MlArray >> meanNoNan [ 
	^ self internalArray meanNoNan
]

{ #category : #'reduce operations' }
MlArray >> meanNoNan: axis [
	^ self reduce: #meanNoNan axis: axis
]

{ #category : #'reduce operations' }
MlArray >> median [ 
	^ self internalArray median
]

{ #category : #'reduce operations' }
MlArray >> median: axis [
	^ self reduce: #median axis: axis
]

{ #category : #'reduce operations' }
MlArray >> min [ 
	^ self internalArray min
]

{ #category : #'reduce operations' }
MlArray >> min: axis [
	^ self reduce: #min axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mode [
	^ self internalArray mode
]

{ #category : #'reduce operations' }
MlArray >> mode: axis [
	^ self reduce: #mode axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mode: axis exclude: anElement [
	^ self reduce: #modeExcludeElement:  axis: axis arguments: {anElement} 
]

{ #category : #'reduce operations' }
MlArray >> module [
	^ self internalArray module
]

{ #category : #'reduce operations' }
MlArray >> module: axis [
	^ self reduce: #module axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mse: aMlArray [
	^ aMlArray species = self class  
		ifTrue:[self internalArray mse: aMlArray internalArray]
		ifFalse:[self internalArray mse: aMlArray ]
]

{ #category : #accessing }
MlArray >> nBytes [
	^ self internalArray byteSize
]

{ #category : #accessing }
MlArray >> nDim [
	^ self shape size
]

{ #category : #'private-creating' }
MlArray >> newInstanceButBool [

	^ self class new: self shape deepCopy order:self order dType: #Boolean.
	
]

{ #category : #'private-creating' }
MlArray >> newInstanceButEmpty [
	| i |
	i := self class new.
	i shape: self shape deepCopy; order:self order; dType: self dType.
	^i
]

{ #category : #'private-creating' }
MlArray >> newInstanceButShaped: aShape [
	| i |
	
	i := self class new: aShape order:self order dType: self dType.
	^i
]

{ #category : #'private-creating' }
MlArray >> newInstanceLikeMe [
	| i |
	i := self class new: self shape deepCopy order:self order dType: self dType.
	^i
]

{ #category : #'math functions' }
MlArray >> oneHotDecode: aMlArray [ 
	^ self performBinaryOp: #oneHotDecode: on: aMlArray 

]

{ #category : #'math functions' }
MlArray >> oneHotEncode: aMlArray [ 
	^ self performBinaryOp: #oneHotEncode: on: aMlArray 

]

{ #category : #accessing }
MlArray >> order [
	^ order ifNil:[ order := #F]
]

{ #category : #accessing }
MlArray >> order: cOrFChar [
	order := cOrFChar
]

{ #category : #'math functions' }
MlArray >> performBinaryOp: op on: aMlArray [
	^ self performBinaryOp: op on: aMlArray withArguments:{}
]

{ #category : #'math functions' }
MlArray >> performBinaryOp: op on: aMlArray withArguments:args [
	| newInstance a b  |
	newInstance := self newInstanceButEmpty. 
	aMlArray isMlArray 
		ifTrue:[
			a:= self internalArray. b:= (self adaptSizeOfArray:aMlArray )]
		ifFalse:[
			aMlArray isNumber
			ifTrue:[ a:= self internalArray. b:= aMlArray]
			ifFalse:[
				a:= self internalArray. b:= (self adaptSizeOfArray: aMlArray asMlArray )]].

	newInstance internalArray: (a perform: op withEnoughArguments: {b.  args} ) buffer .
	^ newInstance
]

{ #category : #printing }
MlArray >> printOn: aStream axis: axisCollection maxPad: maxPad [
	| axistmp axis lenghtOfDimension interval  lastA  printPoints element |
	"axisCollection is Empty in the first call"
	axis := (axisCollection size +1 ).
	"is last axis"	
	printPoints := false.
	lastA:=0.
	axis = self nDim 
	ifTrue:[	
		aStream nextPut: Character tab;nextPut:$[.
		lenghtOfDimension := (self shape at: axis).
		interval := (lenghtOfDimension < (2 * self maxElementsToPrint+1) ) 
			ifTrue:[1 to:lenghtOfDimension]
			ifFalse:[
				printPoints := true.
				(1 to:self maxElementsToPrint ),
				(( lenghtOfDimension- self maxElementsToPrint ) to:lenghtOfDimension) ].		
		
		lastA := interval first.
		interval do:[:a| 
			axisCollection add:a.
			"in 1d array index should be an index otherwise it returns an slide {1. 3} b.e"
			element := self at: (self nDim = 1 ifTrue:[axisCollection first] ifFalse:[axisCollection asArray]).
			aStream nextPutAll: ((element isInteger|element isFloat) 
				ifTrue:[ element printPaddedWith: Character space to: maxPad]
				ifFalse:[ element asString ]).
			a = lenghtOfDimension ifFalse:[aStream nextPut:$,].
			(printPoints and:[a -lastA >1 ]) ifTrue:[aStream nextPutAll:'...'] .
			lastA := a.
			axisCollection removeLast.
			].
		aStream nextPut:$]; nextPut: Character tab.
		axistmp :=(self shape copyFrom: 1 to: axisCollection size).
		axisCollection asArray=  axistmp ifFalse:[aStream cr]]
	ifFalse:[
		aStream nextPut:$[.
		lenghtOfDimension := (self shape at: axis).
		interval := (lenghtOfDimension < (2 * self maxElementsToPrint + 1) ) 
			ifTrue:[1 to:lenghtOfDimension]
			ifFalse:[
				printPoints := true.
				(1 to:self maxElementsToPrint ),
				(( lenghtOfDimension- self maxElementsToPrint ) to:lenghtOfDimension) ].
		lastA := interval first.
		interval do:[:a|		
			axisCollection add:a.
			self printOn: aStream axis: axisCollection maxPad: maxPad.
			(printPoints and:[a-lastA >1 ]) ifTrue:[aStream nextPut:$.;cr;nextPut:$.;cr;nextPut:$.;cr] .
			lastA := a.
			axisCollection removeLast.
		].
		aStream nextPut:$].
	].

		

]

{ #category : #printing }
MlArray >> printString [
	"TODO provisional"
	|s maxPad|
	s := WriteStream on: String new.
	[  maxPad := ((self max asInteger asString size) + 2)] on:Exception do:[maxPad := 10].
	
	self printOn:s axis: OrderedCollection new maxPad:maxPad.
	^ s contents
]

{ #category : #'reduce operations' }
MlArray >> quartiles [
	^ self internalArray quartiles
]

{ #category : #'reduce operations' }
MlArray >> quartiles: axis [
	^ self reduce: #quartiles axis: axis
]

{ #category : #'reduce operations' }
MlArray >> reduce: aSymbol axis: anIntegerOrAPair [

	^ self
		reduce: aSymbol
		axis: anIntegerOrAPair
		arguments:{}
		
]

{ #category : #'reduce operations' }
MlArray >> reduce: aSymbol axis: anAxis arguments: args [
	"Execute a reduce function (mean,max... all values from an axis to one) 
	aSymbol is the operation, anAxis, the axis, args an array with the arguments for the method
	aClass is the  "
	| axis results newShape instance realAxis|
	realAxis := self getNumberForAxis: anAxis.
	axis := self nDim - anAxis.
	axis < 0 ifTrue:[ axis := self shape last + 1 - axis].
	(axis > self nDim)|( axis < 1 )ifTrue:[ MlShapeError signal:'Axis is higher than nDim']. 

	"the operation 'aSymbol' should reduce the collection to 1, i.e. mean, std..."
	results := OrderedCollection new.

	self walkOnWhile:[:l :s| axis >1 ifTrue:[l < (axis -1)] ifFalse:[false]]
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
	^ (self order = #C) ifTrue:[instance] ifFalse:[instance asFortranArray] 
]

{ #category : #enumerating }
MlArray >> reject: aBlock [ 
	| nc i |
	nc:= self internalArray reject:aBlock.
	i := self newInstanceButEmpty internalArray: nc; shape:{nc size}.
	^i
]

{ #category : #'math functions' }
MlArray >> replace: element by: aMlArray [ 
	^ self performBinaryOp: #replaceBy:element: on:aMlArray withArguments:  element

]

{ #category : #'math functions' }
MlArray >> replaceAllBy: aMlArray [ 
	^ self performBinaryOp: #replaceAllBy: on: aMlArray 

]

{ #category : #'math functions' }
MlArray >> replaceNanBy: aMlArray [ 
	^ self performBinaryOp: #replaceNanBy: on: aMlArray 

]

{ #category : #accessing }
MlArray >> reshape: anArrayOfInt [
	| newSize nr1 newShape |
	nr1 := (anArrayOfInt count:[:e| e = -1]).
	nr1 > 1 ifTrue:[MlShapeError signal:'Only one dimension could be -1' ]. 
	
	newShape := (nr1 = 1) 
						ifTrue:[ |uDim|
									uDim := (self internalArray size / 
										(anArrayOfInt inject:1 into:[:m :e| e = -1 ifTrue:[m] ifFalse:[m*e]])).
									uDim isInteger ifFalse:[MlShapeError signal].
									anArrayOfInt replaceAll: -1 with:uDim.	]
						ifFalse:[anArrayOfInt].
 	newSize := newShape inject: 1 into: [ :m :e | m*e].  
	newSize = self internalArray size ifFalse:[MlShapeError signal].
	self shape: newShape								
]

{ #category : #enumerating }
MlArray >> select: aBlock [ 
	| nc i |
	nc:= self internalArray select:aBlock.
	i := self newInstanceButEmpty internalArray: nc; shape:{nc size}.
	^i
]

{ #category : #labeling }
MlArray >> setLabels: anArray onAxis: standarAxisNumber [
	| axis |
	axis := self getNumberForAxis: standarAxisNumber.
	(axis <1 | axis > self nDim) ifTrue:[ ^ MlShapeError signal:('dimension  ', axis asString,' does not exist') ].
	(anArray size = (self shape at: axis)) ifFalse:[ ^ MlShapeError signal:('labels should have ',(self shape at: axis) asString,' elements') ].
	
	self labelsDict at: axis put: (MlLabelDict newFrom:anArray)
]

{ #category : #accessing }
MlArray >> shape [
	^ shape
]

{ #category : #'private-accessing' }
MlArray >> shape: anArrayOfInt [
	shape := anArrayOfInt asArray
]

{ #category : #'reduce operations' }
MlArray >> size [ 
	^ self internalArray size
]

{ #category : #'reduce operations' }
MlArray >> skewness [ 
	^ self internalArray skewness 
]

{ #category : #'reduce operations' }
MlArray >> skewness: axis [
	^ self reduce: #skewness axis: axis
]

{ #category : #'private-slicing' }
MlArray >> slice: aSliceArray [
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: aSliceArray copy: false	

]

{ #category : #'private-slicing' }
MlArray >> slice: aSliceArray copy: makeCopy [
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"

	| slice list indexes newShape startLevel newInstance |
	"first we ignore block slice in compete slice "
	
	slice := self completeSlice: aSliceArray.
	list := Array new: self nDim.
	indexes := OrderedCollection new.
	startLevel := self order = #C | (self nDim ~= 2)
		ifTrue: [ 1 ]
		ifFalse: [ 2 ].
	self
		getIntervalAdressesFor: slice
		level: startLevel
		list: list
		indexes: indexes.
	newShape := slice
		collect: [ :e | 
			e isInterval
				ifTrue: [ "is an interval" e size ]
				ifFalse: [ e inject: 0 into: [ :sum :each | sum + each size ] ] ].
	"should be array of intervals"
	
	newInstance := makeCopy
		ifTrue: [ self createNewSlicedInstance: indexes shape: newShape ]
		ifFalse: [ self createNewSlicedReference: indexes shape: newShape ].
	
	^ newInstance sliceUsingBooleanFilter: aSliceArray.
]

{ #category : #'private-slicing' }
MlArray >> sliceUsingBooleanFilter: aSliceArray [
	|newInstance sliceForDim|
	newInstance := self.
	1 to: aSliceArray size do:[:axis|
		sliceForDim := (aSliceArray at: axis).
		(sliceForDim isMlArray and:[sliceForDim dType = #Boolean])
			ifTrue:[newInstance := newInstance applyBooleanFilter: sliceForDim on: axis.]
	].

	^	newInstance	
		

]

{ #category : #sorting }
MlArray >> sortBy: anIndexArray onAxis: axis [
	
	| b  realAxis  slide |
	realAxis := self getNumberForAxis: axis.
	slide := Array new: self nDim withAll: _@_.
	1 to: (self shape at: realAxis) do:[:a|	
				slide at: realAxis put: a.
				b := self at: slide.
				b performBinaryOp: #applyNewIndexOrder: on: anIndexArray]

]

{ #category : #sorting }
MlArray >> sortByColumn: indexOrNameOfColumn [ 
	self sortByColumn: indexOrNameOfColumn where: [ :a :b | a < b ] 
]

{ #category : #sorting }
MlArray >> sortByColumn: indexOrNameOfColumn where: aBlock [ 
	|columns slide z si |

	slide := Array new: self nDim withAll: _@_.
	slide at: slide size put: indexOrNameOfColumn.
	columns := self changeLabelsByIndexes: slide.
	z := self at: columns.
	si := z getIndexesSortingBy: aBlock.
	self sortBy: si onAxis:1
	
]

{ #category : #'math functions' }
MlArray >> sparsity [
	^ 1- (self count:[:e| e ~= 0] / self size)
]

{ #category : #'math functions' }
MlArray >> split: indicesOrSections axis: standarAxisNumber [
	| axis sliceTotal ios collectionOfSlices i endSection |
	
	ios := indicesOrSections isInteger ifTrue:[{indicesOrSections}] ifFalse:[indicesOrSections].
	axis := self getNumberForAxis: standarAxisNumber.
	collectionOfSlices := OrderedCollection new.
	i := 1.
	ios := ios , { (self shape at:axis)+1 }. 
	ios do:[:section|
		sliceTotal := self shape collect:[:d| 1@d].
		endSection := section - 1.
		endSection := endSection min: ((sliceTotal at: axis) y).
		endSection := endSection max:1.
		sliceTotal at: axis put: i@(section - 1).
		collectionOfSlices add: (self at:sliceTotal).
		i := section.
	].
	
	^ collectionOfSlices	
	
	

]

{ #category : #'reduce operations' }
MlArray >> stdDev [ 
	^ self internalArray stdDev
]

{ #category : #'reduce operations' }
MlArray >> stdDev: axis [
	^ self reduce: #stdDev axis: axis
]

{ #category : #'reduce operations' }
MlArray >> sum [ 
	^ self internalArray sum
]

{ #category : #'reduce operations' }
MlArray >> sum: axis [
	^ self reduce: #sum axis: axis
]

{ #category : #'private-creating' }
MlArray >> switchShapeOrder: aShape [
	| newShape tmp |
	aShape size = 1 ifTrue:[^ aShape].
	newShape := (aShape copyFrom:1 to:aShape size).
	tmp := newShape last.
	newShape at:(newShape size) put: (newShape at:(newShape size -1)).
	newShape at:(newShape size - 1) put: tmp.
	^newShape
]

{ #category : #accessing }
MlArray >> transform: aBlock [
	
	1 to:self size do:[:i|
		self internalArray at:i put: ( aBlock value:(self internalArray at:i))]
]

{ #category : #converting }
MlArray >> transposed [
	|instance|
	self order = #C ifTrue:[instance := self asFortranArray order:#C].
	self order = #F ifTrue:[instance := self asCArray order:#F].
	instance shape: (self switchShapeOrder: self shape).
	^ instance

]

{ #category : #'private-accessing' }
MlArray >> validateAddress: anArrayOfInt [
	(anArrayOfInt size = self nDim ) ifFalse:[^false].
	self shape doWithIndex:[:e :i| 
		(anArrayOfInt at:i) isInteger ifFalse:[MlIndexTypeError signal].
		(e >= (anArrayOfInt at:i) and:[(anArrayOfInt at:i)>0]) ifFalse:[^false]].
	^ true.
		
]

{ #category : #'reduce operations' }
MlArray >> variance [ 
	^ self internalArray variance
]

{ #category : #'reduce operations' }
MlArray >> variance: axis [

	^ self reduce: #variance axis: axis
]

{ #category : #enumerating }
MlArray >> walkOn:l slice: s while: aWhileBlock when: aConditionBlock do: aBlock [ 


	1 to: (self shape at: l) do:[:i| 
		s at:l put: i.
		(aWhileBlock value:l value:s) ifTrue:[
			self walkOn:l+1 slice: s while: aWhileBlock when: aConditionBlock do: aBlock ].
		(aConditionBlock value:l value:s) ifTrue:[(aBlock  value:l value:s)].
	]
]

{ #category : #enumerating }
MlArray >> walkOnWhen: aConditionBlock do: aBlock [ 
	self walkOn:1 slice: (Array new: self nDim withAll:1) while: [:l :s| l < self nDim]  when: aConditionBlock do: aBlock 


]

{ #category : #enumerating }
MlArray >> walkOnWhile: aWhileBlock when: aConditionBlock do: aBlock [ 
	self walkOn:1 slice: (Array new: self nDim withAll:1) while: aWhileBlock when: aConditionBlock do: aBlock 


]

{ #category : #enumerating }
MlArray >> weightForAxis: anAxis [
	| w tempShape axis|
	axis := anAxis.
	axis < 1 ifTrue:[^ self size].
	self nDim = 1 ifTrue:[^ 1].
	tempShape := self shape.
	self order=#F ifTrue:[  
		anAxis = (self nDim - 1) ifTrue:[^ 1].
		w := anAxis = self nDim 
				ifTrue:[ (1 to: axis -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]]
				ifFalse:[ (axis +1 to: self nDim -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]].
		].
	self order=#C ifTrue:[  
		anAxis = self nDim ifTrue:[^ 1].
		w:= (axis +1 to: self nDim) inject:1 into:[:mul :e|  mul * (tempShape at:e)]].
	^ w
]

{ #category : #'math functions' }
MlArray >> | aMlArray [
	| newInstance zip |
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray  
		ifTrue:[
			zip := MlZipper on: {self internalArray.  (self adaptSizeOfArray:(aMlArray ) )}.
			newInstance internalArray:  (zip collect:[:row| row first | row last]).
			newInstance ]
		ifFalse:[
			newInstance internalArray: (self internalArray | (self adaptSizeOfArray:(aMlArray ))) .
			newInstance]
]

{ #category : #comparing }
MlArray >> ~= aMlArrayOrNumber [
		^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isString)
		ifTrue:[self select:[:e| e ~= aMlArrayOrNumber] ]
		ifFalse:[(self = aMlArrayOrNumber) not ] 
]
