Class {
	#name : #LibNCV,
	#superclass : #FFILibrary,
	#category : #'Ml4St-FFI-libNCVector'
}

{ #category : #accessing }
LibNCV class >> calculateVirtualSize:size strides: strides stridesSize: strSize [
	"q coño pasa"
	^ self ffiCall: #(int64  calculateVirtualSize(int64  size, int64  *strides, int64  strSize)) library: LibFloatNCV 
]

{ #category : #floatVector }
LibNCV class >> newVector: size strides: strides stridesSize: stridesSize [ 
	self subclassResponsibility 
]

{ #category : #floatVector }
LibNCV class >> vector: ncVector at:pos [ 
	self subclassResponsibility 
]

{ #category : #floatVector }
LibNCV class >> vector: ncVector at:pos put:aValue [
	self subclassResponsibility 
]

{ #category : #floatVector }
LibNCV class >> vector: aNCVector dot: otherNCVector [ 
	self subclassResponsibility 
]

{ #category : #accessing }
LibNCV class >> vector: aNCVector fakeAt: aPos [ 
	^ self ffiCall: #(uint64 fakeAt( NCFloatVector  *aNCVector, uint64 aPos)) library: LibFloatNCV 
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
