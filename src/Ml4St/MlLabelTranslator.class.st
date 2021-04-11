"
It is a SmallDictionary of labels to give a ""name"" to each element of an axis.
- at: anObject overrides the at: method, it returns the index for a label and if it is absent, returns the same label. I can     call it passing the index itself and get te same index or transform the label to an index. 
"
Class {
	#name : #MlLabelTranslator,
	#superclass : #OrderedCollection,
	#category : #'Ml4St-Core'
}

{ #category : #'instance creation' }
MlLabelTranslator class >> newFrom: anArray [ 
	^ super newFrom: (anArray collect:[:v| v asString])
]

{ #category : #'sorting and filtering' }
MlLabelTranslator >> applyBooleanFilter: aBooleanArray [
	| i |
	i := 0.
	^ self select:[:c | i:=i+1. (aBooleanArray at:i) ]

]

{ #category : #accessing }
MlLabelTranslator >> at: i put: anObject [
	^ super at:i put: anObject asString
]

{ #category : #copying }
MlLabelTranslator >> deepCopy [
	^ self shallowCopy 
]

{ #category : #accessing }
MlLabelTranslator >> slice: aSliceInOneDimension [
	| copy |
	copy := self class new.
	self isEmpty ifTrue:[^ copy].
	aSliceInOneDimension do:[:s| 
		s isCollection 
			ifTrue:[s do:[:e| copy add: (self at:e) ]]
			ifFalse:[copy add: (self at:s)]].
	^ copy
	
]

{ #category : #accessing }
MlLabelTranslator >> translate: aLabel [
	
	^ self indexOf: aLabel ifAbsent:[aLabel].
	
]
