Class {
	#name : #MlTreeNode,
	#superclass : #OrderedCollection,
	#instVars : [
		'featureName',
		'infoGain',
		'conditionBlock'
	],
	#category : #'MlSt-Ensemble-RandomForestClassifier'
}

{ #category : #'instance creation' }
MlTreeNode class >> newFeatureName: fname infoGain: infogain [
	^ self new featureName: fname; infoGain: infogain 
]

{ #category : #accessing }
MlTreeNode >> conditionBlock [
	^ conditionBlock 
]

{ #category : #accessing }
MlTreeNode >> conditionBlock: aBlockReturnsBool [
	conditionBlock := aBlockReturnsBool 
]

{ #category : #accessing }
MlTreeNode >> featureName [
	^ featureName
]

{ #category : #accessing }
MlTreeNode >> featureName: anObject [
	featureName := anObject
]

{ #category : #accessing }
MlTreeNode >> infoGain [
	^ infoGain
]

{ #category : #accessing }
MlTreeNode >> infoGain: anObject [
	infoGain := anObject
]

{ #category : #testing }
MlTreeNode >> isLeaf [
	^ self isEmpty or:[ self first value isString ] 
]

{ #category : #testing }
MlTreeNode >> isMlTreeNode [
	^ true
]
