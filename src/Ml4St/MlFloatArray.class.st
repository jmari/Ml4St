Class {
	#name : #MlFloatArray,
	#superclass : #FFIArray,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'instance creation' }
MlFloatArray class >> new: size [ 
	^ super externalNewType: #float size:size.
]
