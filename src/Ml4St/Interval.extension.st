Extension { #name : #Interval }

{ #category : #'*Ml4St' }
Interval >> asSlice [ 
	^ start@stop@step
]

{ #category : #'*Ml4St' }
Interval >> isSlice [
	^ true
]

{ #category : #'*Ml4St' }
Interval class >> union: collectionOfSlices [
	|top aStackOfSlices collectionOfSlicesSortedByFirst|
 	aStackOfSlices := Stack new.
	collectionOfSlicesSortedByFirst := collectionOfSlices sort:[:a :b| a first < (b first)].
	aStackOfSlices push: collectionOfSlicesSortedByFirst first.
	collectionOfSlicesSortedByFirst allButFirstDo:[:each|
		(aStackOfSlices top last < each first) 
		ifTrue:[aStackOfSlices push:each ]
		ifFalse:[ 
			(aStackOfSlices top last < each last)
			ifTrue:[
				top := aStackOfSlices pop.
				top isInterval ifTrue:[
					(top includes: each first) ifTrue:[
							(top increment % each increment) = 0 
								ifTrue:[aStackOfSlices push: (top first to:each last by:each increment)]
								ifFalse:[(each increment % top increment) = 0 
												ifTrue:[aStackOfSlices push: (top first to: each last by: top increment)]
												ifFalse:[	aStackOfSlices push: ((top , each) asSet asArray sort)	 ]
												]
								]
					].
				(top isInterval not or:[(top includes: each first) not])  ifTrue:[	aStackOfSlices push: ((top , each) asSet asArray sort)	 ] ]
			ifFalse:[
				top := aStackOfSlices pop.
				top isInterval ifTrue:[
					(top includes: each first) ifTrue:[
							(top increment % each increment) = 0 
								ifTrue:[aStackOfSlices push: (top first to:top last by:each increment)]
								ifFalse:[(each increment % top increment) = 0 
												ifTrue:[aStackOfSlices push: (top first to: top last by: top increment)]
												ifFalse:[	aStackOfSlices push: ((top , each) asSet asArray sort)	 ]
												]
								]
					].
				(top isInterval not or:[(top includes: each first) not])  ifTrue:[	aStackOfSlices push: ((top , each) asSet asArray sort)	 ]
				]	
			] 
		].
			
	^ aStackOfSlices
]
