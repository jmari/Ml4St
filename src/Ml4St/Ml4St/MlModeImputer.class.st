"
MlImputers replaces ""missing values"" by other values like the Mode of each column, in this case...
Imputers do not create a new buffer, they use replace:  by:
"
Class {
	#name : #MlModeImputer,
	#superclass : #MlImputer,
	#instVars : [
		'uMatrix'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlModeImputer >> fitParameters: aMlArray [

	uMatrix := aMlArray mode: 0 exclude:self missingValue.
	
]

{ #category : #'protected-abstract' }
MlModeImputer >> transform: aMlArray [

	^  aMlArray  replace: self missingValue by: uMatrix 
]
