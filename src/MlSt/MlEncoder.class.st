Class {
	#name : #MlEncoder,
	#superclass : #Dictionary,
	#instVars : [
		'reverseIndex',
		'max'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #adding }
MlEncoder >> add: anElement [

	self at:anElement ifAbsentPut: [
			self reverseIndex at: (self size + 1)  put:anElement.
			(self size + 1)].
	max := self size.

	
	
	
]

{ #category : #adding }
MlEncoder >> add: anElement value: aVal [

	self at:anElement ifAbsentPut: [self reverseIndex at: aVal  put:anElement. aVal].
	self max < aVal ifTrue:[  max := aVal ]
	
	
	
	
]

{ #category : #adding }
MlEncoder >> decode: anIndex [
	^ self reverseIndex at:anIndex ifAbsent:[anIndex]
	
	
	
]

{ #category : #adding }
MlEncoder >> encode: anElement [
	^ self at: anElement ifAbsent:[anElement]
	
	
	
]

{ #category : #adding }
MlEncoder >> max [ 
	^ max ifNil:[max:= Integer minVal]
	
	
	
	
]

{ #category : #adding }
MlEncoder >> oneHotDecode: aMlArray [
	aMlArray as1DArray doWithIndex:[:e :anIndex|
		e = 1 ifTrue:[ ^ self reverseIndex at:anIndex ifAbsent:[ aMlArray ]]].
	^ aMlArray
	
	
	
]

{ #category : #adding }
MlEncoder >> oneHotEncode: anElement [
	|e |
	e:= self at: anElement ifAbsent:[anElement].
	^ (MlArray zeros: self max) at:e put:1;yourself.
	
	
	
]

{ #category : #adding }
MlEncoder >> reverseIndex [
	^ reverseIndex ifNil:[reverseIndex := Dictionary new]
	
	
	
]
