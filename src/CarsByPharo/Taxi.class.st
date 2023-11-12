"
Taxi class extends Car class, remembers the company and depricationRate.
"
Class {
	#name : #Taxi,
	#superclass : #Car,
	#instVars : [
		'company',
		'depreciationRate'
	],
	#category : #CarsByPharo
}

{ #category : #calculating }
Taxi >> calculateDepreciationRate [
 	 |value|
	 value := depreciationRate.
    yearsInUse timesRepeat: [ 
        value := value + (value * value * 10 / 100).
    ].
	^ value
]

{ #category : #accessing }
Taxi >> company [

	^ company
]

{ #category : #accessing }
Taxi >> company: anObject [

	company := anObject
]

{ #category : #accessing }
Taxi >> depreciationRate [

	^ depreciationRate
]

{ #category : #accessing }
Taxi >> depreciationRate: anObject [

	depreciationRate := anObject
]

{ #category : #calculating }
Taxi >> estimatedValue [
    "Обчислює оціночну вартість таксі"
    | depreciationRateTaxi value |
    depreciationRateTaxi := 1 - (depreciationRate / 10). "(10 * k)% depreciation rate per year"
    value := initialCost.
    yearsInUse timesRepeat: [ value := value * depreciationRateTaxi ].
    ^value.
]

{ #category : #initialization }
Taxi >> initializeWithModel: aModel cost: anInitialCost yearsInUse: years company: aCompany depreciationRate: aRate [
    self initializeWithModel: aModel cost: anInitialCost yearsInUse: years.
    company := aCompany.
    depreciationRate := aRate.
]

{ #category : #printing }
Taxi >> printOn: aStream [
    super printOn: aStream.
    aStream nextPutAll: ' Company: '. 
    company printOn: aStream.
    aStream nextPutAll: ' Depreciation Rate: '.
    depreciationRate printOn: aStream.
]
