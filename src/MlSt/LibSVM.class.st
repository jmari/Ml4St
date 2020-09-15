Class {
	#name : #LibSVM,
	#superclass : #FFILibrary,
	#category : #'MlSt-FFI-LibSVM-Uffi'
}

{ #category : #'ffi calls' }
LibSVM class >> checkParameter: aParameter from: aProblem [ 
	
	^ self ffiCall: #(const char *svm_check_parameter(SVMProblem *aProblem, SVMParameter *aParameter) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> checkProbabilityModel: aModel [ 

	^ self ffiCall: #(int svm_check_probability_model(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> crossValidation: aProblem parameter: aParameter nrFolds: anInteger target: aDouble [

	^ self ffiCall: #( void svm_cross_validation(SVMProblem *aProblem, SVMParameter *aParameter, int anInteger, double *aDouble) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> destroyParameter: aParameter [ 
	
	^ self ffiCall: #(void svm_destroy_param(SVMParameter *aParameter) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> freeAndDestroyModel: aModel [ 
	"void free_and_destroy_model(struct model **model_ptr_ptr);"
	^ self ffiCall: #(void svm_free_and_destroy_model(SVMModel **aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> freeModelContent: aModel [ 
	
	^ self ffiCall: #(void svm_free_model_content(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getLabels: aModel label: anInteger [
	
	^ self ffiCall: #(void svm_get_labels(SVMModel *aModel, int* anInteger) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getNRClass: aModel [ 
	
	^ self ffiCall: #(int svm_get_nr_class(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getNRSV: aModel [ 

	^ self ffiCall: #(int svm_get_nr_sv(LNModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getSVIndices: aModel [
	
	^ self ffiCall: #(void svm_get_sv_indices(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getSVMType: aModel [ 
	
	^ self ffiCall: #(int svm_get_svm_type(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> getSVRProbability: aModel [ 
	
	^ self ffiCall: #(double svm_get_svr_probability(SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> loadModel: aString [ 
	| model |
	model:= self ffiCall: #(SVMModel *svm_load_model(const char *aString) ) library: LibSVM.
	model autoRelease.
	^ model
]

{ #category : #'ffi calls' }
LibSVM class >> predict: aModel featureNode: aFeatureNode [ 
	
	^ self ffiCall: #( double svm_predict(SVMModel *aModel, SVMFeatureNode  *aFeatureNode) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> predictProbability: aModel featureNode: aFeatureNode probEstimates: aDouble [
	"double predict_probability(const struct model *model_, const struct feature_node *x, double* prob_estimates);"
	^ self ffiCall: #( double svm_predict_probability(SVMModel *aModel, SVMFeatureNode  *aFeatureNode, double* aDouble) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> predictValues: aModel featureNode: aFeatureNode decValues: aDouble [

	^ self ffiCall: #( double svm_predict_values(SVMModel *aModel, SVMFeatureNode  *aFeatureNode, double* aDouble) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> saveModel: aModel filename: aString [ 

	^ self ffiCall: #(int svm_save_model(const char *aString, SVMModel *aModel) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> set_print_string_function: aPointerToAFunction [ 
	"
	I think this is not supported by UFFI
	void set_print_string_function(void (*print_func) (const char*));"
	^ self ffiCall: #(void svn_set_print_string_function(void (*aPointerToAFunction) (const char*)) ) library: LibSVM
]

{ #category : #'ffi calls' }
LibSVM class >> train: aProblem parameter: aParameter [ 
	
	^ self ffiCall: #( SVMModel* svm_train(SVMProblem *aProblem, SVMParameter *aParameter) ) library: LibSVM
]

{ #category : #'accessing platform' }
LibSVM >> macModuleName [
	^ self unixModuleName 
]

{ #category : #'accessing platform' }
LibSVM >> unixModuleName [
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	{  
		'/usr/lib/i386-linux-gnu/libsvm.so.', self version. 
		'/usr/lib32/libsvm.so.', self version. 
		'/usr/lib/libsvm.so.', self version.
		'libsvm.so.', self version. }
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate libsvm.so.', self version,' library Please check that it is installed on your system.'
]

{ #category : #versions }
LibSVM >> version [ 
	^ '2'
]

{ #category : #'accessing platform' }
LibSVM >> win32ModuleName [ 
	"On different flavors of Linux, the path to the library may differ, 
	depending on the distro and whether the system is 32- or 64-bit."
	#( 'libsvm.dll' ) 
	do: [ :path | 
		path asFileReference exists ifTrue: [ ^ path ] ].
	self error: 'Cannot locate libsvm.dll library. Please check that it is installed on your system.'
]
