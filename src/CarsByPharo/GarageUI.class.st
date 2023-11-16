"
Garage ui class
"
Class {
	#name : #GarageUI,
	#superclass : #Object,
	#instVars : [
		'garage',
		'garageWindow',
		'contentMorph'
	],
	#category : #CarsByPharo
}

{ #category : #adding }
GarageUI >> addCarToGarage [
    | model initialCost yearsInUse newCar carType |

    carType := (UIManager default
        chooseFrom: {'Car' . 'Taxi'}
        lines: #( 'Select Car Type' )
        title: 'Choose Car Type') ifNil: [^ self].

    model := (UIManager default request: 'Enter Model:') ifNil: [^ self].

    initialCost := (UIManager default request: 'Enter Initial Cost:' , String new) asInteger 
	 ifNil: [^ self].
	
    yearsInUse := (UIManager default request: 'Enter Years in Use:' , String new) asInteger 
	 ifNil: [^ self].

    newCar := (carType = 2)
        ifTrue: [
            | taxiCompany depreciationRate |
            taxiCompany := (UIManager default request: 'Enter Company:') ifNil: [^ self].
            depreciationRate := (UIManager default request: 'Enter Depreciation Rate:' , String new) 				asNumber ifNil: [^ self].
            
            Taxi new
                initializeWithModel: model
                cost: initialCost
                yearsInUse: yearsInUse
                company: taxiCompany
                depreciationRate: depreciationRate
        ]
        ifFalse: [
            Car new initializeWithModel: model cost: initialCost yearsInUse: yearsInUse.
        ].
    
    garage add: newCar.
    self updateContentMorph.

]

{ #category : #adding }
GarageUI >> createButtonWithLabel: aLabel action: anActionSelector [
    | button |
    button := SimpleButtonMorph new
        target: self;
        actionSelector: anActionSelector;
        label: aLabel;
		  color: Color lightGray.
    ^ button.
]

{ #category : #accessing }
GarageUI >> garage [

	^ garage
]

{ #category : #accessing }
GarageUI >> garage: anObject [

	garage := anObject
]

{ #category : #accessing }
GarageUI >> increaseYearsInUse [
	garage increaseYearsInUse.
	self updateContentMorph.
]

{ #category : #initialization }
GarageUI >> initializeWithGarage: aGarage [
    garage := aGarage.
]

{ #category : #'accessing - file' }
GarageUI >> loadGarage [
    | fileName |
    fileName := UIManager default
        chooseFullFileNameMatching: nil 
        label: 'Select a file'.
    
    fileName ifNil: [^ self].
	 garage := Garage new initializeWithName: garage name  owner: garage owner.
    
    garage readFromFile: fileName.
	 self updateContentMorph.
]

{ #category : #opening }
GarageUI >> open: aGarage [
		self initializeWithGarage: aGarage.
		self openGarageWindow.
]

{ #category : #'accessing - ui' }
GarageUI >> openGarageWindow [
    | buttonBar fileButton loadButton increaseYearButton addButton sellButton windowExtent xOffset yOffset cheapestCarButton mostExpensiveButton cheaperThanButton olderThanButton taxiByCompanyButton allCarsCostButton showAllCarsButton |

    windowExtent := 900 @ 600.

    contentMorph := TextMorph new.
    contentMorph contents: (garage printString).

    garageWindow := (SystemWindow labelled: 'Garage') model: garage.
    garageWindow extent: windowExtent.

    xOffset := (garageWindow width - contentMorph width) / 2.
    yOffset := (garageWindow height - contentMorph height) / 2.

    contentMorph position: xOffset @ yOffset.

    garageWindow addMorph: contentMorph.

    buttonBar := AlignmentMorph newRow.
    buttonBar color: Color transparent.
    buttonBar layoutInset: 30 @ 40.

    fileButton := self createButtonWithLabel: 'Save' action: #saveGarage.
    loadButton := self createButtonWithLabel: 'Load' action: #loadGarage.
    increaseYearButton := self createButtonWithLabel: 'Increase Years' action: #increaseYearsInUse.
    addButton := self createButtonWithLabel: 'Add Car' action: #addCarToGarage.
    sellButton := self createButtonWithLabel: 'Sell Car' action: #sellCar.
    cheapestCarButton := self createButtonWithLabel: 'Cheapest Car' action: #showCheapestCar.
    mostExpensiveButton := self createButtonWithLabel: 'Most Expensive Car' action: #showMostExpensiveCar.
    cheaperThanButton := self createButtonWithLabel: 'Cheaper Than' action: #showCarsCheaperThan.
    olderThanButton := self createButtonWithLabel: 'Older Than' action: #showOlderThan.
    taxiByCompanyButton := self createButtonWithLabel: 'Taxi By Company' action: #showTaxiByCompany.
    allCarsCostButton := self createButtonWithLabel: 'All Cars Cost' action: #showAllCarsCost.
    showAllCarsButton := self createButtonWithLabel: 'All Cars' action: #updateContentMorph.

	 buttonBar addAllMorphs: {fileButton. loadButton. increaseYearButton. addButton. sellButton. cheapestCarButton. 									 									 mostExpensiveButton. cheaperThanButton. olderThanButton. taxiByCompanyButton. 
									 allCarsCostButton. showAllCarsButton}.

    garageWindow addMorph: buttonBar.
    garageWindow openInWorld.

]

{ #category : #'accessing - file' }
GarageUI >> saveGarage [
    | fileName |
    fileName := UIManager default
        chooseFullFileNameMatching: nil 
        label: 'Select a file'.
    
    fileName ifNil: [^ self].
    
    garage writeToFile: fileName.


]

{ #category : #removing }
GarageUI >> sellCar [
	| model |
	model := (UIManager default request: 'Enter Model You Want To Sell:') ifNil: [^ self].
	garage sellCar: model.
	
	self updateContentMorph.
]

{ #category : #'api - showing' }
GarageUI >> showAllCarsCost [
    contentMorph contents: (garage printString, 'All Cars Cost = ', (garage sumOfAllCarsCost printString)).

]

{ #category : #'api - showing' }
GarageUI >> showCarsCheaperThan [
   | cost cheaperCars |
    cost := (UIManager default request: 'Enter Initial Cost:' , String new) asInteger ifNil: [^ self].
    cheaperCars := garage findCarsCheaperThan: cost.
    contentMorph contents: ''.
    cheaperCars do: [:car |
        contentMorph contents: (car printString , String cr , (contentMorph contents)).
    ].
]

{ #category : #'api - showing' }
GarageUI >> showCheapestCar [
	contentMorph contents: (garage findCheapestCar printString).
	
]

{ #category : #'api - showing' }
GarageUI >> showMostExpensiveCar [
	contentMorph contents: (garage findMostExpensiveCar printString).
]

{ #category : #'api - showing' }
GarageUI >> showOlderThan [
	| years olderCars |
	years := (UIManager default request: 'Enter Years:', String new) asInteger ifNil: [^ self].
	contentMorph contents: ''.
	olderCars := (garage findCarsOlderThan: years).
	olderCars do: [:car |
   		contentMorph contents: (car printString , String cr , (contentMorph contents)).
   ].

]

{ #category : #'api - showing' }
GarageUI >> showTaxiByCompany [
    | company resultMessage |
    company := (UIManager default request: 'Enter Company:') ifNil: [^ self].

    resultMessage := garage findAllTaxiByCompany: company.
    
	 contentMorph contents: ''.
    resultMessage isEmpty
        ifTrue: [contentMorph contents: 'No Taxi found with this company.']
        ifFalse: [resultMessage do: [:car |
        		contentMorph contents: (car printString , String cr , (contentMorph contents)).
    	  ]].

]

{ #category : #update }
GarageUI >> updateContentMorph [
    contentMorph contents: (garage printString).

]
