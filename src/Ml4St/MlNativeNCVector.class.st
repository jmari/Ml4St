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

{ #category : #'instance creation' }
MlNativeNCVector class >> new: size [ 
	^ self basicNew initialize: size
]

{ #category : #accessing }
MlNativeNCVector >> at: aPos [
	^ self libClass vector: self buffer getNativeInstance  at: aPos
]

{ #category : #accessing }
MlNativeNCVector >> at: aPos put: aValue [
	^ self libClass vector: self buffer getNativeInstance at: aPos put: aValue
]

{ #category : #accessing }
MlNativeNCVector >> dot: otherNCArray [
	^ self libClass vector: self buffer getNativeInstance dot: otherNCArray buffer
]

{ #category : #accessing }
MlNativeNCVector >> getNativeInstance [
	^ instance  
]

{ #category : #accessing }
MlNativeNCVector >> initialize: initSize [
	instance ifNil:[instance := self libClass newVector: initSize strides: nil stridesSize:0].
	^ self
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
	
	instance strides: stridesArray asUInt64Array. 
	instance stridesSize: stridesArray size.
	instance size: (self libClass calculateVirtualSize: instance realSize 
										strides: instance strides getHandle 
										stridesSize: stridesArray size).
	self size: instance size
	
	
]

{ #category : #'as yet unclassified' }
MlNativeNCVector >> supportsNativeSlicing [
	^ true
]
