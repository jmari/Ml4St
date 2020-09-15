Class {
	#name : #MlUtilityTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlUtilityTest >> testDecisionTree [
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
	a setLabels:#(#Weekend #Weather #ParentalAvaliability #Wealthy #Decision) onAxis:1. 
	b := MlDecisionTree new maxDepth:10."default gini"
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1.


	b := MlDecisionTree new maxDepth:10; criterionEntropy.
	c := b fit:(a at:{_. {#Weather. #ParentalAvaliability.  #Wealthy}}) 
			 target: (a at:{_. #Decision}). 	
	p := c predict: a.
	
	r := (a at:_ at: #Decision) accuracy:p.
	self assert: (r at:#accuracy) equals: 1
]

{ #category : #tests }
MlUtilityTest >> testDecisionTreeContinuousVar [
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
	a setLabels:#(#Weekend #Weather #ParentalAvaliability #Wealthy #Decision) onAxis:1. 
	b := MlDecisionTree new maxDepth:10."default gini"
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

{ #category : #tests }
MlUtilityTest >> testEntropy [
	| a b |
	a := MlArray from: #(
							  #(1 1 3 5 ) 
							  #(1  5 6 4 ) 
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(1 11 12 2 )
							  #(2 2 3 6 ) 
							  #(2 11 12 20)
							  #(2 11 12 56)
							  #(2 11 12 20)
							  #(2 11 12 56)
							).

	b := a entropy:1.
	self assert: b closeTo: 0.940285958670631.

	
							
		
]

{ #category : #tests }
MlUtilityTest >> testGiniIndex [
	| a b |
	a := MlArray from: #(
							  #(true false true true ) 
							  #(false true false false)
							  #(true false true true ) 
							  #(true true true true ) 
							  #(false false true false)
							  #(true false false false ) 
							  #(false true true false)
							  #(false false true false)
							  #(true false false false ) 
							  #(true true true true ) 
							).
	a setLabels:#(#pastTrend #openInterest #tradingVol #return) onAxis:1. 

	b := a gini:#pastTrend->#return.
	self assert: b first closeTo: 4/15.
	b := a gini:#openInterest->#return.
	self assert: b first closeTo: 7/15.
	b := a gini:#tradingVol->#return.
	self assert: b first  closeTo: 3/10.
	b := a gini:#(#pastTrend #openInterest #tradingVol )->#return.
	self assert:b closeTo: (MlArray from:{4/15. 7/15. 3/10}).	

	
							
		
]

{ #category : #tests }
MlUtilityTest >> testIndexOf [
	| a b c |
	a := MlArray from: #(
							  #(#H1 #Sunny true #Rich #Cinema true) 
							  #(#H2 #Sunny false #Rich #Tennis true) 
							  #(#H3 #Windy true #Rich #Cinema true) 
							  #(#H4 #Rainy true #Poor #Cinema true) 
							  #(#H5 #Rainy false #Rich #Home true) 
							  #(#H6 #Rainy true #Poor #Cinema true) 
							  #(#H7 #Windy false #Poor #Cinema true) 
							  #(#H8 #Windy false #Rich #Shopping true) 
							  #(#H9 #Windy true #Rich #Cinema true)
							  #(#H10 #Sunny false #Rich #Tennis true) 
							).
	self flag:#todo. "it is not working at all"
	c := a indexOf:#H7	
				
		
]

{ #category : #tests }
MlUtilityTest >> testInfoGain [
	| a b |
	a := MlArray from: #(
							  #(#H1 #Sunny true #Rich #Cinema true) 
							  #(#H2 #Sunny false #Rich #Tennis true) 
							  #(#H3 #Windy true #Rich #Cinema true) 
							  #(#H4 #Rainy true #Poor #Cinema true) 
							  #(#H5 #Rainy false #Rich #Home true) 
							  #(#H6 #Rainy true #Poor #Cinema true) 
							  #(#H7 #Windy false #Poor #Cinema true) 
							  #(#H8 #Windy false #Rich #Shopping true) 
							  #(#H9 #Windy true #Rich #Cinema true)
							  #(#H10 #Sunny false #Rich #Tennis true) 
							).
	b := a entropy:5.
	self assert: b  closeTo: 1.571.
	b := a entropy:6.
	self assert: b  closeTo: 0.0.
	b := a infoGain:2->5.
	self assert: (b first)  closeTo: 0.6954.
	b := a infoGain:3->5.
	self assert: (b first) closeTo: 0.61.
	b := a infoGain:4->5.
	self assert: (b first)  closeTo: 0.2813.
	b := a infoGain:{ 2. 3. 4. 6.}->5.
	self assert:b closeTo: (MlArray from:{0.6954. 0.61. 0.2813. 0.0}).						
		
]
