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

{ #category : #reading }
CarCollection >> readFromFile: fileName [
	| file line tokens model initialCost yearsInUse car |
	file := fileName asFileReference readStream.

	[file atEnd] whileFalse: [
    	line := file nextLine.
    	tokens := line substrings: ' '''.
    
    	model := (tokens at: 2).
    	initialCost := (tokens at: 5) asInteger.
    	yearsInUse := (tokens at: 9) asInteger.
    
    	car := Car new initializeWithModel: model cost: initialCost yearsInUse: yearsInUse.
     	(tokens includes: 'Company:') ifTrue: [
            car := Taxi new.
            car model: (tokens at: 2).
            car initialCost: (tokens at: 5) asInteger.
            car yearsInUse: (tokens at: 9) asInteger.
            car company: (tokens at: 11).
            car depreciationRate: (tokens last) asNumber.
        ].

    	cars add: car.
	]. 

	file close.
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
