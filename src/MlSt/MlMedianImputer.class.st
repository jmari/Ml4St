Class {
	#name : #MlMedianImputer,
	#superclass : #MlImputer,
	#instVars : [
		'uMatrix'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #'protected-abstract' }
MlMedianImputer >> fitParameters: aMlArray [

	uMatrix := aMlArray median: 0.
	
]

{ #category : #'protected-abstract' }
MlMedianImputer >> transform: aMlArray [

	^  aMlArray  replace: self missingValue by: uMatrix 
]
