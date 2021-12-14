Class {
	#name : #MlLinearSVC,
	#superclass : #MlLinearClassifier,
	#category : #'Ml4St-LinearModel'
}

{ #category : #initialization }
MlLinearSVC >> initializeSolver [
	(self parameters at:#penalty) = #l1 ifTrue:[
		(self parameters at:#dual) 
		ifTrue:[self error:'penalty: #l1 and dual:true is not possible for the SVC classifier']
		ifFalse:[
			(self parameters at:#loss) = #l1 
			ifTrue:[self error:'penalty: #l1 and loss: #l1 is not possible for the SVC classifier']
			ifFalse:[self parameters at:#solver_type put: L1R_L2LOSS_SVC value]]].
	
	(self parameters at:#penalty) = #l2 ifTrue:[
		(self parameters at:#dual) 
		ifTrue:[
		 	(self parameters at:#loss) = #l1 
			ifTrue:[self parameters at:#solver_type put: L2R_L1LOSS_SVC_DUAL value]
			ifFalse:[self parameters at:#solver_type put: L2R_L2LOSS_SVC_DUAL value]]]
		ifFalse:[self parameters at:#solver_type put: L2R_L2LOSS_SVC value]
				
				
]
