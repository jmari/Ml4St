Class {
	#name : #MlIndexTypeError,
	#superclass : #Error,
	#category : #'Ml4St-Exceptions'
}

{ #category : #initialization }
MlIndexTypeError >> initialize [ 
	super initialize .
	self messageText: 'Index type error'
]
