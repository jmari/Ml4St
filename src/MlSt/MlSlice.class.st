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

{ #category : #converting }
MlSlice >> asSlice [
	^self
]

{ #category : #testing }
MlSlice >> isSlice [ 
	^ true
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
