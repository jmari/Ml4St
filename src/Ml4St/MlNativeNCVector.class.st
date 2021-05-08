Class {
	#name : #MlNativeNCVector,
	#superclass : #MlNonContinuousVector,
	#type : #variable,
	#instVars : [
		'instance'
	],
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #'as yet unclassified' }
MlNativeNCVector class >> ffiClass [
	^ FFIArray
]

{ #category : #accessing }
MlNativeNCVector >> at: aPos [
	^ self libClass vector: self buffer at: aPos
]

{ #category : #accessing }
MlNativeNCVector >> at: aPos put: aValue [
	^ self libClass vector: self buffer at: aPos put: aValue
]

{ #category : #accessing }
MlNativeNCVector >> dot: otherNCArray [
	^ self libClass vector: self buffer dot: otherNCArray buffer
]

{ #category : #accessing }
MlNativeNCVector >> initialize: size [
	^ instance ifNil:[instance := self libClass newVector: size strides: nil stridesSize:0]
]

{ #category : #accessing }
MlNativeNCVector >> libClass [ 
	^ self subclassResponsibility 	
]

{ #category : #accessing }
MlNativeNCVector >> size [ 
	^ instance size
]

{ #category : #accessing }
MlNativeNCVector >> strides: stridesArray [
	instance strides: stridesArray . 
	instance stridesSize: stridesArray size.
	instance size: (LibFloatNCV calculateVirtualSize: instance realSize strides: stridesArray getHandle stridesSize: stridesArray size).
	self size: instance size
	
	
]

{ #category : #'as yet unclassified' }
MlNativeNCVector >> supportsNativeSlicing [
	^ true
]
