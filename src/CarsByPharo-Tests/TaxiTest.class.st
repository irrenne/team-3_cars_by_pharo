Class {
	#name : #TaxiTest,
	#superclass : #TestCase,
	#category : #'CarsByPharo-Tests'
}

{ #category : #tests }
TaxiTest >> testAccessingCompany [
|c|
c:=Taxi new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
self assert: c company equals: 'SuperTaxi'.
]

{ #category : #tests }
TaxiTest >> testAccessingRate [
|c|
c:=Taxi new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
self assert: c depreciationRate equals: 1.2.
]

{ #category : #tests }
TaxiTest >> testCalculateDepreciationRate [
|c cor|
cor:=1.2.
c:=Taxi new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
11 timesRepeat: [ 
        cor := cor + (cor* cor * 10 / 100).
    ].
self assert: (c calculateDepreciationRate ) closeTo:  cor.
]

{ #category : #tests }
TaxiTest >> testEstimatedValue [
|c cor value|

c:=Taxi new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11 company: 'SuperTaxi' depreciationRate: 1.2.
cor := 1 - (c depreciationRate / 10). "(10 * k)% depreciation rate per year"
value := c initialCost.
c yearsInUse timesRepeat: [ value := value * cor ].

self assert: (c estimatedValue ) closeTo:  value.
]
