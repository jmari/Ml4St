Extension { #name : #Array }

{ #category : #'*Ml4St' }
Array >> asMlInterval [
	self assert: [self isArrayOfIntegers]. 
	^ MlInterval shaped:self
	
]

{ #category : #'*Ml4St' }
Array >> asSlice [ 
	(self size =  5 and:[
		(self at:2) = #'.'  & (self at:3) = #'.' & (self at:4) = #'.'] ) ifTrue:[
			^ ((self at:1)= #'_' ifTrue:[nil] ifFalse:[(self at:1)])
			  @ ((self at:5)= #'_' ifTrue:[nil] ifFalse:[(self at:5)])].
	(self size =  7 and:[
		(self at:2) = #'.'  & (self at:3) = #'.' & (self at:4) = #'.' & (self at:6) = #by]) ifTrue:[
			^ ((self at:1)= #'_' ifTrue:[nil] ifFalse:[(self at:1)])
			  @ ((self at:5)= #'_' ifTrue:[nil] ifFalse:[(self at:5)])
			  @ (self at:7) ].
	^ self
	
]

{ #category : #'*Ml4St' }
Array >> isArrayOfIntegers [
	self do:[:i| i isInteger ifFalse:[^false]].
	^ true
	
]

{ #category : #'*Ml4St' }
Array >> isSlice [ 
	^ (self size =  5 and:[
		(self at:2) = #'.'  & (self at:3) = #'.' & (self at:4) = #'.'] ) |
	(self size =  7 and:[
		(self at:2) = #'.'  & (self at:3) = #'.' & (self at:4) = #'.' & (self at:6) = #by])

	
]

{ #category : #'*Ml4St' }
Array >> to: anArrayOfIntegers [
	^ self to: anArrayOfIntegers by: 1
	
]

{ #category : #'*Ml4St' }
Array >> to: anArrayOfIntegers by: step [
	self assert: [self isArrayOfIntegers]. 
	self assert: [anArrayOfIntegers isArrayOfIntegers].
	self assert: [ self size = (anArrayOfIntegers size )].
	^ MlInterval from:self to:anArrayOfIntegers by: step
	
]
