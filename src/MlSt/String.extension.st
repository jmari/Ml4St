Extension { #name : #String }

{ #category : #'*MlSt' }
String >> @ anObject [
	^ MlFakeSlice with:self with:anObject with:1
]
