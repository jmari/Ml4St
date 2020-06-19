Class {
	#name : #MlMetricsTests,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlMetricsTests >> testAccuracy [
	| la1 la2 |
	la1 := #(0 1 2 3 4 5 6 7 8 9).
	la2 := #(0 1 2 3 4 5 6 7 8 9).
	self assert: ((la1 accuracy: la2) at:#accuracy) equals:1.0.
	la2 := la2 reverse.
	self assert: ((la1 accuracy: la2) at:#accuracy) equals:0.0.
	
	
]

{ #category : #tests }
MlMetricsTests >> testConfusionMatrix [
	| predicted real cm pr |
	predicted := #(0 1 1 1 4 5 6 7 8 9).
	real := #(0 1 1 1 0 0 0 0 0 0).
	
	cm := predicted confusionMatrix: real.
	pr := cm performanceReport.
	self assert: ((pr at:#accuracy) closeTo: 0.4).
	self assert: (((pr at:1) at:#precision ) closeTo: 1.0).
	self assert: (((pr at:1) at:#recall ) closeTo: 1.0).
	self assert: (((pr at:0) at:#precision  ) closeTo: 1/7).
	self assert: (((pr at:0) at:#recall ) closeTo: 1.0).
	self assert: (((pr at:9) at:#precision  ) closeTo: 0.0).
	self assert: (((pr at:9) at:#recall ) closeTo: 0.0)
]

{ #category : #tests }
MlMetricsTests >> testDiagonalConfusionMatrix [
	| predicted real sum cm |
	predicted := #(0 1 2 3 4 5 6 7 8 9).
	real := #(0 1 2 3 4 5 6 7 8 9).
	sum := 0.
	cm := predicted confusionMatrix: real.
	cm labels do:[:i| sum := sum + (cm at:i at:i)] .
	self assert: sum equals:10.
	
	sum := 0.
	cm labels do:[:i|
		 sum := sum + (cm sumRow:i)+(cm sumColumn:i)].
	
	self assert: sum equals:20.
	self assert: cm sumRows values sum equals: 10.
	self assert: cm sumColumns values sum equals: 10.
	self assert: cm accuracy equals: 1.
	cm labels do:[:l|
		self assert: (cm precision:l) equals: 1.
		self assert: (cm recall:l) equals: 1.
		self assert: (cm f1score:l) equals: 1].
	
	

	   
]
