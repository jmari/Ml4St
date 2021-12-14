Class {
	#name : #LNModel,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_BIAS',
		'OFFSET_LABEL',
		'OFFSET_NR_CLASS',
		'OFFSET_NR_FEATURE',
		'OFFSET_PARAM',
		'OFFSET_W'
	],
	#category : #'Ml4St-FFI-LibLinear-Uffi'
}

{ #category : #'as yet unclassified' }
LNModel class >> fieldsDesc [
	^#(
		LNParameter param;
		int nr_class;		
		int nr_feature;
		double *w;
		int *label;		
		double bias;
	)
]

{ #category : #finalization }
LNModel class >> finalizeResourceData:  aTuple [
	| model param |
	model := aTuple first.
	param := aTuple last.
	LibLinear destroyParameter: param.
	param isNull ifFalse:[
		param free. 
		param beNull].
	LibLinear freeAndDestroyModel: model.
	model isNull ifFalse: [ 
		model free. 
		model beNull]
	
]

{ #category : #finalization }
LNModel class >> resourceData [ 
	^ {self getHandle. self param  }
	
]

{ #category : #'accessing structure variables' }
LNModel >> bias [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_BIAS
]

{ #category : #'accessing structure variables' }
LNModel >> bias: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_BIAS put: anObject
]

{ #category : #'accessing structure variables' }
LNModel >> label [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LABEL) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
LNModel >> label: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LABEL put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
LNModel >> nr_class [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NR_CLASS
]

{ #category : #'accessing structure variables' }
LNModel >> nr_class: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NR_CLASS put: anObject
]

{ #category : #'accessing structure variables' }
LNModel >> nr_feature [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NR_FEATURE
]

{ #category : #'accessing structure variables' }
LNModel >> nr_feature: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NR_FEATURE put: anObject
]

{ #category : #'accessing structure variables' }
LNModel >> param [
	"This method was automatically generated"
	^ LNParameter fromHandle: (handle referenceStructAt: OFFSET_PARAM length: LNParameter byteSize)
]

{ #category : #'accessing structure variables' }
LNModel >> param: anObject [
	"This method was automatically generated"
	handle structAt: OFFSET_PARAM put: anObject getHandle length: LNParameter byteSize
]

{ #category : #'accessing structure variables' }
LNModel >> w [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_W) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
LNModel >> w: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_W put: anObject getHandle.
]
