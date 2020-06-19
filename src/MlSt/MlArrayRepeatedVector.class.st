"
I am a false repeated ntimes the array in, I am used for Maths operations between broadcasted vectors and multidimensional Arrays. 
get an instance using:
- newFrom: anArray timesRepeat:tr 
- at: index returns the element at position index.

Example:
a := MlArrayRepeatedVector newFrom: #(2 5) timesRepeated:5
the behaviour of a will be like a:= #(2 5 2 5 2 5 2 5 2 5) but internally is #(2 5)
"
Class {
	#name : #MlArrayRepeatedVector,
	#superclass : #MlRedimensionableArray,
	#type : #variable,
	#category : #'MlSt-Core'
}

{ #category : #accessing }
MlArrayRepeatedVector >> at: anInteger [ 
	anInteger > self size ifTrue:[^ SubscriptOutOfBounds signal: anInteger].
	^ self buffer at: ((anInteger -1) \\ (self buffer size ) ) +1
]
