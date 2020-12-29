Class {
	#name : #MlIntArray,
	#superclass : #FFIArray,
	#category : #'MlSt-FFI-NCVector'
}

{ #category : #'instance creation' }
MlIntArray class >> new: size [ 
	^ super newArrayTypeOf: #int size: size
]
