Class {
	#name : #MlMinMaxScaler,
	#superclass : #MlTransformer,
	#instVars : [
		'minMatrix',
		'maxMatrix',
		'rangeMin',
		'rangeMax'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #accessing }
MlMinMaxScaler >> featureRange: aMinMaxPair [
	rangeMin := aMinMaxPair at:1.
	rangeMax := aMinMaxPair at:2.
	


]

{ #category : #'protected-abstract' }
MlMinMaxScaler >> fitParameters: aMlArray [
	minMatrix := aMlArray min: 0.
	maxMatrix := aMlArray max: 0.
	
]

{ #category : #'protected-abstract' }
MlMinMaxScaler >> inverseTransform: aMlArray [

	^ ((aMlArray -  self rangeMin )/ (  self rangeMax   -   self rangeMin )) * (maxMatrix  - minMatrix) + minMatrix.
	
	
	  
]

{ #category : #accessing }
MlMinMaxScaler >> rangeMax [
	^ rangeMax ifNil:[rangeMax := 1.0]
]

{ #category : #accessing }
MlMinMaxScaler >> rangeMax: anObject [
	rangeMax := anObject
]

{ #category : #accessing }
MlMinMaxScaler >> rangeMin [
	^ rangeMin ifNil:[rangeMin:= 0.0]
]

{ #category : #accessing }
MlMinMaxScaler >> rangeMin: anObject [
	rangeMin := anObject
]

{ #category : #'protected-abstract' }
MlMinMaxScaler >> transform: aMlArray [

	^ (((aMlArray -  minMatrix )/ ( maxMatrix -  minMatrix)) * (self rangeMax - self rangeMin)) + self rangeMin.
]
