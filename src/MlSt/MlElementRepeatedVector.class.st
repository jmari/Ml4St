"
I am a false repeated ntimes each element vector, I am used for Maths operations between broadcasted vectors and multidimensional Arrays. 
get an instance using:
- newFrom: anArray timesRepeat:tr 
- at: index returns the element at position index.

Example:
a := MlElementRepeatedVector newFrom: #(2 5) timesRepeated:5
the behaviour of a will be like a:= #(2 2 2 2 2 5 5 5 5 5) but internally is #(2 5)


"
Class {
	#name : #MlElementRepeatedVector,
	#superclass : #MlRedimensionableArray,
	#type : #variable,
	#category : #'MlSt-Core'
}

{ #category : #accessing }
MlElementRepeatedVector >> at: anInteger [ 
	| pos |
	pos := ((anInteger -1/ timesRepeat ) asInteger).

	^ self buffer at: (pos \\ self size) +1
]
