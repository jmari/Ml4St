Class {
	#name : #MlArraySlicingTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

{ #category : #tests }
MlArraySlicingTest >> testSlice1D [
	| a b d sol |
	a := MlArray from: #(10 1 3 5 2  5 6 4  10 11 12 2 11 2 3 6 10 11 12 20 10 11 12 56).
	d := a at: {  1@2. 4@5. 7@9  }.
	sol :=  MlArray from: #( 10 1 5 2 6 4 10).
	self assert:d equals: sol.
	d := a at: 11@_. 
	sol :=  MlArray from: #( 12 2 11 2 3 6 10 11 12 20 10 11 12 56).
	self assert:d equals: sol.	
	d := a at: #( 1 2 3 4 5 6 8). 
	sol :=  MlArray from: #( 10 1 3 5 2 5 4).
	self assert:d equals: sol.		
]

{ #category : #tests }
MlArraySlicingTest >> testSlice1DC [
	| a b d sol |
	a := MlArray from: #(10 1 3 5 2  5 6 4  10 11 12 2 11 2 3 6 10 11 12 20 10 11 12 56) order:#C.
	d := a at: {  1@2. 4@5. 7@9  }.
	sol :=  MlArray from: #( 10 1 5 2 6 4 10) order:#C.
	self assert:d equals: sol.
	d := a at: 11@_. 
	sol :=  MlArray from: #( 12 2 11 2 3 6 10 11 12 20 10 11 12 56) order:#C.
	self assert:d equals: sol.	
	d := a at: #( 1 2 3 4 5 6 8). 
	sol :=  MlArray from: #( 10 1 3 5 2 5 4) order:#C.
	self assert:d equals: sol.		
]

{ #category : #tests }
MlArraySlicingTest >> testSlice1DUsingIntervals [
	| a b d sol |
	a := MlArray from: #(10 1 3 5 2  5 6 4  10 11 12 2 11 2 3 6 10 11 12 20 10 11 12 56).
	d := a at: {  1 to:2. 4 to:5. 7 to:9  }.
	sol :=  MlArray from: #( 10 1 5 2 6 4 10).
	self assert:d equals: sol.
	d := a at: {11 to: _}. 
	sol :=  MlArray from: #( 12 2 11 2 3 6 10 11 12 20 10 11 12 56).
	self assert:d equals: sol.	
	d := a at: #( 1 2 3 4 5 6 8). 
	sol :=  MlArray from: #( 10 1 3 5 2 5 4).
	self assert:d equals: sol.		
]

{ #category : #tests }
MlArraySlicingTest >> testSlice2C [

	| a b s |
	a := MlArray from: #(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12) 
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))
							order:#C.
										
	self assert: a shape equals:#(8 3).
	b := a slice:{1@_. 1@1}.
	s :=MlArray from: #(#(1) #(4) #(7) #(10) #(21) #(24) #(27) #(30)) order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(8 1).
	
	b := a slice:{1. 1}.
	s :=MlArray from: #(#(1)) order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(1 1).
	
	b := a slice:{1@2. 1@2}.
	s :=MlArray from:  #(
									#(1 2 ) 
							  		#(4 5 ) 
							  		)  order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(2 2).
	
	
	b := a slice:{1@_. 1@_}.
	
	self assert: b shape equals:#(8 3).
	self assert: b equals: a.
	self deny:( b == a).

]

{ #category : #tests }
MlArraySlicingTest >> testSlice2F [

	| a b s |
	a := MlArray from: #(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12) 
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))
							order:#F.
										
	self assert: a shape equals:#(8 3).
	b := a slice:{1@_. 1@1}.
	s :=MlArray from: #(#(1) #(4) #(7) #(10) #(21) #(24) #(27) #(30)) order:#F.
	self assert: b equals: s.
	self assert: b shape equals:#(8 1).
	
	b := a slice:{1. 1}.
	s :=MlArray from: #(#(1)) order:#F.
	self assert: b equals: s.
	self assert: b shape equals:#(1 1).
	
	b := a slice:{1@2. 1@2}.
	s :=MlArray from:  #(
									#(1 2 ) 
							  		#(4 5 ) 
							  		)  order:#F.
	self assert: b equals: s.
	self assert: b shape equals:#(2 2).
	
	
	b := a slice:{1@_. 1@_}.
	
	self assert: b shape equals:#(8 3).
	self assert: b equals: a.
	self deny:( b == a).

]

{ #category : #tests }
MlArraySlicingTest >> testSliceC [

	| a b s |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32)))
							order:#C.
										
	self assert: a shape equals:#(2 4 3).
	b := a slice:{1@1. 1@_. 1@1}.
	s :=MlArray from: #(#(#(1) #(4) #(7) #(10))) order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 1).
	
	b := a slice:{1. 1. 1}.
	s :=MlArray from: #(#(#(1))) order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(1 1 1).
	
	b := a slice:{1@_. 1@2. 1@2}.
	s :=MlArray from:  #(
								#(
									#(1 2 ) 
							  		#(4 5 ) 
							  		) 
								#(
									#(21 22 ) 
							  		#(24 25 ) 
							  		) ) order:#C.
	self assert: b equals: s.
	self assert: b shape equals:#(2 2 2).
	
	
	b := a slice:{1@_. 1@_. 1@_}.
	
	self assert: b shape equals:#(2 4 3).
	self assert: b equals: a.
	self deny:( b == a).

]

{ #category : #tests }
MlArraySlicingTest >> testSliceF [

	| a b s |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))).
										
	self assert: a shape equals:#(2 4 3).
	b := a slice:{1@1. 1@_. 1@1}.
	s :=MlArray from: #(#(#(1) #(4) #(7) #(10))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 1).
	self assert: b itemSize equals:a itemSize.
	self assert: b size equals:4.	
	self assert: b byteSize equals: a byteSize.	
	
	b := a slice:{1. 1. 1}.
	s :=MlArray from: #(#(#(1))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 1 1).
	
	b := a slice:{1@_. 1@_. -2}.
	s :=MlArray from:  #(
								#(
									#(2 ) 
							  		#(5 ) 
							  		#( 8 )
									#(11 )) 
								#(
									#( 22 ) 
							  		#( 25 ) 
							  		#( 28 )
									#(31 ))).
	self assert: b equals: s.
	self assert: b shape equals:#(2 4 1).
	
	
	b := a slice:{1@_. 1@_. 1@_}.
	
	self assert: b shape equals:#(2 4 3).
	self assert: b equals: a.
	self deny:( b == a).

]

{ #category : #tests }
MlArraySlicingTest >> testSliceFByReference [

	| a b s s2 |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))).
										
	self assert: a shape equals:#(2 4 3).
	b := a at:{1@1. 1@_. 1@1}.
	s :=MlArray from: #(#(#(1) #(4) #(7) #(10))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 1).
	
	b := a at:{1. 1. 2}.

	self assert: b equals: 2.
	
	b := a at:{1@_. 1@_. -2}.
	s :=MlArray from:  #(
								#(
									#( 2 ) 
							  		#( 5 ) 
							  		#( 8 )
									#( 11 )) 
								#(
									#( 22) 
							  		#( 25) 
							  		#( 28)
									#( 31 ))).
	self assert: b equals: s.
	self assert: b shape equals:#(2 4 1).
	
	b := a at:{_. _. _}.
	
	self assert: b shape equals:#(2 4 3).
	self assert: b equals: a.
	self deny:( b == a).
	self deny:( b internalArray buffer == a internalArray buffer).
	
	b := a at:{_. _. 1@1} put:0.

	s := MlArray from: #(
								#(
									#(0 2 3 ) 
							  		#(0 5 6) 
							  		#(0 8 9)
									#(0 11 12)) 
								#(
									#(0 22 23) 
							  		#(0 25 26) 
							  		#(0 28 29)
									#(0 31 32))).

	s2 := MlArray from: #(#(
									#(0)
									#(0)
									#(0)
									#(0) 
									) 
								#(
									#(0)
									#(0)
									#(0)
									#(0) 
							  		)).
									
	self assert: b shape equals:#(2 4 1).
	self assert: a equals: s.
	self assert: b equals: s2.
	self deny:( b == a).

]

{ #category : #tests }
MlArraySlicingTest >> testSliceFCopy [


	| a b s s2 |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))).
										
	self assert: a shape equals:#(2 4 3).
	b := a slice:{1@1. 1@_. 1@1} copy:true.
	s :=MlArray from: #(#(#(1) #(4) #(7) #(10))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 1).
	
	b := a at:{1. 1. 2}.

	self assert: b equals: 2.
	
	b := a slice:{1@_. 1@_. -2} copy:true.
	s :=MlArray from:  #(
								#(
									#( 2 ) 
							  		#( 5 ) 
							  		#( 8 )
									#( 11 )) 
								#(
									#( 22) 
							  		#( 25) 
							  		#( 28)
									#( 31 ))).
	self assert: b equals: s.
	self assert: b shape equals:#(2 4 1).
	
	b := a slice:{_. _. _} copy:true.
	
	self assert: b shape equals:#(2 4 3).
	self assert: b equals: a.
	self deny:( b == a).
	
	b := a at:{_. _. 1} put:0.

	s := MlArray from: #(
								#(
									#(0 2 3 ) 
							  		#(0 5 6) 
							  		#(0 8 9)
									#(0 11 12)) 
								#(
									#(0 22 23) 
							  		#(0 25 26) 
							  		#(0 28 29)
									#(0 31 32))).

	s2 := MlArray from: #(#(
									#(0)
									#(0)
									#(0)
									#(0) 
									) 
								#(
									#(0)
									#(0)
									#(0)
									#(0) 
							  		)).
									
	self assert: b shape equals:#(2 4 1).
	self assert: a equals: s.
	self assert: b equals: s2.
	self deny:( b == a).
]

{ #category : #tests }
MlArraySlicingTest >> testSliceUnion [
	| a r |
	a:= Interval union:{  3 to:5. 4 to:10. 1 to:5  }.
	r := Stack new.
	r push:(1 to:10).
	self assert:a equals: r.

	a:= Interval union:{  1 to:5 by: 2. 4 to:10 by:2}.
	r := Stack new.
	r push:{1. 3. 4. 5. 6. 8. 10}.
	self assert:a equals: r.
	
]

{ #category : #tests }
MlArraySlicingTest >> testSliceUnion2 [
	| a b d sol |
	a := MlArray from: #(#(1 2 3 4 5 6 7 8 9 10) #(11 12 13 14 15 16 17 18 19 20)).
	d := a at:_@_ at: {  1@5. 4@5. 7@9  } .
	sol :=  MlArray from: #(#( 1 2 3 4 5 7 8 9) #( 11 12 13 14 15 17 18 19)).
	self assert:d equals: sol.
	self assert: d size equals: 16.

	
]

{ #category : #tests }
MlArraySlicingTest >> testSliceUnion3 [
	| a b d sol |
	a := MlArray from: #(#(1 2 3 4 5 6 7 8 9 10) #(11 12 13 14 15 16 17 18 19 20)).
	d := a at:_@_ at: {  1@5@2. 4@5@2. 7@9  } .
	sol :=  MlArray from: #(#( 1 3 4 5 7 8 9) #( 11 13 14 15 17 18 19)).
	self assert:d equals: sol.
	self assert: d size equals: 14.

	
]

{ #category : #tests }
MlArraySlicingTest >> testSliceUnion4 [
	| a b d sol |
	a := MlArray from: #(#(1 2 3 4 5 6 7 8 9 10) #(11 12 13 14 15 16 17 18 19 20)).
	d := a at:_@_ at: {  1@5@2. 2@10@3. 4@10@2  } .
	sol :=  MlArray from: #(#( 1 2 3 4 5 6 8 10) #( 11 12 13 14 15 16 18 20)).
	self assert:d equals: sol.
	self assert: d size equals: 16.

	
]

{ #category : #tests }
MlArraySlicingTest >> testSliceWithBooleanCondition [

	| a b s |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))).
	a setLabels: #('A' 'B' 'C') onAxis:1.
	
	b := a at:{_. _. (( a at:{1. 1. _}) < 3)} .	
	self assert: b  equals: (a at:{_. _. 1@2.}).
	self assert: (b getLabelsOnAxis:1 ) asArray equals: #('A' 'B' ).
	


]

{ #category : #tests }
MlArraySlicingTest >> testSliceWithStepsF [

	| a b s |
	a := MlArray from: #(
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(21 22 23) 
							  		#(24 25 26) 
							  		#(27 28 29)
									#(30 31 32))).
										
	self assert: a shape equals:#(2 4 3).
	b := a slice:{1@1. 1@_. 1@_@2}.
	s :=MlArray from: #(#(#(1 3) #(4 6) #(7 9) #(10 12))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 2).
	self assert: b itemSize equals:a itemSize.
	self assert: b size equals:8.	
	self assert: b byteSize equals: a byteSize.	
	
	a := MlArray from: #(1 2 3 4 5 6 7 8 9 10).
	b := a slice:{1@_@3}.
	s :=MlArray from: #(1 4 7 10).
	self assert: b equals: s.
	self assert: b shape equals:#(4).
	
	b := a slice:{_@_@(-1)}.
	s := MlArray from: #(10 9 8 7 6 5 4 3 2 1).
	self assert: b equals: s.	

]
