Class {
	#name : #MlDecisionTree,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'idxs',
		'minSamplesLeaf',
		'n',
		'c',
		'val',
		'score'
	],
	#category : #'MlSt-Ensemble-RandomForestClassifier'
}

{ #category : #accessing }
MlDecisionTree >> asString [ 	
	
]

{ #category : #accessing }
MlDecisionTree >> c [
	^ c
]

{ #category : #accessing }
MlDecisionTree >> c: anObject [
	c := anObject
]

{ #category : #accessing }
MlDecisionTree >> checkFeatures [
	1 to:self c do:[:i| self findBestSplit:i]
]

{ #category : #accessing }
MlDecisionTree >> findBestSplit: anInteger [ 

]

{ #category : #accessing }
MlDecisionTree >> idxs [
	^ idxs ifNil:[ idxs := Array new: self y size]
]

{ #category : #accessing }
MlDecisionTree >> idxs: anObject [
	idxs := anObject
]

{ #category : #testing }
MlDecisionTree >> isLeaf [
	self score = Float infinity. 
	
]

{ #category : #accessing }
MlDecisionTree >> minSamplesLeaf [
	^ minSamplesLeaf
]

{ #category : #accessing }
MlDecisionTree >> minSamplesLeaf: anObject [
	minSamplesLeaf := anObject
]

{ #category : #accessing }
MlDecisionTree >> n [
	^ n
]

{ #category : #accessing }
MlDecisionTree >> n: anObject [
	n := anObject
]

{ #category : #accessing }
MlDecisionTree >> score [
	^ score ifNil:[ score :=  Float infinity]
]

{ #category : #accessing }
MlDecisionTree >> score: anObject [
	score := anObject
]

{ #category : #accessing }
MlDecisionTree >> val [
	^ val
]

{ #category : #accessing }
MlDecisionTree >> val: anObject [
	val := anObject
]

{ #category : #accessing }
MlDecisionTree >> x [
	^ x
]

{ #category : #accessing }
MlDecisionTree >> x: anObject [
	x := anObject
]

{ #category : #accessing }
MlDecisionTree >> y [
	^ y
]

{ #category : #accessing }
MlDecisionTree >> y: anObject [
	y := anObject
]
