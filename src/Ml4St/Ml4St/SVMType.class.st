Class {
	#name : #SVMType,
	#superclass : #FFIEnumeration,
	#classVars : [
		'C_SVC',
		'EPSILON_SVR',
		'NU_SVC',
		'NU_SVR',
		'ONE_CLASS'
	],
	#category : #'Ml4St-FFI-LibSVM-Uffi'
}

{ #category : #'as yet unclassified' }
SVMType class >> enumDecl [
	^ #(
			C_SVC 0
			NU_SVC 1
			ONE_CLASS 2
			EPSILON_SVR 3
			NU_SVR 4 
			)
]
