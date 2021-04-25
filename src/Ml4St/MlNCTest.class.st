Class {
	#name : #MlNCTest,
	#superclass : #TestCase,
	#category : #'Ml4St-FFI-Test'
}

{ #category : #tests }
MlNCTest >> testInstantiate [
	|instance strides|
	
	strides := MlInt64Array new:4.
	strides at:1 put: 1.
	strides at:2 put: 4.
	strides at:3 put: 4.
	strides at:4 put: 10.
	
	instance := LibNCV newNCVector: 20 strides: strides stridesSize: strides size.
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
