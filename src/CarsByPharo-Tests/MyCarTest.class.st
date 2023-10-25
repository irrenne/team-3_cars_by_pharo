Class {
	#name : #MyCarTest,
	#superclass : #TestCase,
	#category : #'CarsByPharo-Tests'
}

{ #category : #tests }
MyCarTest >> testAccessingInitialCost [
|c|
c:=Car new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11.
self assert: c initialCost equals: 12000.
]

{ #category : #tests }
MyCarTest >> testAccessingModel [
|c|
c:=Car new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11.
self assert: c model equals: 'Toyota'.
]

{ #category : #tests }
MyCarTest >> testAccessingYearsInUse [
|c|
c:=Car new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11.
self assert: c yearsInUse equals: 11.
]

{ #category : #tests }
MyCarTest >> testCalculatingEstamatedValue [
|c|
c:=Car new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11.
self assert: (c estimatedValue ) closeTo:  (12000* (0.9 raisedTo: 11)).

]

{ #category : #tests }
MyCarTest >> testComparing [
|c b|
c:=Car new.
c initializeWithModel: 'Toyota' cost: 12000 yearsInUse: 11.

b:=Car new.
b initializeWithModel: 'Mazda' cost: 25000 yearsInUse: 8.

self assert: c<b .

]
