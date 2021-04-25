Class {
	#name : #MlInt64Array,
	#superclass : #FFIArray,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'instance creation' }
MlInt64Array class >> new: size [ 
	^ super  externalNewType: #uint64 size:size.
]
