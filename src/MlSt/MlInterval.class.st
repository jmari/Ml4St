Class {
	#name : #MlInterval,
	#superclass : #Object,
	#instVars : [
		'start',
		'step',
		'stop',
		'size',
		'wForAxes'
	],
	#category : #'MlSt-Core-Enumerator'
}

{ #category : #'instance creation' }
MlInterval class >> from: startSlice to: stopSlice [ 
	"Answer an instance of me, starting at startNumber, ending at 
	stopNumber, and with an interval increment of 1."

	^self new
		setFrom: startSlice
		to: stopSlice
		by: 1

]

{ #category : #'as yet unclassified' }
MlInterval class >> from: startSlice to: stopSlice by: step [ 
	"Answer an instance of me, starting at startNumber, ending at 
	stopNumber, and with an interval increment of stepNumber."

	^self new
		setFrom: startSlice
		to: stopSlice
		by: step


]

{ #category : #'instance creation' }
MlInterval class >> new [
	"Primitive. Create and answer with a new instance of the receiver
	(a class) with no indexable fields. Fail if the class is indexable. Override
	SequenceableCollection new. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 70>
	self isVariable ifTrue: [ ^ self new: 0 ].
	"space must be low"
	OutOfMemory signal.
	^ self new  "retry if user proceeds"
]

{ #category : #'instance creation' }
MlInterval class >> shaped: aShape [

	^ self shaped: aShape by: 1
]

{ #category : #'instance creation' }
MlInterval class >> shaped: aShape by: step [

^self new
		setFrom: (Array new:aShape size withAll:1)
		to: aShape
		by: step
]

{ #category : #'instance creation' }
MlInterval class >> streamSpecies [
	^ Array
]

{ #category : #arithmetic }
MlInterval >> + aScalarOrArray [
	^ self class from: start + aScalarOrArray to: stop + aScalarOrArray by: step
]

{ #category : #arithmetic }
MlInterval >> - aScalarOrArray [
	^ self class from: start - aScalarOrArray to: stop - aScalarOrArray by: step
]

{ #category : #accessing }
MlInterval >> = anObject [

	^ self == anObject
		ifTrue: [true]
		ifFalse: [anObject isMlInterval
			ifTrue: [start = anObject first
				and: [step = anObject increment
					and: [self last = anObject last]]]
			ifFalse: [super = anObject]]
]

{ #category : #accessing }
MlInterval >> asArray [ 
	^ (1 to: self size) collect:[:i| self at:i]
]

{ #category : #accessing }
MlInterval >> at: anInteger [
	"Answer the anInteger'th element."
	| linearIndex tmpIndex blockWeight blocksize |
	"the loop should be from the slower changing axis to the faster changing axis"
	anInteger > self size | anInteger <1 ifTrue:[self error:'Index should be higer than 0 and lower than ', self size].
	linearIndex :=  (anInteger - 1) * step.
	
	tmpIndex := (self nDim = 1 )
			ifTrue:[linearIndex + 1] 
			ifFalse:[
				tmpIndex := Array new: self nDim withAll:0.
				(1 to: self nDim ) do:[:i|
					blockWeight := (self weightOfAxis:i).
					blocksize := (linearIndex / blockWeight) asInteger.
					tmpIndex at:i put:blocksize .
					linearIndex := linearIndex  - (blocksize * blockWeight)].
				tmpIndex + start.
				].

	^tmpIndex
]

{ #category : #accessing }
MlInterval >> at: anInteger put: anObject [ 
	"Storing into an Interval is not allowed."

	self error: 'you can not store into an interval'
]

{ #category : #'instance creation' }
MlInterval >> by: aStep [
	step := aStep.
	"forze to recalculate size"
	size := nil 
]

{ #category : #enumerating }
MlInterval >> collect: aBlock [
	|  result |
	result := self species new: self size.
	1 to: result size do:
		[:i |
		result at: i put: (aBlock value: (self at:i))].
	^ result
]

{ #category : #enumerating }
MlInterval >> do: aBlock [
	"Evaluate aBlock for each value of the interval"

	| index size1 |
	index := 0.
	size1 := self size.
	[index < size1]
		whileTrue: [
			index := index + 1.
			aBlock value: (self at:index)]
]

{ #category : #enumerating }
MlInterval >> doWithIndex: aBlock [
	"Evaluate aBlock for each value of the interval"

	| index size1|
	index := 0.
	size1 := self size.
	[index < size1]
		whileTrue: [
			index := index + 1.
			aBlock value: (self at:index) value:index]
]

{ #category : #accessing }
MlInterval >> extent [ 
	"Answer the max - min of the receiver interval."
	"(10 to: 50) extent"

	^ step < 0 ifTrue:[start - stop + 1] ifFalse:[stop - start + 1]
]

{ #category : #accessing }
MlInterval >> first [ 
	"Refer to the comment in SequenceableCollection|first."

	^start
]

{ #category : #accessing }
MlInterval >> hash [
	"Hash is reimplemented because = is implemented."

	^(((start hash bitShift: 2)
		bitOr: stop hash)
		bitShift: 1)
		bitOr: self size
]

{ #category : #accessing }
MlInterval >> includes: aSlice [
	"Return true if the number lies in the interval between start and stop "

	^ (self indexOf:aSlice) isInteger and:[self rangeIncludes: aSlice]
]

{ #category : #accessing }
MlInterval >> increment [
	"Answer the receiver's interval increment."

	^step
]

{ #category : #'private-accessing' }
MlInterval >> indexOf:anArrayOfInt [
	| address  transportedAddress  |
	address := 1.
	"transport to [1,n] => [0,n-1]"
	transportedAddress := step < 0 ifTrue:[start - anArrayOfInt ]
											ifFalse:[	anArrayOfInt  - start].

	transportedAddress  doWithIndex:[:each :i| address := address + (each * (self weightOfAxis:i))].	
 
	address := (address +1 )/ (step abs). 
	"step < 0 ifTrue:[address :=  address - 1]."
	^ address
]

{ #category : #accessing }
MlInterval >> isMlInterval [

	^ true
]

{ #category : #accessing }
MlInterval >> last [ 
	"Refer to the comment in SequenceableCollection|last."

	^self at: self size
]

{ #category : #accessing }
MlInterval >> nDim [
	^  start size
]

{ #category : #accessing }
MlInterval >> permutationsDo: aBlock [
	"Repeatly value aBlock with a single copy of the receiver. Reorder the copy
	so that aBlock is presented all (self size factorial) possible permutations."
	"(1 to: 4) permutationsDo: [:each | Transcript cr; show: each printString]"

	self asArray permutationsDo: aBlock
]

{ #category : #accessing }
MlInterval >> rangeIncludes: aSlice [
	"Return true if the number lies in the interval between start and stop "
	step > 0 
	ifTrue:[ aSlice doWithIndex:[:v :i| 
			(v >= (start at:i) and:[v <= (stop at:i)]) ifFalse:[^ false]].^ true] 
	ifFalse:[ aSlice doWithIndex:[:v :i| 
			(v >= (stop at:i) and:[v <= (start at:i)]) ifFalse:[^ false]].^ true] 
]

{ #category : #accessing }
MlInterval >> remove: newObject [ 
	"Removing from an Interval is not allowed."

	self error: 'elements cannot be removed from an Interval'
]

{ #category : #enumerating }
MlInterval >> reverseDo: aBlock [ 
	"Evaluate aBlock for each element of my interval, in reverse order.
	Implementation notes: see do: for an explanation on loop detail"

	|  index |
	index := self size.
	[index > 0]
		whileTrue: [
			aBlock value: (self at:index).
			index := index - 1.]
]

{ #category : #enumerating }
MlInterval >> reverseDoWithIndex: aBlock [ 
	"Evaluate aBlock for each element of my interval, in reverse order.
	Implementation notes: see do: for an explanation on loop detail"

	|  index |
	index := self size.
	[index > 0]
		whileTrue: [
			aBlock value: (self at:index) value: index.
			index := index - 1.]
]

{ #category : #enumerating }
MlInterval >> select: aBlock [
	|  result |
	result := OrderedCollection new.
	1 to: result size do:
		[:i | (aBlock value: (self at:i)) ifTrue:[result add:(self at:i)]].
	^ result asArray
]

{ #category : #accessing }
MlInterval >> setFrom: startSlice to: stopSlice by: stepSlice [ 

	start := startSlice.
	stop := stopSlice.
	step := stepSlice.
	step isZero ifTrue: [ ^ DomainError signal: 'Zero size steps not allowed' ]
]

{ #category : #accessing }
MlInterval >> shape [ 
	^ step < 0 
		ifTrue:[(start- stop + 1) abs]
		ifFalse:[(stop - start + 1) abs]
]

{ #category : #accessing }
MlInterval >> shuffled [
	"Return an array that contains my elements shuffled in a random order"
	^ self asArray shuffle
]

{ #category : #accessing }
MlInterval >> size [
	"Answer how many elements the receiver contains."

	^ size ifNil:[
		size := (self indexOf:stop) < (self indexOf:start)
				ifTrue: [^ 0]
				ifFalse: [^ ((self indexOf:stop) - (self indexOf:start) ) asInteger +1]]
]

{ #category : #accessing }
MlInterval >> sort: aBlock [
	"What sorting an Interval means is not clear."

	self shouldNotImplement.
]

{ #category : #accessing }
MlInterval >> sorted [
	^ self increment >= 0
		ifTrue: [ self copy ]
		ifFalse: [ self last to: self first by: self increment negated ]
]

{ #category : #accessing }
MlInterval >> sorted: aSortBlockOrNil [
	"Return a new sequenceable collection which contains the same elements as self but its elements are sorted by aSortBlockOrNil. The block should take two arguments and return true if the first element should preceed the second one. If aSortBlock is nil then <= is used for comparison. We convert the interval to an array because intervals can't be changed."
	
	^self asArray sort: aSortBlockOrNil
]

{ #category : #accessing }
MlInterval >> species [

	^Array
]

{ #category : #accessing }
MlInterval >> storeOn: aStream [ 
	aStream nextPut: $(;
	 	store: start;
	 	nextPutAll: ' to: ';
	 	store: stop.
	step ~= 1 ifTrue: [aStream nextPutAll: ' by: '; store: step].
	aStream nextPut: $)
]

{ #category : #'private-accessing' }
MlInterval >> weightOfAxes [
	^ wForAxes ifNil:[wForAxes := Array new: self shape size ]
]

{ #category : #enumerating }
MlInterval >> weightOfAxesAt: anAxis [ 
	^ self weightOfAxes at:anAxis 
]

{ #category : #accessing }
MlInterval >> weightOfAxesAt: anAxis put: anInteger [
	self weightOfAxes at:anAxis put: anInteger
]

{ #category : #enumerating }
MlInterval >> weightOfAxis: anAxis [
	| w |
	"the weigth means the number of elements we have to jump in the internal vector to get next element in the same axis"
	anAxis < 1 ifTrue:[^ self size].
	"one dimension so weight for any axis is 1"
	self nDim = 1 ifTrue:[^ 1]. 
	anAxis = self nDim ifTrue:[^ 1]. "row dim weight is 1"
	(self weightOfAxesAt: anAxis) ifNotNil:[^ (self weightOfAxesAt: anAxis)].
	w:= (anAxis +1 to: self nDim) inject:1 into:[:mul :e|  mul * (self shape at:e)].
	self weightOfAxesAt: anAxis put:w.
	^ w
]
