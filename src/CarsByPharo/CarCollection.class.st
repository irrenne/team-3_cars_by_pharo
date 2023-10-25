"
Class for storing cars
"
Class {
	#name : #CarCollection,
	#superclass : #Object,
	#instVars : [
		'cars'
	],
	#category : #CarsByPharo
}

{ #category : #adding }
CarCollection >> add: aCar [
    cars add: aCar.
]

{ #category : #accessing }
CarCollection >> cars [

	^ cars
]

{ #category : #accessing }
CarCollection >> cars: anObject [

	cars := anObject
]

{ #category : #'finding/searching' }
CarCollection >> findCheapestCar [
    | cheapestCar |
    cheapestCar := cars first.
    cars do: [:each | (each < cheapestCar) ifTrue: [cheapestCar := each]].
    ^ cheapestCar
]

{ #category : #accessing }
CarCollection >> increaseYearsInUse [
	cars do: [:each | each increaseYearsInUse].
]

{ #category : #initialization }
CarCollection >> initialize [
    cars := OrderedCollection new.
]

{ #category : #adding }
CarCollection >> printOn: aStream [
    cars do: [:each | aStream print: each; cr].
]

{ #category : #writing }
CarCollection >> writeToFile: fileName [
	 |file|
	 file := fileName asFileReference writeStream.
    cars do: [:car |
    	car printOn: file.
    	file cr.
	 ].
	 file close.
]
