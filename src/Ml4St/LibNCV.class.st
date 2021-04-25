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
	^ self ffiCall: #(ulonglong  calculateVirtualSize(ulonglong  size, ulonglong  *strides, ulonglong  strSize)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> fakeAt: aPos strides: strides stridesSize: stridesSize size: size lastPos: lastPos [
	^ self ffiCall: #(uint fakeAt( uint aPos, uint* strides,  uint stridesSize,  uint size,   uint* lastPos)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> newNCVector: size strides: strides stridesSize: stridesSize [ 
	""
	^ self ffiCall: #(NCFloatVector * newNCFloatVector(uint64 size, uint64 *strides, uint64 stridesSize)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> vector: ncVector at:pos [ 
	"q coño pasa"
	^ self ffiCall: #(float at(NCFloatVector ncVector, int pos)) library: LibNCV 
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
