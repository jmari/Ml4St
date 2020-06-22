Class {
	#name : #MlArrayIndexingTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #accessing }
MlArrayIndexingTest >> indexNoFLoatTest [

	| a |
	a := MlArray from:{{{5}}}.
	self should: [a at:0.0] raise: Exception.

       " assert_raises(IndexError, lambda: a[0, 0.0])
        assert_raises(IndexError, lambda: a[0.0, 0])
        assert_raises(IndexError, lambda: a[0.0,:])
        assert_raises(IndexError, lambda: a[:, 0.0])
        assert_raises(IndexError, lambda: a[:, 0.0,:])
        assert_raises(IndexError, lambda: a[0.0,:,:])
        assert_raises(IndexError, lambda: a[0, 0, 0.0])
        assert_raises(IndexError, lambda: a[0.0, 0, 0])
        assert_raises(IndexError, lambda: a[0, 0.0, 0])
        assert_raises(IndexError, lambda: a[-1.4])
        assert_raises(IndexError, lambda: a[0, -1.4])
        assert_raises(IndexError, lambda: a[-1.4, 0])
        assert_raises(IndexError, lambda: a[-1.4,:])
        assert_raises(IndexError, lambda: a[:, -1.4])
        assert_raises(IndexError, lambda: a[:, -1.4,:])
        assert_raises(IndexError, lambda: a[-1.4,:,:])
        assert_raises(IndexError, lambda: a[0, 0, -1.4])
        assert_raises(IndexError, lambda: a[-1.4, 0, 0])
        assert_raises(IndexError, lambda: a[0, -1.4, 0])
        assert_raises(IndexError, lambda: a[0.0:, 0.0])
        assert_raises(IndexError, lambda: a[0.0:, 0.0,:])"
]

{ #category : #accessing }
MlArrayIndexingTest >> testIndexNoFLoat [

	| a |
	a := MlArray from:{{{5}}}.
	self should: [a at:1.0] raise: MlShapeError.
	self should: [a at:#(1 1.0)] raise: MlShapeError.
	self should: [a at:#(1.0 1)] raise: MlShapeError.
	self should: [a at:#(1.0 1.0 1.0)] raise: MlIndexTypeError.
	self should: [a at:#(1.1 1.0 1.0)] raise: MlIndexTypeError.	
	self should: [a at:{_@_. 1 }] raise: MlSliceError.	
	self should: [a at:{1. _@_.}] raise: MlSliceError.
	self should: [a at:{1.0. _@_. 1.1}] raise: MlSliceError.
	self should: [a at:{1.0. _@_. 1.0}] raise: MlSliceError.
	self shouldnt: [a at:{1. _@_. 1.}] raise: MlSliceError.
      
]

{ #category : #tests }
MlArrayIndexingTest >> testNilArray [
	| a |
	a := MlArray from:#(nil nil nil).

]

{ #category : #tests }
MlArrayIndexingTest >> testNilIndex [
	| a |
	a := MlArray from:#(1 2 3).
	self should: [a at:#()] raise:MlShapeError. 
	self should: [a at:nil] raise:MlIndexTypeError.
	a := MlArray from:#()	.
	self assert: a shape equals:#()
]

{ #category : #tests }
MlArrayIndexingTest >> testNonBaseClassValues [
	| a |
	a := MlArray zeros:#(5 5).
	
	self should: [a at:#()] raise:MlShapeError. 
	self should: [a at:nil] raise:MlIndexTypeError.
	a := MlArray from:#()	.
	self assert: a shape equals:#()
]

{ #category : #tests }
MlArrayIndexingTest >> testSliceIndexing [

	| a b s|
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
	b := a at:{1@1. 1@_. {1. 3.}}.
	s :=MlArray from: #(#(#(1 3) #(4 6)  #(7 9) #(10 12))).
	self assert: b equals: s.
	self assert: b shape equals:#(1 4 2).
	
	b := a at:{1. {1. 3}. 2}.
	s :=MlArray from: #(#(#(2) #(8))).
	self assert: b equals: s.
	
	b := a at:{1@_. 1@_. -2}.
	s :=MlArray from:  #(
								#(
									#( 2) 
							  		#( 5) 
							  		#( 8)
									#( 11)
									) 
								#(
									#( 22) 
							  		#( 25) 
							  		#( 28)
									#( 31))).
	self assert: b equals: s.
	self assert: b shape equals:#(2 4 1).
	
	b := a at:{1@_. 1@_. {1@1. 2@3}}.
	
	self assert: b shape equals:#(2 4 3).
	self assert: b equals: a.
	self deny:( b == a).
	


]
