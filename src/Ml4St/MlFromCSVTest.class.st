Class {
	#name : #MlFromCSVTest,
	#superclass : #TestCase,
	#category : #'Ml4St-Test-Core'
}

{ #category : #tests }
MlFromCSVTest >> testLoadCSV [
	| fs titanic work neo headers imputer iTitanic emptyStringValues nilValues pclassXfare t |
	"load the file in a MlArray"
	work := FileSystem disk workingDirectory. 
	fs := (work / 'Titanic_train.csv') readStream.
	neo := (NeoCSVReader on: fs).
	"we first load the column labels and then the data"
	headers := neo readHeader.
	titanic := MlArray from: neo upToEnd.
	titanic setLabels: headers onAxis: 1. 
	nilValues := titanic count:[:v | v isNil].
	self assert: (titanic anySatisfy:[:e | e isNil]).
	emptyStringValues := titanic count:[:v | v =''].
	"FARE: first we will assing nil values on fare using the mode depending on the Pclass"
	pclassXfare := titanic groupBy:'Pclass'->'Fare' aggregate:[:k :v| v mode].

	(titanic at:{((titanic at:{_. 'Fare'}) = nil). 'Fare'})<- 
	(titanic at:{((titanic at:{_. 'Fare'}) = nil). 'Pclass'})  transform:[:v| 
														pclassXfare at: {((pclassXfare at:{_. 'Pclass'}) = v). 'Fare'}].	
	self assert: ((titanic  at:{_. 'Fare'}) anySatisfy:[:e | e isNil]) not. 
	
	"CABIN assign NO to all nil values in column Cabin "
	(titanic at:{((titanic at:{_. 'Cabin'}) = nil). 'Cabin'})  <- 'NO'. 
	self assert: ((titanic  at:{_. 'Cabin'}) anySatisfy:[:e | e isNil]) not. 
	self assert: ((titanic  at:{_. 'Cabin'}) anySatisfy:[:e | e = 'NO']). 
	
	"[	[62,1,1,Icard, Miss. Amelie,female,38,0,0,113572,80,B28,nil]	
	   [830,1,1,Stone, Mrs. George Nelson (Martha Evelyn),female,62,0,0,113572,80,B28,nil]	]"
	t:=titanic at:{((titanic at:{_. 'Embarked'}) = nil). _}.
	t:= titanic at:{((titanic at:{_. 'Ticket'}) eval:[:v| v ifNil:[false] ifNotNil:[v matchesRegex: '113.*']] ). _}.   
	(titanic at:{((titanic at:{_. 'Embarked'}) = nil). 'Embarked'})<-'S'.

	"changes nil values by the mode the other columns"
	imputer := MlModeImputer new missingValue: nil.	
	imputer fit: titanic.
	iTitanic := imputer transform.
	"converts numerical columns to integer or number"
	(iTitanic at:{_. {1@3. 6@8}}) <- (iTitanic at:{_. {1@3. 6@8}}) transform:[:v| v asInteger].
	(iTitanic at:{_. -3})<- (iTitanic at:{_. -3}) transform:[:v| v asNumber ].
	(iTitanic at:{_. {1@3. 6@8}}) describe inspect.
	iTitanic summary inspect.	
	self assert: (iTitanic anySatisfy:[:e | e isNil]) not. 
	
	

]
