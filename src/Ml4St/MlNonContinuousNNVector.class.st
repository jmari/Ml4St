Class {
	#name : #MlNonContinuousNNVector,
	#superclass : #MlNonContinuousVector,
	#type : #variable,
	#category : #'Ml4St-Core'
}

{ #category : #accessing }
MlNonContinuousNNVector >> at: aPos [
	^ self buffer at: (self fakeAt: aPos)

	
	
		 
]

{ #category : #accessing }
MlNonContinuousNNVector >> at: aPos put: aValue [
	^ self buffer at: (self fakeAt: aPos) put:aValue

	
	
		 
]
