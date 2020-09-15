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
MlSVClassifier >> initializeParameters [
	parameters := MlLibSVMParameter new.
]

{ #category : #initialization }
MlSVClassifier >> initializeSolver [
	self parameters at:#svm_type put: C_SVC value.
	self parameters at:#kernel_type put: RBF value.
]

{ #category : #initialization }
MlSVClassifier >> library [ 	
	"return library class"
	^ LibSVM
]
