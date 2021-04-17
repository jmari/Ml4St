Extension { #name : #Array }

{ #category : #'*Ml4St' }
Array >> asMlInterval [
	self assert: [self isArrayOfIntegers]. 
	^ MlInterval shaped:self
	
]

{ #category : #'*Ml4St' }
Array >> isArrayOfIntegers [
	self do:[:i| i isInteger ifFalse:[^false]].
	^ true
	
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
