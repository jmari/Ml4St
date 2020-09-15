Class {
	#name : #MlSVClassifier,
	#superclass : #MlClassification,
	#pools : [
		'SVMKernelType',
		'SVMType'
	],
	#category : #'MlSt-Svm-Classification'
}

{ #category : #initialization }
MlSVClassifier >> initializeSolver [
	self parameters at:#svm_type put: C_SVC value.
	self parameters at:#kernel_type put: RBF value.
]

{ #category : #initialization }
MlSVClassifier >> libraryClass [ 	
	"return library class"
	^ LibSVM
]

{ #category : #initialization }
MlSVClassifier >> parameterClass [ 
	^ MlLibSVMParameter 
]
