Class {
	#name : #MlIntArray,
	#superclass : #MlNCArray,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'instance creation' }
MlIntArray class >> new: size [ 
	^ self ffiClass externalNewType: #uint64 size:size.
]

{ #category : #testing }
MlIntArray >> isMlIntArray [
	^ true
]

{ #category : #accessing }
MlIntArray >> libClass [ 
	^ LibIntNCV	
]
