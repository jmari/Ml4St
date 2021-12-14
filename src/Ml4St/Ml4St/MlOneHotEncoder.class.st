Class {
	#name : #MlOneHotEncoder,
	#superclass : #MlOrdinalEncoder,
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlOneHotEncoder >> inverseTransform: aMlArray [

	^  aMlArray oneHotDecode: encoder 
	
]

{ #category : #'protected-abstract' }
MlOneHotEncoder >> transform: aMlArray [

	^  aMlArray oneHotEncode: encoder 
	
]
