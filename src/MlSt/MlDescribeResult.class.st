Class {
	#name : #MlDescribeResult,
	#superclass : #Object,
	#instVars : [
		'numberOfObs',
		'min',
		'max',
		'mean',
		'variance',
		'skewness',
		'kurtosis'
	],
	#category : #'MlSt-Metrics'
}

{ #category : #accessing }
MlDescribeResult >> kurtosis [
	^ kurtosis
]

{ #category : #accessing }
MlDescribeResult >> kurtosis: anObject [
	kurtosis := anObject
]

{ #category : #accessing }
MlDescribeResult >> max [
	^ max
]

{ #category : #accessing }
MlDescribeResult >> max: anObject [
	max := anObject
]

{ #category : #accessing }
MlDescribeResult >> mean [
	^ mean
]

{ #category : #accessing }
MlDescribeResult >> mean: anObject [
	mean := anObject
]

{ #category : #accessing }
MlDescribeResult >> min [
	^ min
]

{ #category : #accessing }
MlDescribeResult >> min: anObject [
	min := anObject
]

{ #category : #accessing }
MlDescribeResult >> numberOfObs [
	^ numberOfObs
]

{ #category : #accessing }
MlDescribeResult >> numberOfObs: anObject [
	numberOfObs := anObject
]

{ #category : #accessing }
MlDescribeResult >> skewness [
	^ skewness
]

{ #category : #accessing }
MlDescribeResult >> skewness: anObject [
	skewness := anObject
]

{ #category : #accessing }
MlDescribeResult >> variance [
	^ variance
]

{ #category : #accessing }
MlDescribeResult >> variance: anObject [
	variance := anObject
]
