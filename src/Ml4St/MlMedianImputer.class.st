"
MlImputers replaces ""missing values"" by other values like Median of each column, in this case...
Imputers do not create a new buffer, they use replace:  by:
"
Class {
	#name : #MlMedianImputer,
	#superclass : #MlImputer,
	#instVars : [
		'uMatrix'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlMedianImputer >> fitParameters: aMlArray [

	uMatrix := aMlArray median: 0 exclude:self missingValue..
	
]

{ #category : #'protected-abstract' }
MlMedianImputer >> transform: aMlArray [

	^  aMlArray  replace: self missingValue by: uMatrix 
]
