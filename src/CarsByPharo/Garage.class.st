"
Class garagegege for storing cars
"
Class {
	#name : #Garage,
	#superclass : #Object,
	#instVars : [
		'name',
		'owner',
		'cars'
	],
	#category : #CarsByPharo
}

{ #category : #adding }
Garage >> add: aCar [
    cars add: aCar.
]

{ #category : #accessing }
Garage >> cars [

	^ cars
]

{ #category : #accessing }
Garage >> cars: anObject [

	cars := anObject
]

{ #category : #'finding/searching' }
Garage >> findAllTaxiByCompany: aCompany [
	
	 ^ cars select: [:each | (each isKindOf: Taxi) and: [each company = aCompany]]
]

{ #category : #'finding/searching' }
Garage >> findCarsCheaperThan: price [
	
	 ^ cars select: [:each | each initialCost < price].
]

{ #category : #'finding/searching' }
Garage >> findCarsOlderThan: years [

    ^ cars select: [:each | each yearsInUse > years].
]

{ #category : #'finding/searching' }
Garage >> findCheapestCar [
    | cheapestCar |
    cheapestCar := cars first.
    cars do: [:each | (each < cheapestCar) ifTrue: [cheapestCar := each]].
    ^ cheapestCar
]

{ #category : #'finding/searching' }
Garage >> findMostExpensiveCar [
    | mostExpensiveCar |
    mostExpensiveCar := cars first.
    cars do: [:each | (each > mostExpensiveCar) ifTrue: [mostExpensiveCar := each]].
    ^ mostExpensiveCar
]

{ #category : #accessing }
Garage >> increaseYearsInUse [
	cars do: [:each | each increaseYearsInUse].
]

{ #category : #initialization }
Garage >> initialize [
    cars := OrderedCollection new.
]

{ #category : #initialization }
Garage >> initializeWithName: aName owner: anOwner [
    name := aName.
	 owner := anOwner.
	 cars := OrderedCollection new.
]

{ #category : #accessing }
Garage >> name [

	^ name
]

{ #category : #accessing }
Garage >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Garage >> owner [

	^ owner
]

{ #category : #accessing }
Garage >> owner: anObject [

	owner := anObject
]

{ #category : #adding }
Garage >> printOn: aStream [
	aStream nextPutAll: ' Name: '. 
   name printOn: aStream.
	aStream cr.
	aStream nextPutAll: ' Owner: '. 
   owner printOn: aStream.
	aStream cr.
	cars do: [:each | aStream print: each; cr].
]

{ #category : #reading }
Garage >> readFromFile: fileName [
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

{ #category : #removing }
Garage >> sellCar: carModel [
	cars removeAllSuchThat: [:each | (each model = carModel)].
	
]

{ #category : #accessing }
Garage >> setDeprecationRate: aDeprecationRate ForTaxiByModel: aModel [
	 | taxi |
	 taxi := cars detect: [:each | (each isKindOf: Taxi) and: [each model = aModel]] ifNone: [^ self].
    taxi depreciationRate: aDeprecationRate.
]

{ #category : #calculating }
Garage >> sumOfAllCarsCost [
	| total |
    total := 0.
    
    cars do: [:each | total := total + each estimatedValue].

    ^ total.
]

{ #category : #writing }
Garage >> writeToFile: fileName [
	 |file|
	 file := fileName asFileReference writeStream.
    cars do: [:car |
    	car printOn: file.
    	file cr.
	 ].
	 file close.
]
