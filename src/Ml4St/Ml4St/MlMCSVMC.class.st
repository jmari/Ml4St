"
multi-class support vector classification by Crammer and Singer
"
Class {
	#name : #MlMCSVMC,
	#superclass : #MlLinearClassifier,
	#category : #'Ml4St-LinearModel'
}

{ #category : #initialization }
MlMCSVMC >> initializeSolver [
	self parameters at:#solver_type put: MCSVM_CS value.
]
