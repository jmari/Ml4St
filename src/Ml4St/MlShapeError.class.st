Class {
	#name : #MlShapeError,
	#superclass : #Error,
	#category : #'Ml4St-Exceptions'
}

{ #category : #initialization }
MlShapeError >> initialize [ 
	super initialize .
	self messageText: 'Incompatible shape for this array'
]
