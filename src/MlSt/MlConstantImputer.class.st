Class {
	#name : #MlConstantImputer,
	#superclass : #MlImputer,
	#instVars : [
		'uMatrix',
		'constant'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #accessing }
MlConstantImputer >> constant [
	^ constant ifNil:[constant := MlArray from:{0.}]
]

{ #category : #accessing }
MlConstantImputer >> constant: anObject [
	constant := MlArray from:{anObject}
]

{ #category : #'protected-abstract' }
MlConstantImputer >> fitParameters: aMlArray [

	"do nothing"
	
]

{ #category : #'protected-abstract' }
MlConstantImputer >> transform: aMlArray [

	^  aMlArray  replace: self missingValue by: self constant 
]
