Class {
	#name : #MlNCTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-FFI-LibNCVector'
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
MlNCTest >> testCreateMlArray [
	| tmp |
	tmp :=MlArray from: { 1. 2. 3. 4 } dType: #UFFIFloat. 
	tmp inspect
	
	

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

	
	vector := LibFloatNCV newVector: 10 strides: strides getHandle stridesSize: strides size.
	1 to: vector size do:[:i|
		value := LibFloatNCV vector:vector at:i put: i asFloat.
		].
	
	vector2 := LibFloatNCV newVector: 10 strides: nil stridesSize: 0.
	1 to: vector2 size do:[:i|
		value := LibFloatNCV vector:vector2 at:i put: i asFloat.
		].
	"strides are 1@4 6@7"
	vector2 strides: strides getHandle.
	vector2 stridesSize:strides size.
	vector2 size: (LibFloatNCV calculateVirtualSize: vector2 size strides: strides getHandle stridesSize: strides size).
		
	value := LibFloatNCV vector:vector dot:vector2.
	self assert:value equals: ({1. 2. 3. 4. 5. 6} dot: {4. 5. 7. 8. 9. 10.}) 
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
	"slice in C is 2@3 5@6"
	self assert:values asArray equals: {0. 1. 3. 4. 6. 7. 8. 9.}
	
	
	

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
	"strides are 0@2 9@10 so..."
	self assert: vals asArray equals: {2. 3. 4. 5. 6. 7. 8.}.
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

{ #category : #tests }
MlNCTest >> testWeightOfAxis [
	|array shape  w shape2 |
	shape := MlNativeIntArray new:4.
	shape at:1 put: 1.
	shape at:2 put: 2.
	shape at:3 put: 3.
	shape at:4 put: 4.
	
	shape2 := {1. 2. 3. 4.}.
	array := MlArray new: shape2 order:#F.

	1 to: shape size do:[:axis|
		w := LibFloatNCV weightOfAxis: axis shape: shape getHandle ndim: shape size order:$F.
		Transcript show: axis asString.
		self assert: (array weightOfAxis: axis) equals:w] 
	
	
	

]

{ #category : #tests }
MlNCTest >> testWeightOfAxisC [
	|array shape  w shape2 |
	shape := MlNativeIntArray new:4.
	shape at:1 put: 1.
	shape at:2 put: 2.
	shape at:3 put: 3.
	shape at:4 put: 4.
	
	shape2 := {1. 2. 3. 4.}.
	array := MlArray new: shape2 order:#C.

	1 to: shape size do:[:axis|
		w := LibFloatNCV weightOfAxis: axis shape: shape getHandle ndim: shape size order:$C.
		Transcript show: axis asString.
		self assert: (array weightOfAxis: axis) equals:w] 
	
	
	

]
