"
I am a false n-times repeated lenght vector, I am used for Maths operations between broadcasted vectors and multidimensional 

"
Class {
	#name : #MlRedimensionableArray,
	#superclass : #MlBufferedArray,
	#type : #variable,
	#instVars : [
		'timesRepeat'
	],
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlRedimensionableArray class >> new: size [
	| hisBuffer myClass i |
	
	myClass := Array.
	hisBuffer := thisContext sender at:1.

	[hisBuffer isKindOf: MlBufferedArray] whileTrue:[ 
		hisBuffer := hisBuffer buffer.
		myClass := hisBuffer species].

	i := self basicNew.
	i buffer: (myClass new:size).
	i ntimes:1.
	i size: size .
	^ i


]

{ #category : #'instance creation' }
MlRedimensionableArray class >> newFrom: anArray timesRepeat:tr [ 
	| i |
	i := self basicNew.
	i buffer: (anArray class newFrom:anArray).
	i ntimes:tr.
	i size: (anArray size * tr).
	^ i
]

{ #category : #accessing }
MlRedimensionableArray >> at: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
MlRedimensionableArray >> at: anObject put: aValue [
	MlNonWritableObject signal
]

{ #category : #accessing }
MlRedimensionableArray >> ntimes: tr [ 
	timesRepeat:= tr
]
