Extension { #name : #Dictionary }

{ #category : #'*MlSt' }
Dictionary >> at:e add: anObject [
	| v popo |
	popo :=self findElementOrNil: e.
	v := self at:e ifAbsentPut:[OrderedCollection new].
	^ v add:anObject
]

{ #category : #'*MlSt' }
Dictionary >> at:e incrementBy: incr [
	| v |
	v := self at:e ifAbsent:0.
	self at:e put:(v+incr)
]
