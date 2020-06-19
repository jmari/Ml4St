Class {
	#name : #LibLinearTest,
	#superclass : #TestCase,
	#classVars : [
		'LNSolverType'
	],
	#category : #'MlSt-Test'
}

{ #category : #'as yet unclassified' }
LibLinearTest >> exampleSVM [
	^ '1 1:0.368684 2:0.141667 3:0.0454545 4:0.184681 5:0.223514 6:0.0716594 7:0.870079 8:0.913386 9:0.582677 10:0.875366 11:1 43:1 
1 1:0.365683 2:0.155556 3:0.030303 4:0.151754 5:0.215762 6:0.0547984 7:0.866142 8:0.925197 9:0.594488 10:0.867838 11:1 43:1 
2 1:0.472736 2:0.386111 3:0.136364 4:0.19184 5:0.307494 6:0.446817 7:0.92126 8:0.937008 9:0.531496 10:0.853339 11:1 26:1 
2 1:0.463232 2:0.430556 3:0.272727 4:0.173228 5:0.375969 6:0.434172 7:0.937008 8:0.937008 9:0.480315 10:0.865886 11:1 44:1 
1 1:0.368184 2:0.125 3:0.030303 4:0.10952 5:0.222222 6:0.0549389 7:0.866142 8:0.92126 9:0.590551 10:0.860449 11:1 43:1 
2 1:0.36018 2:0.366667 3:0.0909091 4:0.214746 5:0.204134 6:0.00941408 7:0.905512 8:0.933071 9:0.551181 10:0.840792 11:1 43:1 
1 1:0.373687 2:0.125 3:0.106061 4:0.193271 5:0.229974 6:0.088942 7:0.874016 8:0.885827 9:0.543307 10:0.872159 11:1 43:1 '
]

{ #category : #tests }
LibLinearTest >> readSVMFileFormat [
	| reader problem |

	"run in workspace, test takes too must time"
	reader := SVMReader on: 'covtype.libsvm.binary.scale' asFileReference  readStream.
	problem := reader nextToLast.
	self assert: problem size equals: 2.
	self assert: (problem at:1) size equals: (problem at:1) size
]

{ #category : #tests }
LibLinearTest >> testCheckParameters [
]

{ #category : #tests }
LibLinearTest >> testLibCreation [
	| libLinear |
	libLinear := LibLinear uniqueInstance.
	self assert:libLinear isNil not
]

{ #category : #tests }
LibLinearTest >> testLoadModelAndPredict [
	| model sample reader problem labels |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	problem := reader asLNProblem.
	model := LibLinear loadModel:'test_model.mdl'.
	model inspect.
	labels := OrderedCollection new.

	problem f_array do:[:e|
		labels add:( LibLinear predict:model featureNode: (LNFeatureNode fromHandle: e))].
	labels inspect
						
		

]

{ #category : #tests }
LibLinearTest >> testLoadProblem [

]

{ #category : #tests }
LibLinearTest >> testReadSVMFormat [
	| reader problem |

	"allowing complex map keys used to be optional, now it is always the default"
	reader := SVMReader on: self exampleSVM readStream.
	problem := reader nextToLast.
	self assert: problem size equals: 2.
	self assert: (problem at:1) size equals: (problem at:1) size
]

{ #category : #tests }
LibLinearTest >> testSVMRowCollection [
	| reader problem rowCollection newRowColection |

	"allowing complex map keys used to be optional, now it is always the default"
	reader := SVMReader on: self exampleSVM readStream.
	problem := reader nextToLast.
	rowCollection := problem at:2.
	newRowColection := rowCollection * 2.

	self assert: (newRowColection at:1) / 2 equals: (rowCollection at:1) 
]

{ #category : #tests }
LibLinearTest >> testSaveModel [
]

{ #category : #tests }
LibLinearTest >> testTrainModel [
	| sample reader problem parameters model |
	sample := self exampleSVM.
	reader := SVMReader on: sample readStream.
	problem := reader asLNProblemWithBias:-1.
	problem inspect.
	parameters := LNParameter new C:4.
	model := LibLinear train: problem parameter:parameters.
	model inspect.
	LibLinear saveModel: model filename: 'test_model.mdl'.
	LibLinear destroyParameter: parameters.
]
