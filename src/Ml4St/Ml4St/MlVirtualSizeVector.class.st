"
I am a false n-times repeated lenght vector, I am used for Maths operations between broadcasted vectors and multidimensional 

"
Class {
	#name : #MlVirtualSizeVector,
	#superclass : #MlBufferedArray,
	#type : #variable,
	#instVars : [
		'timesRepeat'
	],
	#category : #'Ml4St-Core'
}

{ #category : #'instance creation' }
MlVirtualSizeVector class >> new: size [
	| hisBuffer myClass i |
	
	myClass := Array.
	hisBuffer := thisContext sender at:1 ifAbsent:[nil].

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
MlVirtualSizeVector class >> newFrom: anArray timesRepeat:tr [ 
	| i |
	i := self basicNew.
	i buffer: (anArray class newFrom:anArray).
	i ntimes:tr.
	i size: (anArray size * tr).
	^ i
]

{ #category : #accessing }
MlVirtualSizeVector >> at: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
MlVirtualSizeVector >> at: anObject put: aValue [
	MlNonWritableObject signal
]

{ #category : #testing }
MlVirtualSizeVector >> isSliced [
	^ true
]

{ #category : #accessing }
MlVirtualSizeVector >> ntimes: tr [ 
	timesRepeat:= tr
]
