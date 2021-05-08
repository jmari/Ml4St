Class {
	#name : #MlFloatArray,
	#superclass : #MlNCArray,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'instance creation' }
MlFloatArray class >> new: size [ 
	^ self ffiClass externalNewType: #float size:size.
]

{ #category : #testing }
MlFloatArray >> isMlFloatArray [
	^ true
]

{ #category : #accessing }
MlFloatArray >> libClass [ 
	^ LibFloatNCV	
]
