"
MlImputers replaces ""missing values"" by other values like Constants, Means. medians and mode.
Imputers do not create a new buffer, they use replace:  by: 
"
Class {
	#name : #MlImputer,
	#superclass : #MlTransformer,
	#instVars : [
		'missingValue'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #initialization }
MlImputer >> initialize [ 
	super initialize.
	"nan is default missingValue.
	 you can change it before instantiate using the accessor"
	missingValue := Float nan	
]

{ #category : #'protected-abstract' }
MlImputer >> inverseTransform: aMlArray [

	^ self error:'Inverse Transform is not possible'
	
	
	  
]

{ #category : #'as yet unclassified' }
MlImputer >> missingValue [

	^ missingValue 
]

{ #category : #'as yet unclassified' }
MlImputer >> missingValue: aValue [

	missingValue:= aValue 
]
