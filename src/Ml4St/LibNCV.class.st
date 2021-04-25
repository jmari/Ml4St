Class {
	#name : #LibNCV,
	#superclass : #FFILibrary,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #accessing }
LibNCV class >> at:pos [
	"q coño pasa"
	^ self ffiCall: #(int at(int *aPos, int pos)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> calculateVirtualSize:size strides: strides stridesSize: strSize [
	"q coño pasa"
	^ self ffiCall: #(int64  calculateVirtualSize(int64  size, int64  *strides, int64  strSize)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> fakeAt: aPos strides: strides stridesSize: stridesSize size: size lastPos: lastPos [
	^ self ffiCall: #(uint64 fakeAt( uint64 aPos, uint64* strides,  uint64 stridesSize,  uint64 size,   uint64* lastPos)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> newNCVector: size strides: strides stridesSize: stridesSize [ 
	""
	^ self ffiCall: #(NCFloatVector * newNCFloatVector(ulonglong size, ulonglong *strides, ulonglong stridesSize)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> vector: ncVector at:pos [ 
	"q coño pasa"
	^ self ffiCall: #(float at(NCFloatVector ncVector, uint64 pos)) library: LibNCV 
]

{ #category : #'accessing platform' }
LibNCV >> macModuleName [
	^ self unixModuleName 
]

{ #category : #'accessing platform' }
LibNCV >> unixModuleName [
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	{  'libncv_', self version, '.dylib'. }
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate libncv_', self version,' library Please check that it is installed on your system.'
]

{ #category : #versions }
LibNCV >> version [ 
	^ '1'
]
