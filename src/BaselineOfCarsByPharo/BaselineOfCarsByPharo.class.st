"
Baseline class to load packages.
"
Class {
	#name : #BaselineOfCarsByPharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfCarsByPharo
}

{ #category : #baselines }
BaselineOfCarsByPharo >> baseline: spec [
	<baseline>
	spec for: #common do:[
		spec 
			package: 'CarsByPharo';
			package: 'CarsByPharo-Tests' with: [ spec requires: #('CarsByPharo') ]
		].
]

{ #category : #accessing }
BaselineOfCarsByPharo >> projectClass [ 
	^MetacelloCypressBaselineProject
]
