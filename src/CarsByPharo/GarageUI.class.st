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
    | buttonBar fileButton loadButton addButton sellButton windowExtent xOffset yOffset |
    
    windowExtent := 600@500.

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
    addButton := SimpleButtonMorph new
        target: self;
        actionSelector: #addCarToGarage;
        label: 'Add Car'.
	 sellButton := SimpleButtonMorph new
        target: self;
        actionSelector: #sellCar;
        label: 'Sell Car'.
    
    buttonBar addMorph: fileButton.
    buttonBar addMorph: loadButton.
    buttonBar addMorph: addButton.
	 buttonBar addMorph: sellButton.

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

{ #category : #update }
GarageUI >> updateContentMorph [
    contentMorph contents: (garage printString).

]
