Class {
	#name : #LNSolverType,
	#superclass : #FFIEnumeration,
	#classVars : [
		'L1R_L2LOSS_SVC',
		'L1R_LR',
		'L2R_L1LOSS_SVC_DUAL',
		'L2R_L1LOSS_SVR_DUAL',
		'L2R_L2LOSS_SVC',
		'L2R_L2LOSS_SVC_DUAL',
		'L2R_L2LOSS_SVR',
		'L2R_L2LOSS_SVR_DUAL',
		'L2R_LR',
		'L2R_LR_DUAL',
		'MCSVM_CS'
	],
	#category : #'MlSt-FFI-LibLinear-Uffi'
}

{ #category : #'as yet unclassified' }
LNSolverType class >> enumDecl [
	^ #(
			L2R_LR 0
			L2R_L2LOSS_SVC_DUAL 1
			L2R_L2LOSS_SVC 2
			L2R_L1LOSS_SVC_DUAL 3
			MCSVM_CS 4 
			L1R_L2LOSS_SVC 5 
			L1R_LR 6 
			L2R_LR_DUAL 7 
			L2R_L2LOSS_SVR 11
			L2R_L2LOSS_SVR_DUAL 12 
			L2R_L1LOSS_SVR_DUAL 13
			)
]
