Class {
	#name : #MlArrayTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

{ #category : #tests }
MlArrayTest >> testAddDimension [

	| a |
	a := MlArray new: #(1 2 3).
	self assert: a shape equals:#(1 2 3).
	a addDimension.
	self assert: a shape equals:#(1 1 2 3).	
	a addDimensionAtEnd.
	self assert: a shape equals:#(1 1 2 3 1).	

]

{ #category : #tests }
MlArrayTest >> testAddressing [
	|a|
	a := MlArray random:{4. 2. 3. 7}.
	Transcript clear.
	1 to: a size do:[:add | Transcript show: (a sliceForAddress:add);cr]

]

{ #category : #tests }
MlArrayTest >> testAsCArray [

	| a b|
	
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}}. {{7. 8. 9}.{10. 11. 12}}}  order:#F.
	b := MlArray  from: {{{1. 2. 3}. {4. 5. 6}}. {{7. 8. 9}.{10. 11. 12}}} order:#C.
	self assert: a shape equals:#(2 2 3).
	self assert: a asCArray  equals:b.	

]

{ #category : #tests }
MlArrayTest >> testAsFArray [

	| a b|
	a := MlArray  from: #(#(#(1 2 3) #(4 5 6) #(7 8 9)) ).
	b := MlArray  from: #(#(#(1 2 3) #(4 5 6) #(7 8 9)) ) order:#F.
	self assert: a shape equals:#(1 3 3).
	self assert: a asFortranArray  equals:b.	

]

{ #category : #tests }
MlArrayTest >> testAsSparseMatrix [

	| a matrix matrixb |
	a := MlArray from: #(
								#(
									#(1 0 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12))) order:#F.
	matrix := a asSparseMatrix .
	
	self assert: matrix size equals: 8 .
	
	a := MlArray from: #(
								#(
									#(1 0 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12)) 
								#(
									#(1 2 3) 
							  		#(4 5 6) 
							  		#(7 8 9)
									#(10 11 12))) order:#C.
	matrixb := a asSparseMatrix .

	self assert: matrix size equals: 8 .
	self assert: matrix  equals: matrixb .
	
	
]

{ #category : #tests }
MlArrayTest >> testComparing [

	| a b |
	a := MlArray  from: #(#(#(1 2 3) #(4 5 6) #(7 8 9)) ).	
	b := a at:{_. _. ((a at:{_. _. 1}) > 3)}.
	self assert: b shape equals: {1. 3. 2}.


	

]

{ #category : #tests }
MlArrayTest >> testConcatenation [

	| a b c|
	a := MlArray  from: {{{1. 2. 3.}. {4. 5. 6.}. {7. 8. 9.}}}.
	b := MlArray  from: {{(11 to:13). (14 to:16). (17 to:19)}}.
	c := a , b.
	self assert: c shape equals:#(1 6 3).
	self assert: c internalArray buffer equals:#(1 4 7 11 14 17 2 5 8 12 15 18 3 6 9 13 16 19) asIntegerArray.
	"C stype"
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}} order:#C.
	b := MlArray  from: {{(1 to:3). (4 to:6). (7 to:9)}} order:#C.
	c := a , b.
	self assert: c shape equals:#(1 6 3).
	self assert: c internalArray buffer equals:#(1 2 3 4 5 6 7 8 9 1 2 3 4 5 6 7 8 9) asIntegerArray. 

	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}.
	b := MlArray  from: {{(1 to:3)}}.
	c := a concat: b axis:0.
	self assert: c shape equals:#(1 4 3).
	self assert: c internalArray buffer equals:#(1 4 7 1 2 5 8 2 3 6 9 3) asIntegerArray. 
	
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}} order:#C.
	b := MlArray  from: {{(1 to:3)}} order:#C.
	c := a , b.
	self assert: c shape equals:#(1 4 3).
	self assert: c internalArray buffer equals:#(1 2 3 4 5 6 7 8 9 1 2 3) asIntegerArray.
	"(1 2 3) shoud addes at end"
	a := MlArray  from: {1. 2. 3. 4. 5. 6. 7. 8. 9} order:#C.
	b := MlArray  from: {10. 11. 12.} order:#C.
	c := a , b.
	self assert: c shape equals:#(12).
	self assert: c internalArray buffer equals:#(1 2 3 4 5 6 7 8 9 10 11 12) asIntegerArray.
	

	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}}. {{7. 8. 9}.{10. 11. 12}}} order:#C.
	b := MlArray  from: {{(1 to:3). (4 to:6)}} order:#C .
	c := a concat: b axis:2.
	self assert: c shape equals:#(3 2 3).
	self assert: c internalArray buffer equals:#(1 2 3 4 5 6 7 8 9 10 11 12 1 2 3 4 5 6) asIntegerArray.
	
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}}. {{7. 8. 9}.{10. 11. 12}}} .
	b := MlArray  from: {{(21 to:23). (24 to:26)}} .
	c := a concat: b axis:2.
	self assert: c shape equals:#(3 2 3).
	self assert: c internalArray buffer equals:#(1 4 7 10 21 24 2 5 8 11 22 25 3 6 9 12 23 26) asIntegerArray.	

]

{ #category : #tests }
MlArrayTest >> testConversion [

	| a b|
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}.
	self assert: a dType equals:#SmallInteger.
	b := a dType: #Float.
	self assert: a dType equals:#Float. 
	self assert: a arrayType equals:#FloatArray.

]

{ #category : #tests }
MlArrayTest >> testCreation [

	| a b|
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}.
	b := MlArray  from: {{(1 to:3). (4 to:6). (7 to:9)}}.
	self assert: a shape equals:#(1 3 3).
	self assert: a = b.	

]

{ #category : #tests }
MlArrayTest >> testEquality [

	| a b c f d |
	a := MlArray  from: #(#(#(1 2 3) #(4 5 6) #(7 8 9)) ).
	b := a := MlArray  from: #(#(#(1 2 3) #(4 5 6) #(7 8 9)) ).
	c := a asCArray.
	
	self assert: (a ~= c) .
	self assert: a equals:b.
	f:= c asFortranArray.
	self assert: a equals:f.
	d := a reshape:#(3 3 1).
	" reshape changes the shape do not create a new array, returns self"
	self assert: (a = d) .
	
	b := a > 2.
	self assert: b nDim equals: 3
	

]

{ #category : #tests }
MlArrayTest >> testExamples [ 
	| a |
	" new array of shape 1 2 3"
	a := MlArray new:#(1 2 3).
	self assert: a shape equals: #(1 2 3).
	"new array of shape 3 and content 1 2 3"
	a := MlArray from:#(1 2 3).
	self assert: a shape equals: #(3).
	self assert: a size equals: 3.
	"array of shape 2 2, data type autodetected"
	a := MlArray from:#(#(1 2) #(3 4)).
	self assert: a shape equals: #(2 2).
	self assert: a dType equals: #SmallInteger.
	"array of shape 2 2 set data type to Float"
	a := MlArray from:#(#(1 2) #(3 4)) dType:#Float.
	self assert: a dType equals: #Float.
	"array of shape 2 2 set data type to Float of zeros"
	a := MlArray zeros:#(3 6).
	self assert: a dType equals: #SmallFloat64.	
	"array of shape 2 2 set data type to Float of ones"
	a := MlArray ones:#(3 6).
	self assert: a dType equals: #SmallFloat64.	
	a := MlArray new:#(3 6) withAll: 'H'.
	self assert: a dType equals: #ByteString.	
		
		
	
]

{ #category : #tests }
MlArrayTest >> testGrouping [

	| a b c |
	a := MlArray  from: {{1. 2. 3}. {1. 5. 6}. {2. 8. 9}}.
	b := a groupBy: 1->{2. 3} aggregate:[:k :v| v sum:0].
	c := MlArray from:{ {1. 7. 9 }. {2. 8. 9 } }.
	self assert: b equals:c.

	b := a groupBy:[ :row | (row at: 1) > 1 ] ->{2. 3} aggregate:[:k :v| v sum:0].
	c := MlArray from:{ {'[ :row | (row at: 1) > 1 ] not'. 7. 9 }. {'[ :row | (row at: 1) > 1 ]'. 8. 9 }.  }.
	self assert: b equals:c.	
]

{ #category : #tests }
MlArrayTest >> testGroupingNDim [

	| a b c |
	a := MlArray  from: {{{1. 2. 3}. {1. 5. 6}. {2. 8. 9}}. {{4. 2. 3}. {4. 5. 6}. {5. 8. 9}}}.
	b := a groupBy: 1->{2. 3} aggregate:[:k :v| v sum:0].
	c := MlArray from:{ {1. 7. 9 }. {2. 8. 9 }. {5. 8. 9 }. {4. 7. 9 } }.
	self assert: b equals:c.

	b := a groupBy:[ :row | (row at: 1) > 1 ] ->{2. 3} aggregate:[:k :v| v sum:0].
	c := MlArray from:{ {	'[ :row | (row at: 1) > 1 ] not'. 7. 9 }. 
							  {'[ :row | (row at: 1) > 1 ]'. 8. 9 } .
							  {'[ :row | (row at: 1) > 1 ]'. 15. 18 } .  }.
	self assert: b equals:c.	
]

{ #category : #tests }
MlArrayTest >> testIndexOf [
	| a b c |
	
	a := MlArray from: #(
							  #(#(#H1 #Sunny true #Rich #Cinema true) 
							  #(#H2 #Sunny false #Rich #Tennis true) )
							  #(#(#H3 #Windy true #Rich #Cinema true) 
							  #(#H4 #Rainy true #Poor #Cinema true)) 
							  #(#(#H5 #Rainy false #Rich #Home true) 
							  #(#H6 #Rainy true #Poor #Cinema true) )
							  #(#(#H7 #Windy false #Poor #Cinema true) 
							  #(#H8 #Windy false #Rich #Shopping true))
							  #(#(#H9 #Windy true #Rich #Cinema true)
							  #(#H10 #Sunny false #Rich #Tennis true)) 
							) order:#C. 
	c := a indexOf:#H7.	
	self assert:c equals:{4. 1. 1.}.
	c := a indexOf:#Sunny.	
	self assert:c equals:{1. 1. 2.}.				
	c := a indexOf:#Shopping.	
	self assert:c equals:{4. 2. 5.}.
	
	a := MlArray from: #(
							  #(#(#H1 #Sunny true #Rich #Cinema true) 
							  #(#H2 #Sunny false #Rich #Tennis true) )
							  #(#(#H3 #Windy true #Rich #Cinema true) 
							  #(#H4 #Rainy true #Poor #Cinema true)) 
							  #(#(#H5 #Rainy false #Rich #Home true) 
							  #(#H6 #Rainy true #Poor #Cinema true) )
							  #(#(#H7 #Windy false #Poor #Cinema true) 
							  #(#H8 #Windy false #Rich #Shopping true))
							  #(#(#H9 #Windy true #Rich #Cinema true)
							  #(#H10 #Sunny false #Rich #Tennis true)) 
							). 
	c := a indexOf:#H7.	
	self assert:c equals:{4. 1. 1.}.
	c := a indexOf:#Sunny.	
	self assert:c equals:{1. 1. 2.}.				
	c := a indexOf:#Shopping.	
	self assert:c equals:{4. 2. 5.}		
]

{ #category : #tests }
MlArrayTest >> testInfiniteCVector [
	| a anArray |
	anArray :={ 1. 2. 3. 4. 5. 6.}.
	a := MlArrayRepeatedVector newFrom:  anArray timesRepeat:3.
	self assert:(a at:1) equals: (a at: 7).
	self assert:(a at:2) equals: (a at: 8).
	self assert:2 equals: (a at: 2).
	self assert:(a at:18) equals: 6.
	self should:[a at:19] raise:SubscriptOutOfBounds 
]

{ #category : #tests }
MlArrayTest >> testInfiniteFVector [
	| a anArray |
	anArray :={ 1. 2. 3. 4. 5. 6.}.
	a := MlElementRepeatedVector newFrom:  anArray timesRepeat:3.
	self assert:(a at:1) equals: (a at: 2).
	self assert:(a at:2) equals: (a at: 3).
	self assert:2 equals: (a at: 4).
	self assert:(a at:18) equals: 6.
	self should:[a at:19] raise:SubscriptOutOfBounds 
]

{ #category : #tests }
MlArrayTest >> testMetrics [
	|a|
	
	a := MlArray  from: {{{1.0. 4.0. 7.0}. {2.0. 5.0. 8.0}.}} order:#F dType:#Float.
	self assert:(a mean:0) equals: (MlArray from:{{1.5. 4.5. 7.5}} order:#F dType:#Float). 
	self assert:(a mean:1 ) equals: (MlArray from:{{4.0. 5.0}} order:#F dType:#Float). 
	self assert:(a mean:2 ) equals: (MlArray from:{4.5} order:#F dType:#Float). 		
	a := MlArray  from: {{{1.0. 4.0. 7.0}. {2.0. 5.0. 8.0}}} order:#C dType:#Float.

	self assert:(a mean:0 ) equals: (MlArray from:{{1.5. 4.5. 7.5}} order:#C dType:#Float). 
	self assert:(a mean:1 ) equals: (MlArray from:{{4.0. 5.0}}  order:#C dType:#Float). 
	self assert:(a mean:2 ) equals: (MlArray from:{4.5} order:#C dType:#Float). 
	
	
	
	a := MlArray  from: {{{1.0. 4.0. 7.0}. {2.0. 5.0. 8.0}. {3.0. 6.0. 9.0}}} order:#F dType:#Float.

	self assert:(a mean:0) equals: (MlArray from:{{2.0. 5.0. 8.0}} order:#F dType:#Float). 
	self assert:(a median:0) equals: (MlArray from:{{2.0. 5.0. 8.0}} order:#F dType:#Float).
	self assert: (a max:0) equals:(MlArray from:{{3.0. 6.0. 9.0}} order:#F dType:#Float). 
	self assert: (a min:0) equals:(MlArray from:{{1.0. 4.0. 7.0}} order:#F dType:#Float). 
	self assert: (a sum:0) equals:(MlArray from:{{6.0. 15.0. 24.0}} order:#F dType:#Float).  
	self assert:(a stdDev:0) equals:(MlArray from:{{1.0. 1.0. 1.0}} order:#F dType:#Float). 
	self assert:(a variance:0) equals:(MlArray from:{{1.0. 1.0. 1.0}} order:#F dType:#Float). 

	"default is F (in front of python) dims are columns"
	self assert:(a mean:2) equals: (MlArray from:{5.0} order:#F dType:#Float). 
	" try in C"
	a := MlArray  from: {{{1.0. 4.0. 7.0}. {2.0. 5.0. 8.0}. {3.0. 6.0. 9.0}}} order:#C dType:#Float.

	self assert:(a mean:0) equals: (MlArray from:{{2.0. 5.0. 8.0}} order:#C dType:#Float). 
	self assert:(a median:0) equals: (MlArray from:{{2.0. 5.0. 8.0}} order:#C dType:#Float).
	self assert: (a max:0) equals:(MlArray from:{{3.0. 6.0. 9.0}} order:#C dType:#Float). 
	self assert: (a min:0) equals:(MlArray from:{{1.0. 4.0. 7.0}} order:#C dType:#Float). 
	self assert: (a sum:0) equals:(MlArray from:{{6.0. 15.0. 24.0}} order:#C dType:#Float).  
	self assert:(a stdDev:0) equals:(MlArray from:{{1.0. 1.0. 1.0}} order:#C dType:#Float). 
	self assert:(a variance:0) equals:(MlArray from:{{1.0. 1.0. 1.0}} order:#C dType:#Float). 

	a := MlArray from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}. {7.0. 8.0. 9.0}}} order:#C dType:#Object.
	self assert:(a meanAndStd:0) size equals:3. 

	a := MlArray from: {{10.0. 7.0. 4.0}. {3.0. 2.0. 1.0}} order:#F dType:#Float.

	self assert:(a median) equals: 3.5. 
]

{ #category : #tests }
MlArrayTest >> testShape [

	| a b|
	a := MlArray new: #(1 2 3).
	self assert: a shape equals:#(1 2 3).
	a reshape:#( 3 2).
	self assert: a shape equals:#(3 2).	
	self should:[(a reshape:#(-1 2 2)) ]raise: MlShapeError. 
	a reshape:#(-1 2 1).
	self assert: a shape equals:#(3 2 1).
	b := a reshaped:#(-1).
	self assert: a shape equals:#(3 2 1).
	self assert: b shape equals:#(6).

]

{ #category : #tests }
MlArrayTest >> testSplit [

	| a b c|
	a := MlArray  from: {{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}.
	b := a split: 2 axis:0.
	self assert: b size equals:2.
	
]

{ #category : #tests }
MlArrayTest >> testStandardAxisNumber [

	| a result |
	a := MlArray  from: {{{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}}.
	result := {3. 4. 2. 1}.
	(0 to: (a nDim - 1)) do:[ :axis | self assert: (a getAxisNumberFromStandard: axis ) equals: (result at: axis + 1) ]  
	
]

{ #category : #tests }
MlArrayTest >> testStandardAxisToFold [

	| a result |
	a := MlArray  from: {{{{1. 2. 3}. {4. 5. 6}. {7. 8. 9}}}}.
	result := {4. 3. 2. 1}.
	(0 to: (a nDim - 1)) do:[ :axis | self assert: (a getAxisToFoldFromStandard: axis ) equals: (result at: axis + 1) ]  
	
]
