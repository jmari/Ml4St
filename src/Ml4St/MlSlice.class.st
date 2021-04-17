"
I am used to allow integer@integer@integer syntax of a Slice.
I am a subclass of Point
	isSlice: yes, it is an slice

"
Class {
	#name : #MlSlice,
	#superclass : #Point,
	#instVars : [
		'step'
	],
	#category : #'Ml4St-Core'
}

{ #category : #'as yet unclassified' }
MlSlice class >> completeSlice:slice axis:i shape: shape [
		|si step start end  |
		"change _ by 1 or shape(i)
		 change -n by shape(i) - n + 1
		 returns an equivalent interval"
		si := slice.
		step :=1.
		si isInteger 
		ifTrue:[	si < 0 
						ifTrue:[start := end := (( shape at:i) + si + 1)]
						ifFalse:[ start := end :=si	]]
		ifFalse:[	
			si isSlice ifFalse:[ MlSliceError signal].
			"to be sure it is not a point"
			si:= si asSlice.
			"remember _ is nil"
			start := (si x notNil) ifTrue:[si x] ifFalse:[ shape at:i].
			start < 0 ifTrue:[start := (( shape at:i) + start +1)].
			end := (si y notNil) ifTrue:[si y] ifFalse:[
				si x ifNil:[1] ifNotNil:[ shape at:i]].
			end < 0 ifTrue:[end := ((shape at:i) + end + 1)].
			step := si step].
		^ (start to:end by:step)

]

{ #category : #'as yet unclassified' }
MlSlice class >> transform: anArrayOfSlices asIntervalsforArray: aMlArray [
	" this function substitutes the _ and negative integers by its value.
	 _@_ left _ will be replaced by 1 and right _ will be replaced by the lenght of the dimension
	 -1@-2 negatige integers will be replaced by n + k + 1 where n is the lenght of the dimension 
	   and k is the negative integer
	 _ or nil means _@_                                             
	 also a slice could be:
	 - an array of integers
	 - an MlArray of Booleans. will be replaced by _@_. the filter will be applied later in the slice method"
	
	| collectionOfSlices sliceOfAnAxis subcollection unionOfSlices|
	
	anArrayOfSlices size = aMlArray nDim  ifFalse:[ MlSliceError signal:'The slice should be an array with ', aMlArray nDim asString,' elements'].
	
	"will store all the completed slices"
	collectionOfSlices:=OrderedCollection new.
		
	1 to: anArrayOfSlices size do:[:dimIndex|
		sliceOfAnAxis := (anArrayOfSlices at: dimIndex).
		sliceOfAnAxis isCollection &  (sliceOfAnAxis isString not ) &  (sliceOfAnAxis isSlice not)
			ifTrue:[
				subcollection := OrderedCollection new.
				sliceOfAnAxis do:[:each| 
					subcollection add: (self completeSlice:(each ifNil:[ _@_] ifNotNil:[each]) 
								  								axis:dimIndex 
																shape: aMlArray shape)].
				unionOfSlices := subcollection first isInterval 
					ifTrue:[Interval union: subcollection] ifFalse:[sliceOfAnAxis].
				collectionOfSlices add: unionOfSlices asArray
				]
			ifFalse:[
				collectionOfSlices add:
					(sliceOfAnAxis isMlArray | (sliceOfAnAxis isNil)
					"is an MlArray of Booleans or all, so get the whole interval, boolean filter will be applied in #slice:"
						ifTrue: [self completeSlice: _@_ axis: dimIndex shape: aMlArray shape]
						ifFalse:[	self completeSlice: sliceOfAnAxis axis: dimIndex shape: aMlArray shape])
			]
	].

	^	collectionOfSlices 	
]

{ #category : #arithmetic }
MlSlice >> + aSlice [ 
	aSlice isSlice 
		ifTrue:[^ (self x + aSlice x)@(self y + aSlice y)@(self step + aSlice step)]
		ifFalse:[ self error:'you can not add an Integer'] 
]

{ #category : #arithmetic }
MlSlice >> - aSlice [ 
	^ aSlice isSlice 
		ifTrue:[(self x - aSlice x)@(self y - aSlice y)@(self step - aSlice step)]
		ifFalse:[ self error:'you can not add an Integer'] 
]

{ #category : #converting }
MlSlice >> asArray [
	^ (self x to: self y by: self step) asArray
]

{ #category : #converting }
MlSlice >> asInterval [
	^ self x to: self y by: self step
]

{ #category : #converting }
MlSlice >> asSlice [
	^self
]

{ #category : #testing }
MlSlice >> isSlice [ 
	^ true
]

{ #category : #testing }
MlSlice >> isZero [
	^ (self x = 0 )& (self y = 0 )& (self step = 0)
]

{ #category : #accessing }
MlSlice >> step [ 	
	^step ifNil:[step:=1]
]

{ #category : #accessing }
MlSlice >> step: anInteger [ 	
	step := anInteger.
	(step < 0) & (x = 1) ifTrue:[x := nil]
]

{ #category : #'as yet unclassified' }
MlSlice >> to: aSlice by: aStep [

	^ MlInterval from:self to: aSlice by: aStep 
]
