Class {
	#name : #MlFromCSVTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlFromCSVTest >> testLoadCSV [
	| fs titanic work neo headers imputer iTitanic nilValues emptyStringValues |
	"load the file in a MlArray"
	work := FileSystem disk workingDirectory. 
	fs := (work / 'Titanic_train.csv') readStream.
	neo := (NeoCSVReader on: fs).
	"we first load the column labels and then the data"
	headers := neo readHeader.
	titanic := MlArray from: neo upToEnd.
	titanic setLabels: headers onAxis: 1. 
	nilValues := titanic count:[:v | v isNil].
	titanic inspect. 
	emptyStringValues := titanic count:[:v | v =''].
	emptyStringValues inspect. 
	"we will change nil values by the mode"
	imputer := MlModeImputer new missingValue: nil.
	
	imputer fit: titanic.
	iTitanic := imputer transform.
	"imputers do not create a new buffer, they use replace:  by: "
	"convert column types to integer and float"
	(iTitanic at:{_@_. {1@3. 6@8}}) <- (iTitanic at:{_@_. {1@3. 6@8}}) transform:[:v| v asInteger].
	(iTitanic at:{_@_. -3})<- (iTitanic at:{_@_. -3}) transform:[:v| v asNumber ].
	(iTitanic at:{_@_. {1@3. 6@8}}) describe.
	
	
	
	self assert: (iTitanic anySatisfy:[:e | e isNil]) not. 
	
	
 	
]
