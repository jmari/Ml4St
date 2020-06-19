Class {
	#name : #LNProblem,
	#superclass : #FFIStructure,
	#instVars : [
		'x_space',
		'f_array'
	],
	#classVars : [
		'OFFSET_BIAS',
		'OFFSET_L',
		'OFFSET_N',
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : #'MlSt-FFI-LibLinear-Uffi'
}

{ #category : #'field definition' }
LNProblem class >> fieldsDesc [
	^ #(
		int l;
		int n;
		double *y;
		LNFeatureNode  **x;
		double bias;
		)
]

{ #category : #finalization }
LNProblem class >> finalizeResourceData:  aTuple [
	|  x_space x_list y handle |
	handle := aTuple at:1.
	x_space := aTuple at:2.
	x_list :=aTuple at:3.
	y := aTuple at:4. 
	x_space isNull ifFalse:[
		x_space free.
		x_space beNull].
	x_list isNull ifFalse:[
		x_list free.
		x_list beNull].
	y isNull ifFalse:[
		y free.
		y beNull].
	
	handle isNull ifFalse: [
		handle free. 
		handle beNull].
]

{ #category : #'field definition' }
LNProblem class >> resourceData [ 
	^ {self getHandle. self x_space. self f_array, self y }
]

{ #category : #'accessing structure variables' }
LNProblem >> bias [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_BIAS
]

{ #category : #'accessing structure variables' }
LNProblem >> bias: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_BIAS put: anObject
]

{ #category : #accessing }
LNProblem >> f_array [
	^ f_array 
	
]

{ #category : #accessing }
LNProblem >> f_array: featuresArray [
	f_array := featuresArray
	
]

{ #category : #'accessing structure variables' }
LNProblem >> l [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_L
]

{ #category : #'accessing structure variables' }
LNProblem >> l: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_L put: anObject
]

{ #category : #'accessing structure variables' }
LNProblem >> n [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_N
]

{ #category : #'accessing structure variables' }
LNProblem >> n: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_N put: anObject
]

{ #category : #'accessing structure variables' }
LNProblem >> x [
	"This method was automatically generated"
	^LNFeatureNode fromHandle: (handle pointerAt: OFFSET_X)
]

{ #category : #'accessing structure variables' }
LNProblem >> x: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_X put: anObject getHandle.
]

{ #category : #accessing }
LNProblem >> x_space [
	^ x_space 
	
]

{ #category : #accessing }
LNProblem >> x_space: xSpace [
	x_space := xSpace
	
]

{ #category : #'accessing structure variables' }
LNProblem >> y [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_Y) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
LNProblem >> y: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_Y put: anObject getHandle.
]
