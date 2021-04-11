Class {
	#name : #SVMNode,
	#superclass : #FFIStructure,
	#classVars : [
		'OFFSET_INDEX',
		'OFFSET_VALUE'
	],
	#category : #'Ml4St-FFI-LibSVM-Uffi'
}

{ #category : #'field definition' }
SVMNode class >> fieldsDesc [
	^ #(
		int index;
		double value;
		)
]

{ #category : #'accessing structure variables' }
SVMNode >> index [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_INDEX
]

{ #category : #'accessing structure variables' }
SVMNode >> index: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_INDEX put: anObject
]

{ #category : #'accessing structure variables' }
SVMNode >> value [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_VALUE
]

{ #category : #'accessing structure variables' }
SVMNode >> value: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_VALUE put: anObject
]
