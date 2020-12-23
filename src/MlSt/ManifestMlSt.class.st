"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMlSt,
	#superclass : #PackageManifest,
	#category : #'MlSt-Manifest'
}

{ #category : #'code-critics' }
ManifestMlSt class >> ruleGRTemporaryVariableCapitalizationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'MlQuantileTransformer class' #sNormInv: #true)) #'2020-05-01T09:24:28.249456+02:00') )
]

{ #category : #'code-critics' }
ManifestMlSt class >> ruleRBEqualNilRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#MlFromCSVTest)) #'2020-06-30T19:19:52.588371+02:00') )
]

{ #category : #'code-critics' }
ManifestMlSt class >> ruleRBGlobalVariablesUsageV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#MlSt)) #'2020-04-30T07:44:19.123985+02:00') )
]

{ #category : #'code-critics' }
ManifestMlSt class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MlArray #concatArrays:axis: #false)) #'2020-09-20T18:34:31.242784+02:00') )
]

{ #category : #'code-critics' }
ManifestMlSt class >> ruleRBToDoRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#MlArray #completeSlice: #false)) #'2020-05-10T08:57:45.590726+02:00') )
]

{ #category : #'code-critics' }
ManifestMlSt class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'SVMSparseMatrix class' #fromMlArray: #true)) #'2020-06-07T10:55:27.358547+02:00') )
]
