Class {
	#name : #MlDecisionTree,
	#superclass : #MlRegressorMixin,
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

{ #category : #'as yet unclassified' }
MlDecisionTree >> id3OnData: aMlArray originalData: originalData features: features target: targetAttributeName parentNodeClass: parentNodeClass [
 "
    ID3 Algorithm: This function takes five paramters:
    1. data = the data for which the ID3 algorithm should be run --> In the first run this equals the total dataset
 
    2. originaldata = This is the original dataset needed to calculate the mode target feature value of the original dataset
    in the case the dataset delivered by the first parameter is empty

    3. features = the feature space of the dataset . This is needed for the recursive call since during the tree growing process
    we have to remove features from our dataset --> Splitting at each node

    4. target_attribute_name = the name of the target attribute

    5. parent_node_class = This is the value or class of the mode target feature value of the parent node for a specific node. This is 
    also needed for the recursive call since if the splitting leads to a situation that there are no more features left in the feature
    space, we want to return the mode target feature value of the direct parent node.
    "
	"Define the stopping criteria --> If one of this is satisfied, we want to return a leaf node
	If all target_values have the same value, return this value"
	
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
