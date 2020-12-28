Class {
	#name : #LibNcv,
	#superclass : #FFILibrary,
	#category : #'MlSt-Core'
}

{ #category : #accessing }
LibNcv class >> fakeAt: aPos strides: strides stridesSize: stridesSize size: size lastPos: lastPos [
	^ self ffiCall: #(uint fakeAt( uint aPos, uint *strides,  uint stridesSize,  uint size,   uint *lastPos)) library: LibNcv 
]

{ #category : #accessing }
LibNcv class >> testA:aPos [
	^ self ffiCall: #(int testA(int aPos)) library: LibNcv 
]

{ #category : #'accessing platform' }
LibNcv >> macModuleName [
	^ self unixModuleName 
]

{ #category : #'accessing platform' }
LibNcv >> unixModuleName [
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	{  'libncv_', self version, '.dylib'. }
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate libncv_', self version,' library Please check that it is installed on your system.'
]

{ #category : #versions }
LibNcv >> version [ 
	^ '1'
]
