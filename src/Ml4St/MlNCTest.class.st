Class {
	#name : #MlNCTest,
	#superclass : #TestCase,
	#instVars : [
		'values'
	],
	#category : #'Ml4St-FFI-Test'
}

{ #category : #tests }
MlNCTest >> testAtAtPut [
	|vector strides value|
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.

	vector := LibNCV newNCVector: 20 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		value := LibNCV vector:vector at:i put: i asFloat.
		self assert:value closeTo: i asFloat].
	1 to: vector size do:[:i|
		value := LibNCV vector:vector at:i.
		self assert:value closeTo: i asFloat].
	
	
	

]

{ #category : #tests }
MlNCTest >> testDot [
	|vector strides value vector2 |
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.
	
	vector := LibNCV newNCVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		value := LibNCV vector:vector at:i put: i asFloat].
	
	vector2 := LibNCV newNCVector: 7 strides: nil stridesSize: 0.
	1 to: vector2 size do:[:i|
		value := LibNCV vector:vector2 at:i put: i asFloat].
		
	value := LibNCV vector:vector dot:vector2.
	self assert:value equals: 25
]

{ #category : #tests }
MlNCTest >> testFakeAt [
	|vector strides values|
	strides := MlInt64Array new:4.
	strides at:1 put: 3.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.
	values := OrderedCollection new.
	vector := LibNCV newNCVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		values add: (LibNCV vector:vector fakeAt:i)].
	self assert:values asArray equals: {0. 1. 3. 4. 6. 7. 8. 9.}
	
	
	

]

{ #category : #tests }
MlNCTest >> testFakeAt2 [
	|vector strides values|
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 3.
	strides at:3 put: 10.
	strides at:4 put: 11.
	values := OrderedCollection new.
	vector := LibNCV newNCVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		values add: (LibNCV vector:vector fakeAt:i)].
	self assert:values asArray equals: {2. 3. 4. 5. 6. 7. 8.}
	
	
	

]

{ #category : #tests }
MlNCTest >> testInstantiate [
	|instance strides|
	
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 4.
	strides at:4 put: 10.
	instance := LibNCV newNCVector: 20 strides: strides getHandle stridesSize: strides size.
	self assert:instance size equals: 11.
	self assert:instance realSize equals: 20.

]

{ #category : #tests }
MlNCTest >> testVirtualSize [
	|s strides|
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 4.
	strides at:4 put: 10.
	s := LibNCV calculateVirtualSize:20 strides: strides getHandle stridesSize: strides size.
	self assert: s equals: 11.
	

]
