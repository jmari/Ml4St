Class {
	#name : #MlArrayPerformanceTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlArrayPerformanceTest >> testArraysConcat [

	| a b t|
	"create a million float array"
	a := MlArray random: #(100 100 100).
	b := MlArray random: #(100 100 100).

	t := [a concat: b axis:1 ] timeToRun.
	self assert:t <= (Duration milliSeconds:1000).
	t := [a concat: b axis:2 ] timeToRun.
	self assert:t <= (Duration milliSeconds:1000).
	t := [a concat: b axis:3 ] timeToRun.
	self assert:t <= (Duration milliSeconds:1000).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testArraysMul [

	| a b t|
	"create a million float array"
	a := MlArray random: #(100 100 100).
	b := MlArray random: #(100 100 100).

	t := [a *= b] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testBigDot [

	| a b t|
	a := (MlArray random: #( 100 100)).
	b := (MlArray random: #( 100 100)).
	
	t := [a dot:b.] timeToRun.
	self assert:t <= (Duration milliSeconds:1000).
	

	


]

{ #category : #tests }
MlArrayPerformanceTest >> testMulArray [

	| a b t|
	"create a million float array"
	a := (MlArray random: #(100 100 100)) .
	b := (MlArray random: #(100 100 100)).

	t := [a *= b] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testMulSlicedArray [

	| a b t|
	"create a million float array"
	a := (MlArray random: #(100 100 100))  at:{_. _. 1@_@2}.
	b := (MlArray random: #(100 100 100))  at:{_. _. 1@_@2}.

	t := [a *= b] timeToRun.
	self assert:t <= (Duration milliSeconds:1500).
	
	
	
]

{ #category : #'as yet unclassified' }
MlArrayPerformanceTest >> testNonContinuousVectorTest [
	|a b|
	a :=  MlArray random: #(10 10 10).
	b := a at:{_. _. 1@_@2}.
	1 to: (b shape at:3) do:[:i|
		self assert: (b at:1 at:1 at:i) equals: (a at:1 at:1 at:(i*2 - 1))]. 
	
	b := a at:{_. _. 1@_@3}.
	1 to: (b shape at:3) do:[:i|
		self assert: (b at:1 at:1 at:i) equals: (a at:1 at:1 at:(i*3 - 2))]. 
]

{ #category : #tests }
MlArrayPerformanceTest >> testScalarMul [

	| a t|
	"create a million float array"
	a := MlArray random: #(100 100 100).
	"multiply by a constant"
	t := [a *= 5] timeToRun.
	self assert:t <= (Duration milliSeconds:500).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testSliceArray [

	| a b t|
	"create a million float array"
	a := MlArray random: #(1000000).
	
	t := [b:= a > 0.5] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testSliceArray2 [

	| a b t|
	"create a million float array"
	a := (MlArray random: #(100 100 100)) at:{_. _. 1@_@2}.
	"element by element slicing"
	t := [b:= a > 0.5] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testSliceArray3 [

	| a b t|
	"create a million float array"
	a := (MlArray random: #(100 100 100)) at:{_. _. 1@_@2}.
	"boolean 1 axis slicing"
	t := [b:= a at:{_. _. ((a at:{_. _. 1}) >0.5)}] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
	
	
	
]
