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
	#category : #'MlSt-Core'
}

{ #category : #'as yet unclassified' }
MlSlice class >> completeSlices: anArrayOfSlices forArray: anMlArray [
	" this function substitutes the _ and negative integers by its value.
	 _@_ left _ will be replaced by 1 and right _ will be replaced by the lenght of the dimension
	 -1@-2 negatige integers will be replaced by n + k + 1 where n is the lenght of the dimension 
	   and k is the negative integer
	 _ or nil means _@_                                             
	 also a slice could be:
	 - an array of integers
	 - an MlArray of Booleans. will be replaced by _@_. the filter will be applied later in the slice method"
	
	| collectionOfSlices completeSlice sliceForDim subcollection |
	
	anArrayOfSlices size = anMlArray nDim  ifFalse:[ MlSliceError signal:'The slice should be an array with ', anMlArray nDim asString,' elements'].
	
	"will store all the completed slices"
	collectionOfSlices:=OrderedCollection new.
	
	"BLOCK DEFINITION: EXECUTED LATER"
	completeSlice := [ :slice :i :colOfSlices|
		|si step start end  |
		si := slice.
		step :=1.
		si isInteger 
		ifTrue:[	si < 0 
						ifTrue:[start := end := ((anMlArray shape at:i) + si + 1)]
						ifFalse:[ start := end :=si	]]
		ifFalse:[	
			"to be sure it is not a point"
			si:= si asSlice.
			"remember _ is nil"
			start := (si x notNil) ifTrue:[si x] ifFalse:[anMlArray shape at:i].
			start < 0 ifTrue:[start := ((anMlArray shape at:i) + start +1)].
			end := (si y notNil) ifTrue:[si y] ifFalse:[
				si x ifNil:[1] ifNotNil:[anMlArray shape at:i]].
			end < 0 ifTrue:[end := ((anMlArray shape at:i) + end + 1)].
			step := si step].
		colOfSlices add: (start to:end by:step)].
	
	
	1 to: anArrayOfSlices size do:[:dimIndex|
		sliceForDim := (anArrayOfSlices at: dimIndex).
		sliceForDim isCollection &  (sliceForDim isString not ) &  (sliceForDim isSlice not)
			ifTrue:[
				subcollection := OrderedCollection new.
				sliceForDim do:[:each| 
					completeSlice value: (each ifNil:[ _@_] ifNotNil:[each]) 
								  value:dimIndex value:subcollection].
				collectionOfSlices add:subcollection asArray
				]
			ifFalse:[
				sliceForDim isMlArray | (sliceForDim isNil)
				ifTrue:[completeSlice value: _@_ value: dimIndex value: collectionOfSlices]
				ifFalse:[	completeSlice value: sliceForDim value: dimIndex value: collectionOfSlices]]
	].

	^	collectionOfSlices 	
]

{ #category : #arithmetic }
MlSlice >> + aSlice [ 
	aSlice isSlice 
		ifTrue:[^ (self x + aSlice x)@(self y + aSlice y)@(self step + aSlice step)]
		ifFalse:[ self error:'We can not add an Integer'] 
]

{ #category : #arithmetic }
MlSlice >> - aSlice [ 
	^ (self x - aSlice x)@(self y - aSlice y)@(self step - aSlice step)
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
