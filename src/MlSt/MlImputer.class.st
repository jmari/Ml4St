Class {
	#name : #MlImputer,
	#superclass : #MlTransformer,
	#instVars : [
		'missingValue'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #initialization }
MlImputer >> initialize [ 
	super initialize.
	"nan is default missingValue.
	 you can change it before instantiate using the accessor"
	missingValue := Float nan	
]

{ #category : #'protected-abstract' }
MlImputer >> inverseTransform: aMlArray [

	^ self error:'Inverse Transform is not possible'
	
	
	  
]

{ #category : #'as yet unclassified' }
MlImputer >> missingValue [

	^ missingValue 
]

{ #category : #'as yet unclassified' }
MlImputer >> missingValue: aValue [

	missingValue:= aValue 
]
