Class {
	#name : #MlFromCSVTest,
	#superclass : #TestCase,
	#category : #'MlSt-Test'
}

{ #category : #tests }
MlFromCSVTest >> testLoadCSV [
	| fs titanic work neo headers imputer iTitanic emptyStringValues nilValues pclassXfare |
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
	"first we will assing nil values on fare using the mode depending on the Pclass"
	pclassXfare := titanic groupBy:'Pclass'->'Fare' aggregate:[:k :v| v mode].

	(titanic at:{((titanic at:{_@_. 'Fare'}) = nil). 'Fare'})<- 
	(titanic at:{((titanic at:{_@_. 'Fare'}) = nil). 'Pclass'})  transform:[:v| 
														pclassXfare at: {((pclassXfare at:{_@_. 'Pclass'}) = v). 'Fare'}].	

	"we will change nil values by the mode"
	imputer := MlModeImputer new missingValue: nil.	
	imputer fit: titanic.
	iTitanic := imputer transform.

	(iTitanic at:{_@_. {1@3. 6@8}}) <- (iTitanic at:{_@_. {1@3. 6@8}}) transform:[:v| v asInteger].
	(iTitanic at:{_@_. -3})<- (iTitanic at:{_@_. -3}) transform:[:v| v asNumber ].
	(iTitanic at:{_@_. {1@3. 6@8}}) describe.
	
		
	self assert: (iTitanic anySatisfy:[:e | e isNil]) not. 
	
	

]
