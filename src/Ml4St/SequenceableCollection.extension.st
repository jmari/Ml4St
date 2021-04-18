Extension { #name : #SequenceableCollection }

{ #category : #'*Ml4St' }
SequenceableCollection >> accuracy: aCollection [
	"self and aCollection should be a collection of floats, each float is a label"
	| sumTotal |
	sumTotal := 0.
	1 to:self size do:[:i|
		(self at:i )= (aCollection at:i) ifTrue:[sumTotal := sumTotal + 1]].
	^ { #accuracy -> (sumTotal / self size)} as: SmallDictionary. 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> asMlArray [
	^ MlArray from: self
]

{ #category : #'*Ml4St' }
SequenceableCollection >> asPlainArray [
	"converts a collection of collections (normally columns of rows) to an array one by the other"
	
	| collection |
	collection := OrderedCollection new..
	self isEmpty ifTrue:[^self].
	self first isCollection & (self first isString not) 
		ifTrue: [self do:[:each| collection addAll:each ]]
		ifFalse: [ collection := self ].
	^ collection
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> buildEncoder [ 
	| i encoder |
	i := 0.
	encoder := MlEncoder new..
	self do:[:e| encoder add:e ].
	^ encoder
]

{ #category : #'*Ml4St' }
SequenceableCollection >> confusionMatrix: aCollection [
	"self should be predicted values and aCollection should be the real values, each float is a label"
	| sumTotal confusionMatrix |
	sumTotal := 0.
	confusionMatrix := MlConfusionMatrix new.		
	1 to:self size do:[:i|
		confusionMatrix at: (self at:i ) at:(aCollection at:i) incrementBy:1].
	^ confusionMatrix. 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> differentiate: step times: times [
	| dest source |
	dest:= self class new:self size.
	source := self.
	times timesRepeat:[ 
		1 to: self size do:[:j|
			dest at:j put: ( (source at:j) - (source at:j - step ifAbsent:[Float nan]))].
		source := dest.
		dest := self class new: self size].
	^ source	
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> dot: anArray [
	| sum |
	sum := 0.
	1 to:self size do:[:i| sum := sum + ((self at:i) * (anArray at:i))].
	^ sum
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> kurtosis [
	| meanAndStd  kurtosis n m4|
	n:= self size.
	meanAndStd := self meanAndStd.
	m4 := self inject:0 into:[:sum :e| sum + ((e - meanAndStd first) **4)].
	kurtosis := 1/n * m4 / (meanAndStd second **4).
	^ kurtosis - 3
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> mean [
	^ self sum / self size 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> meanAndStd [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ Array with: ((ex + (k * self size))/self size) with:((ex2 - (ex squared / self size))/(self size - 1)) sqrt
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> meanAndVariance [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ Array with: (ex + (k * self size)) with:(ex2 - (ex squared / self size))/(self size - 1)
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> meanExcludeElement: anElement [
	| i |
	(anElement isNumber and:[ anElement isNaN])  ifTrue:[^self meanNoNan].
	i := 0.
	^ (self inject:0 into:[:sum :e|  e = anElement ifTrue:[sum] ifFalse:[i := i+1. sum + e]]) / i 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> meanNoNan [
	| i |

	i := 0.
	^ (self inject:0 into:[:sum :e|  (e isNumber and:[ e isNaN]) ifTrue:[sum] ifFalse:[i := i+1. sum + e]]) / i 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> median [
	|ss|
	ss := self sorted. 
	^ ss medianFrom:1 to: ss size
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> medianExcludeElement: anElement [
	| i |
	(anElement isNumber and:[ anElement isNaN])  ifTrue:[^self medianNoNan].

	^ (self select:[:v | v ~= anElement]) median
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> medianFrom: start to: stop [
	| size |
	"self should be sorted"
	size := stop - start + 1.
	^ ( size even) 
		ifTrue:[ ((self at:(start - 1 + (size / 2)))+(self at:(start+ (size / 2)))) / 2] 
		ifFalse:[self at: (start+ (size / 2)) ]
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> medianNoNan [

	^ (self select:[:v| v isNaN not]) median
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> mode [ 
	| mode |
	mode := Dictionary new.
	self do:[:e| (e isNumber and:[ e isNaN]) ifFalse:[ mode at:e incrementBy:1] ].
	^ mode keyAtValue: (mode max)
]

{ #category : #'*Ml4St' }
SequenceableCollection >> modeExcludeElement: anElement [ 
	| mode |
	(anElement isNumber and:[ anElement isNaN]) ifTrue:[^self mode].
	mode := Dictionary new.
	self do:[:e| e = anElement ifFalse:[ mode at:e incrementBy:1] ].
	^ mode keyAtValue: (mode max)
]

{ #category : #'*Ml4St' }
SequenceableCollection >> module [
	^ (self inject:0 into:[:sum :e| (e * e ) + sum ]) sqrt

	
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> mse: aCollection [
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

{ #category : #'*Ml4St' }
SequenceableCollection >> quartiles [
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

{ #category : #'*Ml4St' }
SequenceableCollection >> replaceAllBy: aCollectionOrNum [
	aCollectionOrNum isNumber 
	ifTrue:[1 to:self size do:[:i| self at:i put: aCollectionOrNum]]
	ifFalse:[	1 to:self size do:[:i|self at:i put:(aCollectionOrNum at:i)]]
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> replaceBy: anArrayOfValues element: anElement [
	| i |
	"anArrayOfValues has the same lenght than me, it is usually a broadcasted array of modes,means,..."
	(anElement isNumber and:[ anElement isNaN])  ifTrue:[^self replaceNanBy:anArrayOfValues ].
	i := 0.
	^ self collect:[:e | i:=i+1. e = anElement ifTrue:[(anArrayOfValues at:i)] ifFalse:[e]]
	
	 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> replaceNanBy: anArrayOfValues [

	^ self doWithIndex:[:e :i | (e isNumber and:[ e isNaN])  
			ifTrue:[self at:i put:(anArrayOfValues at:i)]]
]

{ #category : #'*Ml4St' }
SequenceableCollection >> skewness [ 
	| meanAndStd m3 skewness n |
	n := self size.
	meanAndStd := self meanAndStd.
	m3 := self inject:0 into:[:sum :e| sum + ((e - meanAndStd first) **3)].
	skewness := 1/n * m3 /  (meanAndStd second ** 3).
	^ skewness  
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> stdDev [
	^ self variance sqrt
	 
		
]

{ #category : #'*Ml4St' }
SequenceableCollection >> variance [
	| k ex2 ex |
	self size < 2 ifTrue:[^ 0.0].
	k := self at:1.	
	ex := ex2 := 0.0.
   self do:[:x|
        ex := ex + x - k.
        ex2 := ex2 + ((x - k) * (x - k))].
   	^ (ex2 - (ex squared / self size))/(self size - 1)
		
]
