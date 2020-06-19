Class {
	#name : #MlTransformer,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'MlSt-Preprocessing'
}

{ #category : #public }
MlTransformer >> fit: aMlArray [


	self fit: aMlArray transform:false.
	
	
	  
]

{ #category : #'protected-abstract' }
MlTransformer >> fit: aMlArray transform: aBoolean [
	"aCollection could be an array of arrays, an array of dictionaries...etc...but values shoud be Numbers"
	"#( #( #(0 0 0) #(1 1 1) #(2 2 2) ) #( #(0 0 0) #(1 1 1) #(2 2 2) )) shape is 2 3 3"
	"we need to keep the dimensions and classes"
	collection := aMlArray.
	aMlArray isEmpty ifTrue:[^ self].
	self fitParameters: aMlArray.
	^ aBoolean ifTrue:[ self transform:aMlArray] ifFalse:[self]
	
	
	  
]

{ #category : #public }
MlTransformer >> fitAndTransform: aMlArray [
	^ self fit: aMlArray transform: true.

]

{ #category : #'protected-abstract' }
MlTransformer >> fitParameters: aMlArray [
	self subclassResponsibility 
]

{ #category : #public }
MlTransformer >> inverseTransform [
	 self isFitted 
		ifTrue: [
			collection isEmpty ifTrue:[^ collection newInstanceButEmpty ].
			^ self inverseTransform: collection] 
		ifFalse:[self error: (self class asString , ' is not fitted yet')]
]

{ #category : #'protected-abstract' }
MlTransformer >> inverseTransform: aMlArray [

	^ self subclassResponsibility 
	
	
	  
]

{ #category : #public }
MlTransformer >> isFitted [
	^ collection isNotNil
]

{ #category : #public }
MlTransformer >> transform [
	^ self isFitted ifTrue: [self transform: collection] ifFalse:[self error: (self class asString , ' is not fitted yet')]
]

{ #category : #'protected-abstract' }
MlTransformer >> transform: aMlArray [
	^self subclassResponsibility  
]
