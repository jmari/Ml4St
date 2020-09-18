Class {
	#name : #MlLibSVMParameter,
	#superclass : #MlParameterDictionary,
	#instVars : [
		'svmParameter'
	],
	#category : #'MlSt-Svm'
}

{ #category : #access }
MlLibSVMParameter >> nativeParameters [  
	
	^ svmParameter ifNil:[ svmParameter := SVMParameter new].
]
