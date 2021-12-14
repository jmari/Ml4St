Class {
	#name : #MlOrdinalEncoder,
	#superclass : #MlTransformer,
	#instVars : [
		'encoder'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlOrdinalEncoder >> fitParameters: aMlArray [
	
	encoder := aMlArray buildEncoder: 0.

]

{ #category : #'protected-abstract' }
MlOrdinalEncoder >> inverseTransform: aMlArray [
	^  (aMlArray  decode: encoder ) 

]

{ #category : #'protected-abstract' }
MlOrdinalEncoder >> transform: aMlArray [

	^  aMlArray  encode: encoder 
	
]
