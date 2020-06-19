"
SVMReader materializes a LMProblem from a SVM formated data file

For example, if we have the following training data:

    LABEL       ATTR1   ATTR2   ATTR3   ATTR4   ATTR5
    -----       -----   -----   -----   -----   -----
    1           0       0.1     0.2     0       0
    2           0       0.1     0.3    -1.2     0
    1           0.4     0       0       0       0
    2           0       0.1     0       1.4     0.5
    3          -0.1    -0.2     0.1     1.1     0.1

    and bias = 1, then the components of problem are:

    l = 5
    n = 6

    y -> 1 2 1 2 3

    x -> [ ] -> (2,0.1) (3,0.2) (6,1) (-1,?)
         [ ] -> (2,0.1) (3,0.3) (4,-1.2) (6,1) (-1,?)
         [ ] -> (1,0.4) (6,1) (-1,?)
         [ ] -> (2,0.1) (4,1.4) (5,0.5) (6,1) (-1,?)
         [ ] -> (1,-0.1) (2,-0.2) (3,0.1) (4,1.1) (5,0.1) (6,1) (-1,?)
"
Class {
	#name : #SVMReader,
	#superclass : #Object,
	#instVars : [
		'readStream',
		'x_space'
	],
	#category : #'MlSt-FFI-LibLinear-IO'
}

{ #category : #'instance creation' }
SVMReader class >> on: readStream [
	^ self new
		on: readStream;
		yourself
]

{ #category : #accessing }
SVMReader >> asLNProblem [
	^ self asLNProblemWithBias:-1 
]

{ #category : #accessing }
SVMReader >> asLNProblemWithBias: bias [
	|problem |
	problem := self nextToLast.
	^ self asLNProblemWithTarget:(problem at:1) features:(problem at:2) bias:bias
]

{ #category : #accessing }
SVMReader >> asLNProblemWithTarget: yArray features: xArray bias:bias [
	| y featuresArray  max_index  f_m_pair |
	max_index := 0.
	y := self targetAsSVM: yArray.
	f_m_pair := self featuresAsSVM: xArray bias:bias.
	featuresArray := f_m_pair at:1.
	max_index := f_m_pair at:2.
	^ LNProblem new 
					x: featuresArray ; 
					y:y;
					bias:bias;
					n:max_index;
					l:y size; 
					f_array:featuresArray; 
					x_space: x_space 
	
]

{ #category : #accessing }
SVMReader >> featuresAsSVM: xArray bias: bias [
	| featuresArray  max_index x_space_size i collectionOfBiasCol|
	max_index := 0.

	featuresArray := FFIArray externalNewType: 'LNFeatureNode*'  size: xArray size.
	featuresArray autoRelease.
	"we add 2 each time for a -1:?, or ...,max_index:bias,-1:? at the end"
	x_space_size := xArray inject:0 into:[:sum :row| row size +2 +sum].
	x_space := FFIArray externalNewType: LNFeatureNode size:x_space_size.
	x_space autoRelease.
	collectionOfBiasCol := OrderedCollection new.
	i:=1.
	xArray doWithIndex:[:each :index|
		|node|
		"each position has a collection of SmallDictionaries"
		featuresArray at:index put: (x_space at:i) getHandle asExternalAddress.
		each keysAndValuesDo:[:k :v|
			node := x_space at:i.
			node index:k.
			node value: v.
			max_index := k max:max_index.
			i := i + 1.
			].
		bias > 0 ifTrue:[
			"add the index of bias column"
			collectionOfBiasCol add:i.
			(x_space at:i) value: bias.
			i:=i+1].
		(x_space at:i) index:-1.
		i:=i+1
		].
	bias > 0 ifTrue:[ 
		max_index:=max_index +1.
		collectionOfBiasCol do:[:pos| (x_space at:pos) index:max_index+1 ]].
	
	^ { featuresArray. max_index} 
	
]

{ #category : #accessing }
SVMReader >> next [ 
	| line tokens y x colValuePair |
	line := readStream nextLine.
	tokens := line splitOn: Character space.
	y := (tokens at:1) asNumber.
	x := SVMRow new.
	
	2 to:tokens size do:[:i|
		colValuePair := (tokens at:i) splitOn: $:.	
		colValuePair size > 1 ifTrue:[x at:	(colValuePair at:1) asInteger  put:(colValuePair at:2) asNumber ]].
	^ Array with:y with:x
]

{ #category : #accessing }
SVMReader >> nextToLast [
	"[y, x], y: list, x: list of dictionary"
	| y x yXPair |
	y := OrderedCollection new.
	x := SVMSparseMatrix new.
	[readStream atEnd ] whileFalse:[ 
		yXPair := self next.
		y add: (yXPair at:1).
		x add: (yXPair at:2).
	].
	^ Array with:y with:x
	
]

{ #category : #'instance creation' }
SVMReader >> on: aReadStream [
	readStream := aReadStream
]

{ #category : #'instance creation' }
SVMReader >> targetAsSVM: yArray [
	|y|
	y := FFIArray externalNewType:#double size: yArray size.
	yArray doWithIndex:[:e :pos| y at:pos put:e asNumber].
	^ y
]
