Class {
	#name : #MlArrayMathTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

{ #category : #tests }
MlArrayMathTest >> testBooleanOperations [
	| a b c d e |
	a := MlArray  from: {{{true. true. true}. {false. false. false}. {true. true. true}}}.
	b := MlArray  from: {{{false. false. false}. {true. true. true}. {true. true. true}}}.
	c := MlArray  from: {{{false. false. false}}}.
	self assert: (a | b) equals: (MlArray  from: {{{true. true. true}. {true. true. true}. {true. true. true}}}).
	self assert: (a & b) equals: (MlArray  from: {{{false. false. false}. {false. false. false}. {true. true. true}}}).
	self assert: (a | c) equals: (MlArray  from: {{{true. true. true}. {false. false. false}. {true. true. true}}}).
	self assert: (c | a) equals: (MlArray  from: {{{true. true. true}. {false. false. false}. {true. true. true}}}).
	self assert: (a & c) equals: (MlArray  from: {{{false. false. false}. {false. false. false}. {false. false. false}}}).
	self assert: (c & a) equals: (MlArray  from: {{{false. false. false}. {false. false. false}. {false. false. false}}}).
		
	c := MlArray random: #(3 5 10).
	d:= c at:[:v | v > 50].
	self assert: d nDim equals:3.	
	d := c at:{1@1. _. 1@1}. 	
	e := d at:[:v | v > 20] put: 1000.
	self assert: d shape equals: e shape.
	self assert: d equals: e.
		

	
]

{ #category : #tests }
MlArrayMathTest >> testDescribe [

	| a describe |
	a := MlArray random: #(3 5 10).

	describe := a describe.
	describe inspect.
	
	
]

{ #category : #tests }
MlArrayMathTest >> testDot [

	| a b dot r|
	a := MlArray from: #(#(#(6 3) #(7 4) #(6 9)) #(#(2 6) #(7 4) #(3 7))).
	b := MlArray from: #(#(#(7 2 5 4 ) #(1 7 5 1)) #(#(4 0 9 5 ) #(8 0 9 2)) #(#(6 3 8 2 ) #(4 2 6 4))).
	dot := a dot:b.

	self assert: dot shape equals: #(2 3 3 4)
	

	


]

{ #category : #tests }
MlArrayMathTest >> testDot2 [

	| a b dot r|
	a := MlArray from: #(#(2 4) #(3 7) #(5 1)).
	b := (MlArray from: #(1 6)) transposed. 
	dot := a matMul:b.
	r := MlArray from: #(#(26) 
								#(45) 
								#(11)).
	self assert: dot equals:r
	

	


]

{ #category : #tests }
MlArrayMathTest >> testMatMul [

	| a b dot r|
	a := MlArray from: #(#(#(2 0 1) #(3 0 0) #(5 1 1)) #(#(1 -1 1) #(2 2 3) #(-2 -3 -1))).
	b := MlArray from: #(#(#(1 0 1) #(1 2 1) #(1 1 0)) #(#(1 0 4) #(0 2 5) #(1 3 0))). 
	dot := a matMul: b.
	r := MlArray from: #(#(#(3 1 2) #(3 0 3) #(7 3 6)) #(#(2 1 -1) #(5 13 18) #(-3 -9 -23))).
	self assert: dot equals:r
	

	


]

{ #category : #tests }
MlArrayMathTest >> testMatMul2 [

	| a b dot r|
	a := MlArray from: #(#(2 4) #(3 7) #(5 1)).
	b := (MlArray from: #(1 6)) transposed. 
	dot := a matMul:b.
	r := MlArray from: #(#(26) 
								#(45) 
								#(11)).
	self assert: dot equals:r
	

	


]

{ #category : #tests }
MlArrayMathTest >> testMathOperations [

	| a b sum oldA c zip |
	a := MlArray random: #(3 5 10).
	b := MlArray random: #(3 5 10). 
	sum := a + b.
	self assert: (sum - a  closeTo:b).
	a := MlArray random: #(3 5 10).
	oldA := a deepCopy.
	b := MlArray random: #(3 5 10). 
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

{ #category : #tests }
MlArrayMathTest >> testProduct [

	| a b product r|
	a := MlArray from: #(#(2 4) #(3 7) #(5 1)).
	b := (MlArray from: #(#(1 2) #(3 4))). 
	product := a cartesianProduct:b.
	r := MlArray from: #(#(2 4 1 2)
								#(2 4 3 4) 
								#(3 7 1 2)
								#(3 7 3 4) 
								#(5 1 1 2)
								#(5 1 3 4)).
	self assert: product equals:r
	

	


]

{ #category : #tests }
MlArrayMathTest >> testProductMoreThan2D [

	| a b product r|
	a := MlArray from: #(#(#(2 4) #(3 7)) #(#(5 1) #(4 7))).
	b := MlArray from: #(#(#(1 2) #(3 4)) #(#(5 6) #(7 8))). 
	product := a cartesianProduct:b.
	r := MlArray from: #(#(#(2 4 1 2)
								#(2 4 3 4) 
								#(2 4 5 6)
								#(2 4 7 8))  
								#(#(3 7 1 2)
								#(3 7 3 4) 
								#(3 7 5 6)
								#(3 7 7 8))  
								#(#(5 1 1 2)
								#(5 1 3 4)
								#(5 1 5 6)
								#(5 1 7 8))
								#(#(4 7 1 2)
								#(4 7 3 4)
								#(4 7 5 6)
								#(4 7 7 8))  ).
	self assert: product equals:r
	

	


]
