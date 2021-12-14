Class {
	#name : #MlNativeFloatArray,
	#superclass : #MlNativeNCVector,
	#type : #variable,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #testing }
MlNativeFloatArray >> isMlFloatArray [
	^ true
]

{ #category : #accessing }
MlNativeFloatArray >> libClass [ 
	^ LibFloatNCV	
]
