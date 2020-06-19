Class {
	#name : #MlConfusionMatrix,
	#superclass : #Object,
	#instVars : [
		'rows',
		'columns'
	],
	#category : #'MlSt-Metrics'
}

{ #category : #performances }
MlConfusionMatrix >> accuracy [
	"Accuracy = TP+TN/TP+FP+FN+TN"

	^ (self sumDiag/ self sumAll) asFloat.
	
	
]

{ #category : #accessing }
MlConfusionMatrix >> at: aRowIndex [
	^ self rows at: aRowIndex ifAbsent:[^0].
	
]

{ #category : #accessing }
MlConfusionMatrix >> at: aRowIndex at: aColumnIndex [
	^ (self rows at: aRowIndex ifAbsent:[^0]) at:aColumnIndex ifAbsent:[^0]
	
]

{ #category : #accessing }
MlConfusionMatrix >> at: aRowIndex at: aColumnIndex incrementBy: aNumber [
	| cVal |
	self columns add:aColumnIndex.
	cVal := (self rows at: aRowIndex ifAbsentPut:[SmallDictionary new]) at:aColumnIndex ifAbsentPut:[0].
	(self rows at: aRowIndex) at:aColumnIndex put: aNumber + cVal 
	
]

{ #category : #accessing }
MlConfusionMatrix >> at: aRowIndex at: aColumnIndex put: aNumber [
	self columns add:aColumnIndex.
	^ (self rows at: aRowIndex ifAbsentPut:[SmallDictionary new]) at:aColumnIndex ifAbsentPut:[aNumber]
	
]

{ #category : #accessing }
MlConfusionMatrix >> columns [
	^ columns ifNil:[columns := Set new]
]

{ #category : #performances }
MlConfusionMatrix >> f1score: aClass [
	"F1 Score is the weighted average of Precision and Recall."
	| p_r |
	p_r := ((self precision: aClass) + (self recall:aClass)).
	^ (p_r = 0 ifTrue:[0.0] ifFalse:[(2 * (self precision: aClass) * (self recall:aClass)) / p_r]) asFloat 
	

	
]

{ #category : #accessing }
MlConfusionMatrix >> labels [
	^ self columns union: self rows keys
]

{ #category : #performances }
MlConfusionMatrix >> performanceReport [
	| pr |
	pr := (self labels collect:[:label|
					label->({ (#precision->(self precision:label)). 
								(#recall->(self recall:label)). 
								(#f1score->(self f1score:label))} as:SmallDictionary)]) as: SmallDictionary.
	pr at:#accuracy put:self accuracy.
	^ pr	
]

{ #category : #performances }
MlConfusionMatrix >> precision: aClass [
	"Precision = TP/TP+FP"
	| tp tp_fp |
	tp := self at:aClass at:aClass.
	tp_fp := self sumColumn: aClass.
	^ (tp_fp = 0 ifTrue:[0.0] ifFalse:[tp / tp_fp]) asFloat
]

{ #category : #performances }
MlConfusionMatrix >> recall: aClass [
	"Recall = TP/TP+FN"
	| tp tn_fn |
	tp := self at:aClass at:aClass.
	tn_fn := self sumRow: aClass.
	^ (tn_fn = 0 ifTrue:[0.0] ifFalse:[tp / tn_fn]) asFloat
	
]

{ #category : #accessing }
MlConfusionMatrix >> rows [ 
	^ rows ifNil:[rows := SmallDictionary new]
]

{ #category : #accessing }
MlConfusionMatrix >> sumAll [
	^self rows values inject:0 into:[:sum :each|
		each values inject:sum into:[:sum2 :v| sum2 + v]]
	

]

{ #category : #accessing }
MlConfusionMatrix >> sumColumn: aColIndex [
	^ self rows values inject: 0 into:[:sum :each | sum + (each at:aColIndex ifAbsent:[0])].
	

]

{ #category : #accessing }
MlConfusionMatrix >> sumColumns [
	^ (self columns collect:[:aColIndex| aColIndex -> (self rows values inject: 0 into:[:sum :each | sum + (each at:aColIndex ifAbsent:[0])])]) as:SmallDictionary .
	

]

{ #category : #accessing }
MlConfusionMatrix >> sumDiag [
	| tp_tn |
	tp_tn := 0.
	self rows keysDo:[:i| tp_tn := tp_tn + (self at:i at:i)].
	^ tp_tn
	

]

{ #category : #accessing }
MlConfusionMatrix >> sumRow: aRowIndex [
	^ (self rows at: aRowIndex) values inject: 0 into:[:sum :each | sum + each].
	

]

{ #category : #accessing }
MlConfusionMatrix >> sumRows [ 
	^ self rows collect:[ :eachRow| eachRow values inject: 0 into:[:sum :each | sum + each]].
	

]
