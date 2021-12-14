"
int solver_type;
		double eps;	       
		double C;
		int nr_weight;
		int *weight_label;
		double* weight;
		double p;
		double *init_sol;
"
Class {
	#name : #MlLibLinearParameter,
	#superclass : #MlParameterDictionary,
	#instVars : [
		'linearParameter'
	],
	#category : #'Ml4St-LinearModel'
}

{ #category : #initialization }
MlLibLinearParameter >> nativeParameters [  
	
	^ linearParameter ifNil:[ linearParameter := LNParameter new].
]
