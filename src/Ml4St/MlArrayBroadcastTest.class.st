Class {
	#name : #MlArrayBroadcastTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

{ #category : #tests }
MlArrayBroadcastTest >> testBroadCasting [
	| a b sum s |
	a := MlArray random: #(5 1 4).
	b := MlArray new: #( 1 4) withAll: 4.0. 
	sum := a + b.
	s := MlArray from: #(#( #(4 4 4 4))
								#(#(4 4 4 4))
								#(#(4 4 4 4))
								#(#(4 4 4 4))
								#(#(4 4 4 4))
								) dType:#Float.
								
	self assert:( sum - s  closeTo:a).
	
	a := MlArray random: #(5 2 4).
	b := MlArray random: #(2 4). 

	sum := a + b.
	self assert: sum arrayType equals: a arrayType.
	self assert: (sum - b closeTo:a).
	
	a := MlArray random: #(5 1 4).
	b := MlArray random: #(1 4). 
	sum := a + b.
	self deny: (sum - a  closeTo:b).
]

{ #category : #tests }
MlArrayBroadcastTest >> testDotBroadcasting [

	| a b dot r|
	a := MlArray from:  #( #(#(2 0 1) 
									#(3 0 0) 
									#(5 1 1)) 
								#( #(1 -1 1) 
								   #(2 2 3) 
								   #(-2 -3 -1))).
	b := MlArray from: #(#(1 0 0) 
								#(0 1 0)
								#(0 0 1)). 
	dot := a dot: b.
	self assert: dot equals: a
	

	


]

{ #category : #tests }
MlArrayBroadcastTest >> testMatMulBroadcasting [

	| a b dot r|
	a := MlArray from:  #( #(#(2 0 1) 
									#(3 0 0) 
									#(5 1 1)) 
								#( #(1 -1 1) 
								   #(2 2 3) 
								   #(-2 -3 -1))).
	b := MlArray from: #(#(1 0 0) 
								#(0 1 0)
								#(0 0 1)). 
	dot := a matMul: b.
	self assert: dot equals: a
	

	


]

{ #category : #tests }
MlArrayBroadcastTest >> testMathOperations [

	| a b sum oldA c |
	a := MlArray random: #(5 10).
	b := MlArray random: #(3 5 10). 
	sum := a + b.
	self assert: (sum - a  closeTo:b).
	a := MlArray random: #(5 10).
	oldA := a deepCopy.
	b := MlArray random: #(5 10). 
	a += b.
	self assert: ((a - oldA ) closeTo:b).
	a -= b.
	self assert: (a closeTo: oldA).	
	a *= b.
	self assert: ((a/b) closeTo: oldA). 
	c := a * b.
	self assert: ((c / b) closeTo: a).
	c := a / b.
	self assert: ((c * b) closeTo: a).	
	


		
	
	
	
]
