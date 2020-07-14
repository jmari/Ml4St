Class {
	#name : #MlDecisionTree,
	#superclass : #MlRegressorMixin,
	#instVars : [
		'maxDepth',
		'criterion'
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
	| features target |
	aMlArray nDim = 2 ifFalse:[ MlShapeError signal: ('It should be a 2D Array and it has ', aMlArray nDim asString, ' Dimensions')].
	features := (aMlArray getLabelsOnAxis:1).
	target := (tMlArray getLabelsOnAxis:1) first.
	self model: (self id3OnData: (aMlArray concat: tMlArray axis:1)  features: features asArray  target:target)
	
	
	
]

{ #category : #'tree-algoritm' }
MlDecisionTree >> id3OnData: aMlArray features: features target: targetAttributeName [
	
	^ self id3OnData: aMlArray originalData: aMlArray features: features target: targetAttributeName parentNodeClass: nil depth:1
 

]

{ #category : #'tree-algoritm' }
MlDecisionTree >> id3OnData: aMlArray originalData: originalData features: features target: targetAttributeName parentNodeClass: parentNodeClass depth:depth [
 
	| infoGain bestFeature nextFeatures subtree uClass pNodeClass tree featuresIncluded infoGainMax |
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
	infoGainMax  := infoGain max.
	bestFeature  := (features at: (infoGain indexOf: infoGainMax)).  
	nextFeatures := (features select:[:f| f ~= bestFeature] ).
	
	(nextFeatures includes: targetAttributeName) 
		ifFalse:[ featuresIncluded := nextFeatures ,{targetAttributeName}].
	tree := (MlTreeNode 
						newFeatureName:bestFeature
						infoGain:infoGainMax) .
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
