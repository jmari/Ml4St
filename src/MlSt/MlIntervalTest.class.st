Class {
	#name : #MlIntervalTest,
	#superclass : #TestCase,
	#category : #'MlSt-Core-Test'
}

{ #category : #tests }
MlIntervalTest >> testAddSub [
	self assert: ({10. 10. 10} asMlInterval) + 5 equals: ({6. 6. 6} to: { 15. 15. 15 }).
	self assert: ({10. 10. 10} asMlInterval) - 5 equals: ({-4. -4. -4} to: { 5. 5. 5 })   
]

{ #category : #tests }
MlIntervalTest >> testAt [
		| i |
	i := { 2. 3. 4. 5 } asMlInterval.
	self assert: i first equals: { 1. 1. 1. 1 }.
	
	i := { 2. 3. 4. 5 } to: {100. 100. 100. 100}.
	self assert: i first equals: { 2. 3. 4. 5 }.
	self assert: i last equals: {100. 100. 100. 100}.
	
	i := { 2. 3. 4. 5 } to: {10. 10. 10. 10} by:2.
	self assert: i first equals: { 2. 3. 4. 5 }.
	self assert: i last equals: {10. 10. 10. 9}.

	i doWithIndex:[:e :j|self assert: (i indexOf: e)  equals: j].	

	i := {10. 10. 10. 10} to: { 2. 3. 4. 5 }  by:-2.
	self assert: i first equals: { 10. 10. 10. 10 }.
	self assert: i last equals: {2. 3. 4. 6}.
	i doWithIndex:[:e :j|self assert: (i indexOf: e)  equals:j].	
		
	self should: [i at:0]  raise: Error.	
	self should: [i at: (i size + 1)]  raise: Error.	

]

{ #category : #tests }
MlIntervalTest >> testEnumeration [
		| i n |
	i := { 10. 10. 10. 10 } asMlInterval.
	n := 0.
	i do:[:e| n := n + 1].
	self assert:n equals: i size.
	i doWithIndex:[:e :j| n := j].
	self assert:n equals: i size.
	
	n := 0.
	i reverseDo:[:e| n := n + 1].
	self assert:n equals: i size.
	i reverseDoWithIndex:[:e :j| n := j].
	self assert:n equals: 1.
]

{ #category : #tests }
MlIntervalTest >> testEnumerationNegStep [
		| i n |
	i := { 10. 10. 10. 10 } to:{1. 1. 1. 1} by:-1 .
	n := 0.
	i do:[:e| n := n + 1].
	self assert:n equals: i size.
	i doWithIndex:[:e :j| n := j].
	self assert:n equals: i size.

	n := i size.
	i reverseDo:[:e| n := n - 1].
	self assert:n equals: 0.
	i reverseDoWithIndex:[:e :j| n := j].
	self assert:n equals: 1.
]

{ #category : #tests }
MlIntervalTest >> testFromArray [

	| i |
	i := { 2. 3. 4. 5 } asMlInterval.
	self assert: i size equals: 120
]

{ #category : #tests }
MlIntervalTest >> testFromTo [

	| i |
	i := { 1. 1. 1. 1 } to: { 2. 3. 4. 5 }.
	self assert: i size equals: 120
]

{ #category : #tests }
MlIntervalTest >> testFromTo1element [

	| i |
	i := { 2. 3. 4. 5 } to: { 2. 3. 4. 5 }.
	self assert: i size equals: 1
]

{ #category : #tests }
MlIntervalTest >> testFromToNegSlice [

	| i |
	i := { -1. -1. -1. -1 } to: { 2. 3. 4. 5 }.
	self assert: i size equals: 4*5*6*7
]

{ #category : #tests }
MlIntervalTest >> testFromToNegSliceStep2 [

	| i |
	i := { -1. -1. -1. -1 } to: { 2. 3. 4. 5 } by:2.
	self assert: i size equals: 4*5*6*7 /2
]

{ #category : #tests }
MlIntervalTest >> testFromToNegSliceStep3 [

	| i |
	i := { -1. -1. -1. -1 } to: { 2. 3. 4. 5 } by:3.
	self assert: i size equals: 4*5*6*7 /3
]

{ #category : #tests }
MlIntervalTest >> testPerformance [
		| i t |
	i := { 10. 10. 10. 10 } asMlInterval.
	t := [i do:[:e| "nothing"]] timeToRun.
	self assert:t <= (Duration milliSeconds:400).
]
