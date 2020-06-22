Class {
	#name : #MlFromCSVTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlFromCSVTest >> testLoadCSV [
	| fs titanic work neo headers imputer imputed |
	work := FileSystem disk workingDirectory. 
	fs := (work / 'Titanic_train.csv') readStream.
	neo := (NeoCSVReader on: fs).
	headers := neo readHeader.
	titanic := MlArray from: neo upToEnd.
	titanic setLabels: headers onAxis: 1. 
	imputer := MlModeImputer new missingValue: nil.
	
	imputer fit: titanic.
	imputed := imputer transform.
	"imputers do not create a new buffer, they use replace:  by: "
	"convert column types to integer and float"
	(imputed at:{_@_. {1@3. 6@8}}) <- (imputed at:{_@_. {1@3. 6@8}}) transform:[:v| v asInteger].
	(imputed at:{_@_. -3})<- (imputed at:{_@_. -3}) transform:[:v| v asNumber ].
	imputed inspect.
	(imputed at:{_@_. {1@3. 6@8}}) describe inspect.
	self assert: (imputed anySatisfy:[:e | e isNil]) not. 
	
	
 	
]
