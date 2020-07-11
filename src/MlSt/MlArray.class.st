"
!MlArray
MlArrays son arrays multidimensionales basados en numpy arrays diseñados para la manipulación y analisis de conjuntos de datos para el aprendizaje de máquina.  
!!Creación y estructura interna de MLArrays.
MlArrays es un objeto que implementa arrays multidimensionales sobre un array lineal definido en la clase ${class:MlNonContinuousVector}$  
MlArray puede crearse de numerosas maneras, por ejemplo, partiendo de una colección existente:

${example: MlArray class>>gtInstanceOfMlArray}$


mediante el método de clase #from:aCollection
${example: MlArray class>>gtInstanceFromClassMessageFrom}$

o bien especificando la forma del MlArray con #new: shape. Podemos comprobar la forma y orden en memoria del MlArray mediante #shape y #order. El array puede ordenarse según el orden Fortran o C.  Al contrario que en numpy arrays, el array se organiza en memoria en orden Fortran.

${example: MlArray class>>gtInstanceNewShape}$

Los elementos se almacenan en una instancia de la clase ${class:MlNonContinuousVector}$. Este objeto es un array continuo en memoria, en el que podemos aplicar saltos a la hora de acceder a sus elementos, de manera que si indicamos que queremos saltarnos, por ejemplo, los elementos 3,4,5, al utilizar el método #at: 3 , la posición 3, nos devolverá el 6 elemento.

Esta facilidad permite la operación de Slice del MlArray multidimensional, cálculando los fragmentos del array que deben saltarse a la hora de acceder a una determinada posición.
${example: MlArray class>>gtInternalStructure}$

${class:MlNonContinuousVector}$  almacena los elementos en orden #C filas->columnas o #F contenido está ordenado por columnas->filas (Estilo Fortran). Para saber el número de dimensiones del array disponemos del método nDim.
${example:MlArray class>>gtExampleInternalArray |noCode|previewShow=#gtItemsFor:|previewHeight=250}$

Cuando creamos un MlArray a partir de una colección de Smalltalk, el tipo de dato de los elementos, es reconocido automáticamente a partir de los elementos de la primera fila y primera columna. Si se encuentran clases diferentes en estas posiciones, el tipo elegido será Object.
${example: MlArray class>>gtInternalOrder}$
Dependiendo de la clase encontrada, el arreglo  interno empleada será el  que mejor se ajuste a la clase de los elementos. La estructura interna del ${class:MlNonContinuousVector}$ puede ser:
 
FloatArray, si el tipo es #Float.
IntegerArray, si el tipo es #Integer
WordArray, si el tipo es #Word 
DoubleWordArray, si el tipo es #DoubleWord 
ByteArray, si el tipo es #Byte
Array, si el tipo es diferente entre columnas/filas.

El método ${method:MlArray>>dType}$ nos muestra el tipo de dato de los elementos del array.
El método  ${method:MlArray>>arrayType}$ nos devuelve el tipo de array elegido para almacenar los elementos.
Tenemos varios metodos para acceder al número de elementos, el número de bytes que ocupa el array y la medida de los elementos en bytes.

${example: MlArray class>>gtInternalDataType}$

El tipo de dato se puede especificar en el momento de la creacón del ==MlArray==
${example: MlArray class>>gtSetDataType}$

!!Reorganizando MlArrays
Es posible reorganizar un MlArray siempre y cuando la nueva organización pueda dar cabida al mismo número de elementos.

${example: MlArray class>>gtReshapeArrays}$

!!Operaciones
Un MlArray puede realizar  un gran número de operaciones matemáticas. Estas operaciones se ejecutan elemento a elemento.El resultado de la operación es una nueva instancia de MlArray.
Un MlArray puede operarse con otro con distinta forma, extendiendo el número de filas/columnas.
La clase ${class:MlArrayRepeatedVector}$ repite virtualmente todo el array n veces, sin necesidad de consumir  más memoria con la sobrecarga del método  ${method:MlArrayRepeatedVector>>at:}$
La clase ${class:MlElementRepeatedVector}$ repite virtualmente los elementos del array n veces, sin necesidad de consumir  más memoria con la sobrecarga del método at: ${method:MlElementRepeatedVector>>at:}$

${example: MlArray class>>gtArithmeticalOperations}$
Las operaciones matemáticas disponibles son:
${method:MlArray>>&}$. Ejecuta una and lógica entre dos arrays.
${method:MlArray>>\|}$. Ejecuta una or lógica entre dos arrays.
${method:MlArray>>*}$. Ejecuta el producto entre elementos de dos arrays.
${method:MlArray>>*\=}$. Ejecuta el producto entre elementos de dos arrays y asigna el resultado al primero si no ha sido difundido, en ese caso lo asigna al segundo.
${method:MlArray>>/}$. Ejecuta la división entre elementos de dos arrays.
${method:MlArray>>/\=}$. Ejecuta la división entre elementos de dos arrays y asigna el resultado al primero si no ha sido difundido, en ese caso lo asigna al segundo.
${method:MlArray>>\\\\}$. Ejecuta el producto entre elementos de dos arrays.
${method:MlArray>>\\\\\=}$. Ejecuta el producto entre elementos de dos arrays y asigna el resultado al primero si no ha sido difundido, en ese caso lo asigna al segundo.
${method:MlArray>>+}$. Ejecuta la suma entre elementos de dos arrays.
${method:MlArray>>+\=}$. Ejecuta la suma entre elementos de dos arrays y asigna el resultado al primero si no ha sido difundido, en ese caso lo asigna al segundo.
${method:MlArray>>-}$. Ejecuta la suma entre elementos de dos arrays.
${method:MlArray>>-\=}$. Ejecuta la suma entre elementos de dos arrays y asigna el resultado al primero si no ha sido difundido, en ese caso lo asigna al segundo.
${method:MlArray>>differentiate:times:}$. Devuelve la matriz con el diferencial entre el elemento n - step y n, aplicada t veces. el primer elemento de cada columna devuelta será Float nan, al no tener un elemento anterior, si nTimes = k los k-primeros  elementos de cada columna devuelta serán Float nan.
${example: MlArray class>>gtDifferentiateTimes}$

!!Indexado en MlArrays
Si el lector está familiarizado con los arrays de Smalltalk y con los Arrays de Numpy, encontrará el indexado de los MlArrays muy familiar. En un Array de una dimensión, el i-esimo valor (empezando desde 1) puede accederse  especificando el índice deseado.

[[[
x1d := MlArray from: {1. 2. 3. 4. 5.}.
x1d at:1.

]]]
Si recortamos el array de 1d, el objeto devuelto es un MlArray con un elemento
[[[
""if we slice the MlArray, it will return an MlArray of 1 element""

x1d at:{1}
]]]

se puede indicar un índice negativo -k, lo que significa que queremos acceder al  k-ésimo  elemento empezando por el final, siendo -1 el último de los elementos, -2 el penúltimo, y así en adelante. 

[[[
1 to: x1d size do:[ :i| Transcript show: (x1d at:(-1*i))]
]]]
Output: 54321

En un array multidimensional, puede accederse a los elementos usando una tupla de indice o con la sintaxis Smalltalk #at: at: at:, siendo el último eje indicado, el de las columnas y el anterior el de las filas.
[[[
x2d := MlArray from: {{1. 2. 3. 4. 5.}. {6. 7. 8. 9. 10. }}.
x2d at:1 at:1.

]]]
[[[

x2d at:{1. 1}

]]]
 
[[[
 1 to: x2d shape first do:[:i|
    1 to: x2d shape last do:[:j|
    Transcript cr;show: 'Element at:',i asString,' at:', j asString ,' = ', (x2d at:{i. j}) asString
    ]
]
]]]

recuerda que puedes usar indices negativos en todos los ejes para acceder a una posición
${example: MlArray class>>gtArrayIndexExample}$
${example:MlArray class>>gtArrayIndexExample |noCode|previewShow=#gtStringFor:|previewHeight=220}$
!!Recortando MlArrays
Para obtener subconjuntos de los MlArrays podemos recortar (slice) el array. La sintaxis del recorte emplea los siguientes símbolos especiales:
 _ selecciona todo el rango del eje, mismo significado que _@_.
 _@k selecciona desde el inicio hasta elelemento k-ésimo del eje.
 k@_ selecciona desde el element k-ésimo hasta el último elemento.
k@l  selecciona desde el element k-ésimo hasta el l-ésimo elemento. 
k@l@s  selecciona desde el element k-ésimo hasta el l-ésimo elemento separados por  s-pasos.
Un enteros negativos =  k  se sustituyen por la longitud del (eje + k + 1)
Los recortes pueden agruparse en arrays ordenados, {1@2. 5@6} seleccionarán los elementos 1, 2, 5 y 6.
Los recortes pueden indicarse como una lista de enteros {1. 3. 7. 9} seleccionarán los elementos 1, 3, 7, 9.

Empecemos por un array unidimensional.

${example: MlArray class>>gtSlicingExamples1D}$
A continuación un array  multidimensional.
${example: MlArray class>>gtSlicingExamples3D}$
!!Filtros en MlArrays
Los filtros son condiciones booleanas aplicables a un eje del MlArray para la selección de los elementos que cumplen la condición definida.
Empecemos por ver el resultado obtenido en un filtro, queremos obtener únicamente, las filas del array ==x2d== cuya columna 1 sea mayor o igual a 3.
[[[
	x2d := MlArray from: {  {1. 2. 3. 4. 5}. 
							{2. 3. 4. 5. 6}. 
							{3. 4. 5. 6. 7}.  
							{4. 5. 6. 7. 8}}.
	(x2d at:{_.1})>=3

]]]
Obtenemos un MlArray de booleanos con forma #(4 1) , con los valores { false false true true }.  Si aplicamos el filtro en el eje de las filas, al array original obtendremos el resultado buscado.
[[[
	x2d at:{((x2d at:{_.1})>=3). _}
]]]
El array devuelto tiene forma #(2 5) y contiene las filas 3 y 4 del array original. Si seleccionamos la solapa ==Print== veremos el resultado siguiente:
[	[  3,  4,  5,  6,  7]	
	 [  4,  5,  6,  7,  8]	]
	 
	 



"
Class {
	#name : #MlArray,
	#superclass : #Object,
	#instVars : [
		'internalArray',
		'shape',
		'order',
		'dType',
		'labelsDict',
		'maxElementsToPrint'
	],
	#classInstVars : [
		'shape',
		'plainCollection'
	],
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlArray class >> checkClassForAllElementsIn: aCollection [ 
	| firstClass |
	
	firstClass := aCollection first class.
	aCollection do:[:e| e class = firstClass ifFalse:[^false]].
	^ true
]

{ #category : #'instance creation' }
MlArray class >> detectTypeOf:aCollection [ 
	|col parent firstRowIsSameKind  firstCol firstColIsSameKind |
	aCollection isCollection not | aCollection isString ifTrue:[^Object].
	aCollection isEmpty ifTrue:[^Float].
	parent := col := aCollection.
	[ self isNotACollection: col first ] whileFalse:[
		parent := col.
		col := col first].
	firstRowIsSameKind := (self checkClassForAllElementsIn: col ).
	(parent = col) 
	ifTrue:[firstColIsSameKind := true]
	ifFalse:[
		firstCol := parent collect:[:e| e first].
		firstColIsSameKind := ((self checkClassForAllElementsIn: firstCol ) & (firstCol first species = col first species )) ].
	
	^(firstRowIsSameKind  &
	firstColIsSameKind)
	ifTrue:[col first species name]
	ifFalse:[Object name]
	


]

{ #category : #'instance creation' }
MlArray class >> from: aCollection [
	^ self from: aCollection order:#F dType: (self detectTypeOf:aCollection) .
]

{ #category : #'instance creation' }
MlArray class >> from: aCollection dType: dType [
	^ self from: aCollection order: #F dType: dType
]

{ #category : #'instance creation' }
MlArray class >> from: aCollection order: CorF [
	^ self from: aCollection order: CorF dType: (self detectTypeOf:aCollection)
]

{ #category : #'instance creation' }
MlArray class >> from: aCollectionOrObject order: CorF dType: dType [
	| shapeAndPlainCollection instance aCollection |
	aCollectionOrObject isMlArray ifTrue:[^aCollectionOrObject].
	aCollection := aCollectionOrObject.
	aCollection isCollection not | (aCollection isString) ifTrue:[ aCollection := { aCollection} ].
	aCollection isEmpty ifTrue:[ ^ self new:#()].
	shapeAndPlainCollection := self getShapeAndPlainCollectionOf: aCollection.
	instance := self new: (shapeAndPlainCollection at:1) order:CorF dType:dType.
	CorF = #C ifTrue:[self initializeInCStyle:instance 
									shape:(shapeAndPlainCollection at:1) 
									plainCollection:(shapeAndPlainCollection at:2)].
	CorF = #F ifTrue:[self initializeInFStyle:instance 
									shape:(shapeAndPlainCollection at:1)
									plainCollection:(shapeAndPlainCollection at:2)].

	^ instance
]

{ #category : #'as yet unclassified' }
MlArray class >> getRShapeAndPlainCollectionOf: aCollection level:l [

	(self isNotACollection:(aCollection at:1))
		ifTrue:[ plainCollection addAll: aCollection.
					shape at:l put: ((shape at:l ifAbsentPut:0) < aCollection size ifTrue:[aCollection size] ifFalse:[shape at:l]) ]
		ifFalse:[ 
			shape at:l put: ((shape at:l ifAbsentPut:0) < aCollection size ifTrue:[aCollection size] ifFalse:[shape at:l]).
			aCollection do:[:col|
				self getRShapeAndPlainCollectionOf: col level:( l+1)]]

]

{ #category : #'as yet unclassified' }
MlArray class >> getShapeAndPlainCollectionOf: aCollection [ 
	|  |
	shape := OrderedDictionary new.
	plainCollection := OrderedCollection new.
	self getRShapeAndPlainCollectionOf: aCollection level:1.
	^ Array with: shape values with: plainCollection.
	
]

{ #category : #gtExamples }
MlArray class >> gtArithmeticalOperations [
	<gtExample>
	| a b c |
	a:= MlArray from: {{1.1. 2.2. 3.3}. {4.4. 5.5. 6.6}}.
	b := MlArray new:#(3) withAll:2.0.
	b at:2 put: 3.
	" b is broadcasted"
	c := a * b.
	"{{1.1. 2.2. 3.3}.           {{2.0. 3.0. 2.0}.
	 {4.4. 5.5. 6.6}}      X      {2.0. 3.0. 2.0}}"

	self assert: c shape equals:#(2 3).
	"c is not modified, result is loaded in a new instance"
	c - a.
	self assert: c equals: a * b.
	" -= will change c"
	c -=a.
	self assert: c equals: ((a * b) - a).
	
	
]

{ #category : #gtExamples }
MlArray class >> gtArrayIndexExample [
	<gtExample>
	|x2d a |
	x2d := MlArray from: {{1. 2. 3. 4. 5.}. {6. 7. 8. 9. 10. }}.
	a:= String streamContents:[:aStream|
	1 to: x2d shape first do:[:i|
    	1 to: x2d shape last do:[:j|
    	aStream print: ('Element at:',(-1*i) asString,' at:', (-1*j) asString ,' = ', (x2d at:{-1*i. -1*j}) asString);cr.
    	self assert:(x2d at:{i. j}) equals: (x2d at:{i- x2d shape first - 1. j - x2d shape last - 1})
    	]]].
    	
    ^a
]

{ #category : #gtExamples }
MlArray class >> gtDifferentiateTimes [
	<gtExample>
	| a b|
	a:= MlArray from: {{{1.0. 2.0. 3.0}. {2.0. 3.0. 4.0}. {3.0. 4.0. 5.0}. {4.0. 5.0. 6.0}}.{{1.0. 2.0. 3.0}. {2.0. 3.0. 4.0}. {3.0. 4.0. 5.0}. {4.0. 5.0. 6.0}}}.
	" diferentiates those three series, one by one and one time"
	b:= a differentiate: 1 times:2.
	self assert:	(b allSatisfy: [ :v| (v closeTo: 0.0) | (v isNaN) ]).
		
	a:= MlArray from: {{1.0. 2.0. 3.0}. {2.0. 3.0. 4.0}. {3.0. 4.0. 5.0}. {4.0. 5.0. 6.0}} order:#C.
	" diferentiates those three series, one by one and one time"
	b:= a differentiate: 1 times:2.
	self assert:	(b allSatisfy: [ :v| (v closeTo: 0.0) | (v isNaN) ])
]

{ #category : #gtExamples }
MlArray class >> gtExampleInternalArray [
	<gtExample>
	|i|
	i:=self from:#(#(1 2 3) #(4 5 6)).
	^ i internalArray 
]

{ #category : #gtExamples }
MlArray class >> gtInstanceFromClassMessageFrom [
	<gtExample>
	|a b c d e|
	" from an existing collection"
	a := MlArray from: #(1 2 3 4).
	" filled with zeros"
	b:=MlArray zeros:#( 3 4 ).
	"filled with ones"
	c:=MlArray ones:#( 3 4 ).
	"filled with any other value"
	d:=MlArray new:#(10 10) withAll:8.
	"filled with random values are in [0, 1] range " 
	e:=MlArray random:#( 3 4 )
]

{ #category : #gtExamples }
MlArray class >> gtInstanceNewShape [
	<gtExample>
	|a|
	a:= MlArray new: #(2 3).
	
	self assert: a shape equals:#(2 3). 
	self assert: a order equals: #F
	
]

{ #category : #gtExamples }
MlArray class >> gtInstanceOfMlArray [
	<gtExample>
	|a|
	a := #(1 2 3 4 ) asMlArray
]

{ #category : #gtExamples }
MlArray class >> gtInternalDataType [
	<gtExample>
	|a|
	a := MlArray from: #((1 2 3) (4 5 6)).

	self assert:a dType equals:#SmallInteger.
	self assert:a arrayType equals:#IntegerArray.
	" a has 6 elemnts"
	self assert:a size equals:6.
	" and occupies "
	self assert:a nBytes equals:24."bytes"
	"each element is 4 bytes length"
	self assert:a itemSize equals:4."bytes"
	
	
]

{ #category : #gtExamples }
MlArray class >> gtInternalOrder [
	<gtExample>
	|a|
	a := MlArray from: #(#(1 2 3) #(4 5 6)).
	"two rows and three columns"
	self assert:a shape equals:#(2 3).
	"two dimensions"
	self assert:a nDim equals:2.
	"in #F order the internal array is ..."
	self assert:a internalArray buffer equals:#(1 4 2 5 3 6) asIntegerArray.
	
]

{ #category : #gtExamples }
MlArray class >> gtInternalStructure [
	<gtExample>
	|a b|
	a:= MlArray from: #(1 2 3 4 5 6). 
	"Strides only contains 
		-the first stride from 1 to:1 
		-and the last stride size+1 to: size+1 "
	self assert: a internalArray strides equals:#(1 1 7 7). 
	"we want the elements from 2 to: 3 (both included) "
	b := a at:{2@3}.
	self assert: b internalArray strides equals:#(1 2 4 7). 
	" the internalArray instance of a and b are different instances"
	self assert: (a internalArray ~= (b internalArray)).
	"but the buffer of the NonContinuousVector in b is the internal array of a"
	self assert: a internalArray  equals: b internalArray buffer.
	"so if we change a value on b, we change it also on a "
	b at:1 put: 1000.
	self assert: (a at:2) equals: 1000.
	self assert: (b at:1) equals: (a at:2).
	
]

{ #category : #gtExamples }
MlArray class >> gtReshapeArrays [
	<gtExample>
	|a|
	"An MlArray can be reshaped to a new compatible shape, it means that the number of elements of the new shaped array should be the same than the old one."
	a:= MlArray from: {{1.1. 2.2. 3.3}. {4.4. 5.5. 6.6}}.
	self assert:a shape equals:#(2 3).
	a reshape:#(3 2).
	self assert:a shape equals:#(3 2).
	"Setting one of the axis to -1 automatically, sets the value of the axis to the correct value for fitting the size"
	a reshape:#(1 -1).
	self assert:a shape equals:#(1 6).
	a reshape:#(-1 1).
	self assert:a shape equals:#(6 1).
	"you can add a new dimension"
	a addDimension.
	self assert:a shape equals:#(1 6 1).
	"or add a dimension at the end"
	a addDimensionAtEnd.
	self assert:a shape equals:#(1 6 1 1).
]

{ #category : #gtExamples }
MlArray class >> gtSetDataType [
	<gtExample>
	|a |
	" from an existing collection setting the dataType as Float"
	a := MlArray from: #(1 2 3 4) dType:#Float.
	self assert: (a at:1) species equals:SmallFloat64.
	a dType:#Integer.
	self assert: (a at:1) species equals:SmallInteger
]

{ #category : #gtExamples }
MlArray class >> gtSlicingExamples1D [
	<gtExample>
	| a b d sol |
	a := MlArray from: #(10 1 3 5 2  5 6 4  10 11 12 2 11 2 3 6 10 11 12 20 10 11 12 56).
	"b has all the elements"
	b := a at: {_}.
	self assert:b equals: a.
	"three first elements of a"
	b := a at: {_@3}.
	self assert:b as1DArray equals: #(10 1 3).
	"three last elements of a"
	b := a at: {-3@_}.
	self assert:b as1DArray equals: #(11 12 56).
	"three  elements in the middle"
	b := a at: {3@5}.
	self assert:b as1DArray equals: #(3 5 2).
	"three elements 2 by 2"
	b := a at: {3@7@2}.
	self assert:b as1DArray equals: #(3 2 6).
	"list of slices"
	b := a at: {  1@2. 4@5. 7@9  }.
	self assert:b as1DArray equals: #( 10 1 5 2 6 4 10).
	"list of integers"
	d := a at: #( 1 2 3 4 5 6 8). 
	sol :=  MlArray from: #( 10 1 3 5 2 5 4).
	self assert:d equals: sol.
]

{ #category : #gtExamples }
MlArray class >> gtSlicingExamples3D [
	<gtExample>
	| a b d sol |
	a := MlArray from: #(#( #(10 1 3) 
							#(5 2 5)) 
						#(  #(6 4 10) 
							#(11 12 2))
						#(  #(11 2 3) 
						    #(6 10 11)) 
						#(  #(12 20 10) 
							#(11 12 56))).
	"b has all the elements"
	self assert: a shape equals:#(4 2 3).
	b := a at: {_. _. _}.
	self assert:b equals: a.
	"three first elements of a"
	b := a at: {1. 1. _ }.
	self assert:b as1DArray equals: #(10 1 3).
	"three last elements of a"
	b := a at: {-1. -1. _}.
	self assert:b as1DArray equals: #(11 12 56).
	"three  elements in the middle"
	b := a at: {-1. -1. 2@3}.
	self assert:b as1DArray equals: #(12 56).
	"three elements 2 by 2"
	b := a at: {_@_@2. _. _}.
	sol := MlArray from:#(#(#(10 1 3) 
							#(5 2 5)) 
						#(  #(11 2 3) 
						    #(6 10 11)) ).
	
	self assert:b  equals: sol.
	
	"list of slices"
	b := a at: {_. {1}. {  1@1. 3@3 }}.

	sol := MlArray from: #(#( #(10 3)) 
						#(  #(6 10) )
						#(  #(11 3) ) 
						#(  #(12 10))).
							
	self assert:b equals: sol.
	"list of integers"
	b := a at: {_. {1}. {  1. 3 }}.
	self assert:b equals: sol.

]

{ #category : #'instance creation' }
MlArray class >> initialize [ 
	Smalltalk at:#_ put: nil.

]

{ #category : #'instance creation' }
MlArray class >> initializeFromFStyle: instance shape: aShape plainCollection: aPlainCollection [
	|  jump i |
	instance shape: aShape.
	jump := (instance shape copyFrom:1 to:(instance shape size -1)) inject:1 into:[:e :m| e*m].
	i:=0.
	1 to:jump do:[:j|
		((j) to: (j+ instance size -1) by: jump) do:[:index|
			instance internalArray at: (i+1) put: (aPlainCollection at: ((index -1)\\ (instance size ))+1).
			i:=i+1]].

	instance order:#C
]

{ #category : #'instance creation' }
MlArray class >> initializeInCStyle: instance shape: aShape plainCollection: aPlainCollection [
	1 to: instance internalArray size do:[:i| instance internalArray at:i put: (aPlainCollection at:i)].
	instance order:#C
]

{ #category : #'instance creation' }
MlArray class >> initializeInFStyle: instance shape: aShape plainCollection: aPlainCollection [
	|index |

	index:=1.
	0 to: (aShape last -1 ) do:[:i|
		(1 to: aPlainCollection size by: aShape last) do:[:j|
			instance internalArray at:index put: (aPlainCollection at:(j+i)).
			index := index + 1]].

	instance shape: aShape.
	instance order:#F
]

{ #category : #testing }
MlArray class >> isNotACollection: anObject [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	^  (anObject isCollection not) | (anObject isKindOf: String) 
]

{ #category : #'instance creation' }
MlArray class >> new: aShape [
	^ self new: aShape order:#F dType: #Float
]

{ #category : #'instance creation' }
MlArray class >> new: aShape dType:dType [
	^ self new: aShape order: #F dType: dType
]

{ #category : #'instance creation' }
MlArray class >> new: aShape order:CorF [
	^ self new: aShape order: CorF dType: #Float
]

{ #category : #'instance creation' }
MlArray class >> new: anIntOrArray order: CorF dType: dataType [
	|instance size aShape |
	aShape := anIntOrArray isNumber ifTrue:[{anIntOrArray}] ifFalse:[anIntOrArray].
	instance := self new.
	size := aShape inject:1 into:[:m :e| m*e].
	instance internalArrayOfType: dataType size:size.
	instance shape: aShape.
	instance order: CorF.
	^ instance
]

{ #category : #'instance creation' }
MlArray class >> new: aShape withAll: anObject [
	|instance |

	instance := self new: aShape dType: anObject class name.
	instance fillWith: anObject.
	^ instance
]

{ #category : #'instance creation' }
MlArray class >> ones: aShape [
	^ self new: aShape withAll: 1.0
]

{ #category : #'instance creation' }
MlArray class >> random: aShape [ 
	^  self random: aShape seed: Time now asMilliSeconds.
]

{ #category : #'instance creation' }
MlArray class >> random: aShape seed: aSeed [
	| instance generator  |
	instance := self new: aShape.
	generator := Random new seed:aSeed.
	1 to: instance size do:[:i|  instance internalArray at: i put: ((100 atRandom: generator) / 100 ) asFloat ].
	instance dType: #Float.
	^instance
]

{ #category : #'instance creation' }
MlArray class >> zeros: aShape [
	^ self new: aShape withAll: 0.0
]

{ #category : #'binary operations' }
MlArray >> & aMlArray [
	"Logical and operation"
	| newInstance zip |
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray & self].
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray  
		ifTrue:[
			zip := MlZipper on: {self internalArray.  (self adaptSizeOfArray:(aMlArray ))}.
			newInstance internalArray:  (zip collect:[:row| row first & row last]).
			newInstance ]
		ifFalse:[
			newInstance internalArray: (self internalArray & (self adaptSizeOfArray:(aMlArray ))) .
			newInstance]
]

{ #category : #'binary operations' }
MlArray >> * aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray * self].
	^ self performBinaryOp: #* on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> *= aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray *= self].
	^ self performBinaryOp: #*= on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> + aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray + self].
	^ self performBinaryOp: #+ on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> += aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray += self].
	^ self performBinaryOp: #+= on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> , aMlArray [
	^ self concat: aMlArray axis: 0
]

{ #category : #'binary operations' }
MlArray >> - aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ (aMlArray * -1)  performBinaryOp: #+ on: self].
	^ self performBinaryOp: #- on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> -= aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ (aMlArray * -1)  performBinaryOp: #+= on: self].
	^ self performBinaryOp: #-= on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> / aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray * ( self transform:[:v| 1/v])].
	^ self performBinaryOp: #/ on: aMlArray  
]

{ #category : #'binary operations' }
MlArray >> /= aMlArray [
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray *= ( self transform:[:v| 1/v])].
	^ self performBinaryOp: #/= on: aMlArray  
]

{ #category : #comparing }
MlArray >> < aNumber [
	^ self eval:[:e| e< aNumber]
]

{ #category : #accessing }
MlArray >> <- aMlArray [
	| mla |
	mla := aMlArray isMlArray 
				ifTrue:[aMlArray internalArray]
				ifFalse:[self adaptSizeOfArray: ( self class from:aMlArray order: self order)].
	self internalArray replaceFrom: 1 to: self size with: mla startingAt: 1 
]

{ #category : #piping }
MlArray >> << aTransformer [
	^ aTransformer inverseTransform: self.
]

{ #category : #comparing }
MlArray >> <= aNumber [
	^ self eval:[:e| e<= aNumber]
]

{ #category : #comparing }
MlArray >> = aMlArrayOrNumber [
	^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isString)|(aMlArrayOrNumber isNil) 
		ifTrue:[self eval:[:e| e = aMlArrayOrNumber] ]
		ifFalse:[self internalArray = aMlArrayOrNumber internalArray and:[self order = aMlArrayOrNumber order and:[self shape= aMlArrayOrNumber shape]] ]
]

{ #category : #comparing }
MlArray >> > aNumber [
	^ self eval: [:e| e> aNumber]
]

{ #category : #comparing }
MlArray >> >= aNumber [
	^ self eval:[:e| e>= aNumber]
]

{ #category : #piping }
MlArray >> >> aTransformer [
	^ aTransformer fitAndTransform: self.
]

{ #category : #'binary operations' }
MlArray >> \\ aMlArray [
	"module operation and assign"
	| newInstance |
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray   
		ifTrue:[
			newInstance internalArray: self internalArray \\ aMlArray internalArray.
			newInstance]
		ifFalse:[
			newInstance internalArray: self internalArray \\ aMlArray.
			newInstance]
]

{ #category : #'binary operations' }
MlArray >> \\= aMlArray [
	"module operation and assign"
	| newInstance |
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray   
		ifTrue:[
			newInstance internalArray: self internalArray \\= aMlArray internalArray.
			newInstance]
		ifFalse:[
			newInstance internalArray: self internalArray \\= aMlArray.
			newInstance]
]

{ #category : #'reduce operations' }
MlArray >> abs [ 
	^ self collect:[:e| e abs]
]

{ #category : #'reduce operations' }
MlArray >> accuracy: aMlArray [
	^ aMlArray isMlArray   
		ifTrue:[self internalArray accuracy: aMlArray internalArray]
		ifFalse:[self internalArray accuracy: aMlArray ]
]

{ #category : #'private-converting' }
MlArray >> adaptData: anObject for:newArrayType [
	newArrayType = Array  ifTrue:[ ^ anObject].
	^ newArrayType = FloatArray  
			ifTrue:[ anObject asFloat]
			ifFalse:[ anObject asInteger]
]

{ #category : #'binary operations' }
MlArray >> adaptSizeOfArray: anArray [ 
	| tr sameRows sameColumns newArray |
	anArray size = self size ifTrue:[^ anArray internalArray].
	"rules for broadcasting"
	
	tr := self size / anArray size.
	sameRows := self nDim >1 & (anArray nDim > 1)
							ifTrue:[(self shape at:( self nDim-1)) = (anArray shape at:( anArray nDim-1))  ] 
							ifFalse:[self size = anArray size].
	sameColumns := (self shape last = (anArray shape last)) | (anArray size = 1).
	
	(sameRows | sameColumns) ifFalse:[MlShapeError signal:('Array ' ,anArray asString ,' could not be broadcasted')].
	self order = #F 
		ifTrue:[ 
			(sameColumns) ifTrue:[newArray:=MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ].
			(sameColumns not & sameRows) ifTrue:[newArray:=MlArrayRepeatedVector newFrom:anArray internalArray timesRepeat:tr ]]
	 	ifFalse:[ 
			(sameColumns)  ifTrue:[newArray:=MlArrayRepeatedVector  newFrom:anArray internalArray timesRepeat:tr ].
			(sameColumns not & sameRows) ifTrue:[newArray:=MlElementRepeatedVector newFrom:anArray internalArray timesRepeat:tr ]].
	^ newArray
	
]

{ #category : #converting }
MlArray >> adaptToNumber: rcvr andSend: selector [
	^ self perform:selector with: rcvr
]

{ #category : #converting }
MlArray >> addDimension [
	self shape: ({1} , self shape) 


]

{ #category : #converting }
MlArray >> addDimensionAtEnd [
	self shape: (self shape,{1}) 


]

{ #category : #enumerating }
MlArray >> allSatisfy: aBlock [ 
	^ self internalArray allSatisfy:aBlock.
]

{ #category : #enumerating }
MlArray >> anySatisfy: aBlock [ 
	^ self internalArray anySatisfy:aBlock.
]

{ #category : #'binary operations' }
MlArray >> applyBooleanFilter: aBooleanMlArray on: axis [
	| ratio instance |
	
	instance := self performBinaryOp: #applyBooleanFilter: on: aBooleanMlArray.
	ratio := instance size / self size.
	instance shape at:axis put:( (self shape at:axis) * ratio).
	^ instance 
]

{ #category : #sorting }
MlArray >> argSortBy: aBlock [
	| steps array buffer |
	steps :=  self nDim > 2 
		ifTrue:[(self shape copyFrom:1 to: (self nDim -2)) inject:1 into:[:e :mul| e* mul]]
		ifFalse:[self size - 1].
	array:= Array new: self size .
	(1 to: self size  by: steps + 1) do:[:e |
		buffer := self internalArray copyFrom:e  to: (e + steps ).
		"we sort each element of the axis"
		array replaceFrom: e to: (e + steps ) with: ((buffer argSortBy: aBlock) + (e-1)) startingAt: 1  ].
	
	^ array  
]

{ #category : #accessing }
MlArray >> arrayType [ 
	^ self internalArray bufferSpecies name
]

{ #category : #converting }
MlArray >> as1DArray [
	^ self internalArray 
]

{ #category : #converting }
MlArray >> asCArray [
	| newInstance  |
	order = #C ifTrue:[^self].
	newInstance := self newInstanceLikeMe.
	self class initializeFromFStyle: newInstance shape: self shape plainCollection: self internalArray.
	^ newInstance
]

{ #category : #converting }
MlArray >> asFortranArray [
	| newInstance |
	order = #F ifTrue:[^self].
	self nDim = 1 ifTrue:[^ self order:#F].
	newInstance := self newInstanceLikeMe.
	self class initializeInFStyle: newInstance shape: self shape plainCollection: self internalArray.
	^ newInstance
]

{ #category : #converting }
MlArray >> asMlArray [
	^  self
]

{ #category : #converting }
MlArray >> asSlices [
	| slices lastBool start end |
	slices := OrderedCollection new.
	lastBool := true.
	self internalArray doWithIndex:[:each : i|
		each not & lastBool ifTrue:[start := i].
		each  & (lastBool not) ifTrue:[end := i. slices add: start@end].
		lastBool := each].
	^ slices
	
]

{ #category : #converting }
MlArray >> asSparseMatrix [
	^ SVMSparseMatrix fromMlArray: self
]

{ #category : #converting }
MlArray >> asString [
	^ self printString
]

{ #category : #accessing }
MlArray >> at: anObject [
	| address anArrayOfInt |
	"nil returns exception"
	anObject ifNil:[MlIndexTypeError signal].
	"aBlock returns a boolean MlArray of execution of eval 
	 over the internal array, we can not know the shape of the execution..."
	anObject isBlock ifTrue:[^ self eval:anObject].
	"if nDim = 1 an array is a slice"
	
	anArrayOfInt := (self nDim = 1 & (anObject isArray)  
								and:[anObject notEmpty 
								and:[anObject first isArray not & (anObject isNotNil)]]) 
										ifTrue:[	{anObject}]
										ifFalse:[ anObject ].
	"if it is not an array, enclose in an array, "									
	anArrayOfInt := anArrayOfInt isArray 
										ifTrue:[anArrayOfInt]
										ifFalse:[	{anArrayOfInt}].
											
	"substitute labels by indexes"										
	anArrayOfInt := self changeLabelsByIndexes: anArrayOfInt.
	"if the array contain a slices we do slice"
	(self isAnArrayOfSlices: anArrayOfInt) 
		ifTrue:[^ self slice: anArrayOfInt]
		ifFalse:[
			"changes -1 by the last element"
			anArrayOfInt := anArrayOfInt collectWithIndex:[:e :i| e < 0 ifTrue:[(self shape at:i) + e + 1] ifFalse:[e]].
			(self validateAddress: anArrayOfInt) ifFalse:[MlShapeError signal:'Position is not valid for this shape']. "get the address in the 1D internalArray"
			address := self getAddressForPoint:anArrayOfInt.
			^ self internalArray at:address]
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 [
	^ self at:{int1. int2.}
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 [ 
	^ self at:{int1. int2. int3.} 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 at:int4 [
	^ self at:{int1. int2. int3. int4} 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 at:int4 put: aValue [
	^ self at:{int1. int2. int3. int4} put:aValue 
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 at: int3 put:aValue [
	^ self at:{int1. int2. int3.} put:aValue
]

{ #category : #accessing }
MlArray >> at: int1 at: int2 put:aValue [
	^ self at:{int1. int2.} put:aValue
]

{ #category : #accessing }
MlArray >> at: anObject put: aValue [
	| address anArrayOfInt |
	
	anObject ifNil:[MlIndexTypeError signal].
	" evaluates the block on internal array, if true put the value"
	anObject isBlock ifTrue:[ 
		(self eval:anObject) doWithIndex:[:o :i| o ifTrue:[self internalArray at:i put:aValue]].
		^self].
	"if nDim = 1 an array is a slice"
	anArrayOfInt := (self nDim = 1 & (anObject isArray)  
								and:[anObject notEmpty and:[anObject first isArray not]]) 
										ifTrue:[	{anObject}]
										ifFalse:[ anObject ].
	"if it is not an array, enclose in an array, "
	anArrayOfInt := anArrayOfInt isArray 
										ifTrue:[anArrayOfInt]
										ifFalse:[	{anArrayOfInt}].
	anArrayOfInt := self changeLabelsByIndexes: anArrayOfInt.
	(self isAnArrayOfSlices: anArrayOfInt) 
		ifTrue:[^ (self slice: anArrayOfInt) replaceAllBy: aValue;yourself]
		ifFalse:[
			"changes -1 by the last element"
			anArrayOfInt := anArrayOfInt collectWithIndex:[:e :i| e < 0 ifTrue:[(self shape at:i) + e + 1] ifFalse:[e]].
			(self validateAddress: anArrayOfInt) ifFalse:[MlShapeError signal:'Position is not valid for this shape'].
			address := self getAddressForPoint:anArrayOfInt.
			^ [  self internalArray at:address put: aValue] on: Exception do:[self internalArray at:address put: Float nan]]
	
]

{ #category : #'reduce operations' }
MlArray >> buildEncoder: axis [
	^ self reduce: #buildEncoder axis: axis
]

{ #category : #accessing }
MlArray >> byteSize [
	^ self internalArray byteSize
]

{ #category : #accessing }
MlArray >> calculateNewShape: anArrayOfInt [
	| newSize nr1 newShape |
	nr1 := (anArrayOfInt count:[:e| e = -1]).
	nr1 > 1 ifTrue:[MlShapeError signal:'Only one dimension could be -1' ]. 
	
	newShape := (nr1 = 1) 
						ifTrue:[ |uDim|
									uDim := (self internalArray size / 
										(anArrayOfInt inject:1 into:[:m :e| e = -1 ifTrue:[m] ifFalse:[m*e]])).
									uDim isInteger ifFalse:[MlShapeError signal].
									anArrayOfInt replaceAll: -1 with:uDim.	]
						ifFalse:[anArrayOfInt].
 	newSize := newShape inject: 1 into: [ :m :e | m*e].  
	newSize = self internalArray size ifFalse:[MlShapeError signal].
	^ newShape								
]

{ #category : #'private-labeling' }
MlArray >> changeLabelsByIndexes: anArrayOfInt [
	|result|

	result:= Array new: anArrayOfInt size.
	anArrayOfInt doWithIndex:[:o :i| 
		result at:i put: 
		(o isArray ifTrue:[ o collect:[:e| (self labelsDictAt:i) translate: e]]
					 ifFalse:[(self labelsDictAt:i) translate: o])].
	^ result
]

{ #category : #'private-accessing' }
MlArray >> classForType: aType [
	| dTypeDic |

	dTypeDic := { #Float->FloatArray.
	 				  #BoxedFloat64->FloatArray.
					  #SmallFloat64->FloatArray.
					  #Integer -> IntegerArray.
					  #SmallInteger -> IntegerArray.
					  #LargeInteger -> IntegerArray.
					  #LargeNegativeInteger -> IntegerArray.
					  #LargePositiveInteger -> IntegerArray.
					  #Word -> WordArray.
					  #DoubleWord -> DoubleWordArray.
					  #DoubleByte -> DoubleByteArray.
					  #Byte -> ByteArray} asDictionary.
	^ dTypeDic at:aType ifAbsent:[Array]
]

{ #category : #comparing }
MlArray >> closeTo: aMlArrayOrNumber [
	^ self closeTo: aMlArrayOrNumber precision: 0.0001
]

{ #category : #comparing }
MlArray >> closeTo: aMlArrayOrNumber precision: precission [
	^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isKindOf:String) 
		ifTrue:[self select:[:e| e = aMlArrayOrNumber] ]
		ifFalse:[
			1 to: self size do:[:i|
				((self internalArray at:i) closeTo: (aMlArrayOrNumber internalArray at:i) precision: precission)
				ifFalse:[^ false]].
			[self order = aMlArrayOrNumber order and:[self shape= aMlArrayOrNumber shape]] ]
]

{ #category : #enumerating }
MlArray >> collect: aBlock [ 
	^ self newInstanceButEmpty internalArray:  (self internalArray collect:aBlock)
]

{ #category : #'private-slicing' }
MlArray >> completeSlice: aSliceArray [
	" this function substitutes the _ an negative integers by its value.
	 _@_ left _ will be replaced by 1 and right _ will be replaced by the lenght of the dimension
	 -1@-2 negatige integers will be replaced by n + k + 1 where n is the lenght of the dimension 
	   and k is the negative integer
	 _ or nil means _@_                                             
	 also a slice could be:
	 - an array of integers
	 - an MlArray of Booleans. will be replaced by _@_. the filter will be applied later in the slice method"
	
	| collectionOfSlices completeSlice sliceForDim subcollection |
	
	aSliceArray size = self nDim  ifFalse:[ MlSliceError signal:'The slice should be an array with ', self nDim asString,' elements'].
	
	"will store all the completed slices"
	collectionOfSlices:=OrderedCollection new.
	
	"BLOCK DEFINITION: EXECUTED LATER"
	completeSlice := [ :slice :i :colOfSlices|
		|si step start end  |
		si := slice.
		step :=1.
		si isInteger 
		ifTrue:[	si < 0 
						ifTrue:[start := end := ((self shape at:i) + si + 1)]
						ifFalse:[ start := end :=si	]]
		ifFalse:[	
			si isSlice ifFalse:[ MlSliceError signal].
			"to be sure it is not a point"
			si:= si asSlice.
			"remember _ is nil"
			start := (si x notNil) ifTrue:[si x] ifFalse:[self shape at:i].
			start < 0 ifTrue:[start := ((self shape at:i) + start +1)].
			end := (si y notNil) ifTrue:[si y] ifFalse:[
				si x ifNil:[1] ifNotNil:[self shape at:i]].
			end < 0 ifTrue:[end := ((self shape at:i) + end + 1)].
			step := si step].
		colOfSlices add: (start to:end by:step)].
	
	
	1 to: aSliceArray size do:[:dimIndex|
		sliceForDim := (aSliceArray at: dimIndex).
		sliceForDim isArray &  sliceForDim isSlice not
			ifTrue:[
				subcollection := OrderedCollection new.
				sliceForDim do:[:each| 
					completeSlice value: (each ifNil:[ _@_] ifNotNil:[each]) 
								  value:dimIndex value:subcollection].
				collectionOfSlices add:subcollection asArray
				]
			ifFalse:[
				sliceForDim isMlArray | (sliceForDim isNil)
				ifTrue:[completeSlice value: _@_ value: dimIndex value: collectionOfSlices]
				ifFalse:[	completeSlice value: sliceForDim value: dimIndex value: collectionOfSlices]]
	].

	^	collectionOfSlices 	
		

]

{ #category : #'binary operations' }
MlArray >> concat: aMlArray axis: standarAxisNumber [
	| instance axis heightOfSelf heightOfOther j i  k |
	
	axis := self getStandardAxisNumberFor: standarAxisNumber.

	(self isShapeOf: aMlArray concatenableAlongAxis: axis) ifFalse:[MlShapeError signal:('Array is not concatenable on axis:', axis asString)].
	
	instance := self newInstanceButShaped: (self shape deepCopy 
															at: axis 
															put: (self shape at:axis) + (aMlArray shape at:axis);
															yourself) .
											
	heightOfSelf :=self jumpToNextBlockInAxis: axis.
	heightOfOther := aMlArray jumpToNextBlockInAxis: axis.

	i:= j := k:= 1.
	[i < instance size] whileTrue:[
		instance internalArray replaceFrom:i  to: (i + heightOfSelf - 1) with: self internalArray  startingAt: k.
		k:= k + heightOfSelf .
		i := i + heightOfSelf .
		instance internalArray replaceFrom:i  to: (i + heightOfOther - 1) with: aMlArray internalArray  startingAt: j.
		j := j + heightOfOther .
		i := i + heightOfOther 
	].

	^ instance
]

{ #category : #'reduce operations' }
MlArray >> confusionMatrix: aMlArray [
	^ aMlArray isMlArray 
		ifTrue:[self internalArray confusionMatrix: aMlArray internalArray]
		ifFalse:[self internalArray confusionMatrix: aMlArray ]
]

{ #category : #'private-converting' }
MlArray >> convertTypeTo:aType [

	| newArray newArrayType nv |
	newArrayType := (self classForType: aType).
	newArray := newArrayType new: self internalArray size.
	1 to: newArray size do:[:i|
		nv := self adaptData:( self internalArray at:i) for:newArrayType.
		newArray at:i put: nv].
	self internalArray: newArray . 
	^ aType

]

{ #category : #slicing }
MlArray >> copyFrom: aSliceArray [
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: aSliceArray copy: true	

]

{ #category : #slicing }
MlArray >> copyFrom: aSlice to: otherSlice [ 
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: { aSlice. otherSlice } copy: true	

]

{ #category : #'binary operations' }
MlArray >> copyUpToLast: aMlArray [ 
	^ self performBinaryOp: #copyUpToLast: on: aMlArray 

]

{ #category : #'reduce operations' }
MlArray >> count: aBlock [ 
	^ self count: aBlock onAxis: 0
]

{ #category : #'reduce operations' }
MlArray >> count: aBlock onAxis: axis [
	^ self reduce: #count: axis: axis arguments:{aBlock}
]

{ #category : #'private-slicing' }
MlArray >> createNewSlicedInstance: indexes shape: newShape [

	| newInstance i |
	
	newInstance := self newInstanceButShaped: newShape.
	i := 1.
	(indexes sort:[:a :b| a first < b first]) do:[:each|
			newInstance internalArray  replaceFrom:i  to: (i + each size -1) with: self internalArray  startingAt: each first. 
			i:=i + each size ].
	^ newInstance 
]

{ #category : #'private-slicing' }
MlArray >> createNewSlicedReference:indexes shape: newShape [
	
	| newInstance  |
	newInstance := self newInstanceButEmpty. 
	newInstance internalArray: self internalArray. 
	newInstance internalArray validRanges: (indexes sort:[:a :b| a first < b first]).
	newInstance shape: newShape.
	^ newInstance

	

]

{ #category : #accessing }
MlArray >> dType [
	^ dType
]

{ #category : #accessing }
MlArray >> dType: anObject [
	"if dtype changes we have to transform each element"
	dType := dType 
					ifNil:[anObject]
					ifNotNil:[ 
						dType = anObject 
							ifTrue:[dType]
							ifFalse:[self convertTypeTo:anObject]].
]

{ #category : #'binary operations' }
MlArray >> decode: aMlArray [ 
	^ self performBinaryOp: #decode: on: aMlArray 

]

{ #category : #'reduce operations' }
MlArray >> describe [
	^ self describe: 0
]

{ #category : #'reduce operations' }
MlArray >> describe: anAxis [
	|describeResult |
	"It is done one by one...all except mean and variance not in one pass"
	describeResult := MlDescribeResult new.
	
	describeResult mean:(self mean:anAxis).
	describeResult variance: (self variance:anAxis).
	describeResult max: (self max:anAxis).
	describeResult min: (self min:anAxis).
	describeResult numberOfObs: (self nDim>1 
										ifTrue:[self shape at: (self getStandardAxisNumberFor: anAxis)] 
										ifFalse:[self size]).
	describeResult skewness: (self skewness:anAxis).
	describeResult kurtosis: (self kurtosis:anAxis).
	
	^ describeResult
]

{ #category : #'reduce operations' }
MlArray >> differentiate: nSteps times:nTimes [
	"returns a collection with the Xn - Xn-steps elements n Times"
	^ self perform: #differentiate:times:  axis: 0 arguments:{nSteps. nTimes}
	

]

{ #category : #enumerating }
MlArray >> do: aBlock [ 
	^ self internalArray do:aBlock
]

{ #category : #enumerating }
MlArray >> doWithIndex: aBlock [ 
	^ self internalArray doWithIndex:aBlock
]

{ #category : #'binary operations' }
MlArray >> encode: aMlArray [ 
	^ self performBinaryOp: #encode: on: aMlArray 

]

{ #category : #utility }
MlArray >> entropy: targetColumn [
	|countArray entropy |
	countArray := self groupBy: targetColumn->targetColumn aggregate: [:k :v| v size].

	entropy := 	(((countArray at:{_. 2}) * -1 /  self length) * (((countArray at:{_. 2}) /  self length) log:2)) sum.
	^ entropy
]

{ #category : #enumerating }
MlArray >> eval: aBlock [ 
	|newInstance|
	newInstance := self newInstanceButBool.
	self internalArray doWithIndex:[:e :i|
		newInstance internalArray at:i put: (aBlock value:e)].
	^ newInstance
]

{ #category : #'private-accessing' }
MlArray >> fillWith: anObject [
		1 to:  self internalArray size  do:[:i| self internalArray at:i put: anObject].
]

{ #category : #accessing }
MlArray >> first [ 
	
	^ self internalArray first.
]

{ #category : #'private-accessing' }
MlArray >> getAddressForPoint:anArrayOfInt [
	| address  adaptedAddress  |
	address := 1.
	adaptedAddress := anArrayOfInt  - 1.
	
	adaptedAddress  doWithIndex:[:each :i| address := address + (each * (self weightForAxis:i))].	
	^ address 
]

{ #category : #'private-slicing' }
MlArray >> getIntervalAdressesFor:slices level: l list: lklst indexes: indexes [ 
	| si ei currentSlice nextLevel |

	(((l = self nDim) & (self order = #C)) | 
	 ((l = (self nDim - 1)) & (self order = #F)) |
		(self nDim = 1) ) 
		ifTrue: [ 
			(slices at:l) isArray
			ifTrue:[
					(slices at:l) do:[:each|
						lklst at:l put: (each first).
						si := (self getAddressForPoint: lklst asArray).
						lklst at:l put: (each last).
						ei:= (self getAddressForPoint: lklst asArray).
						indexes add: (si to:ei by:(each increment ))]]
			ifFalse:[
					lklst at:l put: ((slices at:l) first).
					si := (self getAddressForPoint: lklst asArray).
					lklst at:l put: ((slices at:l) last).
					ei:= (self getAddressForPoint: lklst asArray).
					indexes add: (si to:ei by:((slices at:l) increment ))]]
		ifFalse:[
			currentSlice := (slices at:l).
			currentSlice isInterval ifTrue:[	
				currentSlice do:[:e|
					lklst at:l put: e.
					
					nextLevel := (self order = #C) 
										ifTrue:[l+1] 
										ifFalse:[ 
											((l + 2) = self nDim ) ifTrue:[ l + 2] ifFalse:[
											((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]]].
					
					self getIntervalAdressesFor: slices  level: nextLevel list: lklst  indexes: indexes.
					]].
			currentSlice isArray ifTrue:[
					currentSlice do:[:each|
						"each one shoud be an interval"
						each do:[:eachVal|
							lklst at:l put: eachVal.
							nextLevel := (self order = #C) 
										ifTrue:[l+1] 
										ifFalse:[ 
											((l + 2) = self nDim ) ifTrue:[ l + 2] ifFalse:[
											((l + 1) > self nDim ) ifTrue:[ self nDim - 1] ifFalse:[l + 1]]].
					
							self getIntervalAdressesFor: slices  level: nextLevel  list: lklst  indexes: indexes.
							]]]
			]
		
	
]

{ #category : #accessing }
MlArray >> getStandardAxisNumberFor: anAxis [
	"return the estandar axis number for an axis. i.e.
	 shape #(1 2 3) axis 0 is the first, 1 rows and 2 columns
	but the standard says axis 0 is row axis, axis 1 is column axis and 2..n are the outter next ones "
	| data axis |
	axis := data := (( self nDim - anAxis - 1) \\  self nDim ) + 1 .
	axis := data = self nDim ifTrue:[self nDim -1] ifFalse:[data].
	axis := (data = (self nDim -1)) ifTrue:[self nDim] ifFalse:[axis].
	^ axis := axis >0 ifTrue:[axis] ifFalse:[1].

]

{ #category : #'reduce operations' }
MlArray >> groupBy: anAssociation aggregate: aBlock [
	"an association shoud be {keys}->{aggregated values}"
	
	^ self groupBy: anAssociation aggregate: aBlock storeValue: true

	
]

{ #category : #'reduce operations' }
MlArray >> groupBy: anAssociation aggregate: aBlock storeValue: includeKeyCol [
	"an association shoud be {keys}->{aggregated values}"
	| agKeys agValues  values sum  r valueRows  keyRows labelsForGroup val result |
	self nDim ~=2 ifTrue:[MlShapeError signal: ('It should be a 2D Array and it has ', self nDim asString, ' Dimensions')].
	labelsForGroup :=	OrderedCollection new.
	agKeys := anAssociation key isInteger | (anAssociation key isString)
					ifTrue:[{anAssociation key}]
					ifFalse:[anAssociation key].
	
	labelsForGroup addAll:agKeys.
	agKeys :=  agKeys collect:[:v|(self labelsDictAt: (self nDim )) translate:v].
	agValues := anAssociation value isInteger | (anAssociation value isString )
					ifTrue:[{anAssociation value}]
					ifFalse:[anAssociation value].
	labelsForGroup addAll:agValues.
	agValues := agValues collect:[:v|(self labelsDictAt: (self nDim )) translate:v].


	sum := Dictionary new.
	(1 to: (self shape at: self nDim -1)) doWithIndex:[:k :i|
		values := self slice:{i. agValues}.	
		sum at: (self slice:{i. agKeys}) as1DArray vstack: values].
		"call slice force to return alguays a MlArray"
	r := OrderedCollection new.
	sum keysAndValuesDo:[:k :v| 
		val := aBlock value:k value:v.
		r add:( val isMlArray ifTrue:[val as1DArray] ifFalse:[{val}]	)]. 
		"if there is only one column in right side it will return an Object, 
		and it should be always an array or a MlArray, becouse r should be a 2D column stacked array"
	includeKeyCol ifTrue:[
		keyRows := self class from: sum keys order: self order dType:#Object.
		valueRows := self class from: r  order: self order dType:#Object.	
		result := (keyRows  concat:valueRows axis:1).
		[result setLabels: labelsForGroup onAxis:1] on:MlShapeError do:[].
	].
	^result 

	
]

{ #category : #accessing }
MlArray >> indexOf: anObject [
	| linearIndex tmpIndex |
	linearIndex := self internalArray indexOf: anObject.
	
	^ self nDim = 1 
			ifTrue:[linearIndex] 
			ifFalse:[
				tmpIndex := Array new: self nDim withAll:1.
				self indexOf: linearIndex index: tmpIndex level:1 sum:0.
				tmpIndex]
]

{ #category : #accessing }
MlArray >> indexOf: anAddress index: anArray level:l sum:s [
	| axisLength i sum |
	axisLength := self shape at:l. 
	i :=0.
	sum := s.
	[ anAddress > sum ] whileTrue:[ 
		sum := sum + axisLength.
		anArray at:l put:i.
		i := i+1].
	l < (self nDim) 
	  	ifTrue:[ self indexOf: anAddress index: anArray level: (l+1) sum: (sum - axisLength)]
	  
	
]

{ #category : #utility }
MlArray >> infoGain: featuresClassAssociation [
	"association shold be split attribute->target name (class)
	Calculate the information gain of a dataset. This function takes two parameters:
    1. split_attribute_name = the name of the feature for which the information gain should be calculated
    2. target_name = the name of the target feature."
	| totalEntropy countArray entropyMatrix weightedEntropy featuresClass we |
	totalEntropy := self class from:{self entropy: featuresClassAssociation value}.
	"|class| count|"
	featuresClass := (featuresClassAssociation key isArray) 
		ifTrue:[ featuresClassAssociation]
		ifFalse:[ { featuresClassAssociation key }->featuresClassAssociation value].
	
	weightedEntropy :=OrderedCollection new.
	featuresClass key do:[:feature	|
		countArray := self groupBy: (feature->featuresClass value) aggregate: [:k :v| v size].
		entropyMatrix := self groupBy: (feature->featuresClass value)  aggregate:[:k :v| v entropy:1]. 
		we := ((countArray at:{_. 2@_}) / self length *  (entropyMatrix at:{_.2@_})) sum.
		weightedEntropy add: we
		].
	weightedEntropy := self class from:weightedEntropy.
	^ totalEntropy - weightedEntropy
]

{ #category : #enumerating }
MlArray >> inject: aValue into: aBlock [ 
	^ self internalArray inject: aValue into:aBlock
]

{ #category : #'private-accessing' }
MlArray >> internalArray [
	^ internalArray 
]

{ #category : #'private-accessing' }
MlArray >> internalArray: aNewArray [ 	
	internalArray := MlNonContinuousVector newFromArray: aNewArray
]

{ #category : #'private-accessing' }
MlArray >> internalArrayOfType: aType size: size [ 	
	| dataClass |
	self dType:aType.
	dataClass :=self classForType: self dType.
	self internalArray: (dataClass new:size)
]

{ #category : #slicing }
MlArray >> isAnArrayOfSlices: arrayOfPoints [ 
	| n |
	arrayOfPoints isNumber ifTrue:[MlShapeError signal].
	arrayOfPoints ifNil:[MlIndexTypeError signal].
	n := false.
	arrayOfPoints detect:[:e | e isPoint | e isSlice | e isArray | e isMlArray| e isNil] ifFound:[n := true].
	^ n 
]

{ #category : #testing }
MlArray >> isEmpty [ 	
	^ self internalArray isEmpty 
]

{ #category : #testing }
MlArray >> isMlArray [	
	^ true
]

{ #category : #'private-converting' }
MlArray >> isShapeOf: aMlArray concatenableAlongAxis: axis [ 
	self nDim = aMlArray nDim ifFalse:[^false].
	1 to: self nDim do:[:i| (((aMlArray shape at:i) = (self shape at:i)) or:[i = axis]) ifFalse:[^ false]].   
	^ true
]

{ #category : #accessing }
MlArray >> itemSize [
	^ self internalArray byteSize / (self internalArray buffer size)
]

{ #category : #'private-slicing' }
MlArray >> jumpToNextBlockInAxis: axis [

	^ self order = #F 
		ifTrue:[(self weightForAxis: axis) * (self shape at:axis)]
		ifFalse:[(self weightForAxis: axis-1)].

]

{ #category : #'reduce operations' }
MlArray >> kurtosis [ 
	^ self internalArray kurtosis
]

{ #category : #'reduce operations' }
MlArray >> kurtosis: axis [
	^ self reduce: #kurtosis axis: axis
]

{ #category : #accessing }
MlArray >> labelsDict [ 
	"labels dict is a dictionary axis-->labels"
	^ labelsDict ifNil:[ labelsDict := SmallDictionary new]
]

{ #category : #accessing }
MlArray >> labelsDict: aSmallDictionary [ 
	"labels dict is a dictionary axis-->labels"
	labelsDict := aSmallDictionary
]

{ #category : #labeling }
MlArray >> labelsDictAt: anInteger [ 
	^ self labelsDict at: anInteger 
	 					   ifAbsentPut:[MlLabelTranslator new]
]

{ #category : #accessing }
MlArray >> last [ 
	
	^ self internalArray last.
]

{ #category : #accessing }
MlArray >> length [
	"returns the number of rows"
	^ self shape at: (self nDim -1)
]

{ #category : #enumerating }
MlArray >> log [
	| nc i |
	nc:= self internalArray log.
	i := self newInstanceButEmpty internalArray: nc.
	^i
]

{ #category : #enumerating }
MlArray >> log: base [
	| nc i |
	nc := self internalArray collect:[:v| v log: base].
	i := self newInstanceButEmpty internalArray: nc.
	^ i
]

{ #category : #'reduce operations' }
MlArray >> max [ 
	^ self internalArray max
]

{ #category : #'reduce operations' }
MlArray >> max: axis [
	^ self reduce: #max axis: axis
]

{ #category : #printing }
MlArray >> maxElementsToPrint [
	^ maxElementsToPrint ifNil:[maxElementsToPrint := 10]
]

{ #category : #printing }
MlArray >> maxElementsToPrint: anInteger [
	^ maxElementsToPrint := anInteger
]

{ #category : #'reduce operations' }
MlArray >> mean [ 
	^ self internalArray mean
]

{ #category : #'reduce operations' }
MlArray >> mean: axis [
	^ self reduce: #mean axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mean: axis exclude: anElement [
	^ self reduce: #meanExcludeElement: axis: axis arguments: {anElement} 
]

{ #category : #'reduce operations' }
MlArray >> meanAndStd [
	^ self internalArray meanAndStd 
]

{ #category : #'reduce operations' }
MlArray >> meanAndStd: axis [
	^ self reduce: #meanAndStd axis: axis
]

{ #category : #'reduce operations' }
MlArray >> meanAndVariance [ 
	^ self internalArray meanAndVariance 
]

{ #category : #'reduce operations' }
MlArray >> meanAndVariance: axis [
	^ self reduce: #meanAndVariance axis: axis
]

{ #category : #'reduce operations' }
MlArray >> meanNoNan [ 
	^ self internalArray meanNoNan
]

{ #category : #'reduce operations' }
MlArray >> meanNoNan: axis [
	^ self reduce: #meanNoNan axis: axis
]

{ #category : #'reduce operations' }
MlArray >> median [ 
	^ self internalArray median
]

{ #category : #'reduce operations' }
MlArray >> median: axis [
	^ self reduce: #median axis: axis
]

{ #category : #'reduce operations' }
MlArray >> min [ 
	^ self internalArray min
]

{ #category : #'reduce operations' }
MlArray >> min: axis [
	^ self reduce: #min axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mode [
	^ self internalArray mode
]

{ #category : #'reduce operations' }
MlArray >> mode: axis [
	^ self reduce: #mode axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mode: axis exclude: anElement [
	^ self reduce: #modeExcludeElement:  axis: axis arguments: {anElement} 
]

{ #category : #'reduce operations' }
MlArray >> module [
	^ self internalArray module
]

{ #category : #'reduce operations' }
MlArray >> module: axis [
	^ self reduce: #module axis: axis
]

{ #category : #'reduce operations' }
MlArray >> mse: aMlArray [
	^ aMlArray species = self class  
		ifTrue:[self internalArray mse: aMlArray internalArray]
		ifFalse:[self internalArray mse: aMlArray ]
]

{ #category : #accessing }
MlArray >> nBytes [
	^ self internalArray byteSize
]

{ #category : #accessing }
MlArray >> nDim [
	^ self shape size
]

{ #category : #'private-creating' }
MlArray >> newInstanceButBool [

	| i |
	i:= self class new: self shape deepCopy order:self order dType: #Boolean.
	i labelsDict: self labelsDict deepCopy.
	^i
	
]

{ #category : #'private-creating' }
MlArray >> newInstanceButEmpty [
	| i |
	i := self class new.
	i shape: self shape deepCopy; order:self order; dType: self dType.
	i labelsDict: self labelsDict deepCopy.
	^i
]

{ #category : #'private-creating' }
MlArray >> newInstanceButShaped: aShape [
	| i |
	
	i := self class new: aShape order:self order dType: self dType.
	i labelsDict: self labelsDict deepCopy.
	^i
]

{ #category : #'private-creating' }
MlArray >> newInstanceLikeMe [
	| i |
	i := self class new: self shape deepCopy order:self order dType: self dType.
	i labelsDict: self labelsDict deepCopy.
	^i
]

{ #category : #'binary operations' }
MlArray >> oneHotDecode: aMlArray [ 
	^ self performBinaryOp: #oneHotDecode: on: aMlArray 

]

{ #category : #'binary operations' }
MlArray >> oneHotEncode: aMlArray [ 
	^ self performBinaryOp: #oneHotEncode: on: aMlArray 

]

{ #category : #accessing }
MlArray >> order [
	^ order ifNil:[ order := #F]
]

{ #category : #accessing }
MlArray >> order: cOrFChar [
	order := cOrFChar
]

{ #category : #'reduce operations' }
MlArray >> perform: aSymbol axis: anAxis arguments: args [
	"Execute a reduce function (mean,max... all values from an axis to one) 
	aSymbol is the operation, anAxis, the axis, args an array with the arguments for the method
	aClass is the  "
	| axis  newShape instance realAxis|
	realAxis := self getStandardAxisNumberFor: anAxis.
	axis := self nDim - anAxis.
	axis < 0 ifTrue:[ axis := self shape last + 1 - axis].
	(axis > self nDim)|( axis < 1 )ifTrue:[ MlShapeError signal:'Axis is higher than nDim']. 

	"the operation 'aSymbol' should return the same number of elements"

	instance := self newInstanceLikeMe.
	self walkOnWhile:[:l :s| axis >1 ifTrue:[l < (axis -1)] ifFalse:[false]]
		when: [:l :s| (s at:realAxis)=1 ]  
		do:[:l :s| 
		| slice array|
		slice := s deepCopy.
		realAxis to: self nDim do:[:i| slice at:i put:_@_].
		1 to: (self shape at:axis)  do:[:s2|
			slice at:axis put: s2.
			array :=  self slice: slice.
			(instance slice:slice) <- (array internalArray perform: aSymbol withEnoughArguments: args)]].
		^ instance
]

{ #category : #'binary operations' }
MlArray >> performBinaryOp: op on: aMlArray [
	^ self performBinaryOp: op on: aMlArray withArguments:{}
]

{ #category : #'binary operations' }
MlArray >> performBinaryOp: op on: aMlArray withArguments:args [
	| newInstance a b  |

	newInstance := self newInstanceButEmpty. 
	aMlArray isMlArray 
		ifTrue:[
			a:= self internalArray. b:= (self adaptSizeOfArray:aMlArray )]
		ifFalse:[
			aMlArray isNumber
			ifTrue:[ a:= self internalArray. b:= aMlArray]
			ifFalse:[
				a:= self internalArray. b:= (self adaptSizeOfArray: aMlArray asMlArray )]].

	newInstance internalArray: (a perform: op withEnoughArguments: {b.  args} ) buffer .
	^ newInstance
]

{ #category : #printing }
MlArray >> printOn: aStream axis: axisCollection maxPad: maxPad [
	| axistmp axis lenghtOfDimension interval  lastA  printPoints element |
	"axisCollection is Empty in the first call"
	axis := (axisCollection size +1 ).
	"is last axis"	
	printPoints := false.
	lastA:=0.
	axis = self nDim 
	ifTrue:[	
		aStream nextPut: Character tab;nextPut:$[.
		lenghtOfDimension := (self shape at: axis).
		interval := (lenghtOfDimension < (2 * self maxElementsToPrint+1) ) 
			ifTrue:[1 to:lenghtOfDimension]
			ifFalse:[
				printPoints := true.
				(1 to:self maxElementsToPrint ),
				(( lenghtOfDimension- self maxElementsToPrint ) to:lenghtOfDimension) ].		
		
		lastA := interval first.
		interval do:[:a| 
			axisCollection add:a.
			"in 1d array index should be an index otherwise it returns an slide {1. 3} b.e"
			element := self at: (self nDim = 1 ifTrue:[axisCollection first] ifFalse:[axisCollection asArray]).
			aStream nextPutAll: ((element isInteger|element isFloat) 
				ifTrue:[ element printPaddedWith: Character space to: maxPad]
				ifFalse:[ element asString ]).
			a = lenghtOfDimension ifFalse:[aStream nextPut:$,].
			(printPoints and:[a -lastA >1 ]) ifTrue:[aStream nextPutAll:'...'] .
			lastA := a.
			axisCollection removeLast.
			].
		aStream nextPut:$]; nextPut: Character tab.
		axistmp :=(self shape copyFrom: 1 to: axisCollection size).
		axisCollection asArray=  axistmp ifFalse:[aStream cr]]
	ifFalse:[
		aStream nextPut:$[.
		lenghtOfDimension := (self shape at: axis).
		interval := (lenghtOfDimension < (2 * self maxElementsToPrint + 1) ) 
			ifTrue:[1 to:lenghtOfDimension]
			ifFalse:[
				printPoints := true.
				(1 to:self maxElementsToPrint ),
				(( lenghtOfDimension- self maxElementsToPrint ) to:lenghtOfDimension) ].
		lastA := interval first.
		interval do:[:a|		
			axisCollection add:a.
			self printOn: aStream axis: axisCollection maxPad: maxPad.
			(printPoints and:[a-lastA >1 ]) ifTrue:[aStream nextPut:$.;cr;nextPut:$.;cr;nextPut:$.;cr] .
			lastA := a.
			axisCollection removeLast.
		].
		aStream nextPut:$].
	].

		

]

{ #category : #printing }
MlArray >> printString [
	"TODO provisional"
	|s maxPad|
	s := WriteStream on: String new.
	[  maxPad := ((self max asInteger asString size) + 2)] on:Exception do:[maxPad := 10].
	
	self printOn:s axis: OrderedCollection new maxPad:maxPad.
	^ s contents
]

{ #category : #'reduce operations' }
MlArray >> quartiles [
	^ self internalArray quartiles
]

{ #category : #'reduce operations' }
MlArray >> quartiles: axis [
	^ self reduce: #quartiles axis: axis
]

{ #category : #'reduce operations' }
MlArray >> reduce: aSymbol axis: anIntegerOrAPair [

	^ self
		reduce: aSymbol
		axis: anIntegerOrAPair
		arguments:{}
		
]

{ #category : #'reduce operations' }
MlArray >> reduce: aSymbol axis: anAxis arguments: args [
	"Execute a reduce function (mean,max... all values from an axis to one) 
	aSymbol is the operation, anAxis, the axis, args an array with the arguments for the method
	aClass is the  "
	| axis results newShape instance realAxis|
	realAxis := self getStandardAxisNumberFor: anAxis.
	axis := self nDim - anAxis.
	axis < 0 ifTrue:[ axis := self shape last + 1 - axis].
	(axis > self nDim)|( axis < 1 )ifTrue:[ MlShapeError signal:'Axis is higher than nDim']. 

	"the operation 'aSymbol' should reduce the collection to 1, i.e. mean, std..."
	results := OrderedCollection new.

	self walkOnWhile:[:l :s| axis >1 ifTrue:[l < (axis -1)] ifFalse:[false]]
		when: [:l :s| (s at:realAxis)=1 ]  
		do:[:l :s| 
		| slide array|
		slide := s deepCopy.
		realAxis to: self nDim do:[:i| slide at:i put:_@_].
		1 to: (self shape at:axis)  do:[:s2|
			slide at:axis put: s2.
			array:=  self slice: slide.
			results  add:( array internalArray perform: aSymbol withEnoughArguments: args)]].
	
	newShape := OrderedCollection newFrom:self shape .
	(axis < (self nDim -1)) 
		ifTrue: [ (self nDim - axis) timesRepeat:[ newShape removeLast] ] 
		ifFalse: [newShape removeAt: realAxis]. 
	instance := self class new shape: newShape;order:#C.
	instance internalArray:results asArray.
	instance labelsDict: self labelsDict deepCopy.
	^ (self order = #C) ifTrue:[instance] ifFalse:[instance asFortranArray] 
]

{ #category : #enumerating }
MlArray >> reject: aBlock [ 
	| nc i |
	nc:= self internalArray reject:aBlock.
	i := self newInstanceButEmpty internalArray: nc; shape:{nc size}.
	^i
]

{ #category : #'binary operations' }
MlArray >> replace: element by: aMlArray [ 
	^ self performBinaryOp: #replaceBy:element: on:aMlArray withArguments:  element

]

{ #category : #'binary operations' }
MlArray >> replaceAllBy: aMlArray [ 
	^ self performBinaryOp: #replaceAllBy: on: aMlArray 

]

{ #category : #'binary operations' }
MlArray >> replaceNanBy: aMlArray [ 
	^ self performBinaryOp: #replaceNanBy: on: aMlArray 

]

{ #category : #accessing }
MlArray >> reshape: anArrayOfInt [
	self shape: ( self calculateNewShape: anArrayOfInt)
]

{ #category : #accessing }
MlArray >> reshaped: anArrayOfInt [
	^ self newInstanceButEmpty shape: ( self calculateNewShape: anArrayOfInt);internalArray: self internalArray

]

{ #category : #sorting }
MlArray >> resortBy: anIndexArray onAxis: axis [
	
	| b  realAxis  slice |
	realAxis := self getStandardAxisNumberFor: axis.
	slice := Array new: self nDim withAll: _@_.
	1 to: (self shape at: realAxis) do:[:a|	
				slice at: realAxis put: a.
				b := self at: slice.
				b performBinaryOp: #applyNewIndexOrder: on: anIndexArray]

]

{ #category : #sorting }
MlArray >> resortByColumn: indexOrNameOfColumn [ 
	self resortByColumn: indexOrNameOfColumn where: [ :a :b | a < b ] 
]

{ #category : #sorting }
MlArray >> resortByColumn: indexOrNameOfColumn where: aBlock [ 
	|columns slide z si |

	slide := Array new: self nDim withAll: _@_.
	slide at: slide size put: indexOrNameOfColumn.
	columns := self changeLabelsByIndexes: slide.
	z := self at: columns.
	si := z argSortBy: aBlock.
	self resortBy: si onAxis:1
	
]

{ #category : #enumerating }
MlArray >> select: aBlock [ 
	| nc i |
	nc:= self internalArray select:aBlock.
	i := self newInstanceButEmpty internalArray: nc; shape:{nc size}.
	^i
]

{ #category : #labeling }
MlArray >> setLabels: anArray onAxis: standarAxisNumber [
	| axis |
	axis := self getStandardAxisNumberFor: standarAxisNumber.
	(axis <1 | axis > self nDim) ifTrue:[ ^ MlShapeError signal:('dimension  ', axis asString,' does not exist') ].
	(anArray size = (self shape at: axis)) ifFalse:[ ^ MlShapeError signal:('labels should have ',(self shape at: axis) asString,' elements') ].
	
	self labelsDict at: axis put: (MlLabelTranslator newFrom:anArray)
]

{ #category : #accessing }
MlArray >> shape [
	^ shape
]

{ #category : #'private-accessing' }
MlArray >> shape: anArrayOfInt [
	shape := anArrayOfInt asArray
]

{ #category : #'reduce operations' }
MlArray >> size [ 
	^ self internalArray size
]

{ #category : #'reduce operations' }
MlArray >> skewness [ 
	^ self internalArray skewness 
]

{ #category : #'reduce operations' }
MlArray >> skewness: axis [
	^ self reduce: #skewness axis: axis
]

{ #category : #'private-slicing' }
MlArray >> slice: aSliceArray [
	"the association should contain two nDim-arrays, from->to 
	#{1@2. 2@_. 3@4} points in the right array shoud be great or equal to le left side.
	# n@_ means from n to the end of the dimension.
	# _@m means from the start to the end of the dimension"
	^self slice: aSliceArray copy: false	

]

{ #category : #'private-slicing' }
MlArray >> slice: aSliceArray copy: makeCopy [


	| slice list indexes newShape startLevel newInstance |
	
	slice := self completeSlice: aSliceArray.
	list := Array new: self nDim.
	indexes := OrderedCollection new.
	startLevel := self order = #C | (self nDim ~= 2)
		ifTrue: [ 1 ]
		ifFalse: [ 2 ].
	self
		getIntervalAdressesFor: slice
		level: startLevel
		list: list
		indexes: indexes.
	newShape := slice
		collect: [ :e | 
			e isInterval
				ifTrue: [ "is an interval" e size ]
				ifFalse: [ e inject: 0 into: [ :sum :each | sum + each size ] ] ].
	"should be array of intervals"
	
	newInstance := makeCopy
		ifTrue: [ self createNewSlicedInstance: indexes shape: newShape ]
		ifFalse: [ self createNewSlicedReference: indexes shape: newShape ].
	newInstance := newInstance sliceUsingBooleanFilter: aSliceArray.
	newInstance sliceLabels: slice.
	^newInstance 
]

{ #category : #'private-labeling' }
MlArray >> sliceLabels: slice [

	| ld |
	slice doWithIndex:[:s :i|
		ld := (self labelsDictAt: i) slice:s.
		self labelsDict at: i put: ld
		]
]

{ #category : #'private-slicing' }
MlArray >> sliceUsingBooleanFilter: aSliceArray [
	|newInstance sliceForDim|
	newInstance := self.
	1 to: aSliceArray size do:[:axis|
		sliceForDim := (aSliceArray at: axis).
		(sliceForDim isMlArray and:[sliceForDim dType = #Boolean])
			ifTrue:[newInstance := newInstance applyBooleanFilter: sliceForDim on: axis.]
	].

	^	newInstance	
		

]

{ #category : #'binary operations' }
MlArray >> sparsity [
	^ 1- (self count:[:e| e ~= 0] / self size)
]

{ #category : #'binary operations' }
MlArray >> split: indicesOrSections axis: standarAxisNumber [
	| axis sliceTotal ios collectionOfSlices i endSection |
	
	ios := indicesOrSections isInteger ifTrue:[{indicesOrSections}] ifFalse:[indicesOrSections].
	axis := self getStandardAxisNumberFor: standarAxisNumber.
	collectionOfSlices := OrderedCollection new.
	i := 1.
	ios := ios , { (self shape at:axis)+1 }. 
	ios do:[:section|
		sliceTotal := self shape collect:[:d| 1@d].
		endSection := section - 1.
		endSection := endSection min: ((sliceTotal at: axis) y).
		endSection := endSection max:1.
		sliceTotal at: axis put: i@(section - 1).
		collectionOfSlices add: (self at:sliceTotal).
		i := section.
	].
	
	^ collectionOfSlices	
	
	

]

{ #category : #'reduce operations' }
MlArray >> stdDev [ 
	^ self internalArray stdDev
]

{ #category : #'reduce operations' }
MlArray >> stdDev: axis [
	^ self reduce: #stdDev axis: axis
]

{ #category : #'reduce operations' }
MlArray >> sum [ 
	^ self internalArray sum
]

{ #category : #'reduce operations' }
MlArray >> sum: axis [
	^ self reduce: #sum axis: axis
]

{ #category : #'reduce operations' }
MlArray >> summary [
	^ self summary:0
]

{ #category : #'reduce operations' }
MlArray >> summary: anAxis [
	^ self reduce: #summary axis: anAxis
]

{ #category : #'private-creating' }
MlArray >> switchShapeOrder: aShape [
	| newShape tmp |
	aShape size = 1 ifTrue:[^ aShape].
	newShape := (aShape copyFrom:1 to:aShape size).
	tmp := newShape last.
	newShape at:(newShape size) put: (newShape at:(newShape size -1)).
	newShape at:(newShape size - 1) put: tmp.
	^newShape
]

{ #category : #accessing }
MlArray >> transform: aBlock [
	
	1 to:self size do:[:i|
		self internalArray at:i put: ( aBlock value:(self internalArray at:i))]
]

{ #category : #converting }
MlArray >> transposed [
	|instance|
	self order = #C ifTrue:[instance := self asFortranArray order:#C].
	self order = #F ifTrue:[instance := self asCArray order:#F].
	self nDim >1 
		ifTrue:[instance shape: (self switchShapeOrder: self shape)]
		ifFalse:[instance reshape: {instance size. 1}].
	
	^ instance

]

{ #category : #'reduce operations' }
MlArray >> unique [
	|unique|
	unique := Set new.
	self internalArray do:[:each| unique add: each ].
	^ self class from:unique asArray order:self order
	
]

{ #category : #'private-accessing' }
MlArray >> validateAddress: anArrayOfInt [
	(anArrayOfInt size = self nDim ) ifFalse:[^false].
	self shape doWithIndex:[:e :i| 
		(anArrayOfInt at:i) isInteger ifFalse:[MlIndexTypeError signal].
		(e >= (anArrayOfInt at:i) and:[(anArrayOfInt at:i)>0]) ifFalse:[^false]].
	^ true.
		
]

{ #category : #'reduce operations' }
MlArray >> variance [ 
	^ self internalArray variance
]

{ #category : #'reduce operations' }
MlArray >> variance: axis [

	^ self reduce: #variance axis: axis
]

{ #category : #enumerating }
MlArray >> walkOn:l slice: s while: aWhileBlock when: aConditionBlock do: aBlock [ 


	1 to: (self shape at: l) do:[:i| 
		s at:l put: i.
		(aWhileBlock value:l value:s) ifTrue:[
			self walkOn:l+1 slice: s while: aWhileBlock when: aConditionBlock do: aBlock ].
		(aConditionBlock value:l value:s) ifTrue:[(aBlock  value:l value:s)].
	]
]

{ #category : #enumerating }
MlArray >> walkOnWhen: aConditionBlock do: aBlock [ 
	self walkOn:1 slice: (Array new: self nDim withAll:1) while: [:l :s| l < self nDim]  when: aConditionBlock do: aBlock 


]

{ #category : #enumerating }
MlArray >> walkOnWhile: aWhileBlock when: aConditionBlock do: aBlock [ 
	self walkOn:1 slice: (Array new: self nDim withAll:1) while: aWhileBlock when: aConditionBlock do: aBlock 


]

{ #category : #enumerating }
MlArray >> weightForAxis: anAxis [
	| w tempShape axis|
	axis := anAxis.
	axis < 1 ifTrue:[^ self size].
	self nDim = 1 ifTrue:[^ 1].
	tempShape := self shape.
	self order=#F ifTrue:[  
		anAxis = (self nDim - 1) ifTrue:[^ 1].
		w := anAxis = self nDim 
				ifTrue:[ (1 to: axis -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]]
				ifFalse:[ (axis +1 to: self nDim -1)  inject:1 into:[:mul :e|  mul * (self shape at:e)]].
		].
	self order=#C ifTrue:[  
		anAxis = self nDim ifTrue:[^ 1].
		w:= (axis +1 to: self nDim) inject:1 into:[:mul :e|  mul * (tempShape at:e)]].
	^ w
]

{ #category : #'binary operations' }
MlArray >> | aMlArray [
	| newInstance zip |
	(aMlArray isMlArray and:[aMlArray size  > (self size )]) ifTrue:[^ aMlArray | self].
	newInstance := self newInstanceButEmpty.
	^ aMlArray isMlArray  
		ifTrue:[
			zip := MlZipper on: {self internalArray.  (self adaptSizeOfArray:(aMlArray ) )}.
			newInstance internalArray:  (zip collect:[:row| row first | row last]).
			newInstance ]
		ifFalse:[
			newInstance internalArray: (self internalArray | (self adaptSizeOfArray:(aMlArray ))) .
			newInstance]
]

{ #category : #comparing }
MlArray >> ~= aMlArrayOrNumber [
	^ aMlArrayOrNumber isNumber| (aMlArrayOrNumber isKindOf:Boolean)|(aMlArrayOrNumber isString)|(aMlArrayOrNumber isNil) 
		ifTrue:[self eval:[:e| e ~= aMlArrayOrNumber] ]
		ifFalse:[(self = aMlArrayOrNumber) not ] 
		
	
]
