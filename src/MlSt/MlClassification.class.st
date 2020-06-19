Class {
	#name : #MlClassification,
	#superclass : #MlRegressorMixin,
	#instVars : [
		'problem'
	],
	#pools : [
		'LNSolverType'
	],
	#category : #'MlSt-LinearModel-Classification'
}

{ #category : #'instance creation' }
MlClassification class >> new: aDictOrCollectionOfAssociations [
	| instance |
	instance := self new.
	instance parameters: (aDictOrCollectionOfAssociations as: MlLibLinearParameter).
	instance initializeSolver.
	^ instance
]

{ #category : #tuning }
MlClassification >> autotune: aSparseMatrix target: anArray [ 
	^self autotune: aSparseMatrix target: anArray sampleWeight: nil
]

{ #category : #tuning }
MlClassification >> autotune: aSparseMatrix target: anArray sampleWeight: sw [
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
MlClassification >> finalize [
	self model ifNotNil:[
		self model isNull ifFalse:[
			self model free;beNull]].
	self parameters nativeParameters isNull ifFalse:[
		self parameters nativeParameters free;beNull] 
		
	
]

{ #category : #'fit-predict' }
MlClassification >> fit: aSparseMatrix target: anArray sampleWeight: sw [
	|  bias swDict reader| 
	sw ifNotNil:[
		swDict := sw as:SmallDictionary.
		reader := SVMReader new.
		self parameters at:#nr_weight put: sw size.
		self parameters at:#weight_label put: ( reader targetAsSVM: swDict keys).
		self parameters at:#weight put: (reader targetAsSVM: swDict values)].
	bias := self parameters at:#bias.
	problem := problem ifNil:[SVMReader new asLNProblemWithTarget: anArray features: aSparseMatrix bias: bias]. 
	self model: (LibLinear train: problem parameter: self parameters nativeParameters).
	^  self
]

{ #category : #initialization }
MlClassification >> initialize [ 
	super initialize.
	parameters := MlLibLinearParameter new.
	self initializeSolver
	
]

{ #category : #initialization }
MlClassification >> initializeSolver [
	self subclassResponsibility 
]

{ #category : #'fit-predict' }
MlClassification >> predict: aSparseMatrix [ 
	| labels bias native_features |
	bias := self parameters at:#bias.
	native_features := (SVMReader new featuresAsSVM: aSparseMatrix bias: bias) at:1.
	labels := Array new: native_features size.
	native_features doWithIndex:[:e :index|
		labels at:index put:(
		LibLinear predict: self model featureNode: (LNFeatureNode fromHandle: e))].
	^ labels
]

{ #category : #'fit-predict' }
MlClassification >> predictProbability: aSparseMatrix [  
	| labels bias native_features  |
	bias := self parameters at:#bias.
	native_features := (SVMReader new featuresAsSVM: aSparseMatrix bias: bias) at:1.
	labels := Array new: native_features size.
	native_features doWithIndex:[:e :index|
		|label probabilities probBuffer i|
		probabilities := Array new: self model nr_class.
		probBuffer := ByteArray new: FFIFloat64 externalTypeSize * self model nr_class.
		label:= LibLinear 	predictProbability: self model 
								featureNode: (LNFeatureNode fromHandle: e)
								probEstimates: probBuffer.
		i := 1.
		(1 to: probBuffer size by:FFIFloat64 externalTypeSize) do:[:pointer|
			probabilities at: i put: (probBuffer doubleAt: pointer).
			i := i +1].
		labels at:index put: (label -> probabilities)
		].
							
	^ labels 
]

{ #category : #'fit-predict' }
MlClassification >> score: aSparseMatrix targets: anArray sampleWeight: sw [
	| n_fold  bias  predictBuffer predict i swDict reader |
	sw ifNotNil:[
		swDict := sw as:SmallDictionary.
		reader := SVMReader new.
		self parameters at:#nr_weight put: sw size.
		self parameters at:#weight_label put: ( reader targetAsSVM: swDict keys).
		self parameters at:#weight put: (reader targetAsSVM: swDict values)].
	
	bias := self parameters at:#bias.
	n_fold := self parameters at:#n_fold.
	problem := SVMReader new asLNProblemWithTarget:anArray features: aSparseMatrix bias:bias.
	predictBuffer := ByteArray new:(FFIFloat64 externalTypeSize) * problem l.	

	LibLinear 	crossValidation: problem 
					parameter: self parameters nativeParameters 
					nrFolds:n_fold  
					target: predictBuffer.
	predict:= Array new: problem l.
	i := 1.
	(1 to:	predictBuffer size by:FFIFloat64 externalTypeSize) do:[:pointer|
			predict at: i put: (predictBuffer doubleAt: pointer).
			i := i +1].
							
	^ 	( (L2R_L2LOSS_SVR value|L2R_L1LOSS_SVR_DUAL value| L2R_L2LOSS_SVR_DUAL value ) = (self parameters at:#solver_type ))
		ifTrue:[anArray mse:predict]
		ifFalse:[predict accuracy:anArray]
		
	
]
