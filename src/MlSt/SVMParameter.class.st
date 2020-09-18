Class {
	#name : #SVMParameter,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_C',
		'OFFSET_CACHE_SIZE',
		'OFFSET_COEF0',
		'OFFSET_DEGREE',
		'OFFSET_EPS',
		'OFFSET_GAMMA',
		'OFFSET_KERNEL_TYPE',
		'OFFSET_NR_WEIGHT',
		'OFFSET_NU',
		'OFFSET_P',
		'OFFSET_PROBABILITY',
		'OFFSET_SHRINKING',
		'OFFSET_SVM_TYPE',
		'OFFSET_WEIGHT',
		'OFFSET_WEIGHT_LABEL'
	],
	#category : #'MlSt-FFI-LibSVM-Uffi'
}

{ #category : #'field definition' }
SVMParameter class >> fieldsDesc [
	^ #(
		int svm_type;
		int kernel_type;
		int degree;
		double gamma;	       
		double coef0; 
		double cache_size;
		double eps;
		double C;
		int nr_weight;
		int *weight_label;
		double* weight;
		double nu;
		double p;
		int shrinking;
		int probability;
		)
]

{ #category : #'accessing structure variables' }
SVMParameter >> C [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_C
]

{ #category : #'accessing structure variables' }
SVMParameter >> C: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_C put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> bias [ 
	^ -1
]

{ #category : #'accessing structure variables' }
SVMParameter >> cache_size [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_CACHE_SIZE
]

{ #category : #'accessing structure variables' }
SVMParameter >> cache_size: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_CACHE_SIZE put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> coef0 [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_COEF0
]

{ #category : #'accessing structure variables' }
SVMParameter >> coef0: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_COEF0 put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> degree [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_DEGREE
]

{ #category : #'accessing structure variables' }
SVMParameter >> degree: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_DEGREE put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> eps [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_EPS
]

{ #category : #'accessing structure variables' }
SVMParameter >> eps: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_EPS put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> gamma [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_GAMMA
]

{ #category : #'accessing structure variables' }
SVMParameter >> gamma: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_GAMMA put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> kernel_type [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_KERNEL_TYPE
]

{ #category : #'accessing structure variables' }
SVMParameter >> kernel_type: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_KERNEL_TYPE put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> nr_weight [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NR_WEIGHT
]

{ #category : #'accessing structure variables' }
SVMParameter >> nr_weight: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NR_WEIGHT put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> nu [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_NU
]

{ #category : #'accessing structure variables' }
SVMParameter >> nu: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_NU put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> p [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_P
]

{ #category : #'accessing structure variables' }
SVMParameter >> p: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_P put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> probability [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_PROBABILITY
]

{ #category : #'accessing structure variables' }
SVMParameter >> probability: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_PROBABILITY put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> shrinking [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SHRINKING
]

{ #category : #'accessing structure variables' }
SVMParameter >> shrinking: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SHRINKING put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> solver_type [
	"just to be compatible with liblinear"
	^handle signedLongAt: OFFSET_SVM_TYPE
]

{ #category : #'accessing structure variables' }
SVMParameter >> svm_type [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SVM_TYPE
]

{ #category : #'accessing structure variables' }
SVMParameter >> svm_type: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SVM_TYPE put: anObject
]

{ #category : #'accessing structure variables' }
SVMParameter >> weight [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_WEIGHT) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
SVMParameter >> weight: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_WEIGHT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
SVMParameter >> weight_label [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_WEIGHT_LABEL) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
SVMParameter >> weight_label: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_WEIGHT_LABEL put: anObject getHandle.
]
