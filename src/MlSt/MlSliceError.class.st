Class {
	#name : #MlSliceError,
	#superclass : #Error,
	#category : #'MlSt-Exceptions'
}

{ #category : #initialization }
MlSliceError >> initialize [ 
	super initialize .
	self messageText: 'Incompatible slice for this array'
]
