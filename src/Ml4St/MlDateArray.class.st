Class {
	#name : #MlDateArray,
	#superclass : #MlArray,
	#category : #'Ml4St-Core'
}

{ #category : #'instance creation' }
MlDateArray class >> from: aDate to: toDate by: duration [
	| numberOfTicks d instance |
	numberOfTicks := (toDate - aDate) / duration.

	instance :=self from:(
		(1 to: numberOfTicks) collect:[ :i |			
			d:= (aDate + (duration * i)) asDateAndTime.
			{ d. d asDate. d  year. d monthName. d month. d dayOfMonth. d asWeek index. d dayOfWeek. d dayOfWeekName }] ).
	instance labelWith:#(#dateAndTime #date #year #monthName #month #dayOfMonth #week #dayOfWeek #dayOfWeekName) axis: 1.
	^ instance
]
