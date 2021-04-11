"
Imports System.Math

Module Acklam

   Public Function SNormInv(ByVal p As Double) As Double

      Dim q As Double
      Dim r As Double

      'Coefficients in rational approximations.

      Const A1 As Double = -39.696830286653757
      Const A2 As Double = 220.9460984245205
      Const A3 As Double = -275.92851044696869
      Const A4 As Double = 138.357751867269
      Const A5 As Double = -30.66479806614716
      Const A6 As Double = 2.5066282774592392

      Const B1 As Double = -54.476098798224058
      Const B2 As Double = 161.58583685804089
      Const B3 As Double = -155.69897985988661
      Const B4 As Double = 66.80131188771972
      Const B5 As Double = -13.280681552885721

      Const C1 As Double = -0.0077848940024302926
      Const C2 As Double = -0.32239645804113648
      Const C3 As Double = -2.4007582771618381
      Const C4 As Double = -2.5497325393437338
      Const C5 As Double = 4.3746641414649678
      Const C6 As Double = 2.9381639826987831

      Const D1 As Double = 0.0077846957090414622
      Const D2 As Double = 0.32246712907003983
      Const D3 As Double = 2.445134137142996
      Const D4 As Double = 3.7544086619074162

      'Define break-points.

      Const P_LOW As Double = 0.02425
      Const P_HIGH As Double = 1 - P_LOW

      If p > 0 AndAlso p < P_LOW Then

         'Rational approximation for lower region.

         q = Sqrt(-2 * Log(p))

         Return (((((C1 * q + C2) * q + C3) * q + C4) * q + C5) * q + C6) / _
            ((((D1 * q + D2) * q + D3) * q + D4) * q + 1)

      ElseIf p >= P_LOW AndAlso p <= P_HIGH Then

         'Rational approximation for central region.

         q = p - 0.5
         r = q * q

         Return (((((A1 * r + A2) * r + A3) * r + A4) * r + A5) * r + A6) * q / _
           (((((B1 * r + B2) * r + B3) * r + B4) * r + B5) * r + 1)

      ElseIf p > P_HIGH AndAlso p < 1 Then

         'Rational approximation for upper region.

         q = Sqrt(-2 * Log(1 - p))

         Return -(((((C1 * q + C2) * q + C3) * q + C4) * q + C5) * q + C6) / _
                ((((D1 * q + D2) * q + D3) * q + D4) * q + 1)

      Else

         Throw New ArgumentOutOfRangeException()

      End If

   End Function

End Module
"
Class {
	#name : #MlQuantileTransformer,
	#superclass : #MlTransformer,
	#instVars : [
		'nQuantiles',
		'distribution'
	],
	#category : #'Ml4St-Preprocessing'
}

{ #category : #'as yet unclassified' }
MlQuantileTransformer class >> sNormInv: p [
	|q r A1 A2 A3 A4 A5 A6 B1 B2 B3 B4 B5 C1 C2 C3 C4  C5 C6 D1 D2 D3 D4  P_LOW P_HIGH|
     
	"Coefficients in rational approximations."

    A1  := -39.696830286653757.
    A2  := 220.9460984245205.
    A3 := -275.92851044696869.
    A4 := 138.357751867269.
    A5 := -30.66479806614716.
    A6 := 2.5066282774592392.

    B1 := -54.476098798224058.
    B2 := 161.58583685804089.
    B3 := -155.69897985988661.
    B4 := 66.80131188771972.
    B5 := -13.280681552885721.

    C1 := -0.0077848940024302926.
    C2 := -0.32239645804113648.
    C3 := -2.4007582771618381.
    C4 := -2.5497325393437338.
    C5 := 4.3746641414649678.
    C6 := 2.9381639826987831.

    D1 := 0.0077846957090414622.
    D2 := 0.32246712907003983.
    D3 := 2.445134137142996.
    D4 := 3.7544086619074162.

	"Define break-points."

    P_LOW := 0.02425.
    P_HIGH := 1 - P_LOW.

	p > 0 & (p < P_LOW )
	ifTrue:[
		"Rational approximation for lower region."
		q := (-2 * (p log)) sqrt.
		^(((((C1 * q + C2) * q + C3) * q + C4) * q + C5) * q + C6) / 
            ((((D1 * q + D2) * q + D3) * q + D4) * q + 1)]

    ifFalse:[p >= P_LOW &  (p <= P_HIGH) ifTrue:[
         "Rational approximation for central region."
         q := p - 0.5.
         r := q * q.
         ^ (((((A1 * r + A2) * r + A3) * r + A4) * r + A5) * r + A6) * q / 
           (((((B1 * r + B2) * r + B3) * r + B4) * r + B5) * r + 1)]
      		ifFalse:[ p > P_HIGH & (p < 1 )ifTrue:[
         "Rational approximation for upper region."
         q := (-2 * ((1 - p) log)) sqrt.
         ^ -1 * ((((((C1 * q + C2) * q + C3) * q + C4) * q + C5) * q + C6) / 
                ((((D1 * q + D2) * q + D3) * q + D4) * q + 1))]
		ifFalse:[ Error signal]]]



]

{ #category : #accessing }
MlQuantileTransformer >> distribution [
	^ distribution ifNil:[ distribution := #uniform ]
]

{ #category : #accessing }
MlQuantileTransformer >> nQuantiles [
	^ nQuantiles ifNil:[ nQuantiles := 1000]
]

{ #category : #accessing }
MlQuantileTransformer >> nQuantiles: anInteger [
	nQuantiles := anInteger
]

{ #category : #accessing }
MlQuantileTransformer >> normalDistribution [
	distribution := #normal 
]

{ #category : #accessing }
MlQuantileTransformer >> uniformDistribution [
	distribution := #uniform 
]
