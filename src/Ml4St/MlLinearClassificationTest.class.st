Class {
	#name : #MlLinearClassificationTest,
	#superclass : #TestCase,
	#classVars : [
		'LNSolverType'
	],
	#category : #'Ml4St-Core-Test'
}

{ #category : #'as yet unclassified' }
MlLinearClassificationTest class >> exampleFitAndPredict [
	| reader problem regressor labelsAndProb score |
	reader := SVMReader on: 'covtype.libsvm.binary.scale' asFileReference readStream. 
	problem := reader nextToLast.	
	[  	
		regressor := MlLogisticRegression new:{	#C->1.
														   #p->0.5}.
		regressor fit: (problem at:2) target: (problem at:1) sampleWeight:{2->5}. 
		labelsAndProb :=	regressor predictProbability: (problem at:2).
		score := (labelsAndProb collect:[:e| e key]) accuracy: (problem at:1).
	]	 timeToRun inspect. 
	score inspect.
	labelsAndProb inspect.
	regressor := nil.
	Smalltalk garbageCollect. 
]

{ #category : #'as yet unclassified' }
MlLinearClassificationTest class >> exampleScore [
	| reader problem regressor score |
	reader := SVMReader on: 'covtype.libsvm.binary.scale' asFileReference readStream. 
	problem := reader nextToLast.	
	[  	
		regressor := MlLogisticRegression new:{	#C->1.
														   #p->0.5}.
		score := regressor score: (problem at:2) targets: (problem at:1) sampleWeight: {2->5}.
	]	 timeToRun inspect. 
	score inspect.
	regressor := nil.
	Smalltalk garbageCollect. 
]

{ #category : #utilties }
MlLinearClassificationTest >> exampleSVM [
	^ '1 1:0.368684 2:0.141667 3:0.0454545 4:0.184681 5:0.223514 6:0.0716594 7:0.870079 8:0.913386 9:0.582677 10:0.875366 11:1 43:1 
1 1:0.365683 2:0.155556 3:0.030303 4:0.151754 5:0.215762 6:0.0547984 7:0.866142 8:0.925197 9:0.594488 10:0.867838 11:1 43:1 
2 1:0.472736 2:0.386111 3:0.136364 4:0.19184 5:0.307494 6:0.446817 7:0.92126 8:0.937008 9:0.531496 10:0.853339 11:1 26:1 
2 1:0.463232 2:0.430556 3:0.272727 4:0.173228 5:0.375969 6:0.434172 7:0.937008 8:0.937008 9:0.480315 10:0.865886 11:1 44:1 
1 1:0.368184 2:0.125 3:0.030303 4:0.10952 5:0.222222 6:0.0549389 7:0.866142 8:0.92126 9:0.590551 10:0.860449 11:1 43:1 
2 1:0.36018 2:0.366667 3:0.0909091 4:0.214746 5:0.204134 6:0.00941408 7:0.905512 8:0.933071 9:0.551181 10:0.840792 11:1 43:1 
1 1:0.373687 2:0.125 3:0.106061 4:0.193271 5:0.229974 6:0.088942 7:0.874016 8:0.885827 9:0.543307 10:0.872159 11:1 43:1 '
]

{ #category : #tests }
MlLinearClassificationTest >> readSVMFileFormat [
	| reader problem |

	"run in workspace, test takes too must time"
	reader := SVMReader on: 'covtype.libsvm.binary.scale' asFileReference  readStream.
	problem := reader nextToLast.
	self assert: problem size equals: 2.
	self assert: (problem at:1) size equals: (problem at:1) size
]

{ #category : #tests }
MlLinearClassificationTest >> testAutotuneModel [
	| sample reader problem regressor score |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	"gets an array with:target with:features"
	problem := reader nextToLast.	
	regressor := MlLogisticRegression new:{	#C->1.0.
														#p->0.5}.
	score := regressor autotune: (problem at:2)  target: (problem at:1). 
	self assert:(score at: #score) > 0


]

{ #category : #tests }
MlLinearClassificationTest >> testTrainAndPredictProbabilityWeighedModel [
	| sample reader problem regressor labelsAndProb score |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	"gets an array with:target with:features"
	problem := reader nextToLast.	
	regressor := MlLogisticRegression new:{	#C->1.
														#p->0.5}.
	regressor fit: (problem at:2) target: (problem at:1) sampleWeight:{2->5}. 
	labelsAndProb :=	regressor predictProbability: (problem at:2).
	score := (labelsAndProb collect:[:e| e key]) accuracy: (problem at:1).

	self assert: (score at:#accuracy) > 0
]

{ #category : #tests }
MlLinearClassificationTest >> testTrainAndPredictWeighedModel [
	| sample reader problem regressor labels score |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	"gets an array with:target with:features"
	problem := reader nextToLast.	
	regressor := MlLogisticRegression new:{	#C->1.
														#p->0.5}.
	regressor fit: (problem at:2) target: (problem at:1) sampleWeight:{2->5}. 
	labels :=	regressor predict: (problem at:2).
	score := labels accuracy: (problem at:1).
	self assert: (score at:#accuracy) > 0
]

{ #category : #tests }
MlLinearClassificationTest >> testTrainModel [
	| sample reader problem regressor |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	"gets an array with:target with:features"
	problem := reader nextToLast.	
	regressor := MlLogisticRegression new:{	#C->1.
														#p->0.5}.
	regressor fit: (problem at:2) target: (problem at:1). 
	self assert: regressor model nr_class equals:2 


]

{ #category : #tests }
MlLinearClassificationTest >> testTrainWeighedModel [
	| sample reader problem regressor |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	"gets an array with:target with:features"
	problem := reader nextToLast.	
	regressor := MlLogisticRegression new:{	#C->1.
														#p->0.5}.
	regressor fit: (problem at:2) target: (problem at:1) sampleWeight:{2->5}. 
	self assert: regressor model nr_class equals:2 


]
