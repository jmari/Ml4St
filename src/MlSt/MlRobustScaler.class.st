Class {
	#name : #MlRobustScaler,
	#superclass : #MlMinMaxScaler,
	#instVars : [
		'medianMatrix'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #'protected-abstract' }
MlRobustScaler >> fitParameters: aMlArray [
	| quartiles |
	quartiles := aMlArray quartiles: 0.
	minMatrix := quartiles collect:[:e| e at:1].
	medianMatrix := quartiles collect:[:e| e at:2].
	maxMatrix := quartiles collect:[:e| e at:3].

]

{ #category : #'protected-abstract' }
MlRobustScaler >> inverseTransform: aMlArray [

	^ ((aMlArray -  self rangeMin )/ (  self rangeMax   -   self rangeMin )) * (maxMatrix  - minMatrix) + medianMatrix.
]

{ #category : #'protected-abstract' }
MlRobustScaler >> transform: aMlArray [

	^ (((aMlArray -  medianMatrix )/ ( maxMatrix -  minMatrix)) * (self rangeMax - self rangeMin)) + self rangeMin.
]
