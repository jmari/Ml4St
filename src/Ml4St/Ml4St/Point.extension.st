Extension { #name : #Point }

{ #category : #'*Ml4St' }
Point >> @ step [ 
	| i |
	(step isString | step isSymbol ) ifTrue:[^ (MlLabeledSlice with:self x with: self y with:1) step: step].
	i :=  MlSlice x:self x y: self y.
	i step: step.
	^ i
	 
]

{ #category : #'*Ml4St' }
Point >> asSlice [

	^MlSlice x:self x y: self y.

]

{ #category : #'*Ml4St' }
Point >> isSlice [ 	
	^ true
]
