Extension { #name : #Dictionary }

{ #category : #'*MlSt' }
Dictionary >> at:e incrementBy: incr [
	| v |
	v := self at:e ifAbsent:0.
	self at:e put:(v+incr)
]

{ #category : #'*MlSt' }
Dictionary >> at:e vstack: anObject [
	| v popo |
	popo := anObject isMlArray ifTrue:[anObject] ifFalse:[anObject asMlArray].
	v := self at:e 
				ifPresent:[:o| self at:e put: o , popo] ifAbsentPut:[popo].
	^ v 
]
