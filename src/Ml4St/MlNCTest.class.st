Class {
	#name : #MlNCTest,
	#superclass : #TestCase,
	#category : #'Ml4St-FFI-LibNCVector-Test'
}

{ #category : #tests }
MlNCTest >> testAtAtPut [
	|vector strides value|
	strides := MlNativeIntArray new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.

	vector := LibFloatNCV newVector: 20 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		value := LibFloatNCV vector:vector at:i put: i asFloat.
		self assert:value closeTo: i asFloat].
	1 to: vector size do:[:i|
		value := LibFloatNCV vector:vector at:i.
		self assert:value closeTo: i asFloat].
	
	
	

]

{ #category : #tests }
MlNCTest >> testDot [
	|vector strides value vector2 r|
	strides := MlNativeIntArray new:4.
	"This should be from 0 to size C format"
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.
	r := OrderedCollection new.
	
	vector := LibFloatNCV newVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		value := LibFloatNCV vector:vector at:i put: i asFloat.
		].
	
	vector2 := LibFloatNCV newVector: 10 strides: nil stridesSize: 0.
	1 to: vector2 size do:[:i|
		value := LibFloatNCV vector:vector2 at:i put: i asFloat.
		r add:value
		].

	vector2 strides: strides getHandle.
	vector2 stridesSize:strides size.
	vector2 size: (LibFloatNCV calculateVirtualSize: vector2 size strides: strides getHandle stridesSize: strides size).
		
	value := LibFloatNCV vector:vector dot:vector2.
	self assert:value equals: ({ 1. 2. 3. 4. 5. 6} dot:{ 1. 5. 6. 8. 9. 10. }) 
]

{ #category : #tests }
MlNCTest >> testFakeAt [
	|vector strides values|
	strides := MlNativeIntArray new:4.
	strides at:1 put: 3.
	strides at:2 put: 4.
	strides at:3 put: 6.
	strides at:4 put: 7.
	values := OrderedCollection new.
	vector := LibFloatNCV newVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		values add: (LibFloatNCV vector:vector fakeAt:i)].
	self assert:values asArray equals: {1. 2. 4. 5. 7. 8. 9. 10.}
	
	
	

]

{ #category : #tests }
MlNCTest >> testFakeAt2 [
	|vector strides vals|
	strides := MlNativeIntArray new:4.
	strides at:1 put: 1.
	strides at:2 put: 3.
	strides at:3 put: 10.
	strides at:4 put: 11.
	vals := OrderedCollection new.
	vector := LibFloatNCV newVector: 10 strides: nil stridesSize: 0.
	vector strides: strides getHandle.
	vector stridesSize: strides size.
	vector size: (LibFloatNCV calculateVirtualSize: vector size strides: strides getHandle stridesSize: strides size).
	1 to: vector size do:[:i|
		vals add: (LibFloatNCV vector:vector fakeAt:i)].
	self assert: vals asArray equals: {3. 4. 5. 6. 7. 8. 9.}.
	
	
	
	

]

{ #category : #tests }
MlNCTest >> testInstantiate [
	|instance strides|
	
	strides := MlNativeIntArray new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 4.
	strides at:4 put: 10.
	instance := LibFloatNCV newVector: 20 strides: strides getHandle stridesSize: strides size.
	self assert:instance size equals: 11.
	self assert:instance realSize equals: 20.

]

{ #category : #tests }
MlNCTest >> testVirtualSize [
	|s strides|
	strides := MlNativeIntArray new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 4.
	strides at:4 put: 10.
	s := LibFloatNCV calculateVirtualSize:20 strides: strides getHandle stridesSize: strides size.
	self assert: s equals: 11.
	

]
