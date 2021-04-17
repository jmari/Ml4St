Class {
	#name : #MlDecissionTreeTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Models'
}

{ #category : #tests }
MlDecissionTreeTest >> testDecisionTree [
	| a b c tree mt p r |
	a := MlArray from: #(
							  #(#H1 #Sunny true #Rich #Cinema ) 
							  #(#H2 #Sunny false #Rich #Tennis ) 
							  #(#H3 #Windy true #Rich #Cinema ) 
							  #(#H4 #Rainy true #Poor #Cinema ) 
							  #(#H5 #Rainy false #Rich #Home ) 
							  #(#H6 #Rainy true #Poor #Cinema ) 
							  #(#H7 #Windy false #Poor #Cinema ) 
							  #(#H8 #Windy false #Rich #Shopping ) 
							  #(#H9 #Windy true #Rich #Cinema )
							  #(#H10 #Sunny false #Rich #Tennis ) 
							).
	a labelWith:#(#Weekend #Weather #ParentalAvaliability #Wealthy #Decision) axis:1. 
	b := MlDecisionTree new maxDepth:10.
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1.


	b := MlDecisionTree new maxDepth:10.
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1
]

{ #category : #tests }
MlDecissionTreeTest >> testDecisionTreeContinuousVar [
	| a b c tree mt p r |
	a := MlArray from: #(
							  #(#H1 10.0 true #Rich #Cinema ) 
							  #(#H2 9.0 false #Rich #Tennis ) 
							  #(#H3 7.0 true #Rich #Cinema ) 
							  #(#H4 3.0 true #Poor #Cinema ) 
							  #(#H5 3.0  false #Rich #Home ) 
							  #(#H6 3.0  true #Poor #Cinema ) 
							  #(#H7 7.0 false #Poor #Cinema ) 
							  #(#H8 7.0 false #Rich #Shopping ) 
							  #(#H9 9.0 true #Rich #Cinema )
							  #(#H10 10.0 false #Rich #Tennis ) 
							).
	a labelWith:#(#Weekend #Weather #ParentalAvaliability #Wealthy #Decision) axis:1. 
	b := MlDecisionTree new maxDepth:10;criterionGini.
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	b inspect.
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1.


	b := MlDecisionTree new maxDepth:10; criterionEntropy.
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1
]
