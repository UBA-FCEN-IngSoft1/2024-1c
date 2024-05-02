!classDefinition: #TDDBabyStepsGameWindow category: #TDDBabyStepsGame!
SystemWindow subclass: #TDDBabyStepsGameWindow
	instanceVariableNames: 'stepResultTextBoxMorph nextButtonMorph forceNextButtonMorph definitionButtonMorph gameJourneyTextBoxMorph testNumberLabel pointsLabel helpButtonMorph lastStepPoints stepSolutionButtonMorph resetButtonMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 5/2/2024 02:35:14'!
closeBoxHit

	| options userAnswer |
	options := #('No' 'Sí, eliminando todo el progreso' 'Sí, guardando el progreso aunque no pueda usarse en el juego nuevamente').
	userAnswer := (PopUpMenu labelArray: options) startUpWithCaption: '¿Desea salir del juego?'.
	
	userAnswer = 2 ifTrue: [ model resetGame. super closeBoxHit ].
	userAnswer = 3 ifTrue: [ super closeBoxHit ]
! !

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:19'!
refreshWindow
	
	stepResultTextBoxMorph updateAcceptedContents.
	gameJourneyTextBoxMorph updateAcceptedContents.
	
	self updateStepAndPoints.
	self updateStepResultBorderColor.
	
	lastStepPoints := model score.! !

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:54'!
updateStepAndPoints

	| currentStepToShow |
	
	currentStepToShow := model currentStep.
	(currentStepToShow > model numberOfTests) ifTrue: [currentStepToShow := model numberOfTests].
	
	testNumberLabel contents: 'Test Number: ', currentStepToShow asString,'/', model numberOfTests asString.
	pointsLabel contents: 'Points: ', model score asString! !

!TDDBabyStepsGameWindow methodsFor: 'events' stamp: 'NR 9/28/2022 17:04:43'!
updateStepResultBorderColor

	lastStepPoints > model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightRed].
	lastStepPoints = model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightBlue].
	lastStepPoints < model score ifTrue: [stepResultTextBoxMorph borderColor: Color lightGreen]! !


!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:33:36'!
build1stRow
	
	| firstRow |

	testNumberLabel := LabelMorph contents:'Test Number:'.
	pointsLabel := LabelMorph contents:'Points:'.
	
	firstRow := LayoutMorph newRow.
	firstRow separation: 15;
	axisEdgeWeight: 1;
	addMorph: testNumberLabel;
	addMorph: pointsLabel.
	
	firstRow layoutSpec proportionalHeight: 0.	

	^firstRow
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 22:19:46'!
build2ndRow
		
	| row |
	
	stepResultTextBoxMorph := TextModelMorph textProvider: self model textGetter: #stepResultText textSetter: nil. 
	stepResultTextBoxMorph  innerTextMorph setProperty: #keyStroke: toValue: [ :key | stepResultTextBoxMorph innerTextMorph acceptContents ].
	stepResultTextBoxMorph borderWidth: 2; borderColor: Color lightBlue.
	stepResultTextBoxMorph layoutSpec proportionalWidth: 1.
	stepResultTextBoxMorph layoutSpec proportionalHeight: 1.
		
	row := LayoutMorph newColumn.
	row separation: 5; 
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents:'Step Result');
	addMorph: stepResultTextBoxMorph.
	
	row layoutSpec fixedHeight: 187.
	
	^row.
	
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:31:26'!
build3rdRow

	| row |

	row := LayoutMorph newRow.
	row separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: self build3rdRow1stColumn;
	addMorph: self build3rdRow2ndColumn.
		
	^row	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 4/29/2024 03:51:11'!
build3rdRow1stColumn

	| firstColumn |

	definitionButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #openDefinition label: 'Definition'.	
	nextButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #next label: 'Next'.	
	forceNextButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #forceNext label: 'Force Next'.	
	stepSolutionButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #stepSolution label: 'Reveal Step Solution'.		
		
	firstColumn := LayoutMorph newColumn.
	firstColumn separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: definitionButtonMorph;
	addMorph: nextButtonMorph;
	addMorph: forceNextButtonMorph;
	addMorph: stepSolutionButtonMorph.
	firstColumn layoutSpec fixedWidth: 10.
		
	^firstColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 5/1/2024 03:23:58'!
build3rdRow2ndColumn

	| secondColumn |
		
	gameJourneyTextBoxMorph := TextModelMorph textProvider: self model textGetter: #gameJourneyText textSetter: nil. 
	gameJourneyTextBoxMorph  innerTextMorph setProperty: #keyStroke: toValue: [ :key | gameJourneyTextBoxMorph innerTextMorph acceptContents ] .
	gameJourneyTextBoxMorph borderWidth: 1; borderColor: Color lightBlue.
	gameJourneyTextBoxMorph layoutSpec proportionalWidth: 1.
	gameJourneyTextBoxMorph layoutSpec proportionalHeight: 1.
				
	secondColumn := LayoutMorph newColumn.
	secondColumn  separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Game Journey');
	addMorph: gameJourneyTextBoxMorph.
		
	^secondColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 5/1/2024 19:57:48'!
build4rdRow

	| row col warningLabel1 warningLabel2 |

	warningLabel1 := LabelMorph contents: 'Warning: "Reveal..." and "Reset..." are destructive actions'.
	warningLabel2 := LabelMorph  contents: 'Your models and/or progression will be lost!!'.
	helpButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #openHelp label: 'Help!!'.		
	resetButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #resetGame label: 'Reset Game'.	
	
	col:= LayoutMorph newColumn.
	col addMorph: warningLabel1.
	col addMorph: warningLabel2.
	col axisEdgeWeight: 0.
	
	row := LayoutMorph newRow.
	row separation: 5;
	axisEdgeWeight: 1;
	addMorph: col;
	addMorph: helpButtonMorph;
	addMorph: resetButtonMorph.
	
	row layoutSpec fixedHeight: 20.
		
	^row	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 4/29/2024 03:45:29'!
buildMorphicWindow

	
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4rdRow.
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 9/24/2022 19:07:21'!
defaultExtent

	^ 600@760
	! !


!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 9/24/2022 19:59:05'!
initializeWith: aGameView gameName: aTitle 

	self setLabel: 'BabySteps: ',aTitle.
	self model: aGameView.
	self buildMorphicWindow.
	self openInWorld.
	self morphExtent: (self defaultExtent).
				
	self suscribeToModelEvents.
	
	lastStepPoints := model score.
	! !

!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 9/24/2022 19:21:40'!
suscribeToModelEvents

	^ self model when: #gameChanged send: #refreshWindow to: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameWindow class' category: #TDDBabyStepsGame!
TDDBabyStepsGameWindow class
	instanceVariableNames: ''!

!TDDBabyStepsGameWindow class methodsFor: 'instance creation' stamp: 'NR 9/24/2022 06:11:26'!
openWithGameView: gameView name: gameName 

	^self new initializeWith: gameView gameName: gameName! !


!classDefinition: #TDDBabyStepsGame category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGame
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/3/2022 08:29:29'!
build
	
	^ TDDBabyStepsGameView for: self buildGame.! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 4/29/2024 07:10:54'!
buildGame
	
	^ TDDBabyStepsGameBase startNamed: self name withCases: self cases withExtraCase:self extraCase withModels: self models withReset: self reset inCategory: 'TDDBabyStepsGame', self name capitalized withDefinition: self definition
	! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/1/2024 22:20:17'!
start

	game := self build.
	
	TDDBabyStepsGameRestLogger followGameView: game.
	
	TDDBabyStepsGameWindow openWithGameView: game name: self name.
	
	^ game start! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 5/2/2024 15:47:52'!
startOff

	game := self build.
	
	TDDBabyStepsGameWindow openWithGameView: game name: self name.
	
	^ game start! !


!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 5/3/2022 08:32:10'!
cases

	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 5/3/2022 08:32:43'!
extraCase
	
	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 4/29/2024 07:11:13'!
models

	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private - cases' stamp: 'NR 4/29/2024 07:11:33'!
reset

	self subclassResponsibility ! !


!TDDBabyStepsGame methodsFor: 'private' stamp: 'NR 5/3/2022 08:34:42'!
definition
	
	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'private' stamp: 'NR 5/3/2022 08:32:39'!
name
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGame class' category: #TDDBabyStepsGame!
TDDBabyStepsGame class
	instanceVariableNames: ''!

!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/3/2022 08:46:01'!
start
	
	^ self new start! !

!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/2/2024 15:47:39'!
startOffline
	
	^ self new startOff! !


!classDefinition: #TDDBabyStepsGameAnagrams category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameAnagrams
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameAnagrams methodsFor: 'private' stamp: 'NR 9/24/2022 22:50:54'!
definition
	
	^ 'Debe obtenerse todos los anagramas de una palabra (string). Por ej. todos los potenciales anagramas de "kata" son:
	
	''ktaa'' ''atka'' ''akat'' ''atak'' ''akta'' ''taka'' ''kata'' ''aatk'' ''tkaa'' ''aakt'' ''kaat'' ''taak''

Ayuda: Considere utilizar el mensaje #copyFrom:to: cuando sea necesario.
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private' stamp: 'NR 5/4/2022 07:48:12'!
name 
	
	^ 'Anagrams'! !


!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/8/2022 15:25:00'!
case01
	
	^ 'test01EmptyStringAnagramIsJustACollectionWithTheEmptyString

	self assert: (Set with: '''') equals: '''' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:07'!
case02

	^ 'test02OneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:''a'') equals: ''a'' anagrams
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:18'!
case03
	
	^ 'test03TwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:''ab'' with: ''ba'') equals: ''ab'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:59:42'!
case04
	
	^ 'test04ThreeCharStringAnagramReturnsAllThe6PossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''abc''.
	anagrams add: ''acb''.
	anagrams add: ''bac''.
	anagrams add: ''bca''.
	anagrams add: ''cab''.
	anagrams add: ''cba''.

	self assert: anagrams equals: ''abc'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 17:00:10'!
case05
	
	^ 'test05MoreThanThreeCharStringAnagramReturnsAllTheCorrectPossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''abcd''; add: ''abdc''; add: ''acbd''; add: ''acdb''; add: ''adbc''; add: ''adcb''; add: ''bacd''; add: ''badc''; add: ''bcad''; add: ''bcda''; add: ''bdac''; add: ''bdca''; add: ''cabd''; add: ''cadb''; add: ''cbad''; add: ''cbda''; add: ''cdab''; add: ''cdba''; add: ''dabc''; add: ''dacb''; add: ''dbac''; add: ''dbca''; add: ''dcab''; add: ''dcba''.

	self assert: anagrams equals: ''abcd'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:10:29'!
cases

	^ {self case01. self case02. self case03. self case04. self case05. }! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 5/4/2022 16:58:23'!
extraCase
	
	^ 'testExtraToCheckGeneralizationOnKata

	self assert: 40320 equals:`''abcdefgh'' anagrams` size.
	
	self assert: (`''abcdefgh'' anagrams`) includes: ''cghdbeaf''.
	
	self assert: 10080 equals: `''abcdefab'' anagrams` size
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 05:24:00'!
model01

	^'String compile: ''anagrams
	
	^Set with: '''''''' '' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 05:46:08'!
model02

	^'String compile: ''anagrams
	
	"1era versión:"
	"self ifEmpty: [^Set with: ''''''''].
	^Set with: ''''a'''' "
	
	"Última versión (Paso 3: Refactor):"
	^Set with: self'' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 05:50:54'!
model03

	^'String compile: ''anagrams
	
	self size < 2 ifTrue: [^Set with: self].
	
	"1era versión:"
	"^Set with:''''ab'''' with: ''''ba''''"
	
	"Última versión (Paso 3: Refactor):"
	^Set with: self with: self reverse'' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 06:15:47'!
model04

	^'String compile: ''anagrams
	
	| anagrams |
	
	self size < 2 ifTrue: [^Set with: self].
	
	self size = 2 ifTrue: [^Set with: self with: self reverse].
	
	anagrams := Set new.
	
	"1era versión:"
	"anagrams add: ''''abc''''.
	anagrams add: ''''acb''''.
	anagrams add: ''''bac''''.
	anagrams add: ''''bca''''.
	anagrams add: ''''cab''''.
	anagrams add: ''''cba''''."
	
	"2da versión (Paso 3: Refactor):"
	"Se agrega abc y acb."
	"anagrams add: (self copyFrom: 1 to: 1), ((self copyFrom: 2 to: 3) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 1 to: 1), ((self copyFrom: 2 to: 3) anagrams asOrderedCollection at: 2)."
		
	"Se agrega bac y bca."
	"anagrams add: (self copyFrom: 2 to: 2), (((self copyFrom: 1 to: 1),(self copyFrom: 3 to: 3)) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 2 to: 2), (((self copyFrom: 1 to: 1),(self copyFrom: 3 to: 3)) anagrams asOrderedCollection at: 2)."
		
	"Se agrega cab y cba"
	"anagrams add: (self copyFrom: 3 to: 3), ((self copyFrom: 1 to: 2) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 3 to: 3), ((self copyFrom: 1 to: 2) anagrams asOrderedCollection at: 2)."
	
	"3era versión (Paso 3: Refactor):"
	"anagrams add: (self copyFrom: 1 to: 1), ((self dropCharacterAt: 1) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 1 to: 1), ((self dropCharacterAt: 1) anagrams asOrderedCollection at: 2).
		
	anagrams add: (self copyFrom: 2 to: 2), ((self dropCharacterAt: 2) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 2 to: 2), ((self dropCharacterAt: 2) anagrams asOrderedCollection at: 2).
		
	anagrams add: (self copyFrom: 3 to: 3), ((self dropCharacterAt: 3) anagrams asOrderedCollection at: 1).
	anagrams add: (self copyFrom: 3 to: 3), ((self dropCharacterAt: 3) anagrams asOrderedCollection at: 2)."
	
	"Última versión (Paso 3: Refactor):"
	anagrams add: (self asStringAt:1), ((self dropCharacterAt: 1) anagrams asOrderedCollection at: 1).
	anagrams add: (self asStringAt:1), ((self dropCharacterAt: 1) anagrams asOrderedCollection at: 2).
		
	anagrams add: (self asStringAt:2), ((self dropCharacterAt: 2) anagrams asOrderedCollection at: 1).
	anagrams add: (self asStringAt:2), ((self dropCharacterAt: 2) anagrams asOrderedCollection at: 2).
		
	anagrams add: (self asStringAt:3), ((self dropCharacterAt: 3) anagrams asOrderedCollection at: 1).
	anagrams add: (self asStringAt:3), ((self dropCharacterAt: 3) anagrams asOrderedCollection at: 2).
	
	
	^anagrams'' classified: ''anagrams''.
	
	
	String compile: ''asStringAt: index
	
	^self copyFrom: index to: index'' classified: ''anagrams''.
	
	
	String compile: ''dropCharacterAt: index
	
	"(self copyFrom: 1 to: 1), ((self copyFrom: 2 to: 3) anagrams"
	"(self copyFrom: 2 to: 2), (((self copyFrom: 1 to: 1),(self copyFrom: 3 to: 3)) anagrams"
	"(self copyFrom: 3 to: 3), ((self copyFrom: 1 to: 2) anagrams"
	
	^(self copyFrom:1 to: index-1), (self copyFrom: index+1 to: self size).'' classified: ''anagrams''.
	
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 06:28:13'!
model05

	^'String compile: ''anagrams
	
	| anagrams head tails |
	
	self isEmpty ifTrue: [^Set with: self].
	
	anagrams := Set new.

	1 to: self size do:[ :index | head := self asStringAt: index.
						  tails := (self dropCharacterAt: index) anagrams.
						  anagrams addAll: (tails collect:[:tail | head,tail])].
		
	^anagrams. '' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 05:26:41'!
models

	^ {self model01. self model02. self model03. self model04. self model05. }! !

!TDDBabyStepsGameAnagrams methodsFor: 'private - cases' stamp: 'NR 4/30/2024 06:30:32'!
reset
	
	^ '[String removeSelector: #anagrams]  on: Error do:[].
	[String removeSelector: #asStringAt:]  on: Error do:[].
	[String removeSelector: #dropCharacterAt:]  on: Error do:[].'
	! !


!classDefinition: #TDDBabyStepsGameContador category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameContador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameContador methodsFor: 'private' stamp: 'NR 5/3/2022 08:40:17'!
definition
	
	^ ' Implementar un contador que recibe el mensaje incrementar para incrementar en 1 su valor.
	El contador debe comenzar en 0.
	El contador tambien sabe responder el mensaje value para obtener su valor.
'! !

!TDDBabyStepsGameContador methodsFor: 'private' stamp: 'FL 11/9/2021 20:23:07'!
name 
	^ 'Contador'! !


!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:45:51'!
case01
	^ 'test01UnNuevoContadorEmpiezaConValorCero

	| contador |
		
	contador := Contador new.
	self assert: 0 equals: contador valor.
	'! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:45:58'!
case02
	^ 'test02AlIncrementarUnaVezElContadorSuValorSubeUno

	| contador |

	contador := Contador new.
	contador incrementar.
	self assert: 1 equals: contador valor.
	' ! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:46:06'!
case03
	^ 'test03SePuedeIncrementarVariasVecesElContadorYSuValorIncrementaEnUnoEsaCantidadDeVeces

	| contador |

	contador := Contador new.
	contador incrementar.
	contador incrementar.
	contador incrementar.
	self assert: 3 equals: contador valor.
	'! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'FL 11/9/2021 20:22:50'!
cases
	^ {self case01. self case02. self case03. }! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 9/29/2022 14:46:18'!
extraCase
	
	^ 'extraTest
	
	self assert: true.
	' ! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 4/29/2024 06:47:13'!
model01
	
	^ 'Object subclass: #Contador
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameContador''.
	
	Contador compile: ''valor
	
	^0'' classified: ''value''.
	
	'.! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 4/29/2024 06:47:28'!
model02
	
	^ 'Object subclass: #Contador
	instanceVariableNames: ''value''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameContador''.
	
	Contador compile: ''valor
	
	^value'' classified: ''value''.
	
	Contador compile: ''incrementar
	
	value := 1'' classified: ''value''.
	
	Contador compile: ''initialize
	
	value := 0'' classified: ''initialization''.
	
	'.
	! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 4/29/2024 06:50:34'!
model03
	
	^ 'Contador compile: ''incrementar
	
	value := value + 1'' classified: ''value''.
	
	'.	! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:39:39'!
models
	^ {self model01. self model02. self model03. }
! !

!TDDBabyStepsGameContador methodsFor: 'private - cases' stamp: 'NR 4/29/2024 07:07:23'!
reset
	
	^ '[Contador selectors do: [:selector | Contador removeSelector: selector]. 
	Contador removeFromSystem ] on: Error do:[]'! !


!classDefinition: #TDDBabyStepsGamePrimeFactors category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGamePrimeFactors
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGamePrimeFactors methodsFor: 'private' stamp: 'NR 9/29/2022 05:23:04'!
definition
	
	^ 'Deben obtenerse los factores primos de un número natural. Por ej. 850 factorize debe retornar 2,5,5 y 17.

Ayuda: Considere utilizar el mensaje #isDivisibleBy: cuando sea necesario.
'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private' stamp: 'NR 5/2/2022 02:05:56'!
name 
	
	^ 'PrimeFactors'! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:15:28'!
case01
	
	^ 'test01OneHasNoPrimeFactors
	
	self assert: Bag new equals: 1 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/8/2022 16:43:51'!
case02

	^ 'test02FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 2) equals: 2 factorize
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/8/2022 16:44:00'!
case03
	
	^ 'test03FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 3) equals: 3 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:26:12'!
case04
	
	^ 'test04CorrectlyFactorizesACompositeNumberWithTwoFactors2
	
	self assert: (Bag with: 2 with: 2) equals: 4 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:25:29'!
case05
	
	^ 'test08CorrectlyFactorizesACompositeNumberWithMoreThanTwoFactors2
	
	self assert: (Bag with: 2 with: 2 with: 2) equals: 8 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/4/2022 07:26:29'!
case06
	
	^ 'test09CorrectlyFactorizesACompositeNumberWithMoreThanOneFactorsDifferentThan2
	
	self assert: (Bag with: 3 with: 3) equals: 9 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 5/2/2022 02:11:29'!
cases
	
	^ {self case01. self case02. self case03. self case04. self case05. self case06. }! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:23'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
	
	self assert: (Bag with: 2 with: 2 with: 3 with: 3 with: 5 with: 13) equals: (2*2*3*3*5*13) factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:34:51'!
model01
	
	^'SmallInteger compile: ''factorize
	
	^Bag new'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:35:48'!
model02
	
	^'SmallInteger compile: ''factorize
	
	self = 1 ifTrue: [^Bag new].
	^Bag with: 2'' classified: ''arithmetic''
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:36:19'!
model03
	
	^'SmallInteger compile: ''factorize
	
	self = 1 ifTrue: [^Bag new].
	^Bag with: self'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:37:18'!
model04
	
	^'SmallInteger compile: ''factorize
	
	| factors leftToFactorize |
	
	factors := Bag new.
	
	leftToFactorize := self.
	(leftToFactorize isDivisibleBy: 2) ifTrue: [factors add: 2. leftToFactorize := leftToFactorize / 2].
	
	(leftToFactorize > 1) ifTrue: [factors add: leftToFactorize].
	
	^factors.'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:38:09'!
model05
	
	^'SmallInteger compile: ''factorize
	
	| factors leftToFactorize |
	
	factors := Bag new.
	
	leftToFactorize := self.
	[leftToFactorize isDivisibleBy: 2] whileTrue: [factors add: 2. leftToFactorize := leftToFactorize / 2].
	
	(leftToFactorize > 1) ifTrue: [factors add: leftToFactorize].
	
	^factors.'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:54:49'!
model06
	
	^'SmallInteger compile: ''factorize
	
	| factors leftToFactorize divisor |
	
	factors := Bag new.
	
	leftToFactorize := self.
	divisor := 2.
	
	[leftToFactorize > 1] whileTrue:[
		[leftToFactorize isDivisibleBy: divisor] whileTrue: 
			[factors add: divisor. 
			leftToFactorize := leftToFactorize / divisor].
		divisor := divisor + 1.
	].
	
	^factors.'' classified: ''arithmetic''
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:40:22'!
models
	^ {self model01. self model02. self model03. self model04. self model05. self model06 }
! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'private - cases' stamp: 'NR 4/30/2024 01:41:58'!
reset
	
	^ '[SmallInteger removeSelector: #factorize]  on: Error do:[]'! !


!classDefinition: #TDDBabyStepsGameRot13 category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameRot13
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRot13 methodsFor: 'private' stamp: 'NR 9/25/2022 04:30:53'!
definition
	
	^ 'ROT13 («rotar 13 posiciones») es un sencillo cifrado César utilizado para ocultar un texto sustituyendo cada letra por la letra que está trece posiciones por delante en el alfabeto. 
	
- A se convierte en N, B se convierte en O y así hasta la M, que se convierte en Z. 
	
- Luego la secuencia se invierte: N se convierte en A, O se convierte en B y así hasta la Z, que se convierte en M. 

Ver gráfico en: https://es.wikipedia.org/wiki/ROT13
Probar en: https://rot13.com/

Ayuda: Considere utilizar los mensajes #asciiValue, #asciiValue: #between:and: cuando sea necesario.

'! !

!TDDBabyStepsGameRot13 methodsFor: 'private' stamp: 'NR 5/2/2022 02:06:01'!
name 
	
	^ 'Rot13'! !


!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:41'!
case01

	^ 'test01CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $n equals: $a asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:47'!
case02

	^ 'test02CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $z equals: $m asRot13
	'
	! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:51'!
case03
	
	^ 'test03CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $a equals: $n asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:55'!
case04
	
	^ 'test04CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $m equals: $z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:11:59'!
case05

	^ 'test05CharOnTheBelowRangeDoesntChange
	
	self assert: $` equals: $` asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:03'!
case06

	^ 'test06CharOnTheUpperRangeDoesntChange
	
	self assert: ${ equals: ${ asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:06'!
case07
	
	^ 'test07CorrectlyEncodesAnUppercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $N equals: $A asRot13.
	self assert: $Z equals: $M asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:10'!
case08
	
	^ 'test08CorrectlyEncodesAnUppercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $A equals: $N asRot13.
	self assert: $M equals: $Z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:14'!
case09

	^ 'test09TheEmptyStringDoesntChange
	
	self assert: '''' equals: '''' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:18'!
case10

	^ 'test10CorrectlyEncodesAOneCharString
	
	self assert: ''n'' equals: ''a'' asRot13.
	self assert: ''Z'' equals: ''M'' asRot13.
	self assert: ''a'' equals: ''n'' asRot13.
	self assert: ''{'' equals: ''{'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:23'!
case11
	
	^ 'test11CorrectlyEncodesATwoCharString
	
	self assert: ''nm'' equals: ''az'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:26'!
case12

	^ 'test12CorrectlyEncodesMoreThanTwoCharString
	
	self assert: ''uByN!!'' equals: ''hOlA!!'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:32'!
cases

	^ {self case01. self case02. self case03. self case04. self case05. self case06. self case07. self case08. self case09. self case10. self case11. self case12 }! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 9/25/2022 18:12:37'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
		
	self assert: ''Ju3er j3 4e3 t01at j3 q0ag a3rq e04q$...'' equals: ''Wh3re w3 4r3 g01ng w3 d0nt n3ed r04d$...'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 02:17:05'!
model01

	^'Character compile: ''asRot13
	
	^$n'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:55:01'!
model02

	^'Character compile: ''asRot13
	
	"1era versión:"
	"self = $a ifTrue: [^$n].
	^$z."
	
	"2da versión (Paso 3: Refactor):"
	"self = $a ifTrue: [^$n].
	self = $m ifTrue: [^$z]."
	
	"Última versión (Paso 3: Refactor):"
	^Character asciiValue: self asciiValue + 13'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 02:40:57'!
model03

	^'Character compile: ''asRot13
	
	self asciiValue < $n asciiValue ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	^$a'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:55:21'!
model04

	^'Character compile: ''asRot13
	
	self asciiValue < $n asciiValue ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	"1era versión:"
	"self = $n ifTrue: [^$a].
	^$m"
	
	"2da versión (Paso 3: Refactor):"
	"self = $n ifTrue: [^$a].
	self = $z ifTrue: [^$m]."
	
	"Última versión (Paso 3: Refactor):"
	^Character asciiValue: self asciiValue - 13'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 03:34:15'!
model05

	^'Character compile: ''asRot13
	
	(self asciiValue >= $a asciiValue and: [self asciiValue <= $m asciiValue]) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	self asciiValue >= $n asciiValue ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:55:39'!
model06

	^'Character compile: ''asRot13
	
	"1era versión:"
	"(self asciiValue >= $a asciiValue and: [self asciiValue <= $m asciiValue]) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue >= $n asciiValue and: [self asciiValue <= $z asciiValue]) ifTrue:
		[^Character asciiValue: self asciiValue - 13]."
		
	"Última versión (Paso 3: Refactor):"
	(self asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:55:59'!
model07

	^'Character compile: ''asRot13
	
	"1era versión:"
	"(self asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
	
	self =$A ifTrue:[^$N].
	self =$M ifTrue: [^$Z]."
	
	"2da versión (Paso 3: Refactor):"
	"(self asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
	
	(self asciiValue between: $A asciiValue and: $M asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13]."
		
	"3era versión (Paso 3: Refactor):"
	"((self asciiValue between: $a asciiValue and: $m asciiValue) or: [self asciiValue between: $A asciiValue and: $M asciiValue]) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13]."
		
	"Última versión (Paso 3: Refactor):"	
	(self asLowercase asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 03:47:38'!
model08

	^'Character compile: ''asRot13
	
	(self asLowercase asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asLowercase asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:41:56'!
model09

	^'String compile: ''asRot13
	
	^'''''''' ''classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 05:09:46'!
model10

	^'String compile: ''asRot13
	
	self isEmpty ifTrue: [^''''''''].
	
	"1era versión:"
	"self = ''''a'''' ifTrue: [^''''n''''].
	self = ''''M'''' ifTrue: [^''''Z''''].
	self = ''''n'''' ifTrue: [^''''a''''].
	self = ''''{'''' ifTrue: [^''''{'''']."
	
	"Última versión (Paso 3: Refactor):"
	^self first asRot13 asString'' classified: ''printing'' 
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:44:31'!
model11

	^'String compile: ''asRot13
	
	self isEmpty ifTrue: [^''''''''].
	
	self size = 1 ifTrue:[^self first asRot13 asString].
	
	^self first asRot13 asString, (self at:2) asRot13 asString'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:14:56'!
model12

	^'String compile: ''asRot13
	
	^self collect: [:aChar | aChar asRot13]'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 04:13:19'!
models

	^ {self model01. self model02. self model03. self model04. self model05. self model06. self model07. self model08. self model09. self model10. self model11. self model12 }! !

!TDDBabyStepsGameRot13 methodsFor: 'private - cases' stamp: 'NR 4/30/2024 02:27:26'!
reset
	
	^ '[Character removeSelector: #asRot13]  on: Error do:[].
	[String removeSelector: #asRot13]  on: Error do:[].'! !


!classDefinition: #TDDBabyStepsGameBase category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameBase
	instanceVariableNames: 'name casesToTest currentStep currentStepReturnMessage category score currentTest journey definition extraTest models resetBlock state prematureDecisionVerifierStrategy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2022 23:07:11'!
addEntryToJourney

	currentStepReturnMessage ifNotEmpty: [ journey add: 	currentStepReturnMessage ]! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2024 08:27:38'!
clearCurrentStepReturnMessage
	
	currentStepReturnMessage := TDDBabyStepsGameCodedMessage emptyMessage ! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 9/24/2022 22:30:32'!
finalScoreLine

	| finalGrade |
	
	finalGrade := String streamContents: [ :strm | self grade printOn: strm fractionDigits: 2 ].

	^ 'Tu puntaje final es: {1} puntos de {2} posibles. Tu nota por la kata es un {3}/10.' format: { score.  self totalObtainablePoints. finalGrade }! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 5/1/2024 08:56:56'!
informGrade
	
	currentStepReturnMessage updateAddingDescription: self newLine, self finalScoreLine 
	! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 9/25/2022 18:17:29'!
newLine

	^ String with: Character newLineCharacter
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - journey' stamp: 'NR 4/29/2024 17:08:33'!
resetGame

	Compiler evaluate: resetBlock.
	
	self testCaseClass selectors do: [:selector | self testCaseClass removeSelector: selector].
	self testCaseClass removeFromSystem.
	
	self initializeToStep0 
	"self initializeNamed: name withCases: casesToTest withExtraCase: extraTest inCategory: category withDefinition: definition" 

	! !


!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:40'!
forcedNextPointsCost

	^ 5! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 9/24/2022 22:31:32'!
grade
	
	| gradeableScore |
	
	gradeableScore := self score.
	gradeableScore  < 0 ifTrue: [ gradeableScore := 0 ].
	
	^ (gradeableScore / self totalObtainablePoints * 10) asFloat! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:31'!
prematureDecisionsMadePointsCost

	^ 1! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:37:09'!
testPassedEarlyBonusPoints

	^ 0! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:47'!
testsDoNotPassPointsCost

	^ 1! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:37:19'!
testsPassedBonusPoints

	^ 5! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 9/25/2022 18:18:11'!
totalObtainablePoints

	^ self numberOfTests * self testsPassedBonusPoints! !


!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 9/25/2022 18:14:23'!
finishGame

	state := GameEnded for: self.
	self hasPassedExtraTest ifTrue: [ self gameEndedGeneralizedCorrectly ] ifFalse: [ self gameEndedGeneralizedIncorrectly ].
	self informGrade.
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/1/2024 20:27:42'!
forceNextOnNormalStep
	
	self nextOnPrematureDecisionsDo: [ self stepCompleted. self decreaseScoreAsForcedNext. ]
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 09:23:32'!
increaseScoreOnEndedGame
	
	self error: self class increaseScoreOnEndedGameErrorMessage.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:09:23'!
increaseScoreOnNormalStep
	
	self increaseScoreAsCurrentTestsPassed
				
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 07:46:54'!
increaseScoreOnPrematureDecisionStep
	
	self increaseScoreAsLatestTestPassedEarly.
	state := OnNormalStep for: self.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:13:48'!
increaseScoreOnStartingGame
	
	self error: self class increaseScoreOnStartingGameErrorMessage.
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/1/2024 18:10:50'!
informGameStartsAnd1stTestCreated

	| message |
	
	self clearCurrentStepReturnMessage.
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameStarting description:  'Test01 creado correctamente. Páselo y presione next para continuar.' .
	
	currentStepReturnMessage updateAddingMessage: message.
	
	self addEntryToJourney! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 07:48:00'!
nextOnEndedGame
	
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/1/2024 20:26:03'!
nextOnNormalStep
	
	self nextOnPrematureDecisionsDo: [ self decreaseScoreAsPrematureDecisionsMade. ]! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/1/2024 20:25:36'!
nextOnPrematureDecisionsDo: prematureActionToBeTaken
	
	self tryToPassTestsAndEvaluate: [	
		(self prematureDecisionMade)
			ifTrue: prematureActionToBeTaken 
			ifFalse:[ self stepCompleted ]
		]
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 10/13/2022 06:18:23'!
nextOnStartingGame
	
	self informGameStartsAnd1stTestCreated.
	self increaseCurrentStep.
	self addTestToTheTestCaseClass.
	state := OnNormalStep for: self.
	! !


!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:27:55'!
currentNewTestPassesEarly
	
	^ currentTest isNil not and: [ self hasPassedCurrentTest ]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:32:26'!
detectPrematureDecisionOnNewStep
	
	self currentNewTestPassesEarly ifTrue: [ 
		state := OnPrematureDecisionStep for: self]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/29/2024 16:22:59'!
eliminateAllCurrentPositivePoints

	score > 0 ifTrue: [ score := 0 ]! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2024 08:42:52'!
eliminateAllCurrentPositivePointsWithMessage: codedMessage

	self eliminateAllCurrentPositivePoints.
	currentStepReturnMessage updateAddingMessage: codedMessage .
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/29/2024 16:49:02'!
forceNextMessage

	^ 'Pero utilizaste el forceNext para avanzar, por lo que restás {1} puntos.'! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2024 17:12:08'!
gameEndedGeneralizedCorrectly
	
	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameEndedCorrectGeneralization description: self newLine, '¡Felicitaciones!! ', self class endOfGameMessage, ' Has generalizado la solución correctamente.'.
	
	currentStepReturnMessage updateAddingMessage: message
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2024 17:21:57'!
gameEndedGeneralizedIncorrectly
	
	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameEndedIncompleteGeneralization description: self newLine, self class endOfGameMessage, ' Pero si bien pasas los tests, no has generalizado la solución lo suficiente.'.
	
	self eliminateAllCurrentPositivePointsWithMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:46'!
gameHasEnded

	^ currentStep > self numberOfTests! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:52'!
increaseCurrentStep

	currentStep := currentStep  + 1
! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 9/25/2022 18:14:55'!
numberOfTests

	^ casesToTest size! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/26/2023 19:23:21'!
prematureDecisionMade
	
	^ currentStep < self numberOfTests and: [ prematureDecisionVerifierStrategy value ]
	
	"^ currentStep < self numberOfTests and: [ self someOfTheNextTestsPass ]"
	"^ currentStep < self numberOfTests and: [ self hasPassedNextTest ]"! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 10/13/2022 05:32:26'!
stepCompleted

	self increaseScore.
	self increaseCurrentStep.
	self gameHasEnded
		ifTrue: [ self finishGame ]
		ifFalse: [ self addTestToTheTestCaseClass.
			self detectPrematureDecisionOnNewStep ]
! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/29/2024 16:58:17'!
stepSolution
	
	state stepSolution 
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 4/29/2024 17:05:25'!
stepSolutionOnNotOngoingGame
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/1/2024 21:25:32'!
stepSolutionOnOngoingGame
	
	| message |
	
	"#Tech Debt"
	
	self clearCurrentStepReturnMessage.
	
	state := 	OnPrematureDecisionStep for: self.
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForUsedStepSolution description: ('Al revelar la solución hasta este paso se pierden todos los puntos conseguidos hasta el momento. Tu puntaje actual es de {1} puntos.' format: {score}).
	
	self eliminateAllCurrentPositivePointsWithMessage: message.
	
	1 to: currentStep do: [:step | Compiler evaluate: (models at: step)].
	
	self addEntryToJourney.
	
! !

!TDDBabyStepsGameBase methodsFor: 'private' stamp: 'NR 5/3/2022 07:07:59'!
tryToPassTestsAndEvaluate: aTestsPassBlock
	
	self clearCurrentStepReturnMessage.
		
	self runSuiteIfPassDo: aTestsPassBlock
		ifDoesNotPass: [ self decreaseScoreAsTestsDoNotPass. ]
	
	
! !


!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:13:00'!
browseTestCase

	BrowserWindow fullOnClass: self testCaseClass
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:01'!
hasPassedCurrentTest

	^ self runCurrentTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:07'!
hasPassedExtraTest

	^ self runExtraTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:12'!
hasPassedNextTest

	^ self runNextTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:16'!
runCurrentTest

	^ self runTest: currentTest
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:20'!
runExtraTest

	^ self runTest: (self compileTestFromMethod: extraTest)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:42:49'!
runNextTest

	^ self runNextTest: self nextTest
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:42:08'!
runNextTest: aCaseToTest

	| nextTestName results |
	nextTestName := (self compileTestFromMethod: aCaseToTest).
	results := self runTest: nextTestName.
	self testCaseClass removeSelector: nextTestName.
	^ results
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:44:25'!
runNextTestNumber: aTestNumber

	^ self runNextTest: (casesToTest at: aTestNumber)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/24/2022 21:07:25'!
runSuiteIfPassDo: aTestsPassBlock ifDoesNotPass: aTestsDoesNotPassBlock
		
	| testResult |

	testResult _ self testSuite run.	
	
	testResult hasPassed 
		ifTrue: aTestsPassBlock
		ifFalse: aTestsDoesNotPassBlock.
	
	self addEntryToJourney.
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/13/2022 05:51:21'!
runTest: aTestName

	| suite |
	suite _ TestSuite forCompiledMethod: self testCaseClass >> aTestName.
	^ suite run
	
	! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 10/4/2022 19:33:09'!
someOfTheNextTestsPass

	^ (currentStep + 1 to: self numberOfTests) anySatisfy: [ :numberOfTest | (self runNextTestNumber: numberOfTest) hasPassed]! !

!TDDBabyStepsGameBase methodsFor: 'private - tests' stamp: 'NR 9/25/2022 18:16:34'!
testSuite

	^ TestSuite forClass: self testCaseClass! !


!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:12:52'!
addTestToTheTestCaseClass

	currentTest := self testCaseClass compile: self currentTest classified: 'tests'! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:12'!
compileTestFromMethod: aTestMethod

	^ self testCaseClass compile: aTestMethod classified: 'tests'! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:21'!
createTestCaseClass

	Compiler evaluate: self createTestCaseDefinition! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:30'!
createTestCaseDefinition

	^ 'TestCase subclass: #{1}
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''{2}''' format: {self testCaseName. self testCaseCategory }! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:36'!
currentStep

	^ currentStep! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'JMB 10/28/2021 19:56:16'!
currentTest

	^ casesToTest at: currentStep! !

!TDDBabyStepsGameBase methodsFor: 'private - test case building' stamp: 'NR 9/25/2022 18:13:42'!
nextTest

	^ casesToTest at: currentStep + 1! !


!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:15:34'!
testCaseCategory

	^ category! !

!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:12:44'!
testCaseClass

	^ Smalltalk at: self testCaseName ! !

!TDDBabyStepsGameBase methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:15:41'!
testCaseName

	^ ('TDDBabySteps{1}Test' format: {name capitalized}) asSymbol! !


!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 5/3/2022 08:13:17'!
forceNext
	
	state forceNext
		
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:00'!
journey

	^ journey! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:04'!
lastStepTakenIfNone: exceptionBlock

	^ journey lastIfEmpty: exceptionBlock ! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:08'!
next

	state next
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:11'!
score

	^ score! !


!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:13:59'!
definition

	^ definition! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/24/2022 22:45:28'!
help
	
	^ '0- Iniciar un juego. Si llegó hasta aquí es que ya hizo: 
	
	game:=TDDBabyStepsGameXXXX start.
	
1- Usted comienza con un puntaje de 0 puntos. Al comenzar se creará la clase de test y se abrirá un class browser.  

2- Para obtener el primer caso de test a pasar presione el botón "next".

3- Una vez finalizada la implementación para ese test presione nuevamente el botón de "next":

- Si sus tests pasan, ganará 5 puntos y se le presentará el próximo test.
- Si sus tests no pasan, perderá 1 punto y deberá seguir intentando haciendolos pasar.
- Si sus test pasan pero se adelantó con su implementación (no es mínima) perderá 1 punto y deberá intentar reformularla para no adelanterse pasos.

3''- IMPORTANTISIMO: Tenga SIEMPRE en mente que hacer "game next" le escribirá un nuevo test. Si desea hacer un "paso 3" de refactor/generalización, hagalo ANTES de presionar "next".

4- Si no logra llegar a la implementación mínima siempre puede presionar el botón "forceNext" para seguir avanzando. De esta manera se le presentará el próximo test (el cual pasará directamente con la implementación propuesta) y así entender en que se había adelantado. Pero ¡Atención!! De hacerlo se le restaran 5 puntos y ademas el nuevo test presentado no sumará puntos pues ya pasaba de entrada al efectuar el "forceNext".

5- Preste atención a las indicaciones descriptas en la sección "Step Result". En "Game Journey" podrá ir visualizando el resumen de su trayecto actual en el juego.

6- Cuando los tests se acaben el juego habrá terminado y se le presentará un puntaje junto a su nota final por el ejercicio. Pero ¡Atención nuevamente!! Si sólo se encargó de pasar los tests y nunca generalizó utilizando un paso 3, puede que pierda TODOS su puntos si no logra pasar un último test extra de generalización. Con lo que, ¡No se olviden de generalizar!!

Notas extras: 
a) Para practicar, antes de presionar "next" puede pensar y anotar en un papel cual cree que sería el próximo test a pasar y así comparar por el que presenta el juego.
b) Al terminar el juego puede pensar cuales de los tests presentados habría que mantener y cuales podrían eliminarse por estar repetidos. Verificar además los nombres de los mismos comparando dato de test con caso de test.
c) Si quiere recomenzar un mismo juego, no olvide eliminar manualmente 1. Todos los casos de tests generados automaticamente por el juego y 2. La implementación que haya escrito hasta el momento.
'! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:14:09'!
name

	^ name! !


!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 4/29/2024 17:13:36'!
initializeNamed: aName withCases: aCasesToTest withExtraCase: anExtraCase inCategory: aCategory withDefinition: aDefinition 
	
	name := aName.
	casesToTest := aCasesToTest.
	extraTest :=anExtraCase.
	category := aCategory.
	definition := aDefinition. 
	prematureDecisionVerifierStrategy  := [self hasPassedNextTest].
	"prematureDecisionVerifierStrategy  := [self someOfTheNextTestsPass]."
	self initializeToStep0.! !

!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 5/1/2024 07:35:21'!
initializeNamed: aName withCases: aCasesToTest withExtraCase: anExtraCase withModels: correctModels withReset: reset inCategory: aCategory withDefinition: aDefinition 
	
	name := aName.
	casesToTest := aCasesToTest.
	models := correctModels.
	extraTest :=anExtraCase.
	resetBlock := reset.
	category := aCategory.
	definition := aDefinition. 
	prematureDecisionVerifierStrategy  := [self hasPassedNextTest].
	"prematureDecisionVerifierStrategy  := [self someOfTheNextTestsPass]."
	self initializeToStep0.! !

!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 4/29/2024 17:13:13'!
initializeToStep0

	currentStep := 0.
	score := 0.
	state := GameStarting for: self.
	journey := OrderedCollection new.
	self createTestCaseClass! !


!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 17:08:55'!
decreaseScoreAsForcedNext

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedViaForceNext description: self newLine, self forceNextMessage. 

	self decreaseScoreBy: self forcedNextPointsCost withMessage: message ! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 17:09:49'!
decreaseScoreAsPrematureDecisionsMade

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForCantAdvancePrematureDecisionsMade description: self class prematureDecisionsMadeErrorMessage, self newLine, 'Restás {1} punto.'.
	
	self decreaseScoreBy: self prematureDecisionsMadePointsCost withMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 17:11:08'!
decreaseScoreAsTestsDoNotPass

	| message |
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForCantAdvanceTestsDoNotPass description: self class testsDoNotPassErrorMessage, self newLine, 'Restás {1} punto.'.
	
	self decreaseScoreBy: self testsDoNotPassPointsCost withMessage:message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 19:32:29'!
decreaseScoreBy: points withMessage: codedMessage
	
	score := score - points.
	currentStepReturnMessage updateAddingMessage: codedMessage.
	currentStepReturnMessage updateAddingDescription: ' Tu puntaje actual es de {2}.' format: {points. score} .
	
	! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/3/2022 07:44:57'!
increaseScore
	
	state increaseScore.
	

	

! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 17:22:23'!
increaseScoreAsCurrentTestsPassed

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedBabyStepsCorrect description: 'Has completado el test actual, sumás {1} puntos.'.
	
	self increaseScoreBy: self testsPassedBonusPoints withMessage: message
	! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 17:23:06'!
increaseScoreAsLatestTestPassedEarly

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedTestAlreadyPassedPrematureDecisions description:  'Sumás {1} puntos porque pasaste este test de entrada. Avanzás al siguiente test.'.
	
	self increaseScoreBy: self testPassedEarlyBonusPoints withMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/1/2024 19:32:37'!
increaseScoreBy: points withMessage: message
	
	score := score + points.
	currentStepReturnMessage updateAddingMessage: message.
	currentStepReturnMessage updateAddingDescription: ' Tu puntaje actual es de {2}.' format: {points. score} 	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameBase class' category: #TDDBabyStepsGame!
TDDBabyStepsGameBase class
	instanceVariableNames: ''!

!TDDBabyStepsGameBase class methodsFor: 'instance creation' stamp: 'NR 4/29/2024 07:19:24'!
startNamed: aName withCases: casesToTest withExtraCase:extraCase inCategory: aCategory withDefinition: aDefinition  
	
	^self new initializeNamed: aName withCases: casesToTest withExtraCase: extraCase inCategory: aCategory withDefinition: aDefinition ! !

!TDDBabyStepsGameBase class methodsFor: 'instance creation' stamp: 'NR 4/29/2024 07:20:18'!
startNamed: aName withCases: casesToTest withExtraCase:extraCase withModels: models withReset: reset inCategory: aCategory withDefinition: aDefinition  
	
	^self new initializeNamed: aName withCases: casesToTest withExtraCase: extraCase withModels:models withReset:reset inCategory: aCategory withDefinition: aDefinition ! !


!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 21:18:15'!
endOfGameMessage
	
	^ 'Has finalizado el juego/kata.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 5/3/2022 09:20:42'!
increaseScoreOnEndedGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego terminado.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 10/13/2022 06:13:34'!
increaseScoreOnStartingGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego que recíen comienza (sin tests).'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 19:13:53'!
prematureDecisionsMadeErrorMessage
	
	^ '¡Te estás adelantando!! Para continuar modifica tu modelo actual por uno más sencillo y menos general.'! !

!TDDBabyStepsGameBase class methodsFor: 'messages' stamp: 'NR 4/30/2022 19:13:48'!
testsDoNotPassErrorMessage
	
	^ 'No se puede avanzar al próximo test si no pasan todos los tests actuales.'! !


!classDefinition: #TDDBabyStepsGameCodedMessage category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameCodedMessage
	instanceVariableNames: 'codes description'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 19:03:55'!
codes

	^codes! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 07:42:18'!
description

	^description! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 07:52:36'!
ifNotEmpty: aBlock

	^description ifNotEmpty: aBlock! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 19:15:11'!
initializeEmptyMessage

	codes := Set new.
	description := ''! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 19:13:37'!
initializeWith: aCode description: startingDescription

	codes := Set with: aCode.
	description := startingDescription ! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 09:18:03'!
updateAddingDescription: newDescriptionPartToAdd
	
	description := description, newDescriptionPartToAdd! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 19:31:06'!
updateAddingDescription: newDescriptionPartToAdd format: aCollection
	
	description := description, newDescriptionPartToAdd format: aCollection ! !

!TDDBabyStepsGameCodedMessage methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 20:15:32'!
updateAddingMessage: newMessagePartToAdd
	
	codes := codes union: newMessagePartToAdd codes.
	self updateAddingDescription: newMessagePartToAdd description! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameCodedMessage class' category: #TDDBabyStepsGame!
TDDBabyStepsGameCodedMessage class
	instanceVariableNames: ''!

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:00:36'!
codeForAdvancedBabyStepsCorrect

	^#AdvancedBabyStepCorrect! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:04:00'!
codeForAdvancedTestAlreadyPassedPrematureDecisions

	^#AdvancedTestAlreadyPassedByPrematureDecisions! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:03:18'!
codeForAdvancedViaForceNext

	^#AdvancedViaForceNext ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 16:58:26'!
codeForCantAdvancePrematureDecisionsMade

	^#CantAdvanceBecausePrematureDecisionsWereMade! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 16:57:52'!
codeForCantAdvanceTestsDoNotPass

	^#CantAdvanceTestsDoNotPass! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:05:10'!
codeForGameEndedCorrectGeneralization

	^#GameEndedCorrectGeneralization ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:04:53'!
codeForGameEndedIncompleteGeneralization

	^#GameEndedIncompleteGeneralization ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:05:47'!
codeForGameReseted

	^#GameReseted! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:02:41'!
codeForGameStarting

	^#GameStarted! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 17:04:21'!
codeForUsedStepSolution

	^#UsedStepSolution! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 19:15:39'!
emptyMessage

	^self new initializeEmptyMessage ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 09:13:16'!
withCode: code description: startingDescription

	^self new initializeWith: code description: startingDescription! !


!classDefinition: #TDDBabyStepsGameRestLogger category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameRestLogger
	instanceVariableNames: 'loggedSteps beginingTimestamp userId gameName jsonGameEndedRecord'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 17:35:08'!
asyncRequest: requestName parameters: fieldDict 

	[ | resp |			
		[
			resp := WebClient htmlSubmit: (self url,'/',requestName) fields: fieldDict.
		] on: Error do: []
	
	] fork.
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:28:28'!
codesForGameResults
	
	"^Dictionary new
		at: TDDBabyStepsGameCodedMessage codeForGameEndedIncompleteGeneralization put: 0;
		at: TDDBabyStepsGameCodedMessage codeForGameEndedCorrectGeneralization put: 1;
		at: TDDBabyStepsGameCodedMessage codeForGameReseted put: 2;
		yourself "! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:28:42'!
codesForStepResults
	
	^Dictionary new
		at: TDDBabyStepsGameCodedMessage codeForGameStarting put: 0;
		at: TDDBabyStepsGameCodedMessage codeForCantAdvanceTestsDoNotPass put: 1;
		at: TDDBabyStepsGameCodedMessage codeForCantAdvancePrematureDecisionsMade put: 2;
		at: TDDBabyStepsGameCodedMessage codeForAdvancedBabyStepsCorrect put: 3;
		at: TDDBabyStepsGameCodedMessage codeForAdvancedViaForceNext put: 4;
		at: TDDBabyStepsGameCodedMessage codeForAdvancedTestAlreadyPassedPrematureDecisions put: 5;
		at: TDDBabyStepsGameCodedMessage codeForUsedStepSolution put: 6;
		at: TDDBabyStepsGameCodedMessage codeForGameEndedIncompleteGeneralization put: 7;
		at: TDDBabyStepsGameCodedMessage codeForGameEndedCorrectGeneralization put: 8;
		yourself ! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 16:07:00'!
correctlyEncodeSpecialSymbolsForGetRequest: textWithSpecialSymbols
	
	^ textWithSpecialSymbols asUnaccented copyReplaceAll: ' ' with: '%20'


		
		
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 01:44:01'!
correctlyEncodeSpecialSymbolsForJsonUtils: textWithSpecialSymbols
	
	^ textWithSpecialSymbols asUnaccented copyReplaceAll: '¡' with: '!!'

		
		
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 23:06:14'!
followGameEndingEventOn: aGameView

	aGameView addGameEndingObserver: [:aPosssibleAbruptEndingStatus | self gameEnded: aPosssibleAbruptEndingStatus ]! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:15:00'!
followGameJourneyChangesOn: aGameView

	aGameView addGameJourneyObserver: [:aCodedMessage :aStepNumber | self updateGameJourney: aCodedMessage step: aStepNumber ]! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:51:00'!
followGameStartedEventOn: aGameView

	aGameView addGameStartedObserver: [:aGameName | self startingGame: aGameName ]! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 17:34:14'!
gameEnded: aPosssibleAbruptEndingStatus
	
	| gameEndedRecord fieldDict |
	
	gameEndedRecord := Dictionary new.
	
	gameEndedRecord 
		at: 'begginingTimestamp' put: beginingTimestamp;
		at: 'endingTimestamp' put: DateAndTime now asString;
		at: 'userId' put: TDDBabyStepsUuid new userId;
		at: 'gameName' put: gameName;
		at: 'steps' put: loggedSteps asArray;
		at: 'reseted' put: aPosssibleAbruptEndingStatus.
		
		
	jsonGameEndedRecord := WebUtils jsonEncode: gameEndedRecord.
	
	fieldDict := Dictionary new.
	fieldDict at: 'dict' put: (self correctlyEncodeSpecialSymbolsForGetRequest: jsonGameEndedRecord) .
	
	self asyncRequest: 'babysteps/' parameters: fieldDict 
	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 16:10:07'!
port
	
	^80
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 00:44:21'!
startingGame: aGameName 
	
	loggedSteps := OrderedCollection new.
	beginingTimestamp := DateAndTime now asString.
	gameName := aGameName.

		
		
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 01:44:13'!
updateGameJourney: codedMessage step: stepNumber
	
	| stepRecord descriptionFixed |
	
	stepRecord := Dictionary new.
	
	descriptionFixed := self correctlyEncodeSpecialSymbolsForJsonUtils: codedMessage description.
	
	 stepRecord 
		at: 'timestamp' put: DateAndTime now asString;
		at: 'stepNumber' put: stepNumber;
		at: 'stepResult' put: ((codedMessage codes collect:[:code | self codesForStepResults at: code]) asArray);
		at: 'description' put: descriptionFixed.
		
	loggedSteps add: stepRecord
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 16:11:50'!
url

	^'http://babysteps.aeon.com.ar:', self port asString
	

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameRestLogger class' category: #TDDBabyStepsGame!
TDDBabyStepsGameRestLogger class
	instanceVariableNames: ''!

!TDDBabyStepsGameRestLogger class methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:47:04'!
followGameView: aGameView
	
	^self new followGameJourneyChangesOn: aGameView;
		followGameStartedEventOn: aGameView;
		followGameEndingEventOn:  aGameView ! !


!classDefinition: #TDDBabyStepsGameState category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameState methodsFor: 'initialization' stamp: 'NR 9/25/2022 18:18:51'!
initializeWith: aGame

	game := aGame! !


!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:07'!
forceNext
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:49:44'!
increaseScore
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 9/25/2022 18:18:58'!
next

	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 4/29/2024 17:04:51'!
stepSolution

	game stepSolutionOnOngoingGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameState class' category: #TDDBabyStepsGame!
TDDBabyStepsGameState class
	instanceVariableNames: ''!

!TDDBabyStepsGameState class methodsFor: 'as yet unclassified' stamp: 'NR 5/3/2022 05:54:15'!
for: aGame
	
	^ self new initializeWith: aGame! !


!classDefinition: #GameEnded category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #GameEnded
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:26'!
forceNext
	
	game nextOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:41:42'!
increaseScore

	game increaseScoreOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:48:00'!
next
	
	game nextOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 4/29/2024 17:05:25'!
stepSolution
	
	game stepSolutionOnNotOngoingGame! !


!classDefinition: #GameStarting category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #GameStarting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:11:25'!
forceNext
	
	game nextOnStartingGame! !

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:12:04'!
increaseScore

	game increaseScoreOnStartingGame! !

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 10/13/2022 06:10:11'!
next
	
	game nextOnStartingGame! !

!GameStarting methodsFor: 'as yet unclassified' stamp: 'NR 4/29/2024 17:05:25'!
stepSolution
	
	game stepSolutionOnNotOngoingGame! !


!classDefinition: #OnNormalStep category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #OnNormalStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:47'!
forceNext

	game forceNextOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:40:42'!
increaseScore

	game increaseScoreOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 5/1/2024 20:26:23'!
next

	game nextOnNormalStep! !


!classDefinition: #OnPrematureDecisionStep category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #OnPrematureDecisionStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:12:15'!
forceNext

	game forceNextOnNormalStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:41:11'!
increaseScore

	game increaseScoreOnPrematureDecisionStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:31:28'!
next

	game nextOnNormalStep! !


!classDefinition: #TDDBabyStepsGameView category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameView
	instanceVariableNames: 'model stepResult gameJourney gameJourneyObservers gameStartedObservers gameEndingObservers notifyGameFinishedWithoutAbortingBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameView methodsFor: 'initialization' stamp: 'NR 5/2/2024 02:17:04'!
clearJourney

	stepResult := ''.
	gameJourney := ''.
	notifyGameFinishedWithoutAbortingBlock := [self notifyGameEndingObservers: false. notifyGameFinishedWithoutAbortingBlock := []]! !

!TDDBabyStepsGameView methodsFor: 'initialization' stamp: 'NR 5/1/2024 22:40:30'!
initializeFor: aGame
	
	model := aGame.
	"gameJourneyObservers := WeakIdentitySet new."
	gameJourneyObservers := OrderedCollection new.
	gameStartedObservers := OrderedCollection new.
	gameEndingObservers := OrderedCollection new.
	self clearJourney.! !


!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:32'!
currentStep

	^model currentStep! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:36'!
forceNext

	self informResultOf: [ model forceNext ]! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:40'!
informResultOf: aNextStepBlock

	aNextStepBlock value.
	
	self informStepResult! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/24/2022 20:39:39'!
next
	
	self informResultOf: [ model next ]
! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:45'!
numberOfTests

	^model numberOfTests ! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 5/2/2024 01:55:53'!
resetGame
	
	model gameHasEnded ifFalse:[self notifyGameEndingObservers: true].
	model resetGame.
	self clearJourney.
	self informStart.! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:50'!
score

	^model score! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:53'!
start

	model browseTestCase. 
	self informStart! !

!TDDBabyStepsGameView methodsFor: 'steps' stamp: 'NR 4/29/2024 16:38:48'!
stepSolution
	
	self informResultOf: [model stepSolution]
	! !


!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 5/1/2024 09:11:31'!
formatJourney

	^ model journey reverse inject: '' into:[ :finalLog :line | finalLog, '- ', line description , self newLine ]! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:02'!
newLine

	^ String with: Character newLineCharacter! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:07'!
openDefinition

	TextModel new contents: model definition; openLabel: 'Enunciado ', model name! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:10'!
openHelp

	TextModel new contents: model help; openLabel: model name, ' Ayuda'! !

!TDDBabyStepsGameView methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:13'!
openJourney
	
	TextModel new contents: self formatJourney; openLabel: model name, ' Journey Log'! !


!TDDBabyStepsGameView methodsFor: 'test cases' stamp: 'NR 9/25/2022 18:20:41'!
testCaseCategory

	^ model testCaseCategory! !


!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 22:57:51'!
gameJourneyText
	
	^gameJourney! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 5/1/2024 23:09:28'!
informStart
	
	self notifyGameStartedObservers: (model name).
	self notify: 'El juego/kata se inicia. Se ha creado la clase de test.', self newLine, 'Avance al siguiente paso (utilizando next) para generar el primer test a pasar.'.
	
	
	
	! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 5/2/2024 02:17:04'!
informStepResult
	
	| lastStepTaken |
	lastStepTaken := model lastStepTakenIfNone: [ ^self ].
	self notifyGameJourneyObservers: lastStepTaken.
	self notify: lastStepTaken description.
	
	model gameHasEnded ifTrue: notifyGameFinishedWithoutAbortingBlock! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/25/2022 18:20:28'!
notify: aMessage
	
	stepResult :=  aMessage.
	gameJourney := self formatJourney.
	
	self triggerEvent: #gameChanged.
	
	
	! !

!TDDBabyStepsGameView methodsFor: 'private' stamp: 'NR 9/23/2022 20:13:47'!
stepResultText
	
	^stepResult! !


!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:39:47'!
addGameEndingObserver: observer

	gameEndingObservers add: observer

! !

!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 21:14:00'!
addGameJourneyObserver: observer

	gameJourneyObservers add: observer

! !

!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 22:39:24'!
addGameStartedObserver: observer

	gameStartedObservers add: observer

! !

!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 23:06:34'!
notifyGameEndingObservers: aPosssibleAbruptEndingStatus

	gameEndingObservers do: [:anObserver | anObserver value: aPosssibleAbruptEndingStatus]
! !

!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 21:19:23'!
notifyGameJourneyObservers: codedMessage

	gameJourneyObservers do: [:anObserver | anObserver value: codedMessage value: self currentStep]
! !

!TDDBabyStepsGameView methodsFor: 'as yet unclassified' stamp: 'NR 5/1/2024 23:02:34'!
notifyGameStartedObservers: aGameName

	gameStartedObservers do: [:anObserver | anObserver value: aGameName ]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameView class' category: #TDDBabyStepsGame!
TDDBabyStepsGameView class
	instanceVariableNames: ''!

!TDDBabyStepsGameView class methodsFor: 'instance creation' stamp: 'NR 4/30/2024 06:47:31'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TDDBabyStepsUuid category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsUuid
	instanceVariableNames: 'userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsUuid methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 15:56:33'!
initialize

	userId := UUIDGenerator default generateRandomBitsOfLength: 32.
! !

!TDDBabyStepsUuid methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 15:56:50'!
userId

	^userId
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsUuid class' category: #TDDBabyStepsGame!
TDDBabyStepsUuid class
	instanceVariableNames: 'uniqueInstance'!

!TDDBabyStepsUuid class methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 16:00:03'!
initialize

	uniqueInstance := self basicNew initialize! !

!TDDBabyStepsUuid class methodsFor: 'as yet unclassified' stamp: 'NR 5/2/2024 15:53:38'!
new

	^uniqueInstance! !

TDDBabyStepsUuid initialize!