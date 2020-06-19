"
I am a generic parameter class for all regression estimators in mlst. Defines a interface like a dictionary for native ffi parameters
"
Class {
	#name : #MlParameterDictionary,
	#superclass : #SmallDictionary,
	#category : #'MlSt-Core'
}

{ #category : #'as yet unclassified' }
MlParameterDictionary >> at: aKey [ 
	^ (self nativeParameters respondsTo: aKey asSymbol) 
		ifTrue:[
			super at: aKey ifAbsent:[
			self nativeParameters perform: aKey asSymbol ]]
		ifFalse:[ self errorKeyNotFound: aKey ]
]

{ #category : #'as yet unclassified' }
MlParameterDictionary >> at: aKey put: anObject [
	(self nativeParameters respondsTo: (aKey, ':') asSymbol) 
		ifTrue:[
			super at: aKey put: anObject.
			self nativeParameters perform: (aKey, ':') asSymbol with: anObject]
		ifFalse:[ self errorKeyNotFound: aKey ,':']
]

{ #category : #'as yet unclassified' }
MlParameterDictionary >> nativeParameters [
	self subclassResponsibility 
]
