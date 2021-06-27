Class {
	#name : #MlNativeIntArray,
	#superclass : #MlNativeNCVector,
	#type : #variable,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'instance creation' }
MlNativeIntArray class >> new: size [ 
	^ self ffiClass externalNewType: #uint64 size:size.
]

{ #category : #testing }
MlNativeIntArray >> isMlIntArray [
	^ true
]

{ #category : #accessing }
MlNativeIntArray >> libClass [ 
	^ LibIntNCV	
]
