Class {
	#name : #MlClassification,
	#superclass : #MlRegressorMixin,
	#instVars : [
		'problem'
	],
	#pools : [
		'LNSolverType'
	],
	#category : #'MlSt-LinearModel'
}

{ #category : #'instance creation' }
MlClassification class >> new: aDictOrCollectionOfAssociations [
	| instance |
	instance := self new.
	instance parameters: (aDictOrCollectionOfAssociations as: instance parameterClass).
	instance initializeSolver.
	^ instance
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
	bias := self parameters at:#bias ifAbsent:[-1.0].
	problem := problem ifNil:[
		self problemFromArray: anArray features: aSparseMatrix bias: bias]. 
	self model: (self libraryClass train: problem parameter: self parameters nativeParameters).
	^  self
]

{ #category : #initialization }
MlClassification >> initialize [ 
	super initialize.
	self initializeParameters.
	self initializeSolver
	
]

{ #category : #initialization }
MlClassification >> initializeParameters [
	parameters := self parameterClass new.
]

{ #category : #initialization }
MlClassification >> initializeSolver [
	self subclassResponsibility 
]

{ #category : #initialization }
MlClassification >> libraryClass [ 	
	"return library class"
	self subclassResponsibility 
]

{ #category : #initialization }
MlClassification >> nodeClass [ 	
	"return library class"
	self subclassResponsibility 
]

{ #category : #initialization }
MlClassification >> parameterClass [ 	
	"return library class"
	self subclassResponsibility 
]

{ #category : #'fit-predict' }
MlClassification >> predict: aSparseMatrix [ 
	| labels bias native_features |
	bias := self parameters at:#bias.
	native_features := (SVMReader new featuresAsSVM: aSparseMatrix bias: bias nodeClass:'LNFeatureNode*') at:1.
	labels := Array new: native_features size.
	native_features doWithIndex:[:e :index|
		labels at:index put:(
		self libraryClass predict: self model featureNode: (self nodeClass fromHandle: e))].
	^ labels
]

{ #category : #'fit-predict' }
MlClassification >> predictProbability: aSparseMatrix [  
	| labels bias native_features  |
	bias := self parameters at:#bias.
	native_features := (SVMReader new featuresAsSVM: aSparseMatrix bias: bias nodeClass:'LNFeatureNode*') at:1.
	labels := Array new: native_features size.
	native_features doWithIndex:[:e :index|
		|label probabilities probBuffer i|
		probabilities := Array new: self model nr_class.
		probBuffer := ByteArray new: FFIFloat64 externalTypeSize * self model nr_class.
		label:= self libraryClass 	predictProbability: self model 
								featureNode: (self nodeClass fromHandle: e)
								probEstimates: probBuffer.
		i := 1.
		(1 to: probBuffer size by:FFIFloat64 externalTypeSize) do:[:pointer|
			probabilities at: i put: (probBuffer doubleAt: pointer).
			i := i +1].
		labels at:index put: (label -> probabilities)
		].
							
	^ labels 
]

{ #category : #initialization }
MlClassification >> problemFromArray: anArray features: aSparseMatrix bias: bias [
	self subclassResponsibility 
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
