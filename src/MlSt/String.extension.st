Extension { #name : #String }

{ #category : #'*MlSt' }
String >> @ anObject [
	^ MlLabeledSlice with:self with:anObject with:1
]
