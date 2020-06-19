Extension { #name : #Dictionary }

{ #category : #'*MlSt' }
Dictionary >> at:e incrementBy: incr [
	| v |
	v := self at:e ifAbsent:0.
	self at:e put:(v+1)
]
