Class {
	#name : #MlArrayPerformanceTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Core-Test'
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
	
	t := [a matMul:b.] timeToRun.
	self assert:t <= (Duration milliSeconds:1100).
	

	


]

{ #category : #tests }
MlArrayPerformanceTest >> testColumnsDo [

	| a t|
	"create a million float array"
	a := (MlArray random: #(10 100000)).
	"boolean 1 axis slicing"
	t := [a columnsDo:[:r :s| #doNothing]] timeToRun.
	"it takes around 40 ms to do a slice of 1 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:1000).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testColumnsDoC [

	| a t|
	"create a million float array"
	a := (MlArray random: #(10 100000)) asCArray.
	"boolean 1 axis slicing"
	t := [a columnsDo:[:r :s| #doNothing]] timeToRun.
	"it takes around 40 ms to do a slice of 1 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:3000).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testGrouping [

	| a b t |
	a := MlArray  randomInt:{1000. 3}.
	t:= [b := a groupBy: 1->{2. 3} aggregate:[:k :v| v sum:0]] timeToRun.
	self assert:t <= (Duration milliSeconds:300).

	t:= [b := a groupBy:[:row| (row at:1) > 50 ] ->{2. 3} aggregate:[:k :v| v sum:0]] timeToRun.
	self assert:t <= (Duration milliSeconds:300).
]

{ #category : #tests }
MlArrayPerformanceTest >> testMatrixDo [

	| a t |
	"create a million float array"
	a := (MlArray random: #(10000 10 10)).
	"boolean 1 axis slicing"

	t := [a matricesDo:[:r :s| "doNothing"]] timeToRun.
	"it takes around 49 ms to do 1000 slices of 10 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:500).

	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testMatrixDoC [

	| a t|
	"create a million float array"
	a := (MlArray random: #(10000 10 10)) asCArray.
	"boolean 1 axis slicing"

	t := [a matricesDo:[:r :s| "doNothing"]] timeToRun.
	"it takes around 40 ms to do a slice of 1 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:500).

	
	
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
MlArrayPerformanceTest >> testRowsDo [

	| a t|
	"create a million float array"
	a := (MlArray random: #(100000 10)).
	"boolean 1 axis slicing"
	t := [a rowsDo:[:r :s| #doNothing]] timeToRun.
	"it takes around 40 ms to do a slice of 1 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:3000).
	
	
	
]

{ #category : #tests }
MlArrayPerformanceTest >> testRowsDoC [

	| a b t|
	"create a million float array"
	a := (MlArray random: #(100000 10)) asCArray.
	"boolean 1 axis slicing"
	t := [a rowsDo:[:r :s| #doNothing]] timeToRun.
	"it takes around 20 ms to do a slice of 1 row and 10 columns in #F order"
	self assert:t <= (Duration milliSeconds:1000).
	
	
	
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

{ #category : #tests }
MlArrayPerformanceTest >> testWalk [

	| a t dTimes wTimes lTimes |
	"create a million float array"
	a := (MlArray random: #(100 100 100)).
	lTimes:=wTimes:=dTimes:=0.
	t := [a 
		walkWhile:[:l :s| lTimes := lTimes + 1.l < (a nDim - 1). ]  
		when:[:l :s|  wTimes := wTimes + 1.l = (a nDim - 1). ]  
		do:[:r :s|  dTimes := dTimes + 1]] timeToRun.
	self assert:t <= (Duration milliSeconds:100).
	self assert:lTimes equals:wTimes.
	self assert:dTimes equals:10000. 
	self assert:lTimes equals:10100 
	
	
	
]
