Class {
	#name : #LibFloatNCV,
	#superclass : #LibNCV,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #floatVector }
LibFloatNCV class >> newVector: size strides: strides stridesSize: stridesSize [ 
	""
	^ self ffiCall: #(NCFloatVector * newNCFloatVector(ulonglong size, ulonglong *strides, ulonglong stridesSize)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibFloatNCV class >> vector: ncVector at:pos [ 

	^ self ffiCall: #(float at(NCFloatVector *ncVector, uint64 pos)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibFloatNCV class >> vector: ncVector at:pos put: aFloat [
	""
	^ self ffiCall: #(float atPut(NCFloatVector *ncVector, uint64 pos, float aFloat)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibFloatNCV class >> vector: aNCVector dot: otherNCVector [ 
	^ self ffiCall: #(float dot( NCFloatVector  *aNCVector, NCFloatVector  *otherNCVector)) library: LibFloatNCV 
]
