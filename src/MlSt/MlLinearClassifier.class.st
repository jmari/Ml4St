Class {
	#name : #MlLinearClassifier,
	#superclass : #MlClassification,
	#category : #'MlSt-LinearModel-Classification'
}

{ #category : #tuning }
MlLinearClassifier >> autotune: aSparseMatrix target: anArray [ 
	^self autotune: aSparseMatrix target: anArray sampleWeight: nil
]

{ #category : #tuning }
MlLinearClassifier >> autotune: aSparseMatrix target: anArray sampleWeight: sw [
	|  startC  bestScore nr_fold startP   bias  bestC bestP  swDict reader | 
	sw ifNotNil:[
		swDict := sw as:SmallDictionary.
		reader := SVMReader new.
		self parameters at:#nr_weight put: sw size.
		self parameters at:#weight_label put: ( reader targetAsSVM: swDict keys).
		self parameters at:#weight put: (reader targetAsSVM: swDict values)].
	
	startC := self parameters at:#C ifAbsent:[ -1.0].
	startP := self parameters at:#p ifAbsent:[ -1.0].
	bias := self parameters at:#bias.
	nr_fold := self parameters at:#n_fold.
	bestC :=  ByteArray new: (FFIFloat64 externalTypeSize). 
	bestP :=  ByteArray new: (FFIFloat64 externalTypeSize). 
	bestScore :=  ByteArray new: (FFIFloat64 externalTypeSize). 
		
	problem := problem ifNil:[SVMReader new 
											asLNProblemWithTarget: anArray
											features: aSparseMatrix
											bias: bias]. 
	LibLinear 	findParameters: problem 
										parameter: self parameters nativeParameters   
										nrFolds:  nr_fold 
										startC: startC 
										startP: startP 
										bestC: bestC 
										bestP: bestP
										bestScore:  bestScore.
									
	self parameters at:#C put: (bestC doubleAt:1).
	self parameters at:#p put: (bestP doubleAt:1).

	^ {#C-> (bestC doubleAt:1).
		#p-> (bestP doubleAt:1).
		#score-> (bestScore doubleAt:1)} as:SmallDictionary
]

{ #category : #initialization }
MlLinearClassifier >> libraryClass [ 
	^ LibLinear
]

{ #category : #initialization }
MlLinearClassifier >> parameterClass [ 
	^ MlLibLinearParameter 
]
