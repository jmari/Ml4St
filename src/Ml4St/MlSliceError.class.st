Class {
	#name : #MlSliceError,
	#superclass : #Error,
	#category : #'Ml4St-Exceptions'
}

{ #category : #initialization }
MlSliceError >> initialize [ 
	super initialize .
	self messageText: 'Incompatible slice for this array'
]
