Class {
	#name : #MlFromCSVTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlFromCSVTest >> testLoadCSV [
	| fs titanic work neo headers imputer |
	work := FileSystem disk workingDirectory. 
	fs := (work / 'Titanic_train.csv') readStream.
	neo := (NeoCSVReader on: fs).
	headers := neo readHeader.
	titanic := MlArray from: neo upToEnd.
	titanic setLabels: headers onAxis: 1. 
	imputer := MlModeImputer new missingValue: nil.
	
	imputer fit: titanic.
	imputer transform.
	"imputers do not create a new buffer, they use replace:  by: "
	"convert column types to integer and float"
	(titanic at:{_@_. {1@3. 6@8}}) dTypeAs:[:v| v asInteger].
	(titanic at:{_@_. -3}) dTypeAs:[:v| v asNumber ].
	titanic inspect.
	self assert: (titanic anySatisfy:[:e | e isNil]) not. 
	
	
 	
]
