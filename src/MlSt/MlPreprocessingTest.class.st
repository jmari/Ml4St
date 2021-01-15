Class {
	#name : #MlPreprocessingTest,
	#superclass : #TestCase,
	#category : #'MlSt-Core-Test'
}

{ #category : #tests }
MlPreprocessingTest >> testConstantImputer [
	|a imputer |
	a := MlArray  from: {{{1. 4. 7. Float nan}. {2. Float nan. 8. 11}. {Float nan. 6. 9. 12}}} order:#F.
	imputer := MlConstantImputer new.
	imputer constant:{ 1. 2. 3. 4}.
	imputer fit:a.
	imputer transform.
"[[	[   1,   4,   7,   4]	
	[   2,   2,   8,  11]	
	[   1,   6,   9,  12]	]]"
	self assert: (a anySatisfy:[:e | e isNaN]) not. 
]

{ #category : #tests }
MlPreprocessingTest >> testMaxAbsScaler [
	|a scaler aScaled |
	a := MlArray  from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}}} order:#F dType:#Float.
	scaler := MlMaxAbsScaler new.
	scaler fit:a.
	aScaled := scaler transform.
"[[	[  0.25,  0.4,  0.5]	
	[  1.0,  1.0,  1.0]	]]"
	self assert: ( scaler inverseTransform:aScaled) equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testMeanImputer [
	|a imputed imputer |
	a := MlArray  from: {{{1. 4. 7. Float nan}. {2. Float nan. 8. 11}. {Float nan. 6. 9. 12}}} order:#F.
	imputer := MlMeanImputer new.
	imputer fit:a.
	imputed := imputer transform.
"[[	[   1,   4,   7,(23/2)]	
	[   2,   5,   8,  11]	
	[(3/2),   6,   9,  12]	]]"
	self assert: (imputed anySatisfy:[:e | e isNaN]) not. 
	self assert: (imputed anySatisfy:[:e | e isNaN]) not. 
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testMinMaxScaler [
	|a scaler aScaled |
	a := MlArray  from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}. {13.0. 8.0. 9.0}}} order:#F dType:#Float.
	scaler := MlMinMaxScaler new.
	scaler fit:a.
	aScaled := scaler transform.
"[[	[  0.0,  0.0,  0.0]	
	[  0.25,  0.5,  0.5]	
	[  1.0,  1.0,  1.0]	]]"

	self assert: ( scaler inverseTransform:aScaled) equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testModeImputer [
	|a imputed imputer |
	a := MlArray  from: {{{1. 4. 7. Float nan}. {2. Float nan. 8. 11}. {Float nan. 6. 9. 12}}} order:#F.
	imputer := MlModeImputer new.
	imputer fit:a.
	imputed := imputer transform.
"[[	[   1,   4,   7,  11]	
	[   2,   6,   8,  11]	
	[   1,   6,   9,  12]	]]"
	self assert: (a anySatisfy:[:e | e isNaN]) not. 
	
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testNormalizer [
	|a scaler aScaled |
	a := MlArray  from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}. {7.0. 8.0. 9.0}}} order:#F dType:#Float.
	scaler := MlNormalizer new.
	scaler fit:a.
	aScaled := scaler transform.
"[[	[  0.05923488777590923,  0.11846977555181847,  0.1777046633277277]	
	[  0.23693955110363693,  0....954614,  0.3554093266554554]	
	[  0.4146442144313646,  0.47387910220727386,  0.533113989983183]	]]"
	self assert: ( scaler inverseTransform:aScaled) equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testOneHotEncoder [
	|a encoder encoded ien |
	a := MlArray  from: {{{'A'. 'A'. 'B'. 'D'}. {'C'. 'B'. 'C'.'E'}. {'A'. 'B'. 'C'. 'M'}}} order:#F.
	encoder := MlOneHotEncoder new.
	encoder fit:a.
	encoded := encoder transform.
	ien := ( encoder inverseTransform: encoded).
"[[	[	[  1.0,  0.0]	,	[  1.0,  0.0]	,	[  1.0,  0.0]	,	[  1.0,  0.0,  0.0]	]	
	[	[  0.0,  1.0]	,	[  0...[  0.0,  1.0,  0.0]	]	
	[	[  1.0,  0.0]	,	[  0.0,  1.0]	,	[  0.0,  1.0]	,	[  0.0,  0.0,  1.0]	]	]]"
	
	self assert: ien  equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testOrdinalEncoder [
	|a encoder encoded ien |
	a := MlArray  from: {{{'A'. 'A'. 'B'. 'D'}. {'C'. 'B'. 'C'.'E'}. {'A'. 'B'. 'C'. 'M'}}} order:#F.
	encoder := MlOrdinalEncoder new.
	encoder fit:a.
	encoded := encoder transform.
	ien := ( encoder inverseTransform: encoded).
"[[	[  1,  1,  1,  1]	
	[  2,  2,  2,  2]	
	[  1,  2,  2,  3]	]]"
	self assert: ien  equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testPipingTransformers [
	| a  r  imp esc  o b |
	a := MlArray  from: {{{1. 4. 7. Float nan}. {2. Float nan. 8. 11}. {Float nan. 6. 9. 12}}} order:#F.
	b := MlArray  from: {{{1. 4. 7. 4}. {2. 2. 8. 11}. {1. 6. 9. 12}}} order:#F.
	imp := MlConstantImputer new.
	imp constant:{ 1. 2. 3. 4.}.
	
	esc := MlMinMaxScaler new.
	
	r := a >> imp >> esc.
	o := r << esc.
"[[	[  0.0,  0.5,  0.0,  0.0]	
	[  1.0,  0.0,  0.5,  0.875]	
	[  0.0,  1.0,  1.0,  1.0]	]]"
	self assert: (r allSatisfy: [ :e| e >=0.0 & e <=1.0 ]).
	self assert: o  equals:b
]

{ #category : #tests }
MlPreprocessingTest >> testPowerTransformer [
	|a scaler aScaled |
	a := MlArray  from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}. {7.0. 8.0. 9.0}}} order:#F dType:#Float.
	scaler := MlRobustScaler new.
	scaler fit:a.
	aScaled := scaler transform.
"[[	[ -1.0, -1.0, -1.0]	
	[  0.0,  0.0,  0.0]	
	[  1.0,  1.0,  1.0]	]]"

	self assert: ( scaler inverseTransform:aScaled) equals:a
	 

	
]

{ #category : #tests }
MlPreprocessingTest >> testStandardScaler [
	|a scaler aScaled |
	a := MlArray  from: {{{1.0. 2.0. 3.0}. {4.0. 5.0. 6.0}. {7.0. 8.0. 9.0}}} order:#F dType:#Float.
	scaler := MlStandardScaler new.
	scaler fit:a.
	aScaled := scaler transform.
"[[	[ -1.0, -0.6666666865348816, -0.3333333432674408]	
	[ -0.3333333432674408,  0.0,  0.3333333432674408]	
	[  0.3333333432674408,  0.6666666865348816,  1.0]	]]"
	self assert: ( scaler inverseTransform:aScaled) equals:a
	 

	
]
