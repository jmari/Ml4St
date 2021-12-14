"
MlElementRepeatedVector se crea a partir de un array de elementos, indicando las veces que queremos repetir cada elemento. La clase repetirá virtualmente los elementos cuando accedemos con ${method:MlElementRepeatedVector>>at:}$. 
Se emplea para difundir el array en columnas en orden #F y en filas en orden #C
${example:MlElementRepeatedVector class>>gtInitializeAndTest}$

"
Class {
	#name : #MlElementRepeatedVector,
	#superclass : #MlVirtualSizeVector,
	#type : #variable,
	#category : #'Ml4St-Core'
}

{ #category : #gtExamples }
MlElementRepeatedVector class >> gtInitializeAndTest [
	<gtExample>
	| a |

	a := MlElementRepeatedVector newFrom: #(2 5) timesRepeat:5.
	
	"it is only storing #(2 5) but it allows you to access to the position: 3 4 5 6 7 8 9 10 returning the same element"
	self assert: a equals:#(2 2 2 2 2 5 5 5 5 5).
	self assert: a size equals:10.
]

{ #category : #accessing }
MlElementRepeatedVector >> at: anInteger [ 
	| pos |
	pos := ((anInteger -1/ timesRepeat ) asInteger).

	^ self buffer at: (pos \\ self size) +1
]
