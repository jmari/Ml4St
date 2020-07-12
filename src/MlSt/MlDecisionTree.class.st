Class {
	#name : #MlDecisionTree,
	#superclass : #MlRegressorMixin,
	#category : #'MlSt-Ensemble-RandomForestClassifier'
}

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
	
	^ self id3OnData: aMlArray originalData: aMlArray features: features target: targetAttributeName parentNodeClass: nil 
 

]

{ #category : #'tree-algoritm' }
MlDecisionTree >> id3OnData: aMlArray originalData: originalData features: features target: targetAttributeName parentNodeClass: parentNodeClass [ 
 
	| infoGain bestFeature nextFeatures subtree uClass pNodeClass tree featuresIncluded infoGainMax |
	"Define the stopping criteria --> If one of this is satisfied, we want to return a leaf node"
	uClass := (aMlArray at:{_. targetAttributeName}) unique.
	uClass size <= 1 ifTrue:   [^ (aMlArray at:{_. targetAttributeName}) first].
	aMlArray length = 0 ifTrue:[^ (originalData at:{_. targetAttributeName}) mode].
	features isEmpty ifTrue:   [^ parentNodeClass].
	"no stopping criteria"
	pNodeClass := uClass first.
	infoGain     := aMlArray infoGain: features ->targetAttributeName.
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
			  				 parentNodeClass: pNodeClass.
					tree add:( k first->subtree)]
				storeCallbackValue:false.
	^ tree
]
