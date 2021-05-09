Class {
	#name : #MlNativeIntArray,
	#superclass : #MlNativeNCVector,
	#type : #variable,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #testing }
MlNativeIntArray >> isMlIntArray [
	^ true
]

{ #category : #accessing }
MlNativeIntArray >> libClass [ 
	^ LibIntNCV	
]
