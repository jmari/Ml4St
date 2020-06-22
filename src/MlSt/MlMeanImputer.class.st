"
MlImputers replaces ""missing values"" by other values like Mean of each column, in this case...
Imputers do not create a new buffer, they use replace:  by: 

"
Class {
	#name : #MlMeanImputer,
	#superclass : #MlImputer,
	#instVars : [
		'uMatrix'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #'protected-abstract' }
MlMeanImputer >> fitParameters: aMlArray [

	uMatrix := aMlArray mean:0 exclude:self missingValue.

	
]

{ #category : #'protected-abstract' }
MlMeanImputer >> transform: aMlArray [

	^  aMlArray  replace: self missingValue by: uMatrix 
]
