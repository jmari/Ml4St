Class {
	#name : #MlNormalizer,
	#superclass : #MlTransformer,
	#instVars : [
		'module'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #'protected-abstract' }
MlNormalizer >> fitParameters: aMlArray [
	module := aMlArray module
]

{ #category : #'protected-abstract' }
MlNormalizer >> inverseTransform: aMlArray [
	^ aMlArray * module
]

{ #category : #'protected-abstract' }
MlNormalizer >> transform: aMlArray [
	^ aMlArray / module
]
