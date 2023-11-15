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
    
    windowExtent := 900@600.

    contentMorph := TextMorph new.
    contentMorph contents: (garage printString).

    garageWindow := (SystemWindow labelled: 'Garage') model: garage.
    garageWindow extent: windowExtent.

    xOffset := (garageWindow width - contentMorph width) / 2.
    yOffset := (garageWindow height - contentMorph height) / 2.

    contentMorph position: xOffset@yOffset.

    garageWindow addMorph: contentMorph.

    buttonBar := AlignmentMorph newRow.
    fileButton := SimpleButtonMorph new
        target: self;
        actionSelector: #saveGarage;
        label: 'Save'.
    loadButton := SimpleButtonMorph new
        target: self;
        actionSelector: #loadGarage;
        label: 'Load'.
    increaseYearButton := SimpleButtonMorph new
        target: self;
        actionSelector: #increaseYearsInUse;
        label: 'Increase Years'.
    addButton := SimpleButtonMorph new
        target: self;
        actionSelector: #addCarToGarage;
        label: 'Add Car'.
    sellButton := SimpleButtonMorph new
        target: self;
        actionSelector: #sellCar;
        label: 'Sell Car'.

cheapestCarButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showCheapestCar;
    label: 'Cheapest Car'.
mostExpensiveButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showMostExpensiveCar;
    label: 'Most Expensive Car'.
cheaperThanButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showCarsCheaperThan;
    label: 'Cheaper Than'.
olderThanButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showOlderThan;
    label: 'Older Than'.
taxiByCompanyButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showTaxiByCompany;
    label: 'Taxi By Company'.
allCarsCostButton := SimpleButtonMorph new
    target: self;
    actionSelector: #showAllCarsCost;
    label: 'All Cars Cost'.
showAllCarsButton := SimpleButtonMorph new
    target: self;
    actionSelector: #updateContentMorph;
    label: 'All Cars'.


    
    buttonBar addMorph: fileButton.
    buttonBar addMorph: loadButton.
    buttonBar addMorph: increaseYearButton.
    buttonBar addMorph: addButton.
    buttonBar addMorph: sellButton.
	 buttonBar addMorph: cheapestCarButton.
buttonBar addMorph: mostExpensiveButton.
buttonBar addMorph: cheaperThanButton.
buttonBar addMorph: olderThanButton.
buttonBar addMorph: taxiByCompanyButton.
buttonBar addMorph: allCarsCostButton.
buttonBar addMorph: showAllCarsButton.

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
	| cost |
	cost := (UIManager default request: 'Enter Cost', String new) asInteger ifNil: [^ self].
	contentMorph contents: (garage findCarsCheaperThan: cost printString).
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
	| years |
	years := (UIManager default request: 'Enter Years:', String new) asInteger ifNil: [^ self].
	contentMorph contents: (garage findCarsOlderThan: years printString).
]

{ #category : #'api - showing' }
GarageUI >> showTaxiByCompany [
    | company resultMessage |
    company := (UIManager default request: 'Enter Company:') ifNil: [^ self].

    resultMessage := garage findAllTaxiByCompany: company.
    
    resultMessage isEmpty
        ifTrue: [contentMorph contents: 'No Taxi found with this company.']
        ifFalse: [contentMorph contents: resultMessage printString].

]

{ #category : #update }
GarageUI >> updateContentMorph [
    contentMorph contents: (garage printString).

]
