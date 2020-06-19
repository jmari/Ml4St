"
MlFakeSlice is used to allow String@integer@String syntax of a Slice.
Implements
	x, y and steps: accessor methods to have same access behaviour as MlSlice(Point).
	isSlice: yes, it is also an slice...or looks like it. 
	It is an Array becouse we have to run through it changing the labels by indexes number.
	
	#( slice1 slice2 ... slice n)
		#(x y) 
	 
"
Class {
	#name : #MlFakeSlice,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'step'
	],
	#category : #'MlSt-Core'
}

{ #category : #converting }
MlFakeSlice >> @ anObject [
	self step: anObject
]

{ #category : #converting }
MlFakeSlice >> asSlice [
	^self
]

{ #category : #testing }
MlFakeSlice >> isSlice [ 
	^ true
]

{ #category : #accessing }
MlFakeSlice >> step [ 	
	^ self at:3 ifAbsent:[1]
]

{ #category : #accessing }
MlFakeSlice >> step: anInteger [ 	
	self at:3 put: anInteger
	
]

{ #category : #accessing }
MlFakeSlice >> x [
	^ self at:1 
]

{ #category : #accessing }
MlFakeSlice >> x: anObject [
	self at:1 put: anObject
]

{ #category : #accessing }
MlFakeSlice >> y [
	^ self at:2
]

{ #category : #accessing }
MlFakeSlice >> y: anObject [
	self at:2 put: anObject
]
