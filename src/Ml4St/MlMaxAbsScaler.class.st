Class {
	#name : #MlMaxAbsScaler,
	#superclass : #MlTransformer,
	#instVars : [
		'maxAbsolute'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlMaxAbsScaler >> fitParameters: aMlArray [
	| max |
	max := aMlArray max: 0.
	maxAbsolute:= max abs 
]

{ #category : #'protected-abstract' }
MlMaxAbsScaler >> inverseTransform: aMlArray [

	^ aMlArray * maxAbsolute 
]

{ #category : #'protected-abstract' }
MlMaxAbsScaler >> transform: aMlArray [

	^ aMlArray / maxAbsolute 
]
