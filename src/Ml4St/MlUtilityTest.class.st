Class {
	#name : #MlUtilityTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

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
	self assert: (b at:2 at:1) closeTo: 16/45.
	b := a gini:#openInterest->#return.
	self assert: (b at:2 at:1) closeTo: 79/180.
	b := a gini:#tradingVol->#return.
	self assert: (b at:2 at:1)  closeTo: 7/20.
	b := a gini:#(#pastTrend #openInterest #tradingVol )->#return.
	self assert:(b at:2 at:_) closeTo: (MlArray from:{{16/45. 79/180. 7/20}}).	

	
							
		
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
