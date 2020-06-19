Extension { #name : #Collection }

{ #category : #'*MlSt' }
Collection >> accuracy: aCollection [
	"self and aCollection should be a collection of floats, each float is a label"
	| sumTotal |
	sumTotal := 0.
	1 to:self size do:[:i|
		(self at:i )= (aCollection at:i) ifTrue:[sumTotal := sumTotal + 1]].
	^ { #accuracy -> (sumTotal / self size)} as: SmallDictionary. 
		
]

{ #category : #'*MlSt' }
Collection >> asMlArray [
	^ MlArray from: self
]

{ #category : #'*MlSt' }
Collection >> buildEncoder [ 
	| i encoder |
	i := 0.
	encoder := MlEncoder new..
	self do:[:e| encoder add:e ].
	^ encoder
]

{ #category : #'*MlSt' }
Collection >> confusionMatrix: aCollection [
	"self should be predicted values and aCollection should be the real values, each float is a label"
	| sumTotal confusionMatrix |
	sumTotal := 0.
	confusionMatrix := MlConfusionMatrix new.		
	1 to:self size do:[:i|
		confusionMatrix at: (self at:i ) at:(aCollection at:i) incrementBy:1].
	^ confusionMatrix. 
		
]

{ #category : #'*MlSt' }
Collection >> decode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) decode:e]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> encode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) encode:e]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> mean [
	^ self sum / self size 
		
]

{ #category : #'*MlSt' }
Collection >> meanAndStd [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ Array with: ((ex + (k * self size))/self size) with:(ex2 - (ex squared / self size))/(self size - 1) sqrt
		
]

{ #category : #'*MlSt' }
Collection >> meanAndVariance [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ Array with: (ex + (k * self size)) with:(ex2 - (ex squared / self size))/(self size - 1)
		
]

{ #category : #'*MlSt' }
Collection >> meanExcludeElement: anElement [
	| i |
	(anElement isNumber and:[ anElement isNaN])  ifTrue:[^self meanNoNan].
	i := 0.
	^ (self inject:0 into:[:sum :e|  e = anElement ifTrue:[sum] ifFalse:[i := i+1. sum + e]]) / i 
		
]

{ #category : #'*MlSt' }
Collection >> meanNoNan [
	| i |

	i := 0.
	^ (self inject:0 into:[:sum :e|  e isNaN ifTrue:[sum] ifFalse:[i := i+1. sum + e]]) / i 
		
]

{ #category : #'*MlSt' }
Collection >> median [
	|ss|
	ss := self sorted. 
	^ ss medianFrom:1 to: ss size
		
]

{ #category : #'*MlSt' }
Collection >> medianFrom: start to: stop [
	| size |
	"self should be sorted"
	size := stop - start + 1.
	^ ( size even) 
		ifTrue:[ ((self at:(start - 1 + (size / 2)))+(self at:(start+ (size / 2)))) / 2] 
		ifFalse:[self at: (start+ (size / 2)) ]
		
]

{ #category : #'*MlSt' }
Collection >> mode [ 
	| mode |
	mode := Dictionary new.
	self do:[:e| (e isNumber and:[ e isNaN])  ifFalse:[ mode at:e incrementBy:1] ].
	^ mode keyAtValue: (mode max)
]

{ #category : #'*MlSt' }
Collection >> modeExcludeElement: anElement [ 
	| mode |
	(anElement isNumber and:[ anElement isNaN]) ifTrue:[^self mode].
	mode := Dictionary new.
	self do:[:e| e = anElement ifFalse:[ mode at:e incrementBy:1] ].
	^ mode keyAtValue: (mode max)
]

{ #category : #'*MlSt' }
Collection >> module [
	^ (self inject:0 into:[:sum :e| (e * e ) + sum ]) sqrt

	
		
]

{ #category : #'*MlSt' }
Collection >> mse: aCollection [
	| y v delta totalError sumY sumV sumYY sumVV sumVY mse scc |
	sumY := 0.0. sumV:= 0.0. sumYY := 0.0. sumVV := 0.0. sumVY := 0.0. totalError := 0.
	self size do:[:i|
		y := self at:i.
		v := aCollection at:i.
		delta := y - v.
		totalError := totalError + delta squared.
		sumY := sumY + y.
		sumV := sumV + v.
		sumYY := sumYY + y squared.
		sumVV := sumVV + v squared.
		sumVY := sumVY + (v * y)].
	mse := totalError / self size.
	scc := ((self size * sumVY) - (sumV*sumY)) squared / 
			 (((self size * sumVV) - (sumV squared)) * ((self size * sumYY) - (sumY squared))).
	^ { #mse -> mse.
		 #scc -> scc } as: SmallDictionary
		
		
]

{ #category : #'*MlSt' }
Collection >> oneHotDecode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotDecode:e]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> oneHotEncode: anArrayOfEncoders [ 
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (anArrayOfEncoders at:i) oneHotEncode:e]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> quartiles [
	|ss median firstQ secQ |
	ss := self sorted. 
	(self size even) 
					ifTrue:[ 
						median :=  ss medianFrom:1 to: ss size.
						firstQ := ss medianFrom:1 to: ss size /2.
						secQ:= ss medianFrom: (ss size/2) + 1 to: ss size
						] 
					ifFalse:[
						median :=  ss medianFrom:1 to: ss size.
						firstQ := ss medianFrom:1 to: ss size /2.
						secQ:= ss medianFrom: ss size/2 to: ss size
						].
	^ { firstQ. median. secQ}
					
		
]

{ #category : #'*MlSt' }
Collection >> replaceAllBy: aCollectionOrNum [
	aCollectionOrNum isNumber 
	ifTrue:[1 to:self size do:[:i| self at:i put: aCollectionOrNum]]
	ifFalse:[	1 to:self size do:[:i|self at:i put:(aCollectionOrNum at:i)]]
		
]

{ #category : #'*MlSt' }
Collection >> replaceBy: anArrayOfValues element: anElement [
	| i |
	(anElement isNumber and:[ anElement isNaN])  ifTrue:[^self replaceNanBy:anArrayOfValues ].
	i := 0.
	^ self collect:[:e | i:=i+1. e = anElement ifTrue:[(anArrayOfValues at:i)] ifFalse:[e]]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> replaceNanBy: anArrayOfValues [
	| i |
	i := 0.
	^ self collect:[:e | i:=i+1. (e isNumber and:[ e isNaN])  ifTrue:[(anArrayOfValues at:i)] ifFalse:[e]]
	
	 
		
]

{ #category : #'*MlSt' }
Collection >> stdDev [
	^ self variance sqrt
	 
		
]

{ #category : #'*MlSt' }
Collection >> variance [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ (ex2 - (ex squared / self size))/(self size - 1)
		
]
