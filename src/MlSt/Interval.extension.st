Extension { #name : #Interval }

{ #category : #'*MlSt' }
Interval >> asSlice [ 
	^ self first@self last@self increment
]

{ #category : #'*MlSt' }
Interval >> isSlice [
	^ true
]
