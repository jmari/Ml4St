Class {
	#name : #MlFloatArray,
	#superclass : #FFIArray,
	#category : #'MlSt-FFI-NCVector'
}

{ #category : #'instance creation' }
MlFloatArray class >> new: size [ 
	^ super newArrayTypeOf: #float size: size
]
