Class {
	#name : #MlDecisionTree,
	#superclass : #MlRegressorMixin,
	#instVars : [
		'maxDepth',
		'criterion',
		'decisionCode'
	],
	#category : #'MlSt-Ensemble-RandomForestClassifier'
}

{ #category : #'as yet unclassified' }
MlDecisionTree >> criterionEntropy [
	criterion := #entropy
]

{ #category : #'as yet unclassified' }
MlDecisionTree >> criterionGini [
	criterion := #gini
]

{ #category : #'fit-predict' }
MlDecisionTree >> fit: aMlArray target: tMlArray sampleWeight: sw [
	| features target weighedMlArray a2DMlArray |
	a2DMlArray := aMlArray nDim = 2 
						ifTrue:[aMlArray] 
						ifFalse:[aMlArray reshaped: {-1.  aMlArray shape last} ].
	weighedMlArray := sw ifNil:[a2DMlArray] ifNotNil:[a2DMlArray * sw].
	features := (weighedMlArray getLabelsOnAxis:1).
	target := (tMlArray getLabelsOnAxis:1) first.

	self model: (self id3OnData: (weighedMlArray concat: tMlArray axis:1)  features: features asArray  target:target)
	
	
	
]

{ #category : #'tree-algoritm' }
MlDecisionTree >> id3OnData: aMlArray features: features target: targetAttributeName [
	
	^ self id3OnData: aMlArray originalData: aMlArray features: features target: targetAttributeName parentNodeClass: nil depth:1
 

]

{ #category : #'tree-algoritm' }
MlDecisionTree >> id3OnData: aMlArray originalData: originalData features: features target: targetAttributeName parentNodeClass: parentNodeClass depth:depth [
 
	| infoGain bestFeature nextFeatures subtree uClass pNodeClass tree featuresIncluded infoGainMax  |
	"Define the stopping criteria --> If one of this is satisfied, we want to return a leaf node"
	uClass := (aMlArray at:{_. targetAttributeName}) unique.
	uClass size <= 1 	ifTrue:   [^ (aMlArray at:{_. targetAttributeName}) first].
	aMlArray length = 0| (depth > self maxDepth ) 
							ifTrue:[^ (originalData at:{_. targetAttributeName}) mode].
	features isEmpty ifTrue:   [^ parentNodeClass].
	"no stopping criteria"
	pNodeClass := uClass first.
	infoGain     := criterion = #entropy
							ifTrue:[aMlArray infoGain: features ->targetAttributeName]
							ifFalse:[aMlArray gini: features ->targetAttributeName].
	self flag:#todo. 
	"we receive the vector of ginis on each interval of a float value
	 we have to extract the partition block"
	infoGainMax  := infoGain max.
	bestFeature  := (features at: (infoGain indexOf: infoGainMax)).  
	nextFeatures := (features select:[:f| f ~= bestFeature] ).

	(nextFeatures includes: targetAttributeName) 
		ifFalse:[ featuresIncluded := nextFeatures ,{targetAttributeName}].
	tree := (MlTreeNode 
						newFeatureName:bestFeature
						infoGain:infoGainMax).
	aMlArray groupBy: bestFeature->featuresIncluded 
				aggregate:[:k :v|
					subtree := self id3OnData: v 
			  				 originalData: aMlArray 
			  				 features: nextFeatures 
			  				 target: targetAttributeName
			  				 parentNodeClass: pNodeClass
							 depth: (depth + 1).
					tree add:( k first->subtree)]
				storeCallbackValue:false.
	^ tree
]

{ #category : #accessing }
MlDecisionTree >> maxDepth [ 
	^ maxDepth ifNil:[maxDepth:= 100] 
]

{ #category : #accessing }
MlDecisionTree >> maxDepth: anInteger [
	maxDepth:= anInteger 
]

{ #category : #'fit-predict' }
MlDecisionTree >> predict: aMlArray [
	| a2DMlArray result |
	self model ifNil:[ MlModelNotDefinedError signal].
	a2DMlArray := aMlArray nDim = 2 
									ifTrue:[aMlArray] 
									ifFalse:[aMlArray reshaped: {-1.  aMlArray shape last} ].
	result := OrderedCollection new.
	1 to: a2DMlArray shape first do:[:i|
		result add: (self predict:a2DMlArray row:i tree:self model)].
	^ MlArray from:result order: a2DMlArray order
]

{ #category : #'fit-predict' }
MlDecisionTree >> predict:a2DMlArray row:i tree: treeNode [

	| nextTreeNode featureValue |
	featureValue := (a2DMlArray at: i at: treeNode featureName).
	nextTreeNode := treeNode at:(treeNode findFirst:[:each| each key = featureValue]).
	
	^ (nextTreeNode value isMlTreeNode) 
		ifFalse:[ nextTreeNode value ]
		ifTrue:[ self predict:a2DMlArray row:i tree:nextTreeNode value ]
]
