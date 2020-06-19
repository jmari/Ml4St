Class {
	#name : #MlIndexTypeError,
	#superclass : #Error,
	#category : #'MlSt-Exceptions'
}

{ #category : #initialization }
MlIndexTypeError >> initialize [ 
	super initialize .
	self messageText: 'Index type error'
]
