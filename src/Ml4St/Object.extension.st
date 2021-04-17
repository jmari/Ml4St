Extension { #name : #Object }

{ #category : #'*Ml4St' }
Object >> asSlice [ 	
	^ self
]

{ #category : #'*Ml4St' }
Object >> isMlArray [	
	^ false
]

{ #category : #'*Ml4St' }
Object >> isMlInterval [

	^ false
]

{ #category : #'*Ml4St' }
Object >> isMlTreeNode [
	^ false
]

{ #category : #'*Ml4St' }
Object >> isNonContinuousVector [
	^ false
]

{ #category : #'*Ml4St' }
Object >> isSlice [ 	
	^ false
]
