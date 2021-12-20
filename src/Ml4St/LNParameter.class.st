Class {
	#name : #LNParameter,
	#superclass : #FFIStructure,
	#instVars : [
		'bias',
		'n_fold',
		'penalty',
		'dual',
		'loss'
	],
	#classVars : [
		'OFFSET_C',
		'OFFSET_EPS',
		'OFFSET_INIT_SOL',
		'OFFSET_NR_WEIGHT',
		'OFFSET_P',
		'OFFSET_SOLVER_TYPE',
		'OFFSET_WEIGHT',
		'OFFSET_WEIGHT_LABEL'
	],
	#pools : [
		'LNSolverType'
	],
	#category : #'Ml4St-FFI-LibLinear-Uffi'
}

{ #category : #'field definition' }
LNParameter class >> fieldsDesc [
	^ #(
		int solver_type;
		double eps;	       
		double C;
		int nr_weight;
		int *weight_label;
		double* weight;
		double p;
		double *init_sol;
		)
]

{ #category : #initialization }
LNParameter class >> finalizeResourceData:  handle [
	LibLinear destroyParameter: handle.
	handle isNull ifTrue: [ ^ self ].
	handle free. 
	handle beNull
]

{ #category : #initialization }
LNParameter class >> initialize [ 
	LNSolverType initialize
]

{ #category : #'accessing structure variables' }
LNParameter >> C [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_C
]

{ #category : #'accessing structure variables' }
LNParameter >> C: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_C put: anObject
]

{ #category : #accessing }
LNParameter >> bias [
	^ bias ifNil:[bias := -1]
]

{ #category : #accessing }
LNParameter >> bias: anObject [
	bias := anObject
]

{ #category : #accessing }
LNParameter >> dual [
	^dual ifNil:[dual := false]
	
]

{ #category : #accessing }
LNParameter >> dual: aBool [
	dual:= aBool
	
]

{ #category : #'accessing structure variables' }
LNParameter >> eps [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_EPS
]

{ #category : #'accessing structure variables' }
LNParameter >> eps: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_EPS put: anObject
]

{ #category : #'accessing structure variables' }
LNParameter >> init_sol [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_INIT_SOL) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
LNParameter >> init_sol: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_INIT_SOL put: anObject getHandle.
]

{ #category : #initialization }
LNParameter >> initialize [ 	
	super initialize.
	self eps: Float infinity.
	self C:1.
	self p:0.1.
	self nr_weight: 0.
	self solver_type: L2R_L2LOSS_SVC value

	
]

{ #category : #accessing }
LNParameter >> loss [
	^ loss ifNil:[loss:=#l2]
]

{ #category : #accessing }
LNParameter >> loss: l1Orl2Symbol [
	loss := l1Orl2Symbol
]

{ #category : #accessing }
LNParameter >> n_fold [
	^ n_fold ifNil:[n_fold := 5]
]

{ #category : #accessing }
LNParameter >> n_fold: anInteger [
	n_fold:= anInteger
]

{ #category : #'accessing structure variables' }
LNParameter >> nr_weight [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_NR_WEIGHT
]

{ #category : #'accessing structure variables' }
LNParameter >> nr_weight: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_NR_WEIGHT put: anObject
]

{ #category : #'accessing structure variables' }
LNParameter >> p [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_P
]

{ #category : #'accessing structure variables' }
LNParameter >> p: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_P put: anObject
]

{ #category : #accessing }
LNParameter >> penalty [
	^ penalty ifNil:[penalty:=#l2]
]

{ #category : #accessing }
LNParameter >> penalty: l1Orl2Symbol [
	penalty := l1Orl2Symbol
]

{ #category : #'accessing structure variables' }
LNParameter >> solver_type [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_SOLVER_TYPE
]

{ #category : #'accessing structure variables' }
LNParameter >> solver_type: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_SOLVER_TYPE put: anObject.
	anObject = L2R_L2LOSS_SVC value ifTrue:[self eps:0.01].
	anObject = L2R_L2LOSS_SVR value ifTrue:[self eps:0.0001].
	anObject = L2R_LR_DUAL value ifTrue:[self eps:0.1].
	anObject = L1R_LR value ifTrue:[self eps:0.1].
	anObject = L1R_LR value ifTrue:[self eps:0.01].
	anObject = L2R_L2LOSS_SVR_DUAL value ifTrue:[self eps:0.1].
]

{ #category : #'accessing structure variables' }
LNParameter >> weight [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_WEIGHT) type: ExternalType double asPointerType
]

{ #category : #'accessing structure variables' }
LNParameter >> weight: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_WEIGHT put: anObject getHandle.
]

{ #category : #'accessing structure variables' }
LNParameter >> weight_label [
	"This method was automatically generated"
	^ExternalData fromHandle: (handle pointerAt: OFFSET_WEIGHT_LABEL) type: ExternalType long asPointerType
]

{ #category : #'accessing structure variables' }
LNParameter >> weight_label: anObject [
	"This method was automatically generated"
	handle pointerAt: OFFSET_WEIGHT_LABEL put: anObject getHandle.
]
