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
