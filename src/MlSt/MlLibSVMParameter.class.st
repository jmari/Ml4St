Class {
	#name : #MlLibSVMParameter,
	#superclass : #MlParameterDictionary,
	#instVars : [
		'svmParameter'
	],
	#category : #'MlSt-Svm-Classification'
}

{ #category : #access }
MlLibSVMParameter >> nativeParameters [  
	
	^ svmParameter ifNil:[ svmParameter := SVMParameter new].
]
