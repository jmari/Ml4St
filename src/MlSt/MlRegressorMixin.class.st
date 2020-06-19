"
I am a Mixin class for all regression estimators in mlst. Defines the interface for all the regressors or classifyers.


"
Class {
	#name : #MlRegressorMixin,
	#superclass : #Object,
	#instVars : [
		'model',
		'parameters'
	],
	#category : #'MlSt-Core'
}

{ #category : #'fit-predict' }
MlRegressorMixin >> fit: aSparseMatrix target: anArray [ 
	^ self fit: aSparseMatrix target: anArray sampleWeight: nil
]

{ #category : #'fit-predict' }
MlRegressorMixin >> fit: aSparseMatrix target: anArray sampleWeight: sw [
	^ self subclassResponsibility 
]

{ #category : #accessing }
MlRegressorMixin >> model [
	^ model
]

{ #category : #accessing }
MlRegressorMixin >> model: anObject [
	model := anObject
]

{ #category : #accessing }
MlRegressorMixin >> parameters [ 
	^ parameters 
	
]

{ #category : #accessing }
MlRegressorMixin >> parameters: aMlParamenterDictionary [ 
	parameters := aMlParamenterDictionary
	
]

{ #category : #'fit-predict' }
MlRegressorMixin >> predict: aSparseMatrix [ 
	^ self subclassResponsibility 
]

{ #category : #'fit-predict' }
MlRegressorMixin >> predictProbability: aSparseMatrix [  
	^ self subclassResponsibility 
]

{ #category : #'fit-predict' }
MlRegressorMixin >> score: aSparseMatrix target: anArray [
	^ self score: aSparseMatrix targets: anArray sampleWeight: nil 
]

{ #category : #'fit-predict' }
MlRegressorMixin >> score: aSparseMatrix targets: anArray sampleWeight: sw [
	^ self subclassResponsibility 
]
