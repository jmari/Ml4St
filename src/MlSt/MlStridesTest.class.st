Class {
	#name : #MlStridesTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlStridesTest >> testBooleanFilters1D [
	| a b d sol |
	a := MlArray from: #(10 1 3 5 
							  2  5 6 4  
							  10 11 12 2 
							  11 2 3 6 
							  10 11 12 20
							  10 11 12 56).
							
	b := a at:[:v| v>=10].	
	d := a at:b.
	sol :=  MlArray from: #( 10 10 11 12 11 10 11 12 20 10 11 12 56).
	self assert:d equals: sol.
	
							
		
]

{ #category : #tests }
MlStridesTest >> testBooleanFilters2D [
	| a b c d sol |
	a := MlArray from: #(
							  #(10 1 3 5 ) 
							  #(2  5 6 4 ) 
							  #(10 11 12 2 )
							  #(11 2 3 6 ) 
							  #(10 11 12 20)
							  #(10 11 12 56)
							).
							
	b := ((a at:{_@_. 1}) at:[:v| (v~=2 ) & (v~=11)]).	
	d := a at:b at: _@_.
	sol :=  MlArray from: #( 	#(  10   1   3   5)
										#(  10  11  12   2)	
									  	#(	 10  11  12  20)
										#(  10  11  12  56) ).
	self assert:d equals:sol.
	
	b := a entropy:1.

	
							
		
]

{ #category : #tests }
MlStridesTest >> testBooleanFilters3D [
	| a b c d sol |
	a := MlArray from: #(
							#(#(10 1 3 5 ) 
							  #(2  5 6 4 ) 
							  #(10 11 12 2  )
							) 
							 #(#(11 2 3 6 ) 
							  #(10 11 12 20 )
							  #(10 11 12 56 ))
							).
							
	b := ((a at:{_@_. _@_. 1}) at:[:v| v=10]).	
	d := a at: _@_ at:b at: _@_.
	sol :=  MlArray from: #(#(	#(  10   1   3   5)
										#(  10  11  12   2)	)
									#(	#(	 10  11  12  20)
										#(  10  11  12  56) )).
	self assert:d equals:sol.
	
	
							
		
]

{ #category : #tests }
MlStridesTest >> testNonContinuousArrays [
	| a b c|
	a := MlArray  from: {1.1. 2.1. 3.1. 4.1. 5.1. 6.1. 7.1. 8.1. 9.1. 10.1. 11.1. 12.1}.
	b := MlArray  from: {1. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12} dType:#Float.
	c := a * b.
	self assert: c internalArray species equals:  MlNonContinuousVector .
	self assert: c internalArray buffer species equals:  a internalArray buffer species
]

{ #category : #tests }
MlStridesTest >> testStrides [
	| a nonContinuousArray |
	a := MlArray  from: {1. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12}.
	nonContinuousArray := a internalArray. 
	
	nonContinuousArray validRanges: { (2 to:3). (5 to:7). (10 to: 11)}. 
	self assert:( nonContinuousArray at:1) equals: 2.
	self assert:( nonContinuousArray at:2) equals: 3.
	self assert:( nonContinuousArray at:3) equals: 5.
	self assert:( nonContinuousArray at:5) equals: 7.
	self assert:( nonContinuousArray at:6) equals: 10.
	self should: [  nonContinuousArray at:8 ] raise: SubscriptOutOfBounds.
	nonContinuousArray validRanges: { (1 to:1)}. 
	"Check if it should be 1 or 2 in numpy implementation
	strides are applied to the original array"
	self assert:( nonContinuousArray at:1) equals: 1.
	
]
