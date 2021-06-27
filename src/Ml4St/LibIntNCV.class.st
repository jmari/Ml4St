Class {
	#name : #LibIntNCV,
	#superclass : #LibNCV,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #floatVector }
LibIntNCV class >> newVector: size strides: strides stridesSize: stridesSize [ 
	""
	^ self ffiCall: #(NCIntVector * newNCIntVector(ulonglong size, ulonglong *strides, ulonglong stridesSize)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibIntNCV class >> vector: ncVector at:pos [ 
	"q coño pasa"
	^ self ffiCall: #(int at(NCIntVector *ncVector, uint64 pos)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibIntNCV class >> vector: ncVector at:pos put: anInteger [
	""
	^ self ffiCall: #(int atPut(NCIntVector *ncVector, uint64 pos, int anInteger)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibIntNCV class >> vector: aNCVector dot: otherNCVector [ 
	^ self ffiCall: #(int64 dot( NCIntVector  *aNCVector, NCIntVector  *otherNCVector)) library: LibFloatNCV 
]
