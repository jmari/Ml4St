"
It is a SmallDictionary of labels to give a ""name"" to each element of an axis.
- at: anObject overrides the at: method, it returns the index for a label and if it is absent, returns the same label. I can     call it passing the index itself and get te same index or transform the label to an index. 
"
Class {
	#name : #MlLabelDict,
	#superclass : #SmallDictionary,
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlLabelDict class >> newFrom: anArray [
	| instance |
	instance := self new.
	anArray doWithIndex:[:l :i| instance at:l put:i].
	^ instance.
]

{ #category : #accessing }
MlLabelDict >> at: anIndex [
	^ self at: anIndex ifAbsent:[ anIndex]
]
