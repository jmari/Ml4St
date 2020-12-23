"
I am an implementation of a Sparse Matrix using Ordered Collection of dictionaries. Each element in the OrderCollection represents a row. In every Row there is a SmallDictionary where keys are columns and the values are the value in the column.

"
Class {
	#name : #SVMSparseMatrix,
	#superclass : #OrderedCollection,
	#instVars : [
		'maxColumnNumber'
	],
	#category : #'MlSt-FFI-LibLinear-IO'
}

{ #category : #'instance creation' }
SVMSparseMatrix class >> fromMlArray: aMlArray [
	| instance  jump rowWidth  i row val columnNumber |
	instance := self new.
	aMlArray order = #C ifTrue:[
		rowWidth:= aMlArray shape last.
		jump := 1].
	aMlArray order = #F ifTrue:[
		jump := aMlArray weightForAxis: (aMlArray nDim).
		rowWidth  := aMlArray shape at: aMlArray nDim].	
	
	i:=0.

	1 to:jump do:[:j|
		((j) to: (j+ aMlArray size -1) by: jump) do:[:index|
			((i \\ (rowWidth)) = 0) ifTrue:[ row:= instance add: SVMRow new].
			val := (aMlArray as1DArray at: ((index -1)\\ (aMlArray size ))+1).
			(val =0 | val isNil) ifFalse:[
				columnNumber := (i \\ rowWidth).
				(instance width <	columnNumber) ifTrue:[	instance width:	columnNumber].	
				row at: columnNumber put: val].
			i:=i+1 ]].

	^ instance
]

{ #category : #arithmetic }
SVMSparseMatrix >> * anArray [ 
	^ self collect:[:each| each * anArray]
]

{ #category : #converting }
SVMSparseMatrix >> asMlArray [
	| instance |
	instance := MlArray new: {self size. self width}.
	self doWithIndex:[:e :row|
		e  keysAndValuesDo:[:col :value| instance at:row at:col put: value]].
	^ instance 
		
]

{ #category : #arithmetic }
SVMSparseMatrix >> at: row at: column [ 
	( row > self size|column > self width )ifTrue:[ ^MlShapeError signal:'this point is aut of range']. 
	^ (self at:row) at:column ifAbsent:[0]
]

{ #category : #arithmetic }
SVMSparseMatrix >> at: row at: column put: aValue [
	row > self size ifTrue:[ self size to:row do:[self add:SVMRow new]].
	( self at:row ) at:column put:aValue
]

{ #category : #'as yet unclassified' }
SVMSparseMatrix >> columnRange [
	^ 0 to: maxColumnNumber
]

{ #category : #accessing }
SVMSparseMatrix >> width [
	^ maxColumnNumber ifNil:[maxColumnNumber :=0]
]

{ #category : #accessing }
SVMSparseMatrix >> width: anObject [
	maxColumnNumber := anObject
]
