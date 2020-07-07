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
	#name : #MlLabeledSlice,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'step'
	],
	#category : #'MlSt-Core'
}

{ #category : #converting }
MlLabeledSlice >> @ anObject [
	self step: anObject
]

{ #category : #converting }
MlLabeledSlice >> asSlice [
	^self
]

{ #category : #testing }
MlLabeledSlice >> isSlice [ 
	^ true
]

{ #category : #accessing }
MlLabeledSlice >> step [ 	
	^ self at:3 ifAbsent:[1]
]

{ #category : #accessing }
MlLabeledSlice >> step: anInteger [ 	
	self at:3 put: anInteger
	
]

{ #category : #accessing }
MlLabeledSlice >> x [
	^ self at:1 
]

{ #category : #accessing }
MlLabeledSlice >> x: anObject [
	self at:1 put: anObject
]

{ #category : #accessing }
MlLabeledSlice >> y [
	^ self at:2
]

{ #category : #accessing }
MlLabeledSlice >> y: anObject [
	self at:2 put: anObject
]
