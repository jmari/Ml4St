"
StandardScaler removes the mean and scales the data to unit variance. However, the outliers have an influence when computing the empirical mean and standard deviation which shrink the range of the feature values as shown in the left figure below. Note in particular that because the outliers on each feature have different magnitudes, the spread of the transformed data on each feature is very different: most of the data lie in the [-2, 4] range for the transformed median income feature while the same data is squeezed in the smaller [-0.2, 0.2] range for the transformed number of households.

StandardScaler therefore cannot guarantee balanced feature scales in the presence of outliers.
"
Class {
	#name : #MlStandardScaler,
	#superclass : #MlTransformer,
	#instVars : [
		'uMatrix',
		'sMatrix'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'protected-abstract' }
MlStandardScaler >> fitParameters: aMlArray [
	
	uMatrix := (aMlArray mean: 0) transposed.
	sMatrix := (aMlArray stdDev: 0) transposed.
]

{ #category : #'protected-abstract' }
MlStandardScaler >> inverseTransform: aMlArray [
	^ aMlArray * sMatrix  + uMatrix 
]

{ #category : #'protected-abstract' }
MlStandardScaler >> transform: aMlArray [
	
	^ (aMlArray - uMatrix ) /  sMatrix 
	
]
