Class {
	#name : #MlRandomForestParameters,
	#superclass : #Object,
	#instVars : [
		'nEstimators',
		'criterion',
		'maxDepth',
		'minSampleSplit',
		'minSamplesLeaf',
		'minWeightFraction',
		'maxFeatures',
		'maxLeafNodes',
		'minImpurityDecrease',
		'minImpuritySplit',
		'bootstrap',
		'oobScore',
		'nJobs',
		'randomState',
		'warmStart',
		'classWeight',
		'cppAlpha',
		'maxSamples'
	],
	#category : #'Ml4St-Ensemble-RandomForestClassifier'
}

{ #category : #accessing }
MlRandomForestParameters >> bootstrap [
	^ bootstrap ifNil:[ bootstrap := true]
]

{ #category : #accessing }
MlRandomForestParameters >> bootstrap: anObject [
	bootstrap := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> classWeight [
	^ classWeight 
]

{ #category : #accessing }
MlRandomForestParameters >> classWeight: anObject [
	classWeight := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> cppAlpha [
	^ cppAlpha ifNil:[cppAlpha := 0.0]
]

{ #category : #accessing }
MlRandomForestParameters >> cppAlpha: anObject [
	cppAlpha := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> criterion [
	^ criterion ifNil:[criterion := #gini]
]

{ #category : #accessing }
MlRandomForestParameters >> criterion: anObject [
	criterion := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
MlRandomForestParameters >> maxDepth: anObject [
	maxDepth := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> maxFeatures [
	^ maxFeatures ifNil:[maxFeatures := #auto]
]

{ #category : #accessing }
MlRandomForestParameters >> maxFeatures: anObject [
	maxFeatures := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> maxLeafNodes [
	^ maxLeafNodes
]

{ #category : #accessing }
MlRandomForestParameters >> maxLeafNodes: anObject [
	maxLeafNodes := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> maxSamples [
	^ maxSamples
]

{ #category : #accessing }
MlRandomForestParameters >> maxSamples: anObject [
	maxSamples := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> minImpurityDecrease [
	^ minImpurityDecrease ifNil:[minImpurityDecrease :=0.0]
]

{ #category : #accessing }
MlRandomForestParameters >> minImpurityDecrease: anObject [
	minImpurityDecrease := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> minImpuritySplit [
	^ minImpuritySplit 
]

{ #category : #accessing }
MlRandomForestParameters >> minImpuritySplit: anObject [
	minImpuritySplit := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> minSampleSplit [
	^ minSampleSplit ifNil:[ minSampleSplit := 2]
]

{ #category : #accessing }
MlRandomForestParameters >> minSampleSplit: anObject [
	minSampleSplit := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> minSamplesLeaf [
	^ minSamplesLeaf ifNil:[minSamplesLeaf := 1]
]

{ #category : #accessing }
MlRandomForestParameters >> minSamplesLeaf: anObject [
	minSamplesLeaf := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> minWeightFraction [
	^ minWeightFraction ifNil:[minWeightFraction := 0.0]
]

{ #category : #accessing }
MlRandomForestParameters >> minWeightFraction: anObject [
	minWeightFraction := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> nEstimators [
	^ nEstimators ifNil:[nEstimators := 100]
]

{ #category : #accessing }
MlRandomForestParameters >> nEstimators: anObject [
	nEstimators := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> nJobs [
	^ nJobs
]

{ #category : #accessing }
MlRandomForestParameters >> nJobs: anObject [
	nJobs := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> oobScore [
	^ oobScore ifNil:[oobScore := false]
]

{ #category : #accessing }
MlRandomForestParameters >> oobScore: anObject [
	oobScore := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> randomState [
	^ randomState
]

{ #category : #accessing }
MlRandomForestParameters >> randomState: anObject [
	randomState := anObject
]

{ #category : #accessing }
MlRandomForestParameters >> warmStart [
	^ warmStart ifNil:[warmStart  := false]
]

{ #category : #accessing }
MlRandomForestParameters >> warmStart: anObject [
	warmStart := anObject
]
