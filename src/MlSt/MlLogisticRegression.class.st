Class {
	#name : #MlLogisticRegression,
	#superclass : #MlLinearClassifier,
	#category : #'MlSt-LinearModel-Classification'
}

{ #category : #initialization }
MlLogisticRegression >> initializeSolver [
	(self parameters at:#penalty) = #l1 ifTrue:[self parameters at:#solver_type put:L1R_LR value].
	(self parameters at:#penalty) = #l2 ifTrue:[
		(self parameters at:#dual) 
			ifTrue:[self parameters at:#solver_type put:L2R_LR_DUAL value]
			ifFalse:[self parameters at:#solver_type put:L2R_LR value]]
]
