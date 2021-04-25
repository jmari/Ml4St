Class {
	#name : #NCFloatVector,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_LASTPOS',
		'OFFSET_REALSIZE',
		'OFFSET_SIZE',
		'OFFSET_STRIDES',
		'OFFSET_STRIDESSIZE',
		'OFFSET_VALUES'
	],
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'field definition' }
NCFloatVector class >> fieldsDesc [
	^ #(
		int * strides;
		int stridesSize;
		int realSize;	       
		int size;
		int  *lastPos;
		float *values; 
		)
]

{ #category : #'accessing structure variables' }
NCFloatVector >> lastPos [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_LASTPOS) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
NCFloatVector >> lastPos: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_LASTPOS put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
NCFloatVector >> realSize [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_REALSIZE
]

{ #category : #'accessing structure variables' }
NCFloatVector >> realSize: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_REALSIZE put: anObject
]

{ #category : #'accessing structure variables' }
NCFloatVector >> size [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SIZE
]

{ #category : #'accessing structure variables' }
NCFloatVector >> size: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SIZE put: anObject
]

{ #category : #'accessing structure variables' }
NCFloatVector >> strides [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_STRIDES) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
NCFloatVector >> strides: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_STRIDES put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
NCFloatVector >> stridesSize [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_STRIDESSIZE
]

{ #category : #'accessing structure variables' }
NCFloatVector >> stridesSize: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_STRIDESSIZE put: anObject
]

{ #category : #'accessing structure variables' }
NCFloatVector >> values [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_VALUES) type: ExternalType float asPointerType
]

{ #category : #'accessing structure variables' }
NCFloatVector >> values: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_VALUES put: anObject getHandle.
]
