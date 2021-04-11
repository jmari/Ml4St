Extension { #name : #MlBufferedArray }

{ #category : #'*MlSt' }
MlBufferedArray >> decode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) decode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> describe [
	|describeResult |
	"It is done one by one...all except mean and variance not in one pass"
	describeResult := MlDescribeResult new.

	describeResult mean:self mean.
	describeResult variance: self variance.
	describeResult max: self max.
	describeResult min: self min.
	describeResult numberOfObs: self size.
	describeResult skewness: self skewness.
	describeResult kurtosis: self kurtosis.
	
	^ describeResult
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> encode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) encode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> oneHotDecode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotDecode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> oneHotEncode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotEncode:e]
	
	 
		
]

{ #category : #'*MlSt' }
MlBufferedArray >> summary [ 
	| summary |
	self size = 0 ifTrue:[^ MlDescribeResult new].
	self first isNumber ifTrue:[ ^ self describe ].
	
	summary := Dictionary new.
	self do:[:each|
		summary at: each incrementBy:1].
	^ summary
	
	 
		
]
