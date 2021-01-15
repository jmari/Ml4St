Extension { #name : #Array }

{ #category : #'*MlSt' }
Array >> asMlInterval [
	self assert: [self isArrayOfIntegers]. 
	^ MlInterval shaped:self
	
]

{ #category : #'*MlSt' }
Array >> isArrayOfIntegers [
	self do:[:i| i isInteger ifFalse:[^false]].
	^ true
	
]

{ #category : #'*MlSt' }
Array >> to: anArrayOfIntegers [
	^ self to: anArrayOfIntegers by: 1
	
]

{ #category : #'*MlSt' }
Array >> to: anArrayOfIntegers by: step [
	self assert: [self isArrayOfIntegers]. 
	self assert: [anArrayOfIntegers isArrayOfIntegers].
	self assert: [ self size = (anArrayOfIntegers size )].
	^ MlInterval from:self to:anArrayOfIntegers by: step
	
]
