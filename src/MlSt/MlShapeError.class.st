Class {
	#name : #MlShapeError,
	#superclass : #Error,
	#category : #'MlSt-Exceptions'
}

{ #category : #initialization }
MlShapeError >> initialize [ 
	super initialize .
	self messageText: 'Incompatible shape for this array'
]
