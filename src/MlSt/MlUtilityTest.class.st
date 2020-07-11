Class {
	#name : #MlUtilityTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
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
	b inspect

	
							
		
]

{ #category : #tests }
MlUtilityTest >> testInfoGain [
	| a b |
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

	b := a infoGain:2->5.
	b inspect

	
							
		
]
