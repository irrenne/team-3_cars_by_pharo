"
Car class remembers the model, initial cost and service life.
"
Class {
	#name : #Car,
	#superclass : #Object,
	#instVars : [
		'model',
		'initialCost',
		'yearsInUse'
	],
	#category : #CarsByPharo
}

{ #category : #comparing }
Car >> < aCar [
    "Порівняння автомобілів за їхньою вартістю"
    ^self estimatedValue < aCar estimatedValue.
]

{ #category : #calculating }
Car >> estimatedValue [
    "Обчислює оціночну вартість автомобіля"
    | depreciationRate value |
    depreciationRate := 0.9. "10% depreciation rate per year"
    value := initialCost.
    yearsInUse timesRepeat: [ value := value * depreciationRate ].
    ^value.
]

{ #category : #accessing }
Car >> initialCost [

	^ initialCost
]

{ #category : #accessing }
Car >> initialCost: aNumber [

	initialCost := aNumber
]

{ #category : #initialization }
Car >> initializeWithModel: aModel cost: anInitialCost yearsInUse: years [
    "Ініціалізуємо об'єкт автомобіля"
    model := aModel.
    initialCost := anInitialCost.
    yearsInUse := years.
]

{ #category : #accessing }
Car >> model [

	^ model
]

{ #category : #accessing }
Car >> model: aString [

	model := aString
]

{ #category : #accessing }
Car >> yearsInUse [

	^ yearsInUse
]

{ #category : #accessing }
Car >> yearsInUse: aNumber [

	yearsInUse := aNumber
]
