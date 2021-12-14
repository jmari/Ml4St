Class {
	#name : #MlLibSVMParameter,
	#superclass : #MlParameterDictionary,
	#instVars : [
		'svmParameter'
	],
	#category : #'Ml4St-Svm'
}

{ #category : #access }
MlLibSVMParameter >> nativeParameters [  
	
	^ svmParameter ifNil:[ svmParameter := SVMParameter new].
]
