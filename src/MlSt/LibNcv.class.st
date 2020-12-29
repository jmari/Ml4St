Class {
	#name : #LibNCV,
	#superclass : #FFILibrary,
	#category : #'MlSt-FFI-NCVector'
}

{ #category : #accessing }
LibNCV class >> fakeAt: aPos strides: strides stridesSize: stridesSize size: size lastPos: lastPos [
	^ self ffiCall: #(uint fakeAt( uint aPos, uint* strides,  uint stridesSize,  uint size,   uint* lastPos)) library: LibNCV 
]

{ #category : #accessing }
LibNCV class >> testA:aPos pos:pos [
	"q coño pasa"
	^ self ffiCall: #(int testA(int *aPos, int pos)) library: LibNCV 
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
