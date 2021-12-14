"
MlArrayRepeatedVector se crea a partir de un array de elementos, indicando las veces que queremos repetir el array entero. La clase repetirá virtualmente los elementos cuando accedemos con ${method:MlArrayRepeatedVector>>at:}$. 
Se emplea para realizar difundir el array en filas en orden #F y en columnas en orden #C
${example:MlArrayRepeatedVector class>>gtInitializeAndTest}$
"
Class {
	#name : #MlArrayRepeatedVector,
	#superclass : #MlVirtualSizeVector,
	#type : #variable,
	#category : #'Ml4St-Core'
}

{ #category : #gtExamples }
MlArrayRepeatedVector class >> gtInitializeAndTest [
	<gtExample>
	| a |

	a := MlArrayRepeatedVector newFrom: #(2 5) timesRepeat:5.
	
	"it is only storing #(2 5) but it allows you to access to the position: 3 4 5 6 7 8 9 10 returning the same element"
	self assert: a equals:#(2 5 2 5 2 5 2 5 2 5).
	self assert: a size equals:10.
	
	
	
]

{ #category : #accessing }
MlArrayRepeatedVector >> at: anInteger [ 
	anInteger > self size ifTrue:[^ SubscriptOutOfBounds signal: anInteger].
	^ self buffer at: ((anInteger -1) \\ (self buffer size ) ) +1
]
