Class {
	#name : #LNFeatureNode,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_INDEX',
		'OFFSET_VALUE'
	],
	#category : #'MlSt-FFI-LibLinear-Uffi'
}

{ #category : #'field definition' }
LNFeatureNode class >> fieldsDesc [
	^ #(
		int index;
		double value;
		)
]

{ #category : #'accessing structure variables' }
LNFeatureNode >> index [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_INDEX
]

{ #category : #'accessing structure variables' }
LNFeatureNode >> index: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_INDEX put: anObject
]

{ #category : #'accessing structure variables' }
LNFeatureNode >> value [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_VALUE
]

{ #category : #'accessing structure variables' }
LNFeatureNode >> value: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_VALUE put: anObject
]
