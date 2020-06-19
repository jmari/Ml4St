Class {
	#name : #SVMRow,
	#superclass : #SmallDictionary,
	#category : #'MlSt-FFI-LibLinear-IO'
}

{ #category : #arithmetic }
SVMRow >> * aVector [
	|newValues|
	newValues := self values  * aVector.	
	^ self species newFromKeys: self keys andValues: newValues 
]
