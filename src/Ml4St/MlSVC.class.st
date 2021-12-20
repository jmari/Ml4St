Class {
	#name : #MlSVC,
	#superclass : #MlClassification,
	#pools : [
		'SVMKernelType',
		'SVMType'
	],
	#category : #'Ml4St-Svm'
}

{ #category : #initialization }
MlSVC class >> initialize [ 
	SVMKernelType initialize.
	SVMType initialize
]

{ #category : #initialization }
MlSVC >> initializeSolver [
	self parameters at:#svm_type put: C_SVC value.
	self parameters at:#kernel_type put: RBF value.
]

{ #category : #initialization }
MlSVC >> libraryClass [ 	
	"return library class"
	^ LibSVM
]

{ #category : #initialization }
MlSVC >> nodeClass [ 
	^ SVMNode
]

{ #category : #initialization }
MlSVC >> parameterClass [ 
	^ MlLibSVMParameter 
]

{ #category : #'fit-predict' }
MlSVC >> problemFromArray: anArray features: aSparseMatrix bias: bias [
	^ SVMReader new asSVMProblemWithTarget: anArray features: aSparseMatrix
]
