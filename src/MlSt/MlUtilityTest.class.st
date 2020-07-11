Class {
	#name : #MlUtilityTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlUtilityTest >> testDecisionTree [
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
	b := MlDecisionTree new.
	c := b id3OnData: a originalData: a features: { 2. 3. 4} target: 5 	parentNodeClass:nil				
		
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
