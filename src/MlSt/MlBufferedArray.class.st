"
I am a false array, the real array is stored in buffer, I'm used to allow operations in the index of the array, like slice or broadcast
"
Class {
	#name : #MlBufferedArray,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'size',
		'buffer'
	],
	#category : #'MlSt-Core'
}

{ #category : #comparing }
MlBufferedArray >> = anArray [
	anArray size = self size ifFalse:[^false].
	1 to:self size do:[:i| (self at:i) ~= (anArray at:i) ifTrue:[^false]].
	^ true
]

{ #category : #accessing }
MlBufferedArray >> at: anObject [
	self subclassResponsibility 

]

{ #category : #accessing }
MlBufferedArray >> at: anObject put: otherObject [
	self subclassResponsibility 

]

{ #category : #accessing }
MlBufferedArray >> buffer [ 

	^ buffer ifNil:[ buffer := Array new]
]

{ #category : #accessing }
MlBufferedArray >> buffer: anArray [ 
	buffer := anArray
]

{ #category : #accessing }
MlBufferedArray >> bufferSize [

	^ self buffer size
]

{ #category : #accessing }
MlBufferedArray >> bufferSpecies [
	| myBuffer myClass |
	myBuffer := self buffer.
	myClass := self buffer species.
	[ myBuffer species = self class] whileTrue:[ 
		myBuffer := myBuffer buffer.
		myClass := myBuffer species].
	^ myClass
]

{ #category : #accessing }
MlBufferedArray >> byteSize [
	^ self buffer byteSize
]

{ #category : #'*MlSt' }
MlBufferedArray >> decode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) decode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> describe [
	|describeResult |
	"It is done one by one...all except mean and variance not in one pass"
	describeResult := MlDescribeResult new.

	describeResult mean:self mean.
	describeResult variance: self variance.
	describeResult max: self max.
	describeResult min: self min.
	describeResult numberOfObs: self size.
	describeResult skewness: self skewness.
	describeResult kurtosis: self kurtosis.
	
	^ describeResult
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> encode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) encode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> oneHotDecode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotDecode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> oneHotEncode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotEncode:e]
	
	 
		
]

{ #category : #accessing }
MlBufferedArray >> size [

	^ size
]

{ #category : #accessing }
MlBufferedArray >> size: anObject [
	size := anObject
]

{ #category : #'*MlSt' }
MlBufferedArray >> summary [ 
	| summary |
	self size = 0 ifTrue:[^ MlDescribeResult new].
	self first isNumber ifTrue:[ ^ self describe ].
	
	summary := Dictionary new.
	self do:[:each|
		summary at: each incrementBy:1].
	^ summary
	
	 
		
]
