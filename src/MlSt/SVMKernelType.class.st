Class {
	#name : #SVMKernelType,
	#superclass : #FFIEnumeration,
	#classVars : [
		'LINEAR',
		'POLY',
		'PRECOMPUTED',
		'RBF',
		'SIGMOID'
	],
	#category : #'MlSt-FFI-LibSVM-Uffi'
}

{ #category : #'as yet unclassified' }
SVMKernelType class >> enumDecl [
	^ #(
		LINEAR 1
		POLY 2
		RBF 3
		SIGMOID 4
		PRECOMPUTED 5
			)
]
