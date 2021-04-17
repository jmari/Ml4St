Extension { #name : #UndefinedObject }

{ #category : #'*Ml4St' }
UndefinedObject >> @ anInteger [ 
	
	^  Point x:1 y:anInteger

]

{ #category : #'*Ml4St' }
UndefinedObject >> isSlice [ 
	^ true

]

{ #category : #'*Ml4St' }
UndefinedObject >> to: anInteger [ 
	
	^  self@anInteger

]
