"
I join two arrays of the same leght in one
	a:= #(1 2 3 4)
	b:= #(5 6 7 8)
	c := MlZipper on:{a. b}
	c = #(#(1 5) #(2 6) #(3 7) #(4 8))
"
Class {
	#name : #MlZipper,
	#superclass : #Object,
	#instVars : [
		'collections'
	],
	#category : #'MlSt-Core'
}

{ #category : #'instance creation' }
MlZipper class >> new: anArrayOfCollections [
	^ self on:anArrayOfCollections
]

{ #category : #'instance creation' }
MlZipper class >> on: anArrayOfCollections [
	| size instance |
	size := anArrayOfCollections first size.
	(anArrayOfCollections allSatisfy:[:e| e size = size]) ifFalse:[self error:'size of each collection shoud be the equal']. 
	instance:= self new.
	instance collections: anArrayOfCollections.
	^ instance
]

{ #category : #enumerating }
MlZipper >> collect: aBlock [ 
	| a |
	a := Array new: self size.
	1 to: self size do:[:i| 
		a at: i put:(aBlock value: (self collections collect:[:col| col at:i]))].
	^ a asArray
]

{ #category : #accessing }
MlZipper >> collections [ 	
	^ collections
]

{ #category : #accessing }
MlZipper >> collections: anArrayOfCollections [ 	
	collections := anArrayOfCollections
]

{ #category : #enumerating }
MlZipper >> do: aBlock [ 
	1 to: self size do:[:i| 
		aBlock value: (self collections collect:[:col| col at:i])].
]

{ #category : #enumerating }
MlZipper >> doWithIndex: aBlock [ 
	1 to: self size do:[:i| 
		aBlock value: (self collections collect:[:col| col at:i]) value:i].
]

{ #category : #enumerating }
MlZipper >> reject: aBlock [ 
	| a row |
	a := OrderedCollection new.
	1 to: self size do:[:i| 
		row := (self collections collect:[:col| col at:i]).
		(aBlock value:row ) ifFalse:[a add: row]].
	^ a asArray
]

{ #category : #enumerating }
MlZipper >> select: aBlock [ 
	| a row |
	a := OrderedCollection new.
	1 to: self size do:[:i| 
		row := (self collections collect:[:col| col at:i]).
		(aBlock value:row ) ifTrue:[a add: row]].
	^ a
]

{ #category : #enumerating }
MlZipper >> size [ 	
	^ self collections first size
]

{ #category : #enumerating }
MlZipper >> width [ 	
	^ self collections size
]
