"
I am used as internal Array structure for MlArray, I am  a linear array where you can set strides in. It allows to slice the array without re-creating a new array with no memory consumption

Public API and Key Messages

- validRanges: array of valid intervals, the method calculates de strides.  
- strides: returns the strides array.
- replaceFrom: to: with: startingAt: calls the native method if ther is no stride, otherwise executes the array      implementacion, this will call the at/at: put: methods of self. 
- isSliced returns true if there is any slice in the array.
- fakeAt: return the real index of a position.
- do: implements do: calling the self at:  

"
Class {
	#name : #MlNonContinuousVector,
	#superclass : #MlBufferedArray,
	#type : #variable,
	#instVars : [
		'strides',
		'lastPos'
	],
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlNonContinuousVector class >> new: size [
	"buffer in a nonContinuousArray could be a nonContinuousArray when MlArray comes 
	from a slice operation.
	Normally this constructor is called by the 2on arg in a bynary operation so that
	thisContext sender at:1 shoud be that argument. the class of the buffer for the new 
	instance willbe the same class"
	| instance hisBuffer myClass |
	
	myClass := Array.
	hisBuffer := thisContext sender at:1.

	[hisBuffer isKindOf: MlBufferedArray  ] whileTrue:[ 
		hisBuffer := hisBuffer buffer.
		myClass := hisBuffer species].

	instance := self basicNew.
	instance initialize.
	instance buffer: (myClass new:size).
	instance validRanges:{1 to: size}.
	^ instance
]

{ #category : #'instance creation' }
MlNonContinuousVector class >> newFromArray: bufferObject [
	| instance |

	instance := self basicNew.
	instance initialize.
	instance buffer: bufferObject .
	instance validRanges:{1 to: bufferObject size}.
	^ instance
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> * anArray [
	| instance |
	^ (anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer * anArray buffer)]
	ifFalse:[ 
		instance := self class new:self size.
		1 to:self size do:[:i| instance at:i put:((self at:i) * 
			(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))].
		instance]

]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> ** anIntOrArray [
	^ self collectWithIndex:[:o :i| 
			o ** (anIntOrArray isNumber 
					ifTrue:[anIntOrArray]
					ifFalse:[anIntOrArray at:i])]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> *= anArray [
	(anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer *= anArray buffer)]
	ifFalse:[ 1 to:self size do:[:i| self at:i put:((self at:i) * 
				(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))]]

]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> + anArray [
	| instance |
	^ (anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer + anArray buffer)]
	ifFalse:[ 
		instance := self class new:self size.
		1 to:self size do:[:i| instance at:i put:((self at:i) + 			
						(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))].
		instance]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> += anArray [
	(anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer += anArray buffer)]
	ifFalse:[ 1 to:self size do:[:i| self at:i put:((self at:i) + 
				(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))]]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> , anArray [
	^ (anArray isNumber not and:[self isSliced not & anArray isSliced not] )
		ifTrue:[self class newFromArray:(self buffer , anArray)]
		ifFalse:[
			self class newFromArray:(
		  		self copyReplaceFrom: self size + 1
		  		to: self size
		  		with: anArray)]

]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> -= anArray [
	(anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer -= anArray buffer)]
	ifFalse:[ 1 to:self size do:[:i| self at:i put:((self at:i) - 
				(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))]]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> /= anArray [
	(anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer /= anArray buffer)]
	ifFalse:[ 1 to:self size do:[:i| self at:i put:((self at:i) / 
				(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))]]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> \\= anArray [
	(anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self class newFromArray:(self buffer \\= anArray buffer)]
	ifFalse:[ 1 to:self size do:[:i| self at:i put:((self at:i) \\ 
				(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))]]
]

{ #category : #adding }
MlNonContinuousVector >> add: newObject [
	self shouldNotImplement
]

{ #category : #'sorting and filtering' }
MlNonContinuousVector >> applyBooleanFilter: aBooleanArray [
	|  lastBool collectionOfStrides lastAdded newSize  instance |

	aBooleanArray size = self size ifFalse:[MlShapeError signal: 'Both MlArrays should have the same size'].
	collectionOfStrides := OrderedCollection new.
	lastBool:=false.
	lastAdded := collectionOfStrides add: 1.
	newSize := self size.
	aBooleanArray doWithIndex:[:each :ind| 
		lastBool not & (each) ifTrue:[
			newSize := newSize - (ind - lastAdded). 
			collectionOfStrides add: ind ].
		lastBool & each not ifTrue:[lastAdded := collectionOfStrides add: ind ].
		lastBool := each].
	collectionOfStrides size odd ifTrue:[  newSize := newSize - (self size + 1 - lastAdded)]. 
	collectionOfStrides add:self size + 1.

	instance := (self class newFromArray:self).
	instance strides: collectionOfStrides.
	instance size: newSize.
	^ self class newFromArray: instance
	
			
]

{ #category : #'sorting and filtering' }
MlNonContinuousVector >> applyNewIndexOrder: anArrayOfIndexes [ 
	| copy |
	copy := self deepCopy.
	anArrayOfIndexes doWithIndex:[:i :j| self at:j put: (copy at:i)].
	
]

{ #category : #'sorting and filtering' }
MlNonContinuousVector >> argSortBy: aBlock [ 
	| algorithm copyOfSelf|
	copyOfSelf := self deepCopy.
	algorithm := copyOfSelf bubbleSort: aBlock.
	^ algorithm value
]

{ #category : #accessing }
MlNonContinuousVector >> at: aPos [
	^ self buffer at: (self fakeAt: aPos)

	
	
		 
]

{ #category : #accessing }
MlNonContinuousVector >> at: aPos put: aValue [
	^ self buffer at: (self fakeAt: aPos) put:aValue

	
	
		 
]

{ #category : #'sorting and filtering' }
MlNonContinuousVector >> bubbleSort: conditionBlock [
 | tmp |
^ [ |swaped i sortedIndexes|
		swaped := true.
		sortedIndexes := Array newFrom:(1 to:self size).
		i:= 1.
		[swaped & (i < (self size))] whileTrue:[
			swaped := false.
			1 to: ( self size - i) do:[:j|
				(conditionBlock value: (self at:j) value: (self at: j + 1)) ifFalse:[ 
					swaped := true.
					tmp := sortedIndexes at:j.
					sortedIndexes at:j put:(sortedIndexes at:j+1).
					sortedIndexes at:j+1 put:tmp.
					self swap: j by:j+1]
			].
			i := i + 1.
		].
		"returns the indexes"
		sortedIndexes
	 ]
]

{ #category : #enumerating }
MlNonContinuousVector >> do: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument."
	1 to: self size do:[:i| aBlock value: (self at: i)]
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> dot: anArray [
	| sum |
	^ (anArray isNumber not and:[self isSliced not & anArray isSliced not] )
	ifTrue:[self buffer dot: anArray buffer]
	ifFalse:[ 
		sum := 0.
		1 to:self size do:[:i| sum := sum + ((self at:i) * 
			(anArray isNumber ifTrue:[anArray] ifFalse:[anArray at:i]))].
		sum]

]

{ #category : #accessing }
MlNonContinuousVector >> fakeAt: aPos [
	| address currentPos j|
	
	aPos > self size ifTrue:[ SubscriptOutOfBounds signal: aPos asString].

	(lastPos first >0 and:[ aPos >= lastPos first ])
	ifTrue:[
		address := aPos+(lastPos at:2).
		j := lastPos at:3.
		currentPos := (lastPos at:4)]
	ifFalse:[
		address := aPos.
		j := 2.
		currentPos := self strides first].
	
	[ address >= currentPos and: [j < self strides size]] whileTrue:[
		address := address +( self strides at:j ) - ( self strides at:j-1).
		currentPos:= ( self strides at:j+1 ).
		j:=j+2.
		].
	"store last sum of the strides and last j. It will accelerate next access in a do: operation"
	lastPos at:1 put:aPos.
	lastPos at:2 put: (address - aPos).
	lastPos at:3 put:j.
	lastPos at:4 put:currentPos.  
	^ address
	
	
		 
]

{ #category : #accessing }
MlNonContinuousVector >> fakeAtFFI: aPos [
	^ LibNCV 
		fakeAt: aPos 
		strides: self strides getHandle 
		stridesSize: self strides size  
		size: self size  
		lastPos:  lastPos getHandle. 

]

{ #category : #initialization }
MlNonContinuousVector >> initialize [ 
	super initialize.
	lastPos := Array new:4.
	"lastPos := FFIArray externalNewType: #uint size:4.
	lastPos autoRelease."
	lastPos at:1 put:0.
	lastPos at:2 put:0.
	lastPos at:3 put:0.
	lastPos at:4 put:0.

	
	
]

{ #category : #testing }
MlNonContinuousVector >> isSliced [
	| myBuffer |
	myBuffer := self buffer.
	[myBuffer isKindOf: MlBufferedArray  ] whileTrue:[ 
		myBuffer := myBuffer buffer].
	^ self size ~= myBuffer size
]

{ #category : #'accumulator ops' }
MlNonContinuousVector >> replaceFrom: start to: stop with: replacement startingAt: repStart [ 

	(self isSliced not & replacement isSliced not)
	ifTrue:[self buffer replaceFrom: start to: stop with: replacement buffer startingAt: repStart ]
	ifFalse:[ super replaceFrom: start to: stop with: replacement startingAt: repStart]

]

{ #category : #accessing }
MlNonContinuousVector >> strides [
	^ strides
]

{ #category : #accessing }
MlNonContinuousVector >> strides: aCollectionOfStrides [
	"strides := FFIArray externalNewType: #uint size:aCollectionOfStrides size.
	strides autoRelease.
	aCollectionOfStrides doWithIndex:[:e :i| strides at:i put:e]"
	strides := aCollectionOfStrides asArray
]

{ #category : #'sorting and filtering' }
MlNonContinuousVector >> swap: j by: k [
	| temp |
	temp := self at:j.
	self at:j put:(self at:k).
	self at:k put:temp
]

{ #category : #accessing }
MlNonContinuousVector >> validRanges: anArrayOfValidIntervals [
	| newStrides|

	newStrides := OrderedCollection new.
	self size: 0.
	newStrides add:1.
	anArrayOfValidIntervals  do:[:interval|
		self size: self size + interval size.
		interval increment = 1 
		ifTrue:[
			newStrides last = interval first 
			ifTrue:[newStrides removeLast]
			ifFalse:[newStrides add: (interval first  )].
			newStrides add: interval last+1]
		ifFalse:[
			interval do:[:index|
				newStrides last = index 
				ifTrue:[newStrides removeLast]
				ifFalse:[newStrides add: index].
				newStrides add: index + 1]
			]].
	newStrides add: self buffer size+1.
	self strides: newStrides 

]
