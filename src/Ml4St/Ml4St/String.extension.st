Extension { #name : #String }

{ #category : #'*Ml4St' }
String >> @ anObject [
	^ MlLabeledSlice with:self with:anObject with:1
]
