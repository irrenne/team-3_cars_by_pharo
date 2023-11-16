Class {
	#name : #GarageTest,
	#superclass : #TestCase,
	#category : #'CarsByPharo-Tests'
}

{ #category : #tests }
GarageTest >> testAccessingName [
|g|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.

self assert: g name equals: 'Garage1'.
]

{ #category : #tests }
GarageTest >> testAccessingOwner [
|g|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.

self assert: g owner equals: 'Taras'.
]

{ #category : #tests }
GarageTest >> testAddCars [
|g c t|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
g add: c.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
g add: t.
self assert: ((g cars) size) equals: 2.
]

{ #category : #tests }
GarageTest >> testCars [
|g c t|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
g cars: #(c t).
self assert: (g cars) equals: #(c t).
]

{ #category : #tests }
GarageTest >> testFindAllTaxiByCompany [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.

self assert: ((g findAllTaxiByCompany: 'SuperTaxi') size )equals: 1.
]

{ #category : #tests }
GarageTest >> testFindCarsCheaperThan [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
self assert: ((g findCarsCheaperThan: 24000) size )equals: 2.
]

{ #category : #tests }
GarageTest >> testFindCarsOlderThan [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
self assert: ((g findCarsOlderThan: 6) size )equals: 2.
]

{ #category : #tests }
GarageTest >> testFindCheapestCar [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
self assert: ((g findCheapestCar)class )equals: Taxi.
]

{ #category : #tests }
GarageTest >> testFindMostExpensiveCar [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
self assert: ((g findMostExpensiveCar)class )equals: Car.
]

{ #category : #tests }
GarageTest >> testIncreaseYearsInUse [ 
|g c t w|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 12000 yearsInUse: 5 company: 'SuperTaxi' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
g increaseYearsInUse.
self assert: ( ( g cars at:1)yearsInUse ) equals: 9.

]

{ #category : #tests }
GarageTest >> testSellCar [
|g c t w |
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'BMW' cost: 13000 yearsInUse: 5 company: 'Taxist' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
g sellCar: 'BMW'.
self assert: (g cars size)equals: 1.
]

{ #category : #tests }
GarageTest >> testSetDeprecationRate [
|g c t w|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 12000 yearsInUse: 5 company: 'SuperTaxi' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
g setDeprecationRate: 2 ForTaxiByModel: 'Toyota' .
self assert:  ((g cars at:2)depreciationRate ) equals: 2.
self assert:  ((g cars at:3)depreciationRate ) equals: 1.75.
]

{ #category : #tests }
GarageTest >> testSumOfAllCarsCost [
|g c t w estv|
g:=Garage new.
g initializeWithName: 'Garage1' owner: 'Taras'.
c:=Car new.
c initializeWithModel: 'BMW' cost: 25000 yearsInUse: 8.
t:=Taxi new.
t initializeWithModel: 'Toyota' cost: 11000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
w:=Taxi new.
w initializeWithModel: 'Tesla' cost: 13000 yearsInUse: 5 company: 'SuperTaxi' depreciationRate: 1.75.
g add:c.
g add:t.
g add:w.
estv:=c estimatedValue +t estimatedValue +w estimatedValue.
self assert: (g sumOfAllCarsCost) equals: estv.

]
