Class {
	#name : #LibLinear,
	#superclass : #FFILibrary,
	#category : #'MlSt-FFI-LibLinear-Uffi'
}

{ #category : #'as yet unclassified' }
LibLinear class >> checkParameter: aParameter from: aProblem [ 
	"const char *check_parameter(const struct problem *prob, const struct parameter *param);"
	^ self ffiCall: #(const char *check_parameter(LNProblem *aProblem, LNParameter *aParameter) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> checkProbabilityModel: aModel [ 
	"int check_probability_model(const struct model *model);"
	^ self ffiCall: #(int check_probability_model(LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> checkRegressionModel: aModel [ 
	"int check_probability_model(const struct model *model);"
	^ self ffiCall: #(int check_regression_model(LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> crossValidation: aProblem parameter: aParameter nrFolds: anInteger target: aDouble [
	"void cross_validation(const struct problem *prob, const struct parameter *param, int nr_fold, double *target);"
	^ self ffiCall: #( void cross_validation(LNProblem *aProblem, LNParameter *aParameter, int anInteger, double *aDouble) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> destroyParameter: aParameter [ 
	"void destroy_param(struct parameter *param);"
	^ self ffiCall: #(void destroy_param(LNParameter *aParameter) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> findParameters: aProblem parameter: aParameter nrFolds: anInteger startC: cAsDouble startP: pAsDouble
bestC: bestCDouble  bestP: bestPDouble bestScore: bestScrDouble [
	"vvoid find_parameters(const struct problem *prob, const struct parameter *param, int nr_fold, double start_C, double start_p, double *best_C, double *best_p, double *best_score);"
	^ self ffiCall: #( void find_parameters(LNProblem *aProblem, LNParameter *aParameter, int anInteger, double cAsDouble, double pAsDouble, double * bestCDouble, double * bestPDouble, double * bestScrDouble ) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> freeAndDestroyModel: aModel [ 
	"void free_and_destroy_model(struct model **model_ptr_ptr);"
	^ self ffiCall: #(void free_model_content(LNModel **aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> freeModelContent: aModel [ 
	"void free_model_content(struct model *model_ptr);"
	^ self ffiCall: #(void free_model_content(LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> getDecfunBias: aModel  label: labelIdxInt [
	"double get_decfun_bias(const struct model *model_, int label_idx);"
	^ self ffiCall: #(double get_decfun_bias(LNModel *aModel,  int labelIdxInt) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> getDecfunCoef: aModel feature: featIdxInt label: labelIdxInt [
	"double get_decfun_coef(const struct model *model_, int feat_idx, int label_idx);"
	^ self ffiCall: #(double get_decfun_coef(LNModel *aModel, int featIdxInt, int labelIdxInt) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> getLabels: aModel label: anInteger [
	"void get_labels(const struct model *model_, int* label);"
	^ self ffiCall: #(void get_labels(LNModel *aModel, int* anInteger) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> getNRClass: aModel [ 
	"int get_nr_class(const struct model *model_);"
	^ self ffiCall: #(int get_nr_class(LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> getNRFeature: aModel [ 
	"int get_nr_feature(const struct model *model_);"
	^ self ffiCall: #(int get_nr_feature(LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> loadModel: aString [ 
	"struct model *load_model(const char *model_file_name);"
	| model |
	model:= self ffiCall: #(LNModel *load_model(const char *aString) ) library: LibLinear.
	model autoRelease.
	^ model
]

{ #category : #'as yet unclassified' }
LibLinear class >> predict: aModel featureNode: aFeatureNode [ 
	"double predict(const struct model *model_, const struct feature_node *x)"
	^ self ffiCall: #( double predict(LNModel *aModel, LNFeatureNode  *aFeatureNode) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> predictProbability: aModel featureNode: aFeatureNode probEstimates: aDouble [
	"double predict_probability(const struct model *model_, const struct feature_node *x, double* prob_estimates);"
	^ self ffiCall: #( double predict_probability(LNModel *aModel, LNFeatureNode  *aFeatureNode, double* aDouble) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> predictValues: aModel featureNode: aFeatureNode decValues: aDouble [
	"double predict_values(const struct model *model_, const struct feature_node *x, double* dec_values);"
	^ self ffiCall: #( double predict_values(LNModel *aModel, LNFeatureNode  *aFeatureNode, double* aDouble) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> saveModel: aModel filename: aString [ 
	"int save_model(const char *model_file_name, const struct model *model_);"
	^ self ffiCall: #(int save_model(const char *aString, LNModel *aModel) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> set_print_string_function: aPointerToAFunction [ 
	"
	I think this is not supported by UFFI
	void set_print_string_function(void (*print_func) (const char*));"
	^ self ffiCall: #(void set_print_string_function(void (*aPointerToAFunction) (const char*)) ) library: LibLinear
]

{ #category : #'as yet unclassified' }
LibLinear class >> train: aProblem parameter: aParameter [ 
	"struct model* train(const struct problem *prob, const struct parameter *param);"
	^ self ffiCall: #( LNModel* train(LNProblem *aProblem, LNParameter *aParameter) ) library: LibLinear
]

{ #category : #'accessing platform' }
LibLinear >> macModuleName [
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	#(
		'/usr/lib/i386-linux-gnu/liblinear.so.3' 
		'/usr/lib32/liblinear.so.3' 
		'/usr/lib/liblinear.so.3'
		'liblinear.so.3' ) 
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate liblinear.so.3 library. Please check that it is installed on your system.'
]

{ #category : #'accessing platform' }
LibLinear >> unixModuleName [
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	#(
		'/usr/lib/i386-linux-gnu/liblinear.so.3' 
		'/usr/lib32/liblinear.so.3' 
		'/usr/lib/liblinear.so.3'
		'liblinear.so.3' ) 
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate liblinear.so.3 library. Please check that it is installed on your system.'
]

{ #category : #'accessing platform' }
LibLinear >> win32ModuleName [ 
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	#( 'liblinear.dll' ) 
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate liblinear.dll library. Please check that it is installed on your system.'
]
