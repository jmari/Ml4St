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
	titanic inspect.
	imputer := MlModeImputer new missingValue: nil.
	
	imputer fit: titanic.
	
	imputed := imputer transform.
	self assert: (imputed anySatisfy:[:e | e isNil]) not. 
 	
]
