Class {
	#name : #MlNCArray,
	#superclass : #Object,
	#instVars : [
		'instance'
	],
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'as yet unclassified' }
MlNCArray class >> ffiClass [
	^ FFIArray
]

{ #category : #accessing }
MlNCArray >> at: aPos [
	^ self libClass vector: self at: aPos
]

{ #category : #accessing }
MlNCArray >> at: aPos put: aValue [
	^ self libClass vector: self at: aPos put: aValue
]

{ #category : #accessing }
MlNCArray >> dot: otherNCArray [
	^ self libClass vector: self dot: otherNCArray
]

{ #category : #accessing }
MlNCArray >> instance [ 
	^ instance ifNil:[instance := self libClass newVector: self size strides: nil stridesSize:0]
]

{ #category : #accessing }
MlNCArray >> instance: sizeOfContent [
	^ instance ifNil:[instance := self libClass newVector: sizeOfContent strides: nil stridesSize:0]
]

{ #category : #accessing }
MlNCArray >> libClass [ 
	^ self subclassResponsibility 	
]
