Extension { #name : #Point }

{ #category : #'*MlSt' }
Point >> @ step [ 
	| i |
	(step isString | step isSymbol ) ifTrue:[^ (MlLabeledSlice with:self x with: self y with:1) step: step].
	i :=  MlSlice x:self x y: self y.
	i step: step.
	^ i
	 
]

{ #category : #'*MlSt' }
Point >> asSlice [

	^MlSlice x:self x y: self y.

]

{ #category : #'*MlSt' }
Point >> isSlice [ 	
	^ true
]
