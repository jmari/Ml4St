Class {
	#name : #SVMModel,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_FREE_SV',
		'OFFSET_L',
		'OFFSET_LABEL',
		'OFFSET_NR_CLASS',
		'OFFSET_NSV',
		'OFFSET_PARAM',
		'OFFSET_PROBA',
		'OFFSET_PROBB',
		'OFFSET_RHO',
		'OFFSET_SV',
		'OFFSET_SV_COEF',
		'OFFSET_SV_INDICES'
	],
	#category : #'Ml4St-FFI-LibSVM-Uffi'
}

{ #category : #'field definition' }
SVMModel class >> fieldsDesc [
	^ #(
		SVMParameter param;
		int nr_class;
		int l;
		SVMNode **SV;
		double **sv_coef;
		double *rho;
		double *probA;
		double *probB;
		int *sv_indices;
		int *label;
		int *nSV
		int free_sv;
		)
]

{ #category : #'accessing structure variables' }
SVMModel >> SV [
	"This method was automatically generated"
	^SVMNode fromHandle: (handle pointerAt: OFFSET_SV)
]

{ #category : #'accessing structure variables' }
SVMModel >> SV: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_SV put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> free_sv [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_FREE_SV
]

{ #category : #'accessing structure variables' }
SVMModel >> free_sv: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_FREE_SV put: anObject
]

{ #category : #'accessing structure variables' }
SVMModel >> l [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_L
]

{ #category : #'accessing structure variables' }
SVMModel >> l: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_L put: anObject
]

{ #category : #'accessing structure variables' }
SVMModel >> label [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LABEL) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> label: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LABEL put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> nSV [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_NSV) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> nSV: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_NSV put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> nr_class [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NR_CLASS
]

{ #category : #'accessing structure variables' }
SVMModel >> nr_class: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NR_CLASS put: anObject
]

{ #category : #'accessing structure variables' }
SVMModel >> param [
	"This method was automatically generated"
	^ SVMParameter fromHandle: (handle referenceStructAt: OFFSET_PARAM length: SVMParameter byteSize)
]

{ #category : #'accessing structure variables' }
SVMModel >> param: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_PARAM put: anObject getHandle length: SVMParameter byteSize
]

{ #category : #'accessing structure variables' }
SVMModel >> probA [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PROBA) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> probA: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PROBA put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> probB [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_PROBB) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> probB: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_PROBB put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> rho [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_RHO) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> rho: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_RHO put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> sv_coef [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_SV_COEF) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> sv_coef: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_SV_COEF put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMModel >> sv_indices [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_SV_INDICES) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
SVMModel >> sv_indices: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_SV_INDICES put: anObject getHandle.
]
