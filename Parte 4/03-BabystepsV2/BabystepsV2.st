!classDefinition: #TDDBabyStepsGameDifficultyNotYetCompletedError category: #TDDBabyStepsGame!
Error subclass: #TDDBabyStepsGameDifficultyNotYetCompletedError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameDifficultyNotYetCompletedError methodsFor: 'description' stamp: 'NR 6/8/2024 20:41:03'!
messageText

	^ 'Game difficulty still not unlocked!! (or server down :P)!! Use #start instead'! !


!classDefinition: #TDDBabyStepsGameWindow category: #TDDBabyStepsGame!
SystemWindow subclass: #TDDBabyStepsGameWindow
	instanceVariableNames: 'stepResultTextBox nextButton forceNextButton definitionButton gameJourneyTextBox testNumberLabel pointsLabel helpButton stepSolutionButton resetButton stepTimerUpdLabel lastStepTimerLabel totalGameTimerUpdLabel userNameLabel changeNameButton warningLabel1 warningLabel2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:05'!
build1stRow
	
	| firstRow firstRow2ndColumn firstRow1stColumn |

	firstRow1stColumn := self build1stRow1stColumn.
	firstRow2ndColumn := self build1stRow2ndColumn.

	firstRow := LayoutMorph newRow.
	firstRow separation: 5; 
	addMorph: firstRow1stColumn;
	addMorph: firstRow2ndColumn.
	
	firstRow layoutSpec fixedHeight: 10.

	^firstRow
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:09'!
build1stRow1stColumn
	
	| firstRow1stColumn  firstRow1stColumn2ndRow maxStepDurationLabel m maxStepDurationT s |
	stepTimerUpdLabel := UpdatingLabelMorph contents: '-:--:--:--' 
	font: (Preferences at: #windowTitleFont)
	emphasis: AbstractFont  boldCode.
	stepTimerUpdLabel layoutSpec offAxisEdgeWeight: 0.5.
	
	m:=model maxStepDuration minutes.
	s:=model maxStepDuration seconds.
		
	maxStepDurationT := String streamContents: [:aStream | m printOn: aStream length:2 zeroPadded: true. aStream nextPut: $:. s printOn: aStream length:2 zeroPadded: true. ] .
	
	maxStepDurationLabel := LabelMorph contents: '(Max T: ', maxStepDurationT,') '.
	
	lastStepTimerLabel := LabelMorph contents: 'Last Step: -:--:--:--'.
	lastStepTimerLabel layoutSpec offAxisEdgeWeight: 0.

	totalGameTimerUpdLabel := UpdatingLabelMorph contents: 'Total Time: -:--:--:--'.
	totalGameTimerUpdLabel layoutSpec offAxisEdgeWeight: 0.
	
	
	firstRow1stColumn2ndRow := LayoutMorph newRow.
	firstRow1stColumn2ndRow separation: 0;
	axisEdgeWeight: 0;
	addMorph: maxStepDurationLabel;
	addMorph: lastStepTimerLabel.
	
	
	firstRow1stColumn := LayoutMorph newColumn.
	firstRow1stColumn separation: 3;
	axisEdgeWeight: 0;
	addMorph: stepTimerUpdLabel ;
	addMorph: firstRow1stColumn2ndRow;
	addMorph: totalGameTimerUpdLabel.
	
	firstRow1stColumn layoutSpec proportionalHeight: 0.	
	
	^firstRow1stColumn 
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/7/2024 07:34:22'!
build1stRow2ndColumn
	
	| firstRow2ndColumn firstRow2ndColumn1stRow firstRow2ndColumn2ndRow user |
	
	user := TDDBabyStepsUniqueUser new.
	
	userNameLabel := LabelMorph contents: ((user userName contractTo: 30), ' | ', (user courseFaculty contractTo:20)).
	testNumberLabel := LabelMorph contents:'Test Number:'.
	pointsLabel := LabelMorph contents:'Points:'.
	changeNameButton := PluggableButtonMorph model: self stateGetter: nil  action: #changeNameCourseFacultyAndUuid label: 'Change Uuid'.	
	
	firstRow2ndColumn1stRow := LayoutMorph newRow.
	firstRow2ndColumn1stRow separation: 5;
	axisEdgeWeight: 1;
	addMorph: userNameLabel;
	addMorph: changeNameButton.
	
	firstRow2ndColumn1stRow layoutSpec proportionalHeight: 0.	
	
	firstRow2ndColumn2ndRow := LayoutMorph newRow.
	firstRow2ndColumn2ndRow separation: 10;
	axisEdgeWeight: 1;
	addMorph: testNumberLabel;
	addMorph: pointsLabel.
	
	firstRow2ndColumn2ndRow layoutSpec proportionalHeight: 0.	
	
	firstRow2ndColumn := LayoutMorph newColumn.
	firstRow2ndColumn separation: 3;
	axisEdgeWeight: 0;
	addMorph: firstRow2ndColumn1stRow;
	addMorph: firstRow2ndColumn2ndRow.
	
	firstRow2ndColumn layoutSpec proportionalHeight: 1.	
	
	^firstRow2ndColumn
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/9/2024 08:02:50'!
build2ndRow
		
	| row rect rowHeight |
	
	stepResultTextBox := TextModelMorph textProvider: self model textGetter: #stepResultText textSetter: nil. 
	stepResultTextBox  innerTextMorph setProperty: #keyStroke: toValue: [ :key | stepResultTextBox innerTextMorph acceptContents ].
	stepResultTextBox borderWidth: 2; borderColor: Color lightBlue.
	stepResultTextBox layoutSpec proportionalWidth: 1.
	stepResultTextBox layoutSpec proportionalHeight: 1.
	
	row := LayoutMorph newColumn.
	row separation: 5; 
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents:'Step Result');
	addMorph: stepResultTextBox.
	
	"row layoutSpec fixedHeight: 187."
	"row layoutSpec fixedHeight: 320."
	rect := self allowedArea.
	rowHeight:= ((rect corner y - rect origin y) / 5) rounded.

	row layoutSpec fixedHeight: rowHeight.
	
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

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:17'!
build3rdRow1stColumn

	| firstColumn |

	definitionButton := PluggableButtonMorph model: self model stateGetter: nil  action: #openDefinition label: 'Definition'.	
	nextButton := PluggableButtonMorph model: self model stateGetter: nil  action: #next label: 'Next'.	
	forceNextButton := PluggableButtonMorph model: self model stateGetter: nil  action: #forceNext label: 'Force Next'.	
	stepSolutionButton := PluggableButtonMorph model: self model stateGetter: nil  action: #stepSolution label: 'Reveal Step Solution'.		
		
	firstColumn := LayoutMorph newColumn.
	firstColumn separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: definitionButton;
	addMorph: nextButton;
	addMorph: forceNextButton;
	addMorph: stepSolutionButton.
	firstColumn layoutSpec fixedWidth: 10.
		
	^firstColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:20'!
build3rdRow2ndColumn

	| secondColumn |
		
	gameJourneyTextBox := TextModelMorph textProvider: self model textGetter: #gameJourneyText textSetter: nil. 
	gameJourneyTextBox  innerTextMorph setProperty: #keyStroke: toValue: [ :key | gameJourneyTextBox innerTextMorph acceptContents ] .
	gameJourneyTextBox borderWidth: 1; borderColor: Color lightBlue.
	gameJourneyTextBox layoutSpec proportionalWidth: 1.
	gameJourneyTextBox layoutSpec proportionalHeight: 1.
				
	secondColumn := LayoutMorph newColumn.
	secondColumn  separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Game Journey');
	addMorph: gameJourneyTextBox.
		
	^secondColumn! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:23'!
build4rdRow

	| row col   |

	warningLabel1 := LabelMorph contents: self model difficultyConfiguration textForHelpLabelLine1.
	warningLabel2 := LabelMorph  contents: self model difficultyConfiguration textForHelpLabelLine2.
	helpButton := PluggableButtonMorph model: self model stateGetter: nil  action: #openHelp label: 'Help!!'.		
	resetButton := PluggableButtonMorph model: self model stateGetter: nil  action: #resetGame label: 'Reset Game'.	
	
	col:= LayoutMorph newColumn.
	col addMorph: warningLabel1.
	col addMorph: warningLabel2.
	col axisEdgeWeight: 0.
	
	row := LayoutMorph newRow.
	row separation: 5;
	axisEdgeWeight: 1;
	addMorph: col;
	addMorph: helpButton;
	addMorph: resetButton.
	
	row layoutSpec fixedHeight: 20.
		
	^row	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:26'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow;
	addMorph: self build4rdRow.
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 5/11/2024 23:23:03'!
clearLabels

	stepTimerUpdLabel visible: true.
	lastStepTimerLabel contents: 'Last Step: -:--:--:--'.
	totalGameTimerUpdLabel font: FontFamily defaultFamilyAndPointSize emphasis: 0.
	pointsLabel font: FontFamily defaultFamilyAndPointSize emphasis: 0.
	self updateScreenSize! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/10/2024 09:21:17'!
defaultExtent
	
	| height rect width |
	
	"^ 600@760"
	"^ super initialExtent "

	rect := self allowedArea.
	width := ((rect corner x - rect origin x) / 2.7) rounded.
	height := (rect corner y - rect origin y).
	
	^ (width@height)
	
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 6/27/2024 12:59:50'!
gameStartingMessage

	^ 'El juego/kata se inicia. Lea atentamente las indicaciones de "Definition" y "Help" para entender el problema. Se ha creado la clase de test, y de existir, se han eliminado soluciones previas.', TDDBabyStepsGameBase newLine, 'Avance al siguiente paso (utilizando next) para generar el primer test a pasar.'! !

!TDDBabyStepsGameWindow methodsFor: 'GUI building' stamp: 'NR 5/11/2024 23:22:40'!
updateScreenSize

	^ self morphExtent: (self defaultExtent)! !


!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:59:47'!
initializeWith: aGameView gameName: aTitle

	self setLabel: 'BabySteps: ',aTitle.
	self model: aGameView.
	self buildMorphicWindow.
	self openInWorld.
	self updateScreenSize.
				
	self suscribeToModelEvents! !

!TDDBabyStepsGameWindow methodsFor: 'initialization' stamp: 'NR 6/27/2024 13:00:13'!
suscribeToModelEvents

	^self followGameJourneyChangesOn: model;
		followGameStartedEventOn: model;
		followGameEndingEventOn:  model;
		receiveConfirmationWarningsOf: model
	! !


!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/27/2024 12:58:52'!
askFor: textPrompt initialAnswer: initialTextAnswer updatingOn: updateBlock cancelationBlock: cancelBlock
	
	self askFor: textPrompt initialAnswer: initialTextAnswer updatingOn: updateBlock cancelationBlock: cancelBlock  onError: []
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/27/2024 12:58:55'!
askFor: textPrompt initialAnswer: initialTextAnswer updatingOn: updateBlock cancelationBlock: cancelBlock onError: errorBlock
	
	| userInput |
	
	[userInput := StringRequestMorph request: textPrompt initialAnswer: initialTextAnswer orCancel: cancelBlock.
	updateBlock value: userInput]
	on: Error
	do: errorBlock
	
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/8/2024 18:49:20'!
askForCourseFaculty: user

	self askFor: 'Enter your course-faculty-university / organization' initialAnswer: user courseFaculty updatingOn: [ :aCourseFaculty | user courseFaculty: aCourseFaculty ] cancelationBlock: [ ^self ].
	self updateUserNameCourseFaculty.! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/7/2024 07:31:01'!
askForName: user

	self askFor: 'Enter your name' initialAnswer: user userName updatingOn: [ :aName | user userName: aName ] cancelationBlock: [ ^self ].
	self updateUserNameCourseFaculty
	! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/7/2024 08:30:23'!
askForUserId: user message: message

	self askFor: message initialAnswer: user userId asString updatingOn: [ :anUuid| user userId: anUuid asNumber] cancelationBlock: [ ^self ] onError: [self askForUserId: user message: 'Invalid Uuid (Numbers only. Do not modify them)']
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/7/2024 07:31:51'!
changeNameCourseFacultyAndUuid
	
	| user |
	
	user := TDDBabyStepsUniqueUser new.
	
	self askForName: user.
	self askForCourseFaculty: user.
	self askForUserId: user message: 'Confirm or reenter old Uuid to mantain user (copy & paste somewhere safe for backup)' ! !

!TDDBabyStepsGameWindow methodsFor: 'Uuid' stamp: 'NR 6/7/2024 07:35:07'!
updateUserNameCourseFaculty

	| user |
	
	user := TDDBabyStepsUniqueUser new.

	userNameLabel contents:  ((user userName contractTo: 30), ' | ', (user courseFaculty contractTo:20)).
	self updateScreenSize! !


!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 6/27/2024 12:59:00'!
askForGameConfirmationWarning: warningMessage onAffirmative: affirmativeBlock onNegative: negativeBlock

	| userAnswer |
	
	userAnswer := PopUpMenu confirm: warningMessage.
	
	userAnswer ifTrue: affirmativeBlock ifFalse: negativeBlock ! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 6/7/2024 16:55:08'!
closeBoxHit

	| options userAnswer |
	options := #('No' 'Sí, eliminando todo el progreso' 'Sí, guardando el progreso aunque no pueda usarse en el juego nuevamente').
	userAnswer := (PopUpMenu labelArray: options) startUpWithCaption: '¿Desea salir del juego?'.
	
	userAnswer = 2 ifTrue: [ model resetGame. super closeBoxHit ].
	userAnswer = 3 ifTrue: [ model notifyPossibleReset. super closeBoxHit ]
! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/11/2024 23:23:54'!
formatTotalTimeResultInLabels

	stepTimerUpdLabel visible: false.
	totalGameTimerUpdLabel font: (Preferences at: #windowTitleFont) emphasis: AbstractFont  boldCode.
	pointsLabel font: (Preferences at: #windowTitleFont) emphasis: AbstractFont  boldCode.
	self updateScreenSize! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/14/2024 18:35:15'!
gameEnded
	
	self stopTimers.
	self formatTotalTimeResultInLabels.
	
	self refreshSupportControls
	
	! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 6/27/2024 12:59:59'!
refreshSupportControls

	warningLabel1 contents: self model difficultyConfiguration textForHelpLabelLine1. 
	warningLabel2 contents: self model difficultyConfiguration textForHelpLabelLine2.
	
	model difficultyConfiguration visibleSupportOptions 
		ifTrue: [ stepSolutionButton visible: true. resetButton visible: true ]
		ifFalse: [ stepSolutionButton visible: false. resetButton visible: false ]! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/14/2024 18:34:54'!
refreshWindow
	
	stepResultTextBox updateAcceptedContents.
	gameJourneyTextBox updateAcceptedContents.
	
	self updateStepAndPoints.
	self updateStepResultBorderColor.
	
	self model gameAdvancedToNextStep 
		ifTrue: [ 
			self startStepTimer.
			lastStepTimerLabel contents: ('Last Step: ', (self model previousStepDuration truncateTo: (Duration seconds: 1)) asString ).
		].
	
	model previousStepPoints: model score.
	! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/14/2024 18:35:50'!
startGame
	
	self model stepResultText: self gameStartingMessage.
	self clearLabels.
	self startTimers.
	self refreshSupportControls.
	self refreshWindow 
	! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/11/2024 23:05:52'!
updateGameJourney: aCodedMessage 

	self model stepResultText: aCodedMessage description.
	self refreshWindow ! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 6/27/2024 13:00:19'!
updateStepAndPoints

	| currentStepToShow |
	
	currentStepToShow := model currentStep.
	(currentStepToShow > model totalNumberOfTests) ifTrue: [ currentStepToShow := model totalNumberOfTests ].
	
	testNumberLabel contents: 'Test Number: ', currentStepToShow asString,'/', model totalNumberOfTests asString.
	pointsLabel contents: 'Points: ', model score asString! !

!TDDBabyStepsGameWindow methodsFor: 'event handlers' stamp: 'NR 5/14/2024 18:21:19'!
updateStepResultBorderColor

	model previousStepPoints > model score ifTrue: [ stepResultTextBox borderColor: Color lightRed ].
	model previousStepPoints = model score ifTrue: [ stepResultTextBox borderColor: Color lightBlue ].
	model previousStepPoints < model score ifTrue: [ stepResultTextBox borderColor: Color lightGreen ]! !


!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/14/2024 19:20:07'!
lineForStepTimerCountingSince: timestamp withTitle: aTitle
	
	^ aTitle,  (self model difficultyConfiguration formatTimerLine: timestamp maxStepDuration: self model maxStepDuration)! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/14/2024 19:18:49'!
lineForTotalGameTimerCountingSince: timestamp withTitle: aTitle
	
	^ aTitle,  ((DateAndTime now - timestamp) truncateTo: (Duration seconds: 1)) asString! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/14/2024 19:09:47'!
startStepTimer

	self startTimerUpdatingOver: stepTimerUpdLabel withFormat: [ self lineForStepTimerCountingSince: self model stepStartTimestamp withTitle: '' ]
	! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/14/2024 19:08:06'!
startTimerUpdatingOver: anUpdatingLabelTimer withFormat: aFormatBlock 

	anUpdatingLabelTimer stepTime: 500;
	target: aFormatBlock;
	getSelector: #value;
	startStepping
		! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/11/2024 23:18:15'!
startTimers
	
	self startStepTimer.
	self startTotalGameTimer! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 6/27/2024 13:00:08'!
startTotalGameTimer

	self startTimerUpdatingOver: totalGameTimerUpdLabel withFormat: [ self lineForTotalGameTimerCountingSince: self model gameStartTimestamp withTitle: 'Total Time: ' ]! !

!TDDBabyStepsGameWindow methodsFor: 'timers' stamp: 'NR 5/11/2024 22:59:05'!
stopTimers

	stepTimerUpdLabel stopStepping.
	totalGameTimerUpdLabel stopStepping! !


!TDDBabyStepsGameWindow methodsFor: 'subscribe to' stamp: 'NR 6/27/2024 12:59:39'!
followGameEndingEventOn: aGameView

	aGameView addGameEndingObserver: [ :aPossibleAbruptEndingStatus :aScore :aGrade | self gameEnded ]! !

!TDDBabyStepsGameWindow methodsFor: 'subscribe to' stamp: 'NR 6/27/2024 12:59:36'!
followGameJourneyChangesOn: aGameView

	aGameView addGameJourneyObserver: [ :aCodedMessage :aStepNumber :aSolutionSC | self updateGameJourney: aCodedMessage ]! !

!TDDBabyStepsGameWindow methodsFor: 'subscribe to' stamp: 'NR 5/14/2024 18:28:55'!
followGameStartedEventOn: aGameView

	aGameView addGameStartedObserver: [ :aGameName :aGameDifficulty | self startGame ]! !

!TDDBabyStepsGameWindow methodsFor: 'subscribe to' stamp: 'NR 6/27/2024 12:59:55'!
receiveConfirmationWarningsOf: aGameView

	aGameView confirmationWarningReceiver: [:confirmationWarningMessage :affirmativeResponseBlock :negativeResonseBlock | self askForGameConfirmationWarning: confirmationWarningMessage onAffirmative: affirmativeResponseBlock onNegative: negativeResonseBlock ]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameWindow class' category: #TDDBabyStepsGame!
TDDBabyStepsGameWindow class
	instanceVariableNames: ''!

!TDDBabyStepsGameWindow class methodsFor: 'instance creation' stamp: 'NR 6/26/2024 07:13:05'!
openWithGameView: gameView name: gameName 

	^self new initializeWith: gameView gameName: gameName, ' Kata'! !


!classDefinition: #TDDBabyStepsGame category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGame methodsFor: 'start' stamp: 'NR 6/27/2024 12:46:04'!
loggedRun: aDifficultyConfiguration
	
	^ self run: [ | gameVM | gameVM := self buildGame: aDifficultyConfiguration.
	TDDBabyStepsGameRestLogger followGameView: gameVM.
	^ gameVM start ]
! !

!TDDBabyStepsGame methodsFor: 'start' stamp: 'NR 6/16/2024 19:22:40'!
run: aGameBuildingBlock 

	^ aGameBuildingBlock on: TDDBabyStepsGameDifficultyNotYetCompletedError do: [ :anError | PopUpMenu inform: anError messageText ]! !

!TDDBabyStepsGame methodsFor: 'start' stamp: 'NR 6/27/2024 12:46:25'!
start
	
	^ self loggedRun: TDDBabyStepsFirstRun new! !

!TDDBabyStepsGame methodsFor: 'start' stamp: 'NR 6/27/2024 12:46:28'!
startExpert

	^ self loggedRun: TDDBabyStepsExpertMode new
	! !

!TDDBabyStepsGame methodsFor: 'start' stamp: 'NR 6/27/2024 12:46:31'!
startUnlocked

	^ self loggedRun: TDDBabyStepsSupportUnlocked new! !


!TDDBabyStepsGame methodsFor: 'start - private' stamp: 'NR 6/8/2024 06:51:15'!
privateRun: aDifficultyConfiguration

	^ self  run: [ | gameVM | gameVM := self buildGame: aDifficultyConfiguration. 
		^ gameVM start ]! !

!TDDBabyStepsGame methodsFor: 'start - private' stamp: 'NR 6/27/2024 12:46:17'!
privateStart

	^ self privateRun: TDDBabyStepsSupportUnlocked new.
	
	! !


!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 6/16/2024 19:22:40'!
assertGameDifficultyUnlocked: difficultyConfiguration
	
	^ (difficultyConfiguration isUnlocked: self name) ifFalse: [ ^ TDDBabyStepsGameDifficultyNotYetCompletedError signal ]
	
	
! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 6/16/2024 07:53:57'!
buildArrayOf: methodBaseName withSize: numberOfCases
	
	| cases |
	
	cases := Array new: numberOfCases .
	
	1 to: numberOfCases do: [:index | | caseNumber | 
		caseNumber := String streamContents: [:aStream | index printOn: aStream length: 2 zeroPadded: true.].
		cases at: index put: (self perform: (methodBaseName,caseNumber) asSymbol) 
	].
	
	^ cases
! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 6/27/2024 12:45:47'!
buildGame: difficultyFeatures

	| gameModel gameView |
	
	self assertGameDifficultyUnlocked: difficultyFeatures.
	
	gameModel := self buildGameBase: difficultyFeatures.
	gameView := self buildGameView: gameModel.
	
	^ gameView
	
	
	! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 6/27/2024 12:45:42'!
buildGameBase: difficultyFeatures
	
	| testCaseBuilder solutionBuilder  |
	
	testCaseBuilder := TDDBabyStepsTestCaseBuilder withCases: self cases forGameNamed: self name.
		
	solutionBuilder := self solutionModelBuilder withModels: self models withTestCaseBuilder: testCaseBuilder reset: self reset.
	
	^ TDDBabyStepsGameBase startNamed: self name withTestCaseBuilder: testCaseBuilder withExtraCase:self extraCase withGenCases: self genCases withSolutionModelBuilder: solutionBuilder withUserSolutionSourceCodeRetriever: self userSolutionSourceCodeRetriever withDefinition: self definition withMaxStepDuration: self maxStepDuration withDifficultyConfiguration: difficultyFeatures
	! !

!TDDBabyStepsGame methodsFor: 'building' stamp: 'NR 6/27/2024 12:45:57'!
buildGameView: gameModel
	
	| gameVM |
	
	gameVM :=TDDBabyStepsGameViewModel for: gameModel.
	TDDBabyStepsGameWindow openWithGameView: gameVM name: self name.
	
	^ gameVM! !


!TDDBabyStepsGame methodsFor: 'models' stamp: 'NR 6/16/2024 07:56:16'!
models

	^ self buildArrayOf: 'model' withSize: self numberOfCases! !

!TDDBabyStepsGame methodsFor: 'models' stamp: 'NR 4/29/2024 07:11:33'!
reset

	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'models' stamp: 'NR 6/21/2024 21:16:39'!
solutionModelBuilder

	self subclassResponsibility! !

!TDDBabyStepsGame methodsFor: 'models' stamp: 'NR 6/27/2024 09:02:59'!
userSolutionSourceCodeRetriever
	
	^ '| completeSourceCode |
	
	completeSourceCode := ''''.
	
	[ classesInCategory := (SystemOrganization listAtCategoryNamed: ''TDDBabyStepsGame', self name, ''') asSortedCollection collect: [:each | Smalltalk at: each].
	classesInCategory do: [ :aClass | 
		aClass name = ''TDDBabySteps', self name, 'Test'' 
			ifFalse:[ completeSourceCode := completeSourceCode, (String with: Character newLineCharacter), aClass name,'':'', (String with: Character newLineCharacter), (String with: Character newLineCharacter).
					
					aClass class selectors asSortedCollection do: [ :selector | 
					| selectorSourceCode |
					selectorSourceCode := [ aClass name,'' class >> (+) '', (aClass class sourceCodeAt: selector), (String with: Character newLineCharacter), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
					completeSourceCode := completeSourceCode, selectorSourceCode].
					
					aClass selectors asSortedCollection do: [ :selector | 
					| selectorSourceCode |
					selectorSourceCode := [ aClass name,'' >> '', (aClass sourceCodeAt: selector), (String with: Character newLineCharacter), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
					completeSourceCode := completeSourceCode, selectorSourceCode]
			]
		]
	] on: Error do: [].
	
	^ completeSourceCode
	'
	! !


!TDDBabyStepsGame methodsFor: 'cases' stamp: 'NR 6/16/2024 07:54:32'!
cases
	
	^ self buildArrayOf: 'case' withSize: self numberOfCases
! !

!TDDBabyStepsGame methodsFor: 'cases' stamp: 'NR 6/16/2024 07:18:19'!
numberOfCases

	self subclassResponsibility ! !


!TDDBabyStepsGame methodsFor: 'step duration' stamp: 'NR 6/27/2024 12:46:08'!
maxStepDuration
	
	self subclassResponsibility ! !


!TDDBabyStepsGame methodsFor: 'definition' stamp: 'NR 5/3/2022 08:34:42'!
definition
	
	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'definition' stamp: 'NR 5/3/2022 08:32:39'!
name
	
	self subclassResponsibility ! !


!TDDBabyStepsGame methodsFor: 'generalization' stamp: 'NR 5/3/2022 08:32:43'!
extraCase
	
	self subclassResponsibility ! !

!TDDBabyStepsGame methodsFor: 'generalization' stamp: 'NR 6/16/2024 07:56:45'!
genCases

	^ self buildArrayOf: 'genCase' withSize: self numberOfCases - 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGame class' category: #TDDBabyStepsGame!
TDDBabyStepsGame class
	instanceVariableNames: ''!

!TDDBabyStepsGame class methodsFor: 'instance creation - private' stamp: 'NR 6/8/2024 06:50:56'!
privateStart
	
	^ self new privateStart! !


!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/3/2022 08:46:01'!
start
	
	^ self new start! !

!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/14/2024 06:42:20'!
startExpert

	^ self new startExpert! !

!TDDBabyStepsGame class methodsFor: 'instance creation' stamp: 'NR 5/14/2024 06:41:59'!
startUnlocked

	^ self new startUnlocked! !


!classDefinition: #TDDBabyStepsGameAnagrams category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameAnagrams
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameAnagrams methodsFor: 'definition' stamp: 'NR 9/24/2022 22:50:54'!
definition
	
	^ 'Debe obtenerse todos los anagramas de una palabra (string). Por ej. todos los potenciales anagramas de "kata" son:
	
	''ktaa'' ''atka'' ''akat'' ''atak'' ''akta'' ''taka'' ''kata'' ''aatk'' ''tkaa'' ''aakt'' ''kaat'' ''taak''

Ayuda: Considere utilizar el mensaje #copyFrom:to: cuando sea necesario.
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'definition' stamp: 'NR 5/4/2022 07:48:12'!
name 
	
	^ 'Anagrams'! !


!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:12'!
model01

	^ 'String compile: ''anagrams
	
	^Set with: '''''''' '' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:16'!
model02

	^ 'String compile: ''anagrams
	
	"1era versión:"
	"self ifEmpty: [^Set with: ''''''''].
	^Set with: ''''a'''' "
	
	"Última versión (Paso 3: Refactor):"
	^Set with: self'' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:22'!
model03

	^ 'String compile: ''anagrams
	
	self size < 2 ifTrue: [^Set with: self].
	
	"1era versión:"
	"^Set with:''''ab'''' with: ''''ba''''"
	
	"Última versión (Paso 3: Refactor):"
	^Set with: self with: self reverse'' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:25'!
model04

	^ 'String compile: ''anagrams
	
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

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:29'!
model05

	^ 'String compile: ''anagrams
	
	| anagrams head tails |
	
	self isEmpty ifTrue: [^Set with: self].
	
	anagrams := Set new.

	1 to: self size do:[ :index | head := self asStringAt: index.
						  tails := (self dropCharacterAt: index) anagrams.
						  anagrams addAll: (tails collect:[:tail | head,tail])].
		
	^anagrams. '' classified: ''anagrams''
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/21/2024 07:48:06'!
reset
	
	^ '[ String removeSelector: #anagrams ]  on: Error do: [].
	[ String removeSelector: #asStringAt: ]  on: Error do: [].
	[ String removeSelector: #dropCharacterAt: ]  on: Error do: []'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/21/2024 21:16:25'!
solutionModelBuilder

	^ IncrementalPartialModelBuilder! !

!TDDBabyStepsGameAnagrams methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	^ '^ [ String sourceCodeAt: #anagrams ] on: Error do: [^'''']'
	! !


!TDDBabyStepsGameAnagrams methodsFor: 'generalization' stamp: 'NR 5/4/2022 16:58:23'!
extraCase
	
	^ 'testExtraToCheckGeneralizationOnKata

	self assert: 40320 equals:`''abcdefgh'' anagrams` size.
	
	self assert: (`''abcdefgh'' anagrams`) includes: ''cghdbeaf''.
	
	self assert: 10080 equals: `''abcdefab'' anagrams` size
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'generalization' stamp: 'NR 5/8/2024 04:30:04'!
genCase01

	^ 'test01GeneralizationOneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'generalization' stamp: 'NR 5/8/2024 04:40:59'!
genCase02

	^ 'test02GeneralizationOneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:''f'') equals: ''f'' anagrams.
	self assert: (Set with:''r'') equals: ''r'' anagrams
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'generalization' stamp: 'NR 5/8/2024 04:41:03'!
genCase03
	
	^ 'test03GeneralizationTwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:''cd'' with: ''dc'') equals: ''cd'' anagrams.
	self assert: (Set with:''we'' with: ''ew'') equals: ''we'' anagrams
	
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'generalization' stamp: 'NR 5/8/2024 04:30:16'!
genCase04
	
	^ 'test04GeneralizationThreeCharStringAnagramReturnsAllThe6PossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''123''.
	anagrams add: ''132''.
	anagrams add: ''213''.
	anagrams add: ''231''.
	anagrams add: ''312''.
	anagrams add: ''321''.

	self assert: anagrams equals: ''123'' anagrams
	'! !


!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 5/8/2022 15:25:00'!
case01
	
	^ 'test01EmptyStringAnagramIsJustACollectionWithTheEmptyString

	self assert: (Set with: '''') equals: '''' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 5/4/2022 16:59:07'!
case02

	^ 'test02OneCharStringAnagramReturnsACollectionWithTheSameOneCharString

	self assert: (Set with:''a'') equals: ''a'' anagrams
	'
	! !

!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 5/4/2022 16:59:18'!
case03
	
	^ 'test03TwoCharStringAnagramReturnsTheOriginalStringAndAnotherOneFlipped

	self assert: (Set with:''ab'' with: ''ba'') equals: ''ab'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 5/4/2022 16:59:42'!
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

!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 5/4/2022 17:00:10'!
case05
	
	^ 'test05MoreThanThreeCharStringAnagramReturnsAllTheCorrectPossibleOrderCombinations

	| anagrams |
	
	anagrams := Set new.
	anagrams add: ''abcd''; add: ''abdc''; add: ''acbd''; add: ''acdb''; add: ''adbc''; add: ''adcb''; add: ''bacd''; add: ''badc''; add: ''bcad''; add: ''bcda''; add: ''bdac''; add: ''bdca''; add: ''cabd''; add: ''cadb''; add: ''cbad''; add: ''cbda''; add: ''cdab''; add: ''cdba''; add: ''dabc''; add: ''dacb''; add: ''dbac''; add: ''dbca''; add: ''dcab''; add: ''dcba''.

	self assert: anagrams equals: ''abcd'' anagrams
	'! !

!TDDBabyStepsGameAnagrams methodsFor: 'cases' stamp: 'NR 6/16/2024 07:18:42'!
numberOfCases

	^ 5 ! !


!TDDBabyStepsGameAnagrams methodsFor: 'step duration' stamp: 'NR 6/7/2024 08:35:49'!
maxStepDuration

	^ Duration minutes: 15! !


!classDefinition: #TDDBabyStepsGameBowling category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameBowling
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameBowling methodsFor: 'definition' stamp: 'NR 6/26/2024 10:40:53'!
definition
	
	^ 'En un juego de bowling, tenés 10 rondas para derribar 10 pines con una bola de boliche En cada ronda, llamada frame, tenés 2 intentos (frame es por el ''marco'' donde se anota el puntaje en una planilla). Si los derribás a todos en el primer intento, hiciste un strike. Si en cambio lo hacés en dos, hacés un spare. Si no lográs derribar los 10, se dice que el frame quedó abierto. En todos los casos, en seguida se reponen los 10 pines y se pasa al próximo frame. Al termino de los 10 frames, el jugador con más puntos gana.

Los puntos se calculan en función del resultado de cada frame:

Si no es un strike ni un spare, es decir un open frame, se calcula sólo la suma de los lanzamientos del frame.
Para un spare, ademas de sumársele el valor de los lanzamientos como en el open frame, también se te suma el valor del siguiente lanzamiento que hagas (del próximo frame) como bonificación. 
El computo del score para el strike es similar al del spare con la diferencia que se te suman los siguientes 2 lanzamientos como bonificación en vez de sólo 1. 

El último frame es sutilmente diferente a los demas. En este frame no hay bonificaciones por los tiros, sino que sólo se suma la cantidad de pins derribados. PERO si obtenés un strike o un spare en el último frame, se te recompensa con hasta un tiro extra por única vez. Luego el último frame puede ser de 2 o 3 tiros como máximo.

Se pide modelar el cálculo del score TOTAL del juego para cualquier estadío del mismo.

Si cree que lo necesita, aquí una buena explicación de como calcular el puntaje del juego directamente de la liga/asociación estadounidense de bowling: https://bowl.com/keeping-score

Ayuda: No se preocupe si en algún paso necesita hacer un refactor muy largo. Recuerde ir haciendolo por partes, pasando todos los tests cada vez. 

'! !

!TDDBabyStepsGameBowling methodsFor: 'definition' stamp: 'NR 6/27/2024 12:37:50'!
name 
	
	^ 'Bowling'! !


!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/27/2024 12:37:22'!
model01

	^ 'Object subclass: #BowlingGame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	BowlingGame compile: ''score
	
	^ 0
	
	'' classified: ''score''
	'
	! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/24/2024 07:40:22'!
model02

	^ 'Object subclass: #BowlingGame
	instanceVariableNames: ''score''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	BowlingGame compile: ''score
	
	^ score
	
	'' classified: ''score''.
	
	BowlingGame compile: ''initialize
	
	score := 0
	
	'' classified: ''initialization''.
	
	BowlingGame compile: ''roll: numberOfPins

	score := numberOfPins
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/25/2024 17:30:22'!
model03

	^ 'Object subclass: #BowlingGame
	instanceVariableNames: ''score''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	BowlingGame compile: ''score
	
	^ score
	
	'' classified: ''score''.
	
	BowlingGame compile: ''initialize
	
	score := 0
	
	'' classified: ''initialization''.
	
	BowlingGame compile: ''roll: numberOfPins

	score := score + numberOfPins
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:02:44'!
model04

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	total = 10 ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"| totalScore |
	
	totalScore := 0.
	
	1 to: rolls size by: 2 do: [ :index | | score |
		
		score := rolls at: index.
		
		index + 1 <= rolls size 
			ifTrue: [ score := score + rolls at: index + 1.
					score = 10 
						ifTrue: [ score := score + rolls at: index + 2 ].
			].
		
		totalScore := totalScore + score.
	].

	^ totalScore"
	
	"Última versión (Paso 3):"
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls := OrderedCollection new"
	
	
	"Última versión (Paso 3):"
	frames := OrderedCollection new.
	currentFrame := Frame new.
	
	frames add: currentFrame
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls add: aNumberOfPins"


	"Última versión (Paso 3):"
	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 09:54:26'!
model05

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	total = 10 ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"| totalScore |
	
	totalScore := 0.
	
	1 to: rolls size by: 2 do: [ :index | | score |
		
		score := rolls at: index.
		
		index + 1 <= rolls size 
			ifTrue: [ score := score + rolls at: index + 1.
					(score = 10 and: [ index + 2 <= rolls size ]) 
						ifTrue: [ score := score + rolls at: index + 2 ].
			].
		
		totalScore := totalScore + score.
	].

	^ totalScore"
	
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls := OrderedCollection new"
	
	
	frames := OrderedCollection new.
	currentFrame := Frame new.
	
	frames add: currentFrame
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls add: aNumberOfPins"


	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:02:07'!
model06

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2 or: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	(total = 10 and: [ rolls size = 1 ]) ifTrue: [ ^ total + nextFrame firstRoll + nextFrame secondRoll ].
	
	(total = 10 and: [ rolls size = 2 ]) ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''secondRoll
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"| totalScore |
	
	totalScore := 0.
	
	1 to: rolls size by: 2 do: [ :index | | score |
		
		score := rolls at: index.
		
		score = 10
			ifTrue: [ score := score + (rolls at: (index + 2)) + (rolls at: (index + 3)) ]
			ifFalse: [ index + 1 <= rolls size
						ifTrue: [ score := score + rolls at: index + 1.
								(score = 10 and: [ index + 2 <= rolls size ]) 
									ifTrue: [ score := score + rolls at: index + 2 ].
						].
					].
		
		totalScore := totalScore + score.
	].

	^ totalScore"
	
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls := OrderedCollection new"
	
	
	frames := OrderedCollection new.
	currentFrame := Frame new.
	
	frames add: currentFrame
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"((rolls size \\ 2 = 0) and: [ aNumberOfPins = 10 ])
		ifTrue: [ rolls add: 10. rolls add: 0 ]
		ifFalse: [ rolls add: aNumberOfPins ]."

	
	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:02:19'!
model07

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2 or: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	(total = 10 and: [ rolls size = 1 ]) ifTrue: [ ^ total + nextFrame firstRoll + nextFrame secondRoll ].
	
	(total = 10 and: [ rolls size = 2 ]) ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''secondRoll
	
	rolls size < 2 ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"| totalScore |
	
	totalScore := 0.
	
	1 to: rolls size by: 2 do: [ :index | | score |
		
		score := rolls at: index.
		
		score = 10
			ifTrue: [ (index + 2 <= rolls size) ifTrue: [score := score + (rolls at: (index + 2)) ].
					(index + 3 <= rolls size) ifTrue: [score := score + (rolls at: (index + 3)) ] 
			]
			ifFalse: [ (index + 1 <= rolls size) 
						ifTrue: [ score := score + rolls at: index + 1.
								(score = 10 and: [ index + 2 <= rolls size ]) 
									ifTrue: [ score := score + rolls at: index + 2 ].
						].
			].
		
		totalScore := totalScore + score.
	].

	^ totalScore"
	
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"rolls := OrderedCollection new"
	
	
	frames := OrderedCollection new.
	currentFrame := Frame new.
	
	frames add: currentFrame
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	"Versión alternativa a continuar y refactorizar de ejercicio extra para sacar conclusiones..."
	"((rolls size \\ 2 = 0) and: [ aNumberOfPins = 10 ])
		ifTrue: [ rolls add: 10. rolls add: 0 ]
		ifFalse: [ rolls add: aNumberOfPins ]"


	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:04:45'!
model08

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2 or: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	(total = 10 and: [ rolls size = 1 ]) ifTrue: [ ^ total + nextFrame firstRoll + nextFrame secondRoll ].
	
	(total = 10 and: [ rolls size = 2 ]) ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''secondRoll
	
	(rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ] ) ifTrue: [ ^ 0 ].
	(rolls size = 1 and: [ rolls first = 10 ]) ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := Frame new.
	
	frames add: currentFrame
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:05:15'!
model09

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''isComplete

	^ rolls size = 2 or: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score
	
	| total |
	
	total := rolls sum: [: roll | roll ] ifEmpty: [ 0 ].
	
	(total = 10 and: [ rolls size = 1 ]) ifTrue: [ ^ total + nextFrame firstRoll + nextFrame secondRoll ].
	
	(total = 10 and: [ rolls size = 2 ]) ifTrue: [ ^ total + nextFrame firstRoll ].
	
	^ total
	
	'' classified: ''score''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''secondRoll
	
	(rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ] ) ifTrue: [ ^ 0 ].
	(rolls size = 1 and: [ rolls first = 10 ]) ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := Frame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	frames size > maxNumberOfFrames ifTrue: [ ^ self error: ''''Game already ended'''' ].

	currentFrame addRoll: numberOfPins.
	
	currentFrame isComplete ifTrue: [ | nextFrame | 
		
		nextFrame := Frame new.
		
		frames add: nextFrame.
		
		currentFrame nextFrame: nextFrame.
		
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:05:44'!
model10

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''isComplete
	
	^ (rolls size = 2 and: [ rolls first + rolls second < 10 ]) or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	(rolls size = 1 and: [ rolls first = 10 ]) ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	(rolls size = 2 and: [ rolls first + rolls second = 10 ]) ifTrue: [ ^ 10+ nextFrame firstRoll ].
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ].
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''secondRoll
	
	(rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ] ) ifTrue: [ ^ 0 ].
	(rolls size = 1 and: [ rolls first = 10 ]) ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	(frames size = maxNumberOfFrames and: [ frames last isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ].

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [ frames size < maxNumberOfFrames ]) ifTrue: [ | nextFrame | 
	
		frames size = (maxNumberOfFrames - 1)
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:06:14'!
model11

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''isOpenFrame

	^ rolls size = 2 and: [ rolls first + rolls second < 10 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''isComplete
	
	^ self isOpenFrame or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''isSpare

	^ rolls size = 2 and: [ rolls first + rolls second = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isStrike

	^ rolls size = 1 and: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ self isStrike ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	self isStrike ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	self isSpare ifTrue: [ ^ 10 + nextFrame firstRoll ].
	
	^ rolls sum: [: roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''firstRollNotAStrikeAndStillNoSecondRollMade
	
	^ rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''secondRoll
	
	self firstRollNotAStrikeAndStillNoSecondRollMade ifTrue: [ ^ 0 ].
	self isStrike ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	(frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ].
	numberOfPins < 0 ifTrue: [self error: ''''Rolls must be positive'''' ].

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [ frames size < maxNumberOfFrames ]) ifTrue: [ | nextFrame | 
	
		frames size = (maxNumberOfFrames - 1)
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:06:55'!
model12

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''isOpenFrame

	^ rolls size = 2 and: [ rolls first + rolls second < 10 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''isComplete
	
	^ self isOpenFrame or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''isSpare

	^ rolls size = 2 and: [ rolls first + rolls second = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isStrike

	^ rolls size = 1 and: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ self isStrike ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	self isStrike ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	self isSpare ifTrue: [ ^ 10 + nextFrame firstRoll ].
	
	^ rolls sum: [: roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''firstRollNotAStrikeAndStillNoSecondRollMade
	
	^ rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''secondRoll
	
	self firstRollNotAStrikeAndStillNoSecondRollMade ifTrue: [ ^ 0 ].
	self isStrike ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''assertGameEnded

	^ (frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''assertNumberOfPinsRolledBetween1And10: numberOfPins

	numberOfPins < 0 ifTrue: [ self error: ''''Rolls must be positive'''' ].
	numberOfPins > 10 ifTrue: [ self error: ''''Only 10 pins to hit on a single roll'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''stillAreFramesToAdd

	^ frames size < maxNumberOfFrames
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''isLastFrame

	^ frames size = (maxNumberOfFrames - 1)
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	"1era versión:"
	"(frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ].
	numberOfPins < 0 ifTrue: [self error: ''''Rolls must be positive'''' ].
	numberOfPins > 10 ifTrue: [self error: ''''Only 10 pins to hit on a single roll'''' ]."
	
	"Última versión (Paso 3):"
	self assertGameEnded.
	self assertNumberOfPinsRolledBetween1And10: numberOfPins.

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [ self stillAreFramesToAdd ]) ifTrue: [ | nextFrame | 
	
		self isLastFrame
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:27:07'!
model13

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''addRoll: numberOfPins

	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	LastFrame compile: ''isOpenFrame

	^ rolls size = 2 and: [ rolls first + rolls second < 10 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''isComplete
	
	^ self isOpenFrame or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''addRoll: numberOfPins
	
	(rolls size > 0 and: [ rolls first + numberOfPins > 10 ]) ifTrue: [ self error: ''''Only 10 pins to hit in a single normal frame'''' ].
	
	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''isSpare

	^ rolls size = 2 and: [ rolls first + rolls second = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isStrike

	^ rolls size = 1 and: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ self isStrike ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	self isStrike ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	self isSpare ifTrue: [ ^ 10 + nextFrame firstRoll ].
	
	^ rolls sum: [: roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''firstRollNotAStrikeAndStillNoSecondRollMade
	
	^ rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''secondRoll
	
	self firstRollNotAStrikeAndStillNoSecondRollMade ifTrue: [ ^ 0 ].
	self isStrike ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''assertGameEnded

	^ (frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''assertNumberOfPinsRolledBetween1And10: numberOfPins

	numberOfPins < 0 ifTrue: [ self error: ''''Rolls must be positive'''' ].
	numberOfPins > 10 ifTrue: [ self error: ''''Only 10 pins to hit on a single roll'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''stillAreFramesToAdd

	^ frames size < maxNumberOfFrames
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''isLastFrame

	^ frames size = (maxNumberOfFrames - 1)
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	self assertGameEnded.
	self assertNumberOfPinsRolledBetween1And10: numberOfPins.

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [ self stillAreFramesToAdd  ]) ifTrue: [ | nextFrame | 
	
		self isLastFrame
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:29:51'!
model14

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''addRoll: numberOfPins

	(rolls size = 1 and: [ rolls first ~= 10 and: [ rolls first + numberOfPins > 10 ] ]) ifTrue: [ self error: ''''Only 10 pins to hit'''' ].
	
	rolls add: numberOfPins.
	
	'' classified: ''rolls''.
	
	
	LastFrame compile: ''isOpenFrame

	^ rolls size = 2 and: [ rolls first + rolls second < 10 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''isComplete
	
	^ self isOpenFrame or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''addRoll: numberOfPins
	
	(rolls size > 0 and: [ rolls first + numberOfPins > 10 ]) ifTrue: [ self error: ''''Only 10 pins to hit in a single normal frame'''' ].
	
	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''isSpare

	^ rolls size = 2 and: [ rolls first + rolls second = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isStrike

	^ rolls size = 1 and: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ self isStrike ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	self isStrike ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	self isSpare ifTrue: [ ^ 10 + nextFrame firstRoll ].
	
	^ rolls sum: [: roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''firstRollNotAStrikeAndStillNoSecondRollMade
	
	^ rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''secondRoll
	
	self firstRollNotAStrikeAndStillNoSecondRollMade ifTrue: [ ^ 0 ].
	self isStrike ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''assertGameEnded

	^ (frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''assertNumberOfPinsRolledBetween1And10: numberOfPins

	numberOfPins < 0 ifTrue: [ self error: ''''Rolls must be positive'''' ].
	numberOfPins > 10 ifTrue: [ self error: ''''Only 10 pins to hit on a single roll'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''stillAreFramesToAdd

	^ frames size < maxNumberOfFrames
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''isLastFrame

	^ frames size = (maxNumberOfFrames - 1)
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	self assertGameEnded.
	self assertNumberOfPinsRolledBetween1And10: numberOfPins.

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [  self stillAreFramesToAdd ]) ifTrue: [ | nextFrame | 
	
		self isLastFrame
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/26/2024 10:30:46'!
model15

	^ 'Object subclass: #Frame
	instanceVariableNames: ''rolls''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	Frame compile: ''initialize

	rolls := OrderedCollection new
	
	'' classified: ''initialization''.
	
	
	Frame compile: ''addRoll: numberOfPins

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''firstRoll
	
	rolls isEmpty ifTrue: [ ^ 0 ].
	
	^ rolls first
	
	'' classified: ''rolls''.
	
	
	Frame compile: ''isComplete

	self subclassResponsibility
	
	'' classified: ''frame''.
	
	
	Frame compile: ''score

	self subclassResponsibility
	
	'' classified: ''score''.
	
	
	Frame compile: ''secondRoll

	self subclassResponsibility
	
	'' classified: ''rolls''.
	
	[Frame removeSelector: #nextFrame:] on: Error do: [].
	
	Frame subclass: #LastFrame
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	LastFrame compile: ''addRoll: numberOfPins

	(rolls size = 1 and: [ rolls first ~= 10 and: [ rolls first + numberOfPins > 10 ] ]) ifTrue: [ self error: ''''Only 10 pins to hit'''' ].
	(rolls size = 2 and: [ rolls first = 10 and: [ rolls second ~= 10 and: [ rolls second + numberOfPins > 10 ] ] ]) ifTrue: [ self error: ''''Only 10 pins to hit'''' ].
	
	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	LastFrame compile: ''isOpenFrame

	^ rolls size = 2 and: [ rolls first + rolls second < 10 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''isComplete
	
	^ self isOpenFrame or: [ rolls size = 3 ]
	
	'' classified: ''frame''.
	
	
	LastFrame compile: ''score
	
	^ rolls sum: [ :roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	LastFrame compile: ''secondRoll
	
	rolls isEmpty ifTrue: [ ^0 ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Frame subclass: #NormalFrame
	instanceVariableNames: ''nextFrame''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	NormalFrame compile: ''areMoreThan10PinsKnockedDownOnSingleNormalFrame: numberOfPins
	
	^ rolls size > 0 and: [ rolls first + numberOfPins > 10 ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''addRoll: numberOfPins
	
	(self areMoreThan10PinsKnockedDownOnSingleNormalFrame: numberOfPins) ifTrue: [ self error: ''''Only 10 pins to hit in a single normal frame'''' ].
	
	rolls add: numberOfPins
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''isSpare

	^ rolls size = 2 and: [ rolls first + rolls second = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isStrike

	^ rolls size = 1 and: [ rolls first = 10 ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''isComplete

	^ rolls size = 2 or: [ self isStrike ]
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''nextFrame: aFrame

	nextFrame := aFrame
	
	'' classified: ''frame''.
	
	
	NormalFrame compile: ''score
	
	self isStrike ifTrue: [ ^ 10 + nextFrame firstRoll + nextFrame secondRoll ].
	self isSpare ifTrue: [ ^ 10 + nextFrame firstRoll ].
	
	^ rolls sum: [: roll | roll ] ifEmpty: [ 0 ]
	
	'' classified: ''score''.
	
	
	NormalFrame compile: ''firstRollNotAStrikeAndStillNoSecondRollMade
	
	^ rolls size = 0 or: [rolls size = 1 and: [ rolls first ~= 10 ] ]
	
	'' classified: ''rolls''.
	
	
	NormalFrame compile: ''secondRoll
	
	self firstRollNotAStrikeAndStillNoSecondRollMade ifTrue: [ ^ 0 ].
	self isStrike ifTrue: [ ^ nextFrame firstRoll ].
	
	^ rolls second
	
	'' classified: ''rolls''.
	
	
	Object subclass: #BowlingGame
	instanceVariableNames: ''frames currentFrame maxNumberOfFrames''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameBowling''.
	
	
	BowlingGame compile: ''score
	
	^ frames sum: [ :frame | frame score ]
	
	'' classified: ''score''.
	
	
	BowlingGame compile: ''initialize
	
	frames := OrderedCollection new.
	currentFrame := NormalFrame new.
	frames add: currentFrame.
	
	maxNumberOfFrames := 10
	
	'' classified: ''initialization''.
	
	
	BowlingGame compile: ''assertGameEnded

	^ (frames size = maxNumberOfFrames and: [ currentFrame isComplete ]) ifTrue: [ self error: ''''Game already ended'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''assertNumberOfPinsRolledBetween1And10: numberOfPins

	numberOfPins < 0 ifTrue: [ self error: ''''Rolls must be positive'''' ].
	numberOfPins > 10 ifTrue: [ self error: ''''Only 10 pins to hit on a single roll'''' ]
	
	'' classified: ''assertions''.
	
	
	BowlingGame compile: ''stillAreFramesToAdd

	^ frames size < maxNumberOfFrames
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''isLastFrame

	^ frames size = (maxNumberOfFrames - 1)
	
	'' classified: ''game state''.
	
	
	BowlingGame compile: ''roll: numberOfPins
	
	self assertGameEnded.
	self assertNumberOfPinsRolledBetween1And10: numberOfPins.

	currentFrame addRoll: numberOfPins.
	
	(currentFrame isComplete and: [ self stillAreFramesToAdd ]) ifTrue: [ | nextFrame | 
	
		self isLastFrame
			ifTrue: [ nextFrame := LastFrame new ]
			ifFalse: [ nextFrame := NormalFrame new ].
			
		currentFrame nextFrame: nextFrame.
		frames add: nextFrame.
		currentFrame := nextFrame ]
	
	'' classified: ''rolls''
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/24/2024 08:45:53'!
reset
	
	^ '
	[ classesInCategory := (SystemOrganization listAtCategoryNamed: ''TDDBabyStepsGameBowling'", self name",''') collect: [:each | Smalltalk at: each].
	classesInCategory do: [ :aClass | 
		aClass name = ''TDDBabyStepsBowling'",self name",'Test'' 
			ifFalse:[ aClass selectors do: [ :selector | aClass removeSelector: selector ].
					aClass class selectors do: [ :selector | aClass class removeSelector: selector ].  
					aClass removeFromSystem
			]
		]
	] on: Error do: []
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/27/2024 12:37:40'!
solutionModelBuilder

	^ AbsoluteCompleteModelBuilder ! !

!TDDBabyStepsGameBowling methodsFor: 'models' stamp: 'NR 6/27/2024 09:03:57'!
userSolutionSourceCodeRetrieverNotGeneralized
	
	^ '| completeSourceCode |
	
	completeSourceCode := ''''.
	
	[ classesInCategory := (SystemOrganization listAtCategoryNamed: ''TDDBabyStepsGameBowling'", self name",''') asSortedCollection collect: [:each | Smalltalk at: each].
	classesInCategory do: [ :aClass | 
		aClass name = ''TDDBabyStepsBowling'",self name",'Test'' 
			ifFalse:[ completeSourceCode := completeSourceCode, (String with: Character newLineCharacter), aClass name,'':'', (String with: Character newLineCharacter), (String with: Character newLineCharacter).
					
					aClass class selectors asSortedCollection do: [ :selector | 
					| selectorSourceCode |
					selectorSourceCode := [ aClass name,'' class >> (+)'', (aClass class sourceCodeAt: selector), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
					completeSourceCode := completeSourceCode, selectorSourceCode].
					
					aClass selectors asSortedCollection do: [ :selector | 
					| selectorSourceCode |
					selectorSourceCode := [ aClass name,'' >> '', (aClass sourceCodeAt: selector), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
					completeSourceCode := completeSourceCode, selectorSourceCode]
			]
		]
	] on: Error do: [].
	
	^ completeSourceCode
	
	'
	! !


!TDDBabyStepsGameBowling methodsFor: 'step duration' stamp: 'NR 6/26/2024 08:34:01'!
maxStepDuration

	^ Duration minutes: 15! !


!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:36:37'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata

	| game |
	
	game := BowlingGame new.
	
	game roll: 4.
	game roll: 2.
	
	game roll: 0.
	game roll: 10.
	
	game roll: 3.
	game roll: 5.
	
	game roll: 10.
	
	game roll: 9.
	game roll: 0.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 0.
	game roll: 10.
	
	game roll: 5.
	game roll: 5.
	game roll: 10.
	
	self assert: game score equals: (6 + (10 + 3) + 8  + (10 + 9 + 0) + 9  + (10 + 10 + 10) + (10 + 10 + 0) + (10 + 0 + 10) + (10 + 5) + (5 + 5 + 10)). 
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:36:42'!
genCase01

	^ 'test01Generalization

	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:36:45'!
genCase02

	^ 'test02Generalization

	'
	! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 07:14:29'!
genCase03
	
	^ 'test03GeneralizationOpenFrameCalculatedAsTheSumOfIts2Rolls

	| game |
	
	game := BowlingGame new.
	
	game roll: 6.
	game roll: 3.
	
	game roll: 0.
	game roll: 2.
	
	game roll: 8.
	game roll: 0.
	
	game roll: 2.
	game roll: 7.
	
	
	self assert: game score equals: (9 + 2 + 8 + 9)
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 07:18:39'!
genCase04
	
	^ 'test04Generalization
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 8.
	
	game roll: 3.
	game roll: 7.
	
	game roll: 0.
	game roll: 10.
	
	game roll: 2.
	game roll: 1.
	
	game roll: 5.
	game roll: 5.
	
	game roll: 4.
	
	self assert: game score equals: ((10 + 3) + (10 + 0) + (10 + 2) + 3 + (10 + 4) + 4)
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 07:18:46'!
genCase05

	^ 'test05Generalization
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 8.
	
	game roll: 3.
	game roll: 7.
	
	game roll: 0.
	game roll: 10.
	
	game roll: 2.
	game roll: 1.
	
	game roll: 9.
	game roll: 1.
	
	self assert: game score equals: ((10 + 3) + (10 + 0) + (10 + 2) + 3 + (10))
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:36:53'!
genCase06

	^ 'test06GeneralizationStrikeScoreCalculatedAsTheSumOfIts2RollsAndNext2RollsOFNextFrameAsBonuses

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 0.
	game roll: 10.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10 + 0 + 10) + 10)
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 08:11:31'!
genCase07
	
	^ 'test07GeneralizationStrikeScoreCalculatedPartiallyIfSomeBonusesNotYetRolled
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 1.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10 + 1) + 1)

	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:36:58'!
genCase08
	
	^ 'test08GeneralizationStrikeScoreCalculatedCrossing2FramesIfFirstBonusRollIsAnotherStrike

	| game |
	
	game := BowlingGame new.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 0.
	game roll: 10.
	
	game roll: 10.
	
	game roll: 10.
	
	self assert: game score equals: (8 + (10 + 10 + 10) + (10 + 10 + 10) + (10 + 10 + 0) + (10 + 0 + 10) + (10 + 10) + (10 + 10) + 10)
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:37:02'!
genCase09

	^ 'test9GeneralizationLastFrameWorkLikeNormalFrameEvenIfPenultimateFrameIsStrike

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 2.
	
	2 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 10.
	
	game roll: 5.
	game roll: 4.
	
	self should: [ game roll: 1 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Game already ended''.
		self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 3 + (10 + 5 + 4) + 9) ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:37:05'!
genCase10
	
	^ 'test10GeneralizationNoScoreBonusesForSTRIKEOrSpareOnLastFrameButExtraRoll

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 2.
	
	3 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 10.
	game roll: 1.
	game roll: 9.
	
	self should: [ game roll: 10 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Game already ended''.
		self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 1 + 2 + (10 + 1 + 9)) ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:37:09'!
genCase11

	^ 'test11GeneralizationRollsMustBePositive

	| game |
	
	game := BowlingGame new.
	
	self should: [ game roll: -4 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Rolls must be positive''.
		self assert: game score equals: 0 ].
	
	game := BowlingGame new.
	
	9 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 9.
	game roll: 1.
	
	self should: [ game roll: -200 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Rolls must be positive''.
		self assert: game score equals: 10 ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 08:09:36'!
genCase12

	^ 'test12GeneraliztionCantHitMoreThan10PinsOnASingleRoll

	| game |
	
	game := BowlingGame new.
	
	self should: [ game roll: 300 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit on a single roll''.
		self assert: game score equals: 0 ].
	
	game := BowlingGame new.
	
	game roll: 1.
	game roll: 1.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 10.
	
	game roll: 0.
	
	self should: [ game roll: 11] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit on a single roll''.
		self assert: game score equals: (2 + (10 + 10) + (10 + 0) + 0) ].
	
	game := BowlingGame new.
	
	9 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 10.
	game roll: 0.
	
	self should: [ game roll: 11 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit on a single roll''.
		self assert: game score equals: 10 ]
	
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 08:08:47'!
genCase13

	^ 'test13GeneralizationCantHitMoreThan10PinsOnASingleNormalFrame

	| game |
	
	game := BowlingGame new.
	
	game roll: 1.
	
	self should: [ game roll: 10 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit in a single normal frame''.
		self assert: game score equals: 1 ].
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'generalization' stamp: 'NR 6/26/2024 08:18:20'!
genCase14

	^ 'test14GeneralizationCantHitMoreThan10PinsOnLastFrameWith2Rolls

	| game |
	
	game := BowlingGame new.
	
	9 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 9.
	
	self should: [ game roll: 2 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit''.
		self assert: game score equals: 9 ]								
	'! !


!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:23'!
case01

	^ 'test01BowlingGameWithNoRollsHas0Score

	| game |
	
	game := BowlingGame new.
	
	self assert: game score equals: 0
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:32'!
case02

	^ 'test02BowlingGameWithJustOneRollHasItAsScore
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	
	self assert: game score equals: 2															
	'
	! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:36'!
case03
	
	^ 'test03OpenFrameCalculatedAsTheSumOfIts2Rolls

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	self assert: game score equals: 6
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:40'!
case04
	
	^ 'test04SpareScoreCalculatedAsTheSumOfIts2RollsAndNextRollAsBonus

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	
	self assert: game score equals: (6 + (10 + 5) + 5)
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/26/2024 08:57:15'!
case05

	^ 'test05SpareScoreCalculatedJustAsTheSumOfIts2RollsWhenBonusNotYetRolled

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.

	game roll: 0.
	game roll: 10.
	
	game roll: 2.
	game roll: 8.
	
	self assert: game score equals: (6 + (10 + 0) + (10 + 2) + (10)) 
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:46'!
case06

	^ 'test06StrikeScoreCalculatedAsTheSumOfIts2RollsAndNext2RollsOFNextFrameAsBonuses

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 1.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10 + 1 + 1) + 2) 
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/26/2024 08:11:44'!
case07
	
	^ 'test07StrikeScoreCalculatedPartiallyIfSomeBonusesNotYetRolled

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10))
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:35:55'!
case08
	
	^ 'test08StrikeScoreCalculatedCrossing2FramesIfFirstBonusRollIsAnotherStrike

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 2.
	
	self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 1 + 2 )
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:00'!
case09

	^ 'test09GameEndsAfter10Frames

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 2.
	
	4 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	self should: [ game roll: 1 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Game already ended''.
		self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 1 + 2) ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:03'!
case10
	
	^ 'test10NoScoreBonusesForStrikeOrSpareOnLastFrameButExtraRoll
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 2.
	
	3 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 9.
	game roll: 1.
	game roll: 10.
	
	self should: [ game roll: 10 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Game already ended''.
		self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 1 + 2 + (9 + 1 + 10)) ]
	
	'
	! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:08'!
case11

	^ 'test11RollsMustBePositive

	| game |
	
	game := BowlingGame new.
	
	game roll: 7.
	
	self should: [ game roll: -1 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Rolls must be positive''.
		self assert: game score equals: 7 ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:11'!
case12

	^ 'test12CantHitMoreThan10PinsOnASingleRoll

	| game |
	
	game := BowlingGame new.
	
	game roll: 7.
	game roll: 1.
	
	self should: [ game roll: 11 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit on a single roll''.
		self assert: game score equals: 8 ]
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:16'!
case13

	^ 'test13CantHitMoreThan10PinsOnASingleNormalFrame

	| game |
	
	game := BowlingGame new.
	
	game roll: 7.
	
	self should: [ game roll: 4 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit in a single normal frame''.
		self assert: game score equals: 7 ]
	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:21'!
case14

	^ 'test14CantHitMoreThan10PinsOnLastFrameWith2Rolls

	| game |
	
	game := BowlingGame new.
	
	9 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 8.
	
	self should: [ game roll: 9 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit''.
		self assert: game score equals: 8 ]																	
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:25'!
case15

	^ 'test15CantHitMoreThan10PinsOnLastFrameAfterStrike

	| game |
	
	game := BowlingGame new.
	
	9 timesRepeat: [ game roll: 0. game roll: 0 ].
	
	game roll: 10.
	game roll: 9.
	
	self should: [ game roll: 8 ] 
	raise: Error 
	withExceptionDo: [ :error | self assert: error messageText equals: ''Only 10 pins to hit''.
		self assert: game score equals: 19 ]
	'! !

!TDDBabyStepsGameBowling methodsFor: 'cases' stamp: 'NR 6/27/2024 12:36:29'!
numberOfCases

	^ 15! !


!classDefinition: #TDDBabyStepsGameContador category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameContador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameContador methodsFor: 'definition' stamp: 'NR 5/3/2022 08:40:17'!
definition
	
	^ ' Implementar un contador que recibe el mensaje incrementar para incrementar en 1 su valor.
	El contador debe comenzar en 0.
	El contador tambien sabe responder el mensaje value para obtener su valor.
'! !

!TDDBabyStepsGameContador methodsFor: 'definition' stamp: 'NR 6/8/2024 22:39:19'!
name 
	
	^ 'Contador'! !


!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 4/29/2024 06:47:13'!
model01
	
	^ 'Object subclass: #Contador
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameContador''.
	
	Contador compile: ''valor
	
	^0'' classified: ''value''.
	
	'.! !

!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 4/29/2024 06:47:28'!
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

!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 4/29/2024 06:50:34'!
model03
	
	^ 'Contador compile: ''incrementar
	
	value := value + 1'' classified: ''value''.
	
	'.	! !

!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 6/21/2024 07:47:34'!
reset
	
	^ '[ Contador selectors do: [ :selector | Contador removeSelector: selector ]. 
	Contador removeFromSystem ] on: Error do: []'! !

!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 6/21/2024 21:56:11'!
solutionModelBuilder

	^ IncrementalPartialModelBuilder! !

!TDDBabyStepsGameContador methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	^ '| initializeSC valorSC incrementarSC |
	
	initializeSC := ''''.
	[ initializeSC:= Contador sourceCodeAt: #initialize ] on: Error do: [].

	valorSC  := ''''.
	[ valorSC := Contador sourceCodeAt: #valor ] on: Error do: [].

	incrementarSC := ''''.
	[ incrementarSC := Contador sourceCodeAt: #incrementar ] on: Error do: [].

	^ initializeSC, (String with: Character newLineCharacter), (String with: Character newLineCharacter), 
	valorSC, (String with: Character newLineCharacter), (String with: Character newLineCharacter), 
	incrementarSC'! !


!TDDBabyStepsGameContador methodsFor: 'step duration' stamp: 'NR 6/8/2024 22:24:55'!
maxStepDuration

	^ Duration minutes: 3! !


!TDDBabyStepsGameContador methodsFor: 'generalization' stamp: 'NR 5/13/2024 06:13:23'!
extraCase
	
	^ 'extraTest
	
	self assert: true
	' ! !

!TDDBabyStepsGameContador methodsFor: 'generalization' stamp: 'NR 6/8/2024 22:38:10'!
genCase01
	
	^ 'test01GeneralizationUnNuevoContadorEmpiezaConValorCero

	'! !

!TDDBabyStepsGameContador methodsFor: 'generalization' stamp: 'NR 6/8/2024 22:38:15'!
genCase02
	
	^ 'test02GeneralizationAlIncrementarUnaVezElContadorSuValorSubeUno

	' ! !


!TDDBabyStepsGameContador methodsFor: 'cases' stamp: 'NR 5/13/2024 06:14:26'!
case01
	
	^ 'test01UnNuevoContadorEmpiezaConValorCero

	| contador |
		
	contador := Contador new.
	self assert: 0 equals: contador valor
	'! !

!TDDBabyStepsGameContador methodsFor: 'cases' stamp: 'NR 5/13/2024 06:14:31'!
case02
	
	^ 'test02AlIncrementarUnaVezElContadorSuValorSubeUno

	| contador |

	contador := Contador new.
	contador incrementar.
	self assert: 1 equals: contador valor
	' ! !

!TDDBabyStepsGameContador methodsFor: 'cases' stamp: 'NR 5/13/2024 06:14:35'!
case03
	
	^ 'test03SePuedeIncrementarVariasVecesElContadorYSuValorIncrementaEnUnoEsaCantidadDeVeces

	| contador |

	contador := Contador new.
	contador incrementar.
	contador incrementar.
	contador incrementar.
	self assert: 3 equals: contador valor
	'! !

!TDDBabyStepsGameContador methodsFor: 'cases' stamp: 'NR 6/16/2024 07:28:30'!
numberOfCases

	^ 3! !


!classDefinition: #TDDBabyStepsGameMinesweeper category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameMinesweeper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameMinesweeper methodsFor: 'definition' stamp: 'NR 6/25/2024 16:58:15'!
definition
	
	^ 'El «Buscaminas» es un divertido juego cuyo objetivo es encontrar todas las minas dentro de un campo minado de NxM posiciones. Para ayudarte, el juego muestra números que indican cuántas minas hay adyacentes a cada posición. 
	
Por ejemplo, considere el siguiente campo de 4x4 con 2 minas (que están representadas por un caracter *):
	
''*...''
''....''
''.*..''
''....''

El mismo campo minado, pero con los números de ayuda se vería de la sigueinte manera:
					
''*100''
''2210''
''1*10''
''1110''

El objetivo de la kata es escribir un programa que reciba un campo minado de cualquier longitud y devuelva su versión de ayuda tal como arrriba.
	
Ayuda: Los tests modelan a los campos minados como colecciones de strings.
 
'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'definition' stamp: 'NR 6/20/2024 23:33:49'!
name 
	
	^ 'Minesweeper'! !


!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:50:18'!
model01

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	^ #(''''0'''')
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:55:10'!
model02

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	minefield size = 1 ifTrue: [ ^ #(''''0'''') ].
	^ # (		''''0'''' 
			''''0'''').
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:50:34'!
model03

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: minefield size.
	
	1 to: (minefield size) do: [ :row | sweptMinefield at: row put: ''''0'''' ].
	
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 09:06:09'!
model04

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: minefield size.
	
	1 to: (minefield size) do: [ :row | 
		(minefield at: row) size = 1 
			ifTrue:[ sweptMinefield at: row put: ''''0'''' ]
			ifFalse: [ sweptMinefield at: row put: ''''00'''' ] ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:50:46'!
model05

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield rowSize |
	
	rowSize := minefield size.
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| colSize sweptMinefieldRow |
		
		colSize := (minefield at: row) size.
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			sweptMinefieldRow at: col put: $0 ].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:51:08'!
model06

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield rowSize |
	
	rowSize := minefield size.
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| colSize sweptMinefieldRow |
		
		colSize := (minefield at: row) size.
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			sweptMinefieldRow at: col put: $0 ].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 09:25:32'!
model07

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].

	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield rowSize colSize |
	
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			sweptMinefieldRow at: col put: $0 ].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 08:51:25'!
model08

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			sweptMinefieldRow at: col put: $0 ].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:28:02'!
model09

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
			
			"Última versión (Paso 3):"
			((minefield at: row) at: col) =  $* ifTrue: [ sweptMinefieldRow at: col put: $* ] ].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
	
	"1era versión:"
	"minefield = #(''''*'''') ifTrue: [ sweptMinefield := minefield ]."
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:32:15'!
model10

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
		
			((minefield at: row) at: col) =  $* 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(row - 1 > 0 and: [ ((minefield at: row - 1) at: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]
		].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:49:01'!
model11

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
			
			"1era versión:"
			"((minefield at: row) at: col) =  $* 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(row - 1 > 0 and: [ ((minefield at: row - 1) at: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
				
			(row + 1 <= rowSize and: [ ((minefield at: row + 1) at: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]"
			
			"Última versión (Paso 3):"
			(self fieldAtRow: row atCol: col) =  $* 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(row - 1 > 0 and: [ (self fieldAtRow: row - 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
				
			(row + 1 <= rowSize and: [ (self fieldAtRow: row + 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	
		].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:38:05'!
model12


	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
			
			(self fieldAtRow: row atCol: col) =  $* 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(row - 1 > 0 and: [ (self fieldAtRow: row - 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
				
			(row + 1 <= rowSize and: [ (self fieldAtRow: row + 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.
				
			(col - 1 > 0 and: [ (self fieldAtRow: row atCol: col - 1) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	
		].
		
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:51:43'!
model13

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''isMineAtRow: row atCol: col

	^ row > 0 and: [ row <= rowSize and: [ col > 0 and: [ col <= colSize and: [ (self fieldAtRow: row atCol: col) =  $* ] ] ] ]
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
			
			"1era versión:"
			"(self fieldAtRow: row atCol: col) =  $* 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(row - 1 > 0 and: [ (self fieldAtRow: row - 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
				
			(row + 1 <= rowSize and: [ (self fieldAtRow: row + 1 atCol: col) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.
				
			(col - 1 > 0 and: [ (self fieldAtRow: row atCol: col - 1) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.
				
			(col + 1 <= colSize and: [ (self fieldAtRow: row atCol: col + 1) = $* ])
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	."
				
			"Última versión (Paso 3):"
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].
			
			(self isMineAtRow: row - 1 atCol: col)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
				
			(self isMineAtRow: row + 1 atCol: col)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.
				
			(self isMineAtRow: row atCol: col - 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.
				
			(self isMineAtRow: row atCol: col + 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	
		].
			
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 07:55:15'!
model14

	^'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''areInRangeRow: row andCol: col

	^ row > 0 and: [ row <= rowSize and: [ col > 0 and: [ col <= colSize ] ] ]
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''isMineAtRow: row atCol: col

	^ (self areInRangeRow: row andCol: col) and: [ (self fieldAtRow: row atCol: col) =  $* ] 
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
			
			sweptMinefieldRow at: col put: $0.
			
			"1era versión:"
			"(self isMineAtRow: row - 1 atCol: col - 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
			(self isMineAtRow: row - 1 atCol: col)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
			(self isMineAtRow: row - 1 atCol: col + 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].	
			(self isMineAtRow: row atCol: col - 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].			
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ].	
			(self isMineAtRow: row atCol: col + 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].
			(self isMineAtRow: row + 1 atCol: col - 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ].	
			(self isMineAtRow: row + 1 atCol: col)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	.	
			(self isMineAtRow: row + 1 atCol: col + 1)
				ifTrue: [ sweptMinefieldRow at: col put: $1 ]	"
				
			"Última versión (Paso 3):"
			-1 to: 1 do: [ :vertIndex |
				-1 to: 1 do: [ :horizIndex |
					(self isMineAtRow: row + vertIndex atCol: col + horizIndex) 
						ifTrue:[ sweptMinefieldRow at: col put: $1 ]
				]
			].
		
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ]
		].
			
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/22/2024 08:05:34'!
model15

	^ 'Object subclass: #Minesweeper
	instanceVariableNames: ''minefield rowSize colSize''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameMinesweeper''.
	
	Minesweeper class compile: ''with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	'' classified: ''instance creation''.
	
	Minesweeper class compile: ''assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: ''''Height cant be less than 1'''' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: ''''Width cant be less than 1'''' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: ''''All columns should be the same size'''' ]. 

	'' classified: ''assertions''.
	
	Minesweeper compile: ''initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	'' classified: ''initialization''.
	
	Minesweeper compile: ''fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''areInRangeRow: row andCol: col

	^ row > 0 and: [ row <= rowSize and: [ col > 0 and: [ col <= colSize ] ] ]
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''isMineAtRow: row atCol: col

	^ (self areInRangeRow: row andCol: col) and: [ (self fieldAtRow: row atCol: col) =  $* ] 
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''notCenterCoordinatesVert: vertIndex hor: horizIndex
	
	^ (vertIndex = 0 and: [ horizIndex = 0 ]) not	
	
	'' classified: ''accessing''.
	
	Minesweeper compile: ''numberOfAdjacentMinesToRow: row toCol: col
	
	| numberOfAdjacentMines |
	
	numberOfAdjacentMines := 0.
	
	-1 to: 1 do: [ :vertIndex |
		-1 to: 1 do: [ :horizIndex |
			((self notCenterCoordinatesVert: vertIndex hor: horizIndex) and: [ self isMineAtRow: row + vertIndex atCol: col + horizIndex ])
				ifTrue:[ numberOfAdjacentMines := numberOfAdjacentMines + 1 ]
		]
	].

	^ numberOfAdjacentMines
	
	'' classified: ''adjacent mines''.
	
	Minesweeper compile: ''sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
						
			"1era versión:"
			"| numberOfAdjacentMines |
			
			numberOfAdjacentMines := 0.
			-1 to: 1 do: [ :vertIndex |
				-1 to: 1 do: [ :horizIndex |
					((vertIndex = 0 and: [ horizIndex = 0]) not and: [ self isMineAtRow: row + vertIndex atCol: col + horizIndex ])
						ifTrue:[ numberOfAdjacentMines := numberOfAdjacentMines + 1 ]
				]
			].
			
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ]
				ifFalse: [ sweptMinefieldRow at: col put: numberOfAdjacentMines asString first ]"
			
			"Última versión (Paso 3):"
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ]
				ifFalse: [ sweptMinefieldRow at: col put: (self numberOfAdjacentMinesToRow: row toCol: col) asString first ]
			
		].
			
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 07:45:52'!
reset
	
	^ '[ Minesweeper selectors do: [ :selector | Minesweeper removeSelector: selector ].
	Minesweeper class selectors do: [ :selector | Minesweeper class removeSelector: selector ].  
	Minesweeper removeFromSystem ] on: Error do: []'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 21:57:52'!
solutionModelBuilder

	^ AbsoluteCompleteModelBuilder ! !

!TDDBabyStepsGameMinesweeper methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	^ '| completeSourceCode |
	
	completeSourceCode := ''''.
	[ Minesweeper selectors asSortedCollection do: [ :selector | 
		| selectorSourceCode |
		selectorSourceCode := [ (Minesweeper sourceCodeAt: selector), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
		completeSourceCode := completeSourceCode, selectorSourceCode ].
	] on: Error do: [].
	^ completeSourceCode'
	! !


!TDDBabyStepsGameMinesweeper methodsFor: 'step duration' stamp: 'NR 6/20/2024 23:33:34'!
maxStepDuration

	^ Duration minutes: 5! !


!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/22/2024 08:08:16'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata

	| minefield |

	minefield := #(				''**...**''
					''*.....*''
					''...*...''
					''*.....*''
					''**...**'').
							
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''**101**''
																''*32123*''
																''221*122''
																''*32123*''
																''**101**'').
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:10:29'!
genCase01

	^ 'test01GeneralizationSweepingEmpty1x1MinefieldReturns1x1SweptMinefieldWithZero

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:16:51'!
genCase02

	^ 'test02GeneralizationSweepingEmpty2x1MinefieldReturns2x1SweptMinefieldWithZeros

	'
	! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:17:53'!
genCase03
	
	^ 'test03GeneralizationSweepingEmptyMoreThan2x1MinefieldReturnsMoreThan2x1SweptMinefieldWithZeros
	
	| minefield8x1 |
	
	minefield8x1 := #(					''.''
						''.''
						''.''
						''.''
						''.''
						''.''
						''.''
						''.'').		
	
	self assert: ((Minesweeper with: minefield8x1) sweep) equals: #(															''0''
																''0''
																''0''
																''0''
																''0''
																''0''
																''0''
																''0'')

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:22:11'!
genCase04
	
	^ 'test04GeneralizationSweepingEmptyNx2MinefieldReturnsNx2SweptMinefieldWithZeros
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:22:47'!
genCase05

	^ 'test05GeneralizationSweepingEmptyNxMMinefieldReturnsNxMSweptMinefieldWithZeros
	
	| minefield6x10 |

	minefield6x10 := #(					''..........''
						''..........''
						''..........''
						''..........''
						''..........''
						''..........'').		
						
	self assert: ((Minesweeper with: minefield6x10) sweep) equals: #(																''0000000000''
																	''0000000000''
																	''0000000000''
																	''0000000000''
																	''0000000000''
																	''0000000000'')

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:27:49'!
genCase06

	^ 'test06GeneralizationMinefieldHeightCantBeLessThan1
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/27/2024 06:28:08'!
genCase07
	
	^ 'test07GeneralizationMinefieldWidthCantBeLessThan1

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:27:18'!
genCase08
	
	^ 'test08GeneralizationColumnsOfMinefieldShouldAllHaveSameSize
       
	| minefield3x5ish |

	minefield3x5ish := #(					''.....''
						''....''
						''.....'').		
						
	self should: [ (Minesweeper with: minefield3x5ish) ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''All columns should be the same size'']
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:29:06'!
genCase09

	^ 'test09GeneralizationSweeping1MineOn1x1MinefieldReturns1x1SweptMinefieldWithMine

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:30:17'!
genCase10
	
	^ 'test10GeneralizationSweeping1MineOnTopIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:30:50'!
genCase11

	^ 'test11GeneralizationSweeping1MineAtBottomIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:31:23'!
genCase12

	^ 'test12GeneralizationSweeping1MineOnLeftIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:31:54'!
genCase13

	^ 'test13GeneralizationSweeping1MineOnRightIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:33:25'!
genCase14

	^ 'test14GeneralizationSweeping1MineAtDiagonalsIn2x2MinefieldReturnsCorrect1DistancedSweptMinefield

	'! !


!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 04:06:48'!
case01

	^ 'test01SweepingEmpty1x1MinefieldReturns1x1SweptMinefieldWithZero

	| minefield1x1 |
	
	minefield1x1 := #(''.'').
	
	self assert: ((Minesweeper with: minefield1x1) sweep) equals: #(''0'')
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 08:55:31'!
case02

	^ 'test02SweepingEmpty2x1MinefieldReturns2x1SweptMinefieldWithZeros

	| minefield2x1 |
	
	minefield2x1 := #(					''.''
						''.'').		
	
	self assert: ((Minesweeper with: minefield2x1) sweep) equals: #(																''0''
																	''0'')
																	
	'
	! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 08:55:50'!
case03
	
	^ 'test03SweepingEmptyMoreThan2x1MinefieldReturnsMoreThan2x1SweptMinefieldWithZeros

	| minefield4x1 |
	
	minefield4x1 := #(					''.''
						''.''
						''.''
						''.'').		
	
	self assert: ((Minesweeper with: minefield4x1) sweep) equals: #(																''0''
																	''0''
																	''0''
																	''0'')
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:18:52'!
case04
	
	^ 'test04SweepingEmptyNx2MinefieldReturnsNx2SweptMinefieldWithZeros

	| minefield1x2 minefield3x2 |
	
	minefield1x2 := #(		''..'').		
	
	self assert: ((Minesweeper with: minefield1x2) sweep) equals: #(''00'').
	
	minefield3x2 := #(					''..''
						''..''
						''..'').		
						
	self assert: ((Minesweeper with: minefield3x2) sweep) equals: #(																''00''
																	''00''
																	''00'')

	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:18:59'!
case05

	^ 'test05SweepingEmptyNxMMinefieldReturnsNxMSweptMinefieldWithZeros

	| minefield3x5 |

	minefield3x5 := #(					''.....''
						''.....''
						''.....'').		
						
	self assert: ((Minesweeper with: minefield3x5) sweep) equals: #(																''00000''
																	''00000''
																	''00000'')
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 04:51:03'!
case06

	^ 'test06MinefieldHeightCantBeLessThan1

	| minefield0 |

	minefield0 := #(	)	.
						
	self should: [ Minesweeper with: minefield0 ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Height cant be less than 1'']
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:19:13'!
case07
	
	^ 'test07MinefieldWidthCantBeLessThan1

	| minefield3x0 |

	minefield3x0 := #(	'''' '''' '''')	.
						
	self should: [ (Minesweeper with: minefield3x0) ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Width cant be less than 1'' ]
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:26:30'!
case08
	
	^ 'test08ColumnsOfMinefieldShouldAllHaveSameSize

	| minefield3x5ish |

	minefield3x5ish := #(						''.....''
							''......''
							''.....'').		
						
	self should: [ (Minesweeper with: minefield3x5ish) ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''All columns should be the same size'']
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 05:02:06'!
case09

	^ 'test09Sweeping1MineOn1x1MinefieldReturns1x1SweptMinefieldWithMine

	| minefield |

	minefield := #(			''*'').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(''*'')
						
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:20:07'!
case10
	
	^ 'test10Sweeping1MineOnTopIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				''*''
					''.'').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''*''
																''1'')
						
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:20:12'!
case11

	^ 'test11Sweeping1MineAtBottomIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				''.''
					''*'').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''1''
																''*'')
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 06:15:41'!
case12

	^ 'test12Sweeping1MineOnLeftIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(''*.'').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(		''*1'')
						
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/22/2024 07:45:06'!
case13

	^ 'test13Sweeping1MineOnRightIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(''.*'').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(		''1*'')			
	
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:20:32'!
case14

	^ 'test14Sweeping1MineAtDiagonalsIn2x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				''*.''
					''..'').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''*1'' 
																''11'').			
	
	minefield := #	(			''.*''
					''..'').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''1*''
																''11'').
														
	minefield := #(				''..''
					''*.'').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''11'' 
																''*1'').
														
	minefield := #(				''..''
					''.*'').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''11'' 
																''1*'')
																									
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 09:20:55'!
case15

	^ 'test15SweepingMoreThan1MineInMinefieldAddsUpMinesCorrectly

	| minefield |
	
	minefield := #(				''*...''
					''....''
					''.*..''
					''....'').
					
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''*100''
																''2210''
																''1*10''
																''1110'').

	minefield := #	(			''***''
					''*.*''
					''***'').		
					
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															''***''
																''*8*''
																''***'')
	'! !

!TDDBabyStepsGameMinesweeper methodsFor: 'cases' stamp: 'NR 6/21/2024 07:08:26'!
numberOfCases

	^ 15! !


!classDefinition: #TDDBabyStepsGamePrimeFactors category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGamePrimeFactors
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGamePrimeFactors methodsFor: 'definition' stamp: 'NR 9/29/2022 05:23:04'!
definition
	
	^ 'Deben obtenerse los factores primos de un número natural. Por ej. 850 factorize debe retornar 2,5,5 y 17.

Ayuda: Considere utilizar el mensaje #isDivisibleBy: cuando sea necesario.
'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'definition' stamp: 'NR 6/8/2024 06:36:13'!
name 
	
	^ 'PrimeFactors'! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'step duration' stamp: 'NR 6/18/2024 23:00:40'!
maxStepDuration

	^ Duration minutes: 15! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 9/25/2022 18:11:23'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
	
	self assert: (Bag with: 2 with: 2 with: 3 with: 3 with: 5 with: 13) equals: (2*2*3*3*5*13) factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:45:01'!
genCase01
	
	^ 'test01GeneralizationOneHasNoPrimeFactors
	
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:45:08'!
genCase02

	^ 'test02GeneralizationFactorsOfAPrimeNumberAreThePrimeNumber

	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 6/21/2024 08:24:49'!
genCase03
	
	^ 'test03GeneralizationFactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 11) equals: 11 factorize.
	self assert: (Bag with: 13) equals: 13 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 5/13/2024 06:01:28'!
genCase04
	
	^ 'test04GeneralizationCorrectlyFactorizesACompositeNumberWithAFactor2AndAPrime
	
	self assert: (Bag with: 5) equals: 5 factorize.
	self assert: (Bag with: 2 with: 3) equals: 6 factorize.
	self assert: (Bag with: 7) equals: 7 factorize.
	self assert: (Bag with: 2 with: 5) equals: 10 factorize.
	self assert: (Bag with: 11) equals: 11 factorize.
	self assert: (Bag with: 13) equals: 13 factorize.
	self assert: (Bag with: 2 with: 7) equals: 14 factorize
	
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'generalization' stamp: 'NR 5/13/2024 06:06:20'!
genCase05
	
	^ 'test08GeneralizationCorrectlyFactorizesACompositeNumberWithTwoOrMoreFactors2AndOrAPrimeNumber
	
	self assert: (Bag with: 2 with: 2 with: 2) equals: 8 factorize.
	self assert: (Bag with: 2 with: 2 with: 3) equals: 12 factorize.
	self assert: (Bag with: 2 with: 2 with: 5) equals: 20 factorize.
	self assert: (Bag with: 2 with: 2 with: 2 with: 3) equals: 24 factorize
	
	'! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:47'!
model01
	
	^ 'SmallInteger compile: ''factorize
	
	^Bag new'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:51'!
model02
	
	^ 'SmallInteger compile: ''factorize
	
	self = 1 ifTrue: [^Bag new].
	^Bag with: 2'' classified: ''arithmetic''
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:41:56'!
model03
	
	^ 'SmallInteger compile: ''factorize
	
	self = 1 ifTrue: [^Bag new].
	^Bag with: self'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:01'!
model04
	
	^ 'SmallInteger compile: ''factorize
	
	| factors leftToFactorize |
	
	factors := Bag new.
	
	leftToFactorize := self.
	(leftToFactorize isDivisibleBy: 2) ifTrue: [factors add: 2. leftToFactorize := leftToFactorize / 2].
	
	(leftToFactorize > 1) ifTrue: [factors add: leftToFactorize].
	
	^factors.'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:05'!
model05
	
	^ 'SmallInteger compile: ''factorize
	
	| factors leftToFactorize |
	
	factors := Bag new.
	
	leftToFactorize := self.
	[leftToFactorize isDivisibleBy: 2] whileTrue: [factors add: 2. leftToFactorize := leftToFactorize / 2].
	
	(leftToFactorize > 1) ifTrue: [factors add: leftToFactorize].
	
	^factors.'' classified: ''arithmetic''
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:08'!
model06
	
	^ 'SmallInteger compile: ''factorize
	
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

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/21/2024 07:47:16'!
reset
	
	^ '[ SmallInteger removeSelector: #factorize ]  on: Error do: [].
	[ Integer removeSelector: #factorize ] on: Error do: []'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/21/2024 21:56:23'!
solutionModelBuilder

	^ IncrementalPartialModelBuilder
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	
	^ '^ [ SmallInteger sourceCodeAt: #factorize ] on: Error do: 
		[^ [ Integer sourceCodeAt: #factorize ] on: Error do: [ ^'''' ] ]'
	! !


!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/4/2022 07:15:28'!
case01
	
	^ 'test01OneHasNoPrimeFactors
	
	self assert: Bag new equals: 1 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/8/2022 16:43:51'!
case02

	^ 'test02FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 2) equals: 2 factorize
	'
	! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/8/2022 16:44:00'!
case03
	
	^ 'test03FactorsOfAPrimeNumberAreThePrimeNumber

	self assert: (Bag with: 3) equals: 3 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/13/2024 06:01:10'!
case04
	
	^ 'test04CorrectlyFactorizesACompositeNumberWithAFactor2AndAPrime
	
	self assert: (Bag with: 2 with: 2) equals: 4 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/13/2024 06:00:42'!
case05
	
	^ 'test08CorrectlyFactorizesACompositeNumberWithTwoOrMoreFactors2AndOrAPrimeNumber
	
	self assert: (Bag with: 2 with: 2 with: 2) equals: 8 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 5/4/2022 07:26:29'!
case06
	
	^ 'test09CorrectlyFactorizesACompositeNumberWithMoreThanOneFactorsDifferentThan2
	
	self assert: (Bag with: 3 with: 3) equals: 9 factorize
	'! !

!TDDBabyStepsGamePrimeFactors methodsFor: 'cases' stamp: 'NR 6/16/2024 07:28:59'!
numberOfCases
	
	^ 6! !


!classDefinition: #TDDBabyStepsGameRomanNumerals category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameRomanNumerals
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRomanNumerals methodsFor: 'definition' stamp: 'NR 6/27/2024 12:39:30'!
definition
	
	^ 'El desafío en «Roman Numerals» es convertir números arabigos a sus pares homólogos romanos utilizando TDD. Por ej. 7 es VII y 24 es XXIV. Se debe poder efectuar la conversión desde el número 1 hasta el 3499 inclusive.
	
Los caracteres romanos son:

1 -> I
5 -> V
10 -> X
50 -> L
100 -> C
500 -> D
1000 -> M
	
Esta vez se pide efectuar el conversor integramente dentro de un method object.

Ayuda 1: Considere una solución iterativa al problema.

Ayuda 2: Puede ser buena idea aprender a utilizar Streams. En: stream := String new writeStream. stream nextPut: $X; nextPut: $I. string := stream contents.  string queda con valor XI.

Ayuda 3: // es la división entera. \\ es el resto de la división por.

'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'definition' stamp: 'NR 6/16/2024 00:29:25'!
name 
	
	^ 'RomanNumerals'! !


!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:30'!
model01

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber

	^ ''''I'''' '' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/18/2024 20:39:01'!
model02

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber

	arabigNumber = 1 ifTrue: [ ^ ''''I''''].
	^ ''''II''''
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/18/2024 20:39:34'!
model03

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	"1era versión:"
	"arabigNumber = 1 ifTrue: [ ^ ''''I''''].
	arabigNumber  = 2 ifTrue: [ ^ ''''II''''].
	 ^ ''''III'''' "
	
	"Última versión (paso 3: Refactor):"
	romanNumber := String new writeStream.
	arabigNumber timesRepeat: [ romanNumber nextPut: $I ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:37'!
model04

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:41'!
model05

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	arabigNumber = 5 ifTrue: [ romanNumber nextPut: $V ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:44'!
model06

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	"1era versión:"
	"arabigNumber = 5 ifTrue: [ romanNumber nextPut: $V ].
	arabigNumber = 6 ifTrue: [ romanNumber nextPut: $V. romanNumber nextPut: $I ]."
	
	"Última versión (Paso 3):"
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:47'!
model07

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:50'!
model08

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	arabigNumber = 10 ifTrue: [ romanNumber nextPut: $X ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:53'!
model09

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	"1era versión:"
	"arabigNumber = 10 ifTrue: [ romanNumber nextPut: $X ].
	arabigNumber = 11 ifTrue: [ romanNumber nextPut: $X. romanNumber nextPut: $I ]."
	
	"2da versión (Paso 3):"
	"arabigNumber = 10 ifTrue: [ romanNumber nextPut: $X ].
	(arabigNumber between: 11 and: 13) ifTrue: [ romanNumber nextPut: $X.
		(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ]."
	
	"Última versión (Paso 3):"
	(arabigNumber between: 10 and: 13) ifTrue: [ romanNumber nextPut: $X.
		(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:56'!
model10

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	(arabigNumber between: 10 and: 14) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigNumber < 14 ifTrue: [
			(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ].
	
		arabigNumber = 14 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].	
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:38:58'!
model11

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	(arabigNumber between: 10 and: 15) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigNumber < 14 ifTrue: [
			(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ].
	
		arabigNumber = 14 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].	
		
		arabigNumber = 15 ifTrue: [ romanNumber nextPut: $V ].
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:39:02'!
model12

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	"1era versión hasta el 16!!"
	(arabigNumber between: 10 and: 18) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigNumber < 14 ifTrue: [
			(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ].
	
		arabigNumber = 14 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].	
		
		"1era versión:"
		"arabigNumber = 15 ifTrue: [ romanNumber nextPut: $V ].
		arabigNumber  = 16 ifTrue: [ romanNumber nextPut: $V. romanNumber nextPut: $I ]."
		
		"Última versión (Paso 3):"
		(arabigNumber between: 15 and: 18) ifTrue: [ romanNumber nextPut: $V.
			(arabigNumber - 15) timesRepeat: [ romanNumber nextPut: $I ] ].
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:38:03'!
model13

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigNumberBeingConverted |
	
	romanNumber := String new writeStream.
	
	"1era versión:"
	"arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	(arabigNumber between: 10 and: 19) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigNumber < 14 ifTrue: [
			(arabigNumber - 10) timesRepeat: [ romanNumber nextPut: $I ] ].
	
		arabigNumber = 14 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].	
		
		(arabigNumber between: 15 and: 18) ifTrue: [ romanNumber nextPut: $V.
			(arabigNumber - 15) timesRepeat: [ romanNumber nextPut: $I ] ].
		
		arabigNumber = 19 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	]."


	"2da versión (Paso 3):"
	"arabigNumber < 4 ifTrue: [
		arabigNumber timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
	
	(arabigNumber between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigNumber - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigNumber = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	
	(arabigNumber between: 10 and: 19) ifTrue: [ 
		romanNumber nextPut: $X.
		arabigNumberBeingConverted := arabigNumber - 10.
		
		arabigNumberBeingConverted < 4 ifTrue: [
			(arabigNumberBeingConverted) timesRepeat: [ romanNumber nextPut: $I ] ].
	
		arabigNumberBeingConverted = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].
		
		(arabigNumberBeingConverted between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
			(arabigNumberBeingConverted - 5) timesRepeat: [ romanNumber nextPut: $I ] ]. .
		
		arabigNumberBeingConverted = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ].
	]."

	"Última versión (Paso 3):"
	self convertUnits: arabigNumber into: romanNumber.
	
	(arabigNumber between: 10 and: 19) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigNumberBeingConverted := arabigNumber - 10.
		self convertUnits: arabigNumberBeingConverted into: romanNumber 
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/18/2024 22:05:11'!
model14

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigUnit |
	
	romanNumber := String new writeStream.
	
	self convertUnits: arabigNumber into: romanNumber.
	
	(arabigNumber between: 10 and: 19) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigUnit := arabigNumber - 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 20 and: 29) ifTrue: [ 
		romanNumber nextPut: $X.
		romanNumber nextPut: $X.
		
		arabigUnit := arabigNumber - 20.
		self convertUnits: arabigUnit into: romanNumber 
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:38:26'!
model15

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigTen arabigUnit |
	
	romanNumber := String new writeStream.
	
	"1era versión:"
	"self convertUnits: arabigNumber into: romanNumber.
	
	(arabigNumber between: 10 and: 19) ifTrue: [ 
		romanNumber nextPut: $X.
		
		arabigUnit := arabigNumber - 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 20 and: 29) ifTrue: [ 
		romanNumber nextPut: $X.
		romanNumber nextPut: $X.
		
		arabigUnit := arabigNumber - 20.
		self convertUnits: arabigUnit into: romanNumber 
	].
	
	(arabigNumber between: 30 and: 39) ifTrue: [ 
		romanNumber nextPut: $X.
		romanNumber nextPut: $X.
		romanNumber nextPut: $X.
		
		arabigUnit := arabigNumber - 30.
		self convertUnits: arabigUnit into: romanNumber 
	]."

	"2da versión (Paso 3):"
	"self convertUnits: arabigNumber into: romanNumber.
	
	(arabigNumber between: 10 and: 39) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	]."

	"Última versión (Paso 3):"
	(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/18/2024 22:16:00'!
model16

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigTen arabigUnit |
	
	romanNumber := String new writeStream.
	
	(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 40 and: 49) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/18/2024 22:16:14'!
model17

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigTen arabigUnit |
	
	romanNumber := String new writeStream.
	
	(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 40 and: 49) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].

	(arabigNumber between: 50 and: 59) ifTrue:[
		
		romanNumber nextPut: $L.
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:39:08'!
model18

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigTen arabigUnit |
	
	romanNumber := String new writeStream.
	
	(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 40 and: 49) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].

	"1era versión:"
	"(arabigNumber between: 50 and: 59) ifTrue:[
		
		romanNumber nextPut: $L.
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].

	(arabigNumber between: 60 and: 89) ifTrue:[
		
		romanNumber nextPut: $L.
		arabigTen := arabigNumber // 10 \\ 10.
		(arabigTen - 5) timesRepeat: [ romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	]."

	"Última versión (Paso 3):"
	(arabigNumber between: 50 and: 89) ifTrue:[
		
		romanNumber nextPut: $L.
		arabigTen := arabigNumber // 10 \\ 10.
		(arabigTen - 5) timesRepeat: [ romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:39:13'!
model19

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber arabigTen arabigUnit |
	
	romanNumber := String new writeStream.
	
	"1era versión:"
	"(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber 
	].

	(arabigNumber between: 40 and: 49) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].

	(arabigNumber between: 50 and: 89) ifTrue:[
		
		romanNumber nextPut: $L.
		arabigTen := arabigNumber // 10 \\ 10.
		(arabigTen - 5) timesRepeat: [ romanNumber nextPut: $X ].
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	].
	
	(arabigNumber between: 90 and: 99) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $C. 
		
		arabigUnit := arabigNumber \\ 10.
		self convertUnits: arabigUnit into: romanNumber
	]."
	
	"2da versión (Paso 3):"
	"(arabigNumber < 40) ifTrue: [ 
		
		arabigTen := arabigNumber // 10 \\ 10.
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
	].

	(arabigNumber between: 40 and: 49) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
	].

	(arabigNumber between: 50 and: 89) ifTrue:[
		
		romanNumber nextPut: $L.
		arabigTen := arabigNumber // 10 \\ 10.
		(arabigTen - 5) timesRepeat: [ romanNumber nextPut: $X ].
	].
	
	(arabigNumber between: 90 and: 99) ifTrue:[
		
		romanNumber nextPut: $X. romanNumber nextPut: $C. 
	].

	arabigUnit := arabigNumber \\ 10.
	self convertUnits: arabigUnit into: romanNumber."
	
	"3er versión (Paso 3):"
	"arabigTen := arabigNumber // 10 \\ 10.
	
	arabigTen < 4 ifTrue: [ 
		arabigTen timesRepeat: [romanNumber nextPut: $X ].
	].

	arabigTen = 4 ifTrue:[
		romanNumber nextPut: $X. romanNumber nextPut: $L. 
	].

	(arabigTen between: 5 and: 8) ifTrue:[
		romanNumber nextPut: $L.
		(arabigTen - 5) timesRepeat: [ romanNumber nextPut: $X ].
	].
	
	arabigTen = 9 ifTrue:[
		romanNumber nextPut: $X. romanNumber nextPut: $C. 
	].

	arabigUnit := arabigNumber \\ 10.
	self convertUnits: arabigUnit into: romanNumber."
	
	"Última versión (Paso 3):"
	arabigTen := arabigNumber // 10 \\ 10.
	self convertTens: arabigTen into: romanNumber.
	
	arabigUnit := arabigNumber \\ 10.
	self convertUnits: arabigUnit into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigUnit into: romanNumber
	
	arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigTen into: romanNumber
	
	arabigTen < 4 ifTrue: [ 
		arabigTen timesRepeat: [romanNumber nextPut: $X ] ].
	
	arabigTen = 4 ifTrue:[ romanNumber nextPut: $X. romanNumber nextPut: $L ].

	(arabigTen between: 5 and: 8) ifTrue:[ romanNumber nextPut: $L.
		(arabigTen- 5 ) timesRepeat: [ romanNumber nextPut: $X ] ].

	arabigTen = 9 ifTrue:[ romanNumber nextPut: $X. romanNumber nextPut: $C ]
	
	'' classified: ''converting''
	
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:39:38'!
model20

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	self convertHundreds: arabigNumber into: romanNumber.
	self convertTens: arabigNumber into: romanNumber.
	self convertUnits: arabigNumber into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigNumber into: romanNumber
	
	| arabigUnit |
	
	arabigUnit := arabigNumber \\ 10.
	
	"1era versión:"
	"arabigUnit < 4 ifTrue: [
		arabigUnit timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 4 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $V ].

	(arabigUnit between: 5 and: 8) ifTrue: [ romanNumber nextPut: $V.
		(arabigUnit - 5) timesRepeat: [ romanNumber nextPut: $I ] ].
	
	arabigUnit = 9 ifTrue: [ romanNumber nextPut: $I. romanNumber nextPut: $X ]"
	
	"Última versión (Paso 3):"
	self convert: arabigUnit into: romanNumber usingAsOne: $I asFive: $V asTen: $X
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigNumber into: romanNumber
	
	| arabigTen |
	
	arabigTen := arabigNumber // 10 \\ 10.
	
	"1era versión:"
	"arabigTen < 4 ifTrue: [ 
		arabigTen timesRepeat: [romanNumber nextPut: $X ] ].
	
	arabigTen = 4 ifTrue:[ romanNumber nextPut: $X. romanNumber nextPut: $L ].

	(arabigTen between: 5 and: 8) ifTrue:[ romanNumber nextPut: $L.
		(arabigTen- 5 ) timesRepeat: [ romanNumber nextPut: $X ] ].

	arabigTen = 9 ifTrue:[ romanNumber nextPut: $X. romanNumber nextPut: $C ]"
	
	"Última versión (Paso 3):"
	self convert: arabigTen into: romanNumber usingAsOne: $X asFive: $L asTen: $C
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertHundreds: arabigNumber into: romanNumber
	
	| arabigHundred |
	
	arabigHundred := arabigNumber // 100 \\ 10.
	
	"1era versión:"
	"arabigHundred < 4 ifTrue: [ 
		arabigHundred timesRepeat: [romanNumber nextPut: $C ] ].
	
	arabigHundred = 4 ifTrue:[ romanNumber nextPut: $C. romanNumber nextPut: $D ].

	(arabigHundred between: 5 and: 8) ifTrue:[ romanNumber nextPut: $D.
		(arabigHundred- 5 ) timesRepeat: [ romanNumber nextPut: $C ] ].

	arabigHundred = 9 ifTrue:[ romanNumber nextPut: $C. romanNumber nextPut: $M ]"
	
	"Última versión (Paso 3):"
	self convert: arabigHundred into: romanNumber usingAsOne: $C asFive: $D asTen: $M
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convert: arabigDigit into: romanNumber usingAsOne: oneChar asFive: fiveChar asTen: tenChar
	
	arabigDigit < 4 ifTrue: [
		arabigDigit timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 4 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: fiveChar ].

	(arabigDigit between: 5 and: 8) ifTrue: [ romanNumber nextPut: fiveChar.
		(arabigDigit - 5) timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 9 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: tenChar ]
	
	'' classified: ''converting''
	
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/22/2024 20:40:54'!
model21

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	self convertThousands: arabigNumber into: romanNumber.
	self convertHundreds: arabigNumber into: romanNumber.
	self convertTens: arabigNumber into: romanNumber.
	self convertUnits: arabigNumber into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigNumber into: romanNumber
	
	| arabigUnit |
	"1era versión:"
	"arabigUnit := arabigNumber \\ 10."
	
	"Última versión (Paso 3):"
	arabigUnit := self digitOf: arabigNumber onPositionOf: 1.
	
	self convert: arabigUnit into: romanNumber usingAsOne: $I asFive: $V asTen: $X
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigNumber into: romanNumber
	
	| arabigTen |
	"1era versión:"
	"arabigTen := arabigNumber // 10 \\ 10."
	
	"Última versión (Paso 3):"
	arabigTen := self digitOf: arabigNumber onPositionOf: 10.
	
	self convert: arabigTen into: romanNumber usingAsOne: $X asFive: $L asTen: $C
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertHundreds: arabigNumber into: romanNumber
	
	| arabigHundred |
	"1era versión:"
	"arabigHundred := arabigNumber // 100 \\ 10."
	
	"Última versión (Paso 3):"
	arabigHundred := self digitOf: arabigNumber onPositionOf: 100.
	
	self convert: arabigHundred into: romanNumber usingAsOne: $C asFive: $D asTen: $M
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertThousands: arabigNumber into: romanNumber
	
	| arabigThousand |
	
	"1era versión:"
	"arabigThousand := arabigNumber // 1000 \\ 10."
	
	"Última versión (Paso 3):"
	arabigThousand := self digitOf: arabigNumber onPositionOf: 1000.
	
	self convert: arabigThousand into: romanNumber usingAsOne: $M asFive: $¿ asTen: $?
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convert: arabigDigit into: romanNumber usingAsOne: oneChar asFive: fiveChar asTen: tenChar
	
	arabigDigit < 4 ifTrue: [
		arabigDigit timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 4 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: fiveChar ].

	(arabigDigit between: 5 and: 8) ifTrue: [ romanNumber nextPut: fiveChar.
		(arabigDigit - 5) timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 9 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: tenChar ]
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''digitOf: arabigNumber onPositionOf: positionalWeight
	
	^ arabigNumber // positionalWeight \\ 10
	
	'' classified: ''accessing''
	
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/22/2024 20:40:45'!
model22

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber isNumber ifFalse: [ self error: ''''Arabig number must be numeric''''  ].
	
	self convertThousands: arabigNumber into: romanNumber.
	self convertHundreds: arabigNumber into: romanNumber.
	self convertTens: arabigNumber into: romanNumber.
	self convertUnits: arabigNumber into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigNumber into: romanNumber
	
	| arabigUnit |

	arabigUnit := self digitOf: arabigNumber onPositionOf: 1.
	self convert: arabigUnit into: romanNumber usingAsOne: $I asFive: $V asTen: $X
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigNumber into: romanNumber
	
	| arabigTen |
	
	arabigTen := self digitOf: arabigNumber onPositionOf: 10.
	self convert: arabigTen into: romanNumber usingAsOne: $X asFive: $L asTen: $C
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertHundreds: arabigNumber into: romanNumber
	
	| arabigHundred |
	
	arabigHundred := self digitOf: arabigNumber onPositionOf: 100.
	self convert: arabigHundred into: romanNumber usingAsOne: $C asFive: $D asTen: $M
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertThousands: arabigNumber into: romanNumber
	
	| arabigThousand |
	
	arabigThousand := self digitOf: arabigNumber onPositionOf: 1000.
	self convert: arabigThousand into: romanNumber usingAsOne: $M asFive: $¿ asTen: $?
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convert: arabigDigit into: romanNumber usingAsOne: oneChar asFive: fiveChar asTen: tenChar
	
	arabigDigit < 4 ifTrue: [
		arabigDigit timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 4 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: fiveChar ].

	(arabigDigit between: 5 and: 8) ifTrue: [ romanNumber nextPut: fiveChar.
		(arabigDigit - 5) timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 9 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: tenChar ]
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''digitOf: arabigNumber onPositionOf: positionalWeight
	
	^ arabigNumber // positionalWeight \\ 10
	
	'' classified: ''accessing''
	
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/22/2024 20:40:25'!
model23

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	arabigNumber isNumber ifFalse: [ self error: ''''Arabig number must be numeric''''  ].
	arabigNumber < 1 ifTrue: [ self error: ''''Less than 1 numbers cannot be converted to romans'''' ].
	
	self convertThousands: arabigNumber into: romanNumber.
	self convertHundreds: arabigNumber into: romanNumber.
	self convertTens: arabigNumber into: romanNumber.
	self convertUnits: arabigNumber into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigNumber into: romanNumber
	
	| arabigUnit |

	arabigUnit := self digitOf: arabigNumber onPositionOf: 1.
	self convert: arabigUnit into: romanNumber usingAsOne: $I asFive: $V asTen: $X
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigNumber into: romanNumber
	
	| arabigTen |
	
	arabigTen := self digitOf: arabigNumber onPositionOf: 10.
	self convert: arabigTen into: romanNumber usingAsOne: $X asFive: $L asTen: $C
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertHundreds: arabigNumber into: romanNumber
	
	| arabigHundred |
	
	arabigHundred := self digitOf: arabigNumber onPositionOf: 100.
	self convert: arabigHundred into: romanNumber usingAsOne: $C asFive: $D asTen: $M
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertThousands: arabigNumber into: romanNumber
	
	| arabigThousand |
	
	arabigThousand := self digitOf: arabigNumber onPositionOf: 1000.
	self convert: arabigThousand into: romanNumber usingAsOne: $M asFive: $¿ asTen: $?
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convert: arabigDigit into: romanNumber usingAsOne: oneChar asFive: fiveChar asTen: tenChar
	
	arabigDigit < 4 ifTrue: [
		arabigDigit timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 4 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: fiveChar ].

	(arabigDigit between: 5 and: 8) ifTrue: [ romanNumber nextPut: fiveChar.
		(arabigDigit - 5) timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 9 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: tenChar ]
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''digitOf: arabigNumber onPositionOf: positionalWeight
	
	^ arabigNumber // positionalWeight \\ 10
	
	'' classified: ''accessing''
	
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/27/2024 12:39:19'!
model24

	^ 'Object subclass: #RomanConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanNumerals''.
	
	RomanConverter compile: ''toRoman: arabigNumber
	
	| romanNumber |
	
	romanNumber := String new writeStream.
	
	"1era versión:"
	"arabigNumber isNumber ifFalse: [ self error: ''''Arabig number must be numeric''''  ].
	arabigNumber < 1 ifTrue: [ self error: ''''Less than 1 numbers cannot be converted to romans'''' ].
	arabigNumber > 3999 ifTrue: [ self error: ''''Greater than 3999 numbers cannot be converted to romans'''' ]."
	
	"Última versión (Paso 3):"
	self assertArabigNumberWithinRange: arabigNumber.
	
	"Debido a que el problema termina en el 3999 se decide terminar acá sin perder declaratividad. Sin embargo si aceptasen más símbolos y por tanto, más números, pueden practicar una posible generalización de la siguiente manera: reificar los próximos 4 métodos en method objects, colocar instancias de cada uno en una colección desde algun contexto de inicialización del Conversor e iterarlas aquí."
	self convertThousands: arabigNumber into: romanNumber.
	self convertHundreds: arabigNumber into: romanNumber.
	self convertTens: arabigNumber into: romanNumber.
	self convertUnits: arabigNumber into: romanNumber.
	
	^ romanNumber contents
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertUnits: arabigNumber into: romanNumber
	
	| arabigUnit |

	arabigUnit := self digitOf: arabigNumber onPositionOf: 1.
	self convert: arabigUnit into: romanNumber usingAsOne: $I asFive: $V asTen: $X
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertTens: arabigNumber into: romanNumber
	
	| arabigTen |
	
	arabigTen := self digitOf: arabigNumber onPositionOf: 10.
	self convert: arabigTen into: romanNumber usingAsOne: $X asFive: $L asTen: $C
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertHundreds: arabigNumber into: romanNumber
	
	| arabigHundred |
	
	arabigHundred := self digitOf: arabigNumber onPositionOf: 100.
	self convert: arabigHundred into: romanNumber usingAsOne: $C asFive: $D asTen: $M
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convertThousands: arabigNumber into: romanNumber
	
	| arabigThousand |
	
	arabigThousand := self digitOf: arabigNumber onPositionOf: 1000.
	self convert: arabigThousand into: romanNumber usingAsOne: $M asFive: $¿ asTen: $?
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''convert: arabigDigit into: romanNumber usingAsOne: oneChar asFive: fiveChar asTen: tenChar
	
	arabigDigit < 4 ifTrue: [
		arabigDigit timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 4 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: fiveChar ].

	(arabigDigit between: 5 and: 8) ifTrue: [ romanNumber nextPut: fiveChar.
		(arabigDigit - 5) timesRepeat: [ romanNumber nextPut: oneChar] ].
	
	arabigDigit = 9 ifTrue: [ romanNumber nextPut: oneChar. romanNumber nextPut: tenChar ]
	
	'' classified: ''converting''.
	
	RomanConverter compile: ''digitOf: arabigNumber onPositionOf: positionalWeight
	
	^ arabigNumber // positionalWeight \\ 10
	
	'' classified: ''accessing''.
	
	RomanConverter compile: ''assertArabigNumberWithinRange: arabigNumber

	arabigNumber isNumber ifFalse: [ self error: ''''Arabig number must be numeric''''  ].
	arabigNumber < 1 ifTrue: [ self error: ''''Less than 1 numbers cannot be converted to romans'''' ].
	arabigNumber > 3999 ifTrue: [ self error: ''''Greater than 3999 numbers cannot be converted to romans'''' ]
	
	'' classified: ''asserting''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 07:46:15'!
reset
	
	^ '[ RomanConverter selectors do: [ :selector | RomanConverter removeSelector: selector ]. 
	RomanConverter removeFromSystem ] on: Error do: []'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 21:57:11'!
solutionModelBuilder

	^ AbsoluteCompleteModelBuilder ! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	^ '| completeSourceCode |
	
	completeSourceCode := ''''.
	[ RomanConverter selectors asSortedCollection do: [ :selector | 
		| selectorSourceCode |
		selectorSourceCode := [ (RomanConverter sourceCodeAt: selector), (String with: Character newLineCharacter) ] on: Error do: [ '''' ] . 
		completeSourceCode := completeSourceCode, selectorSourceCode ].
	] on: Error do: [].
	^ completeSourceCode'
	! !


!TDDBabyStepsGameRomanNumerals methodsFor: 'step duration' stamp: 'NR 6/16/2024 00:28:56'!
maxStepDuration

	^ Duration minutes: 10! !


!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/22/2024 19:10:30'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata

	self assert: (RomanConverter new toRoman: 7) equals: ''VII''.
	self assert: (RomanConverter new toRoman: 8) equals: ''VIII''.
	self assert: (RomanConverter new toRoman: 17) equals: ''XVII''.
	self assert: (RomanConverter new toRoman: 18) equals: ''XVIII''.
	self assert: (RomanConverter new toRoman: 20) equals: ''XX''.
	self assert: (RomanConverter new toRoman: 21) equals: ''XXI''.
	self assert: (RomanConverter new toRoman: 22) equals: ''XXII''.
	self assert: (RomanConverter new toRoman: 23) equals: ''XXIII''.
	self assert: (RomanConverter new toRoman: 25) equals: ''XXV''.
	self assert: (RomanConverter new toRoman: 26) equals: ''XXVI''.
	self assert: (RomanConverter new toRoman: 27) equals: ''XXVII''.
	self assert: (RomanConverter new toRoman: 28) equals: ''XXVIII''.
	self assert: (RomanConverter new toRoman: 29) equals: ''XXIX''.
	self assert: (RomanConverter new toRoman: 30) equals: ''XXX''.
	self assert: (RomanConverter new toRoman: 31) equals: ''XXXI''.
	self assert: (RomanConverter new toRoman: 32) equals: ''XXXII''.
	self assert: (RomanConverter new toRoman: 33) equals: ''XXXIII''.
	self assert: (RomanConverter new toRoman: 34) equals: ''XXXIV''.
	self assert: (RomanConverter new toRoman: 35) equals: ''XXXV''.
	self assert: (RomanConverter new toRoman: 36) equals: ''XXXVI''.
	self assert: (RomanConverter new toRoman: 38) equals: ''XXXVIII''.
	self assert: (RomanConverter new toRoman: 39) equals: ''XXXIX''.
	self assert: (RomanConverter new toRoman: 40) equals: ''XL''.
	self assert: (RomanConverter new toRoman: 41) equals: ''XLI''.
	self assert: (RomanConverter new toRoman: 42) equals: ''XLII''.
	self assert: (RomanConverter new toRoman: 43) equals: ''XLIII''.
	self assert: (RomanConverter new toRoman: 45) equals: ''XLV''.
	self assert: (RomanConverter new toRoman: 46) equals: ''XLVI''.
	self assert: (RomanConverter new toRoman: 47) equals: ''XLVII''.
	self assert: (RomanConverter new toRoman: 48) equals: ''XLVIII''.
	self assert: (RomanConverter new toRoman: 49) equals: ''XLIX''.
	self assert: (RomanConverter new toRoman: 50) equals: ''L''.
	self assert: (RomanConverter new toRoman: 51) equals: ''LI''.
	self assert: (RomanConverter new toRoman: 52) equals: ''LII''.
	self assert: (RomanConverter new toRoman: 53) equals: ''LIII''.
	self assert: (RomanConverter new toRoman: 54) equals: ''LIV''.
	self assert: (RomanConverter new toRoman: 56) equals: ''LVI''.
	self assert: (RomanConverter new toRoman: 57) equals: ''LVII''.
	self assert: (RomanConverter new toRoman: 58) equals: ''LVIII''.
	self assert: (RomanConverter new toRoman: 59) equals: ''LIX''.
	self assert: (RomanConverter new toRoman: 60) equals: ''LX''.
	self assert: (RomanConverter new toRoman: 64) equals: ''LXIV''.
	self assert: (RomanConverter new toRoman: 67) equals: ''LXVII''.
	self assert: (RomanConverter new toRoman: 72) equals: ''LXXII''.
	self assert: (RomanConverter new toRoman: 75) equals: ''LXXV''.
	self assert: (RomanConverter new toRoman: 78) equals: ''LXXVIII''.
	self assert: (RomanConverter new toRoman: 81) equals: ''LXXXI''.
	self assert: (RomanConverter new toRoman: 83) equals: ''LXXXIII''.
	self assert: (RomanConverter new toRoman: 86) equals: ''LXXXVI''.
	self assert: (RomanConverter new toRoman: 89) equals: ''LXXXIX''.
	self assert: (RomanConverter new toRoman: 90) equals: ''XC''.
	self assert: (RomanConverter new toRoman: 91) equals: ''XCI''.
	self assert: (RomanConverter new toRoman: 92) equals: ''XCII''.
	self assert: (RomanConverter new toRoman: 93) equals: ''XCIII''.
	self assert: (RomanConverter new toRoman: 94) equals: ''XCIV''.
	self assert: (RomanConverter new toRoman: 95) equals: ''XCV''.
	self assert: (RomanConverter new toRoman: 96) equals: ''XCVI''.
	self assert: (RomanConverter new toRoman: 97) equals: ''XCVII''.
	self assert: (RomanConverter new toRoman: 98) equals: ''XCVIII''.
	self assert: (RomanConverter new toRoman: 100) equals: ''C''.
	self assert: (RomanConverter new toRoman: 111) equals: ''CXI''.
	self assert: (RomanConverter new toRoman: 200) equals: ''CC''.
	self assert: (RomanConverter new toRoman: 222) equals: ''CCXXII''.
	self assert: (RomanConverter new toRoman: 300) equals: ''CCC''.
	self assert: (RomanConverter new toRoman: 333) equals: ''CCCXXXIII''.
	self assert: (RomanConverter new toRoman: 400) equals: ''CD''.
	self assert: (RomanConverter new toRoman: 444) equals: ''CDXLIV''.
	self assert: (RomanConverter new toRoman: 500) equals: ''D''.
	self assert: (RomanConverter new toRoman: 555) equals: ''DLV''.
	self assert: (RomanConverter new toRoman: 600) equals: ''DC''.
	self assert: (RomanConverter new toRoman: 666) equals: ''DCLXVI''.
	self assert: (RomanConverter new toRoman: 700) equals: ''DCC''.
	self assert: (RomanConverter new toRoman: 777) equals: ''DCCLXXVII''.
	self assert: (RomanConverter new toRoman: 800) equals: ''DCCC''.
	self assert: (RomanConverter new toRoman: 888) equals: ''DCCCLXXXVIII''.
	self assert: (RomanConverter new toRoman: 900) equals: ''CM''.
	self assert: (RomanConverter new toRoman: 999) equals: ''CMXCIX''.
	self assert: (RomanConverter new toRoman: 1000) equals: ''M''.
	self assert: (RomanConverter new toRoman: 1313) equals: ''MCCCXIII''.
	self assert: (RomanConverter new toRoman: 1624) equals: ''MDCXXIV''.
	self assert: (RomanConverter new toRoman: 1735) equals: ''MDCCXXXV''.
	self assert: (RomanConverter new toRoman: 2000) equals: ''MM''.
	self assert: (RomanConverter new toRoman: 2146) equals: ''MMCXLVI''.
	self assert: (RomanConverter new toRoman: 2557) equals: ''MMDLVII''.
	self assert: (RomanConverter new toRoman: 2968) equals: ''MMCMLXVIII''.
	self assert: (RomanConverter new toRoman: 3000) equals: ''MMM''.
	self assert: (RomanConverter new toRoman: 3279) equals: ''MMMCCLXXIX''.
	self assert: (RomanConverter new toRoman: 3749) equals: ''MMMDCCXLIX''.
	self assert: (RomanConverter new toRoman: 3999) equals: ''MMMCMXCIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:39:57'!
genCase01

	^ 'test0001Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:00'!
genCase02

	^ 'test0002Generalization

	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:03'!
genCase03
	
	^ 'test0003Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:06'!
genCase04
	
	^ 'test0004Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:09'!
genCase05

	^ 'test0005Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:07:02'!
genCase06

	^ 'test0006Generalization
       
	self assert: (RomanConverter new toRoman: 7) equals: ''VII''.
	self assert: (RomanConverter new toRoman: 8) equals: ''VIII''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:28'!
genCase07
	
	^ 'test0009Generalization
	
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:32'!
genCase08
	
	^ 'test0010Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:35'!
genCase09

	^ 'test0011Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:39'!
genCase10
	
	^ 'test0014Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:43'!
genCase11

	^ 'test0015Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:07:12'!
genCase12

	^ 'test0016Generalization

	self assert: (RomanConverter new toRoman: 17) equals: ''XVII''.
	self assert: (RomanConverter new toRoman: 18) equals: ''XVIII''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:40:55'!
genCase13

	^ 'test0019Generalization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:07:20'!
genCase14

	^ 'test0020To0029Generalization
	
	self assert: (RomanConverter new toRoman: 20) equals: ''XX''.
	self assert: (RomanConverter new toRoman: 21) equals: ''XXI''.
	self assert: (RomanConverter new toRoman: 22) equals: ''XXII''.
	self assert: (RomanConverter new toRoman: 23) equals: ''XXIII''.
	self assert: (RomanConverter new toRoman: 25) equals: ''XXV''.
	self assert: (RomanConverter new toRoman: 26) equals: ''XXVI''.
	self assert: (RomanConverter new toRoman: 27) equals: ''XXVII''.
	self assert: (RomanConverter new toRoman: 28) equals: ''XXVIII''.
	self assert: (RomanConverter new toRoman: 29) equals: ''XXIX''

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:07:35'!
genCase15

	^ 'test0030To0039Generalization

	self assert: (RomanConverter new toRoman: 30) equals: ''XXX''.
	self assert: (RomanConverter new toRoman: 31) equals: ''XXXI''.
	self assert: (RomanConverter new toRoman: 32) equals: ''XXXII''.
	self assert: (RomanConverter new toRoman: 33) equals: ''XXXIII''.
	self assert: (RomanConverter new toRoman: 34) equals: ''XXXIV''.
	self assert: (RomanConverter new toRoman: 35) equals: ''XXXV''.
	self assert: (RomanConverter new toRoman: 36) equals: ''XXXVI''.
	self assert: (RomanConverter new toRoman: 38) equals: ''XXXVIII''.
	self assert: (RomanConverter new toRoman: 39) equals: ''XXXIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:07:52'!
genCase16

	^ 'test0040To0049Generalization
	
	self assert: (RomanConverter new toRoman: 40) equals: ''XL''.
	self assert: (RomanConverter new toRoman: 41) equals: ''XLI''.
	self assert: (RomanConverter new toRoman: 42) equals: ''XLII''.
	self assert: (RomanConverter new toRoman: 43) equals: ''XLIII''.
	self assert: (RomanConverter new toRoman: 45) equals: ''XLV''.
	self assert: (RomanConverter new toRoman: 46) equals: ''XLVI''.
	self assert: (RomanConverter new toRoman: 47) equals: ''XLVII''.
	self assert: (RomanConverter new toRoman: 48) equals: ''XLVIII''.
	self assert: (RomanConverter new toRoman: 49) equals: ''XLIX''

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 17:09:00'!
genCase17

	^ 'test0050To0059Generalization
	
	self assert: (RomanConverter new toRoman: 50) equals: ''L''.
	self assert: (RomanConverter new toRoman: 51) equals: ''LI''.
	self assert: (RomanConverter new toRoman: 52) equals: ''LII''.
	self assert: (RomanConverter new toRoman: 53) equals: ''LIII''.
	self assert: (RomanConverter new toRoman: 54) equals: ''LIV''.
	self assert: (RomanConverter new toRoman: 56) equals: ''LVI''.
	self assert: (RomanConverter new toRoman: 57) equals: ''LVII''.
	self assert: (RomanConverter new toRoman: 58) equals: ''LVIII''.
	self assert: (RomanConverter new toRoman: 59) equals: ''LIX''

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 22:25:00'!
genCase18

	^ 'test0060To0089Generalization
	
	self assert: (RomanConverter new toRoman: 60) equals: ''LX''.
	self assert: (RomanConverter new toRoman: 64) equals: ''LXIV''.
	self assert: (RomanConverter new toRoman: 67) equals: ''LXVII''.
	self assert: (RomanConverter new toRoman: 72) equals: ''LXXII''.
	self assert: (RomanConverter new toRoman: 75) equals: ''LXXV''.
	self assert: (RomanConverter new toRoman: 78) equals: ''LXXVIII''.
	self assert: (RomanConverter new toRoman: 81) equals: ''LXXXI''.
	self assert: (RomanConverter new toRoman: 83) equals: ''LXXXIII''.
	self assert: (RomanConverter new toRoman: 86) equals: ''LXXXVI''.
	self assert: (RomanConverter new toRoman: 89) equals: ''LXXXIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 18:01:53'!
genCase19

	^ 'test0090To0099Generalization
	
	self assert: (RomanConverter new toRoman: 90) equals: ''XC''.
	self assert: (RomanConverter new toRoman: 91) equals: ''XCI''.
	self assert: (RomanConverter new toRoman: 92) equals: ''XCII''.
	self assert: (RomanConverter new toRoman: 93) equals: ''XCIII''.
	self assert: (RomanConverter new toRoman: 94) equals: ''XCIV''.
	self assert: (RomanConverter new toRoman: 95) equals: ''XCV''.
	self assert: (RomanConverter new toRoman: 96) equals: ''XCVI''.
	self assert: (RomanConverter new toRoman: 97) equals: ''XCVII''.
	self assert: (RomanConverter new toRoman: 98) equals: ''XCVIII''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 22:46:26'!
genCase20

	^ 'test0100To0999Generalization

	self assert: (RomanConverter new toRoman: 100) equals: ''C''.
	self assert: (RomanConverter new toRoman: 111) equals: ''CXI''.
	self assert: (RomanConverter new toRoman: 200) equals: ''CC''.
	self assert: (RomanConverter new toRoman: 222) equals: ''CCXXII''.
	self assert: (RomanConverter new toRoman: 300) equals: ''CCC''.
	self assert: (RomanConverter new toRoman: 333) equals: ''CCCXXXIII''.
	self assert: (RomanConverter new toRoman: 400) equals: ''CD''.
	self assert: (RomanConverter new toRoman: 444) equals: ''CDXLIV''.
	self assert: (RomanConverter new toRoman: 500) equals: ''D''.
	self assert: (RomanConverter new toRoman: 555) equals: ''DLV''.
	self assert: (RomanConverter new toRoman: 600) equals: ''DC''.
	self assert: (RomanConverter new toRoman: 666) equals: ''DCLXVI''.
	self assert: (RomanConverter new toRoman: 700) equals: ''DCC''.
	self assert: (RomanConverter new toRoman: 777) equals: ''DCCLXXVII''.
	self assert: (RomanConverter new toRoman: 800) equals: ''DCCC''.
	self assert: (RomanConverter new toRoman: 888) equals: ''DCCCLXXXVIII''.
	self assert: (RomanConverter new toRoman: 900) equals: ''CM''.
	self assert: (RomanConverter new toRoman: 999) equals: ''CMXCIX''
	
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/22/2024 19:10:05'!
genCase21

	^ 'test1000To3999Generalization

	self assert: (RomanConverter new toRoman: 1000) equals: ''M''.
	self assert: (RomanConverter new toRoman: 1313) equals: ''MCCCXIII''.
	self assert: (RomanConverter new toRoman: 1624) equals: ''MDCXXIV''.
	self assert: (RomanConverter new toRoman: 1735) equals: ''MDCCXXXV''.
	self assert: (RomanConverter new toRoman: 2000) equals: ''MM''.
	self assert: (RomanConverter new toRoman: 2146) equals: ''MMCXLVI''.
	self assert: (RomanConverter new toRoman: 2557) equals: ''MMDLVII''.
	self assert: (RomanConverter new toRoman: 2968) equals: ''MMCMLXVIII''.
	self assert: (RomanConverter new toRoman: 3000) equals: ''MMM''.
	self assert: (RomanConverter new toRoman: 3279) equals: ''MMMCCLXXIX''.
	self assert: (RomanConverter new toRoman: 3749) equals: ''MMMDCCXLIX''.
	self assert: (RomanConverter new toRoman: 3999) equals: ''MMMCMXCIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 19:58:16'!
genCase22

	^ 'testIsNumericGeneralization

	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'generalization' stamp: 'NR 6/18/2024 19:58:31'!
genCase23

	^ 'testLessThanOneGeneralization

	'! !


!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:18'!
case01

	^ 'test0001

	self assert: (RomanConverter new toRoman: 1) equals: ''I''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:22'!
case02

	^ 'test0002

	self assert: (RomanConverter new toRoman: 2) equals: ''II''
	'
	! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:26'!
case03
	
	^ 'test0003

	self assert: (RomanConverter new toRoman: 3) equals: ''III''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:29'!
case04
	
	^ 'test0004

	self assert: (RomanConverter new toRoman: 4) equals: ''IV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:32'!
case05

	^ 'test0005

	self assert: (RomanConverter new toRoman: 5) equals: ''V''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:35'!
case06

	^ 'test0006

	self assert: (RomanConverter new toRoman: 6) equals: ''VI''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:38'!
case07
	
	^ 'test0009

	self assert: (RomanConverter new toRoman: 9) equals: ''IX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:41'!
case08
	
	^ 'test0010

	self assert: (RomanConverter new toRoman: 10) equals: ''X''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:44'!
case09

	^ 'test0011

	self assert: (RomanConverter new toRoman: 11) equals: ''XI''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:47'!
case10
	
	^ 'test0014

	self assert: (RomanConverter new toRoman: 14) equals: ''XIV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:50'!
case11

	^ 'test0015

	self assert: (RomanConverter new toRoman: 15) equals: ''XV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:53'!
case12

	^ 'test0016

	self assert: (RomanConverter new toRoman: 16) equals: ''XVI''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:41:56'!
case13

	^ 'test0019

	self assert: (RomanConverter new toRoman: 19) equals: ''XIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:42:00'!
case14

	^ 'test0020To0029

	self assert: (RomanConverter new toRoman: 24) equals: ''XXIV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:42:03'!
case15

	^ 'test0030To0039

	self assert: (RomanConverter new toRoman: 37) equals: ''XXXVII''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/27/2024 12:42:05'!
case16

	^ 'test0040To0049

	self assert: (RomanConverter new toRoman: 44) equals: ''XLIV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 17:04:22'!
case17

	^ 'test0050To0059

	self assert: (RomanConverter new toRoman: 55) equals: ''LV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 17:14:48'!
case18

	^ 'test0060To0089

	self assert: (RomanConverter new toRoman: 69) equals: ''LXIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 17:59:11'!
case19

	^ 'test0090To0099

	self assert: (RomanConverter new toRoman: 99) equals: ''XCIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 18:30:03'!
case20

	^ 'test0100To0999

	self assert: (RomanConverter new toRoman: 494) equals: ''CDXCIV''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/22/2024 19:04:50'!
case21

	^ 'test1000To3999

	self assert: (RomanConverter new toRoman: 3499) equals: ''MMMCDXCIX''
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 19:56:07'!
case22

	^ 'testIsNumeric

	self should: [ RomanConverter new toRoman: ''treinta y tres'' ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Arabig number must be numeric'' ]
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 19:56:36'!
case23

	^ 'testLessThanOne
	
	self should: [ RomanConverter new toRoman: 0 ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Less than 1 numbers cannot be converted to romans'' ] 
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/22/2024 19:01:58'!
case24

	^ 'testMoreThan3999

	self should: [ RomanConverter new toRoman: 4000 ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Greater than 3999 numbers cannot be converted to romans'' ]  
	'! !

!TDDBabyStepsGameRomanNumerals methodsFor: 'cases' stamp: 'NR 6/18/2024 07:13:43'!
numberOfCases

	^ 24! !


!classDefinition: #TDDBabyStepsGameRomanToArabig category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameRomanToArabig
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRomanToArabig methodsFor: 'definition' stamp: 'NR 6/27/2024 09:34:47'!
definition
	
	^ '«Roman to Arabig» es la parte 2 continuación de «Roman Numerals» kata con lo que si aún no la resolviste, se te recomienda empezar con esa. En esta oportunidad la idea es recorrer el camino inverso, es decir convertir números romanos a sus pares homólogos arábigos utilizando TDD. Por ej. VII es 7 y XXIV es 24. A diferencia de la kata de romanos, aquí sólo se pide convertir desde el número 1 hasta sólo el 999 inclusive.
	
Recordemos, los caracteres romanos son:

1 -> I
5 -> V
10 -> X
50 -> L
100 -> C
500 -> D
1000 -> M
	
Se sigue pidiendo efectuar el conversor integramente dentro de un method object. 

Ayuda importante: El convertir números romanos a arábigos es un problema relativamente sencillo. Sin embargo esta kata incluye también el reconocer que efectivamente un número romano ingresado sea o no válido, lo que no es tan trivial sin utilizar expresiones regulares o conocer de autómatas finitos.

Se recomienda que apenas lo crea posible utilize streams para representar el número romano a convertir. Esta vez se necesita un ReadStream (ej: aStream := ReadStream on: aString) e investigar los métodos #peekFor: ,#back y #atEnd. 

Ayuda 2 (leerla solamente si estás trabado, y estás tentado de ir a ver la solución en el modo soporte): Una posible idea es mentalizarse de entrada en ir construyendo un parser que sepa en todo momento lo que es posible que aparezca en la cadena y no avance si aparecen cosas no esperadas. Al terminar su corrida, si no consumió toda la cadena es que el romano no era válido. De todas formas, si utilizan los metodos propuestos de stream y van paso a paso siguiendo los tests, tal como ocurrió con la parte 1, el patrón de la solución debería emerger sólo y por eso es que se propone realizarla.

'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'definition' stamp: 'NR 6/26/2024 18:31:58'!
name 
	
	^ 'RomanToArabig'! !


!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:30:36'!
model01

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	^ 1
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:30:41'!
model02

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	aRomanNumber = ''''I'''' ifTrue: [ ^ 1 ].
	^ 2
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:30:50'!
model03

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	"1era versión:"
	"aRomanNumber = ''''I'''' ifTrue: [^ 1 ].
	aRomanNumber = ''''II'''' ifTrue: [ ^ 2 ].
	^ 3"
	
	"2da versión (no muy útil):"
	"^ aRomanNumber size"
	
	"Última versión (Paso 3):"
	| aRomanNumberStream arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	arabig := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ arabig := arabig + 1 ].
	
	^ arabig
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:30:54'!
model04

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	arabig := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ arabig := arabig + 1 ].
	
	(aRomanNumberStream peekFor: $V) ifTrue: [ arabig := 5 ].
	
	^ arabig
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:31:03'!
model05

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: aRomanNumberStream
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	arabig := 0.
	
	"1era versión"
	"[ aRomanNumberStream peekFor: $I ] whileTrue: [ arabig := arabig + 1 ].

	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 		arabig := 5. 
				[ aRomanNumberStream peekFor: $I ] whileTrue: [ arabig := arabig + 1 ] ]"
			
	
	"Última versión (Paso 3):"
	arabig := self parseOnes: aRomanNumberStream.
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 		arabig := 5. 
				arabig := arabig + (self parseOnes: aRomanNumberStream) ].
	
	^ arabig
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:31:17'!
model06

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: aRomanNumberStream
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		
		^ 1 + (self parseOnes: aRomanNumberStream) ].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: aRomanNumberStream) ]
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:31:27'!
model07

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: aRomanNumberStream
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		
		^ 1 + (self parseOnes: aRomanNumberStream)
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: aRomanNumberStream) ].
		
	(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 10 ]
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:31:33'!
model08

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: aRomanNumberStream
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: aRomanNumberStream)
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: aRomanNumberStream) ].
		
	(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 10 ]
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:42:50'!
model09

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: aRomanNumberStream
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: $I ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits: aRomanNumberStream
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: aRomanNumberStream) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: aRomanNumberStream) ].
		
	^ 0

	'' classified: ''converting''.
		
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	| aRomanNumberStream arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	"1era versión"	
	"(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: aRomanNumberStream) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: aRomanNumberStream) ].
		
	(aRomanNumberStream peekFor: $X) ifTrue: [ | units |
		
		units := 0.
		(aRomanNumberStream peekFor: $I) ifTrue: [
			(aRomanNumberStream peekFor: $V) ifTrue: [ units := 4 ].
			(aRomanNumberStream peekFor: $X) ifTrue: [ units := 9 ].
			
			units := 1 + (self parseOnes: aRomanNumberStream) 
		].
	
		(aRomanNumberStream peekFor: $V) 
			ifTrue: [ 	units := 5 + (self parseOnes: aRomanNumberStream) ].
		
		^ 10 + units
	]"
		
	"Última versión (Paso 3):"	
	arabig := self convertUnits: aRomanNumberStream.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		arabig := 10 + (self convertUnits: aRomanNumberStream)
	].
	
	^ arabig
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 08:08:38'!
model10

	^ '[ RomanToArabigConverter removeSelector: #parseOnes: ] on: Error do: [].
	[ RomanToArabigConverter removeSelector: #convertUnits: ] on: Error do: [].
	[ RomanToArabigConverter removeSelector: #toArabig: ] on: Error do: [].
	
	Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: $I) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: $I) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
	
	"1era versión:"
	"| arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	arabig := self convertUnits.
	(aRomanNumberStream peekFor: $X) ifTrue: [ | tens|
		tens := self parseOnes: $X.
		arabig := 10 + (tens * 10) + (self convertUnits)
	].
	
	^ arabig"
	
	"Última versión (Paso 3):"
	| units tens |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	tens := 0.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		tens := self parseOnes: $X.
		tens := 10 + (tens * 10) 
	].
	units := self convertUnits.
	
	^ tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:32:11'!
model11

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: $I) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: $I) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	tens := 0.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		tens := self parseOnes: $X.
		tens := 10 + (tens * 10) 
	].
	
	(aRomanNumberStream peekFor: $L) ifTrue: [ 
		tens := 50 
	].

	units := self convertUnits.
	
	^ tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:32:21'!
model12

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: $I) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: $I) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	tens := 0.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		tens := self parseOnes: $X.
		tens := 10 + (tens * 10) 
	].
	
	(aRomanNumberStream peekFor: $L) ifTrue: [ 
		tens := 50 + ((self parseOnes: $X) * 10)
	].

	units := self convertUnits.
	
	^ tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:32:30'!
model13

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: $I) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: $I) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	tens := 0.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		(aRomanNumberStream peekFor: $L) ifTrue: [ tens := 40 ]
		ifFalse:[
		tens := self parseOnes: $X.
		tens := 10 + (tens * 10) ]
	].
	
	(aRomanNumberStream peekFor: $L) ifTrue: [ 
		tens := 50 + ((self parseOnes: $X) * 10)
	].

	units := self convertUnits.
	
	^ tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:32:45'!
model14

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	(aRomanNumberStream peekFor: $I) ifTrue: [
		(aRomanNumberStream peekFor: $V) ifTrue: [ ^ 4 ].
		(aRomanNumberStream peekFor: $X) ifTrue: [ ^ 9 ].
		
		^ 1 + (self parseOnes: $I) 
	].
	
	(aRomanNumberStream peekFor: $V) 
		ifTrue: [ 	^ 5 + (self parseOnes: $I) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertTens
	
	(aRomanNumberStream peekFor: $X) ifTrue: [
		(aRomanNumberStream peekFor: $L) ifTrue: [ ^ 40 ].
		(aRomanNumberStream peekFor: $C) ifTrue: [ ^ 90 ].
		
		^ 10 + ((self parseOnes: $X) * 10)
	].
	
	(aRomanNumberStream peekFor: $L) 
		ifTrue: [ 	^ 50 + ((self parseOnes: $X) * 10) ].
		
	^ 0
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	"1era versión:"
	"tens := 0.
	(aRomanNumberStream peekFor: $X) ifTrue: [ 
		(aRomanNumberStream peekFor: $L) ifTrue: [ tens := 40 ]
		ifFalse:[ (aRomanNumberStream peekFor: $C) ifTrue: [ tens := 90 ]
		ifFalse:[
		tens := self parseOnes: $X.
		tens := 10 + (tens * 10) ] ]
	].
	
	(aRomanNumberStream peekFor: $L) ifTrue: [ 
		tens := 50 + ((self parseOnes: $X) * 10) 
	]"

	"Última versión (Paso 3):"
	tens := self convertTens.
	
	units := self convertUnits.
	^ tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:33:01'!
model15

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ aRomanNumberStream peekFor: oneChar ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''parseRomanDigitsUsingAsOne: oneChar asFive: fiveChar asTen: tenChar positionalWeight: positionalWeight
	
	(aRomanNumberStream peekFor: oneChar) ifTrue: [
		(aRomanNumberStream peekFor: fiveChar) ifTrue: [ ^ 4 * positionalWeight ].
		(aRomanNumberStream peekFor: tenChar) ifTrue: [ ^ 9 * positionalWeight ].
		
		^ ((self parseOnes: oneChar) + 1) * positionalWeight 
	].
	
	(aRomanNumberStream peekFor: fiveChar) 
		ifTrue: [ 	^ (5 * positionalWeight) + ((self parseOnes: oneChar) * positionalWeight) ].
		
	^ 0

	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	^ self parseRomanDigitsUsingAsOne: $I asFive: $V asTen: $X positionalWeight: 1
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertTens
	
	^ self parseRomanDigitsUsingAsOne: $X asFive: $L asTen: $C positionalWeight: 10
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertHundreds
	
	^ self parseRomanDigitsUsingAsOne: $C asFive: $D asTen: $M positionalWeight: 100
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens hundreds |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	hundreds := self convertHundreds.
	tens := self convertTens.
	units := self convertUnits.
	^ hundreds + tens + units
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:33:22'!
model16

	^ 'Object subclass: #RomanToArabigConverter
	instanceVariableNames: ''aRomanNumberStream''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''TDDBabyStepsGameRomanToArabig''.
	
	
	RomanToArabigConverter compile: ''parseOnes: oneChar
	
	| numberOfOnes |
	
	numberOfOnes := 0.
	[ numberOfOnes < 3 and: [aRomanNumberStream peekFor: oneChar] ] whileTrue: [ numberOfOnes := numberOfOnes + 1 ].
			
	^ numberOfOnes
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''parseRomanDigitsUsingAsOne: oneChar asFive: fiveChar asTen: tenChar positionalWeight: positionalWeight
	
	(aRomanNumberStream peekFor: oneChar) ifTrue: [
		(aRomanNumberStream peekFor: fiveChar) ifTrue: [ ^ 4 * positionalWeight ].
		(aRomanNumberStream peekFor: tenChar) ifTrue: [ ^ 9 * positionalWeight ].
		aRomanNumberStream back.
		^ (self parseOnes: oneChar)  * positionalWeight 
	].
	
	(aRomanNumberStream peekFor: fiveChar) 
		ifTrue: [ 	^ (5 * positionalWeight) + ((self parseOnes: oneChar) * positionalWeight) ].
		
	^ 0

	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertUnits
	
	^ self parseRomanDigitsUsingAsOne: $I asFive: $V asTen: $X positionalWeight: 1
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertTens
	
	^ self parseRomanDigitsUsingAsOne: $X asFive: $L asTen: $C positionalWeight: 10
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''convertHundreds
	
	^ self parseRomanDigitsUsingAsOne: $C asFive: $D asTen: $M positionalWeight: 100
	
	'' classified: ''converting''.
	
	
	RomanToArabigConverter compile: ''assertAllRomanNumeralConverted

	aRomanNumberStream atEnd ifFalse: [ self error: ''''Invalid roman numeral'''' ]
	
	'' classified: ''assertions''.
	
	
	RomanToArabigConverter compile: ''assertNotZero: number

	number = 0 ifTrue: [ self error: ''''Invalid roman numeral'''' ].
	
	'' classified: ''assertions''.
	
	
	RomanToArabigConverter compile: ''toArabig: aRomanNumber 
		
	| units tens hundreds arabig |
	
	aRomanNumberStream := ReadStream on: aRomanNumber.
	
	hundreds := self convertHundreds.
	tens := self convertTens.
	units := self convertUnits.
	
	self assertAllRomanNumeralConverted.
	
	arabig := hundreds + tens + units.
	
	self assertNotZero: arabig.
	
	^ arabig
	
	'' classified: ''converting''
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/27/2024 07:09:47'!
reset
	
	^ '[ RomanToArabigConverter selectors do: [ :selector | RomanToArabigConverter removeSelector: selector ]. 
	RomanToArabigConverter removeFromSystem ] on: Error do: []'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'models' stamp: 'NR 6/26/2024 18:31:25'!
solutionModelBuilder

	^ AbsoluteCompleteModelBuilder ! !


!TDDBabyStepsGameRomanToArabig methodsFor: 'step duration' stamp: 'NR 6/27/2024 12:44:30'!
maxStepDuration

	^ Duration minutes: 15! !


!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 08:07:54'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata

	self assert: (RomanToArabigConverter new toArabig: ''CXCIX'') equals: 199.
	self assert: (RomanToArabigConverter new toArabig: ''CCLXXXVIII'') equals: 288.
	self assert: (RomanToArabigConverter new toArabig: ''CCCLXXVII'') equals: 377.
	self assert: (RomanToArabigConverter new toArabig: ''CDLXVI'') equals: 466.
	self assert: (RomanToArabigConverter new toArabig: ''DV'') equals: 505.
	self assert: (RomanToArabigConverter new toArabig: ''DCXLIV'') equals: 644.
	self assert: (RomanToArabigConverter new toArabig: ''DCCXXXIII'') equals: 733.
	self assert: (RomanToArabigConverter new toArabig: ''DCCCXXII'') equals: 822.
	self assert: (RomanToArabigConverter new toArabig: ''CMXI'') equals: 911.
	self assert: (RomanToArabigConverter new toArabig: ''CM'') equals: 900.
	
	self should: [ RomanToArabigConverter new toArabig: ''CCCM'' ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	self should: [ RomanToArabigConverter new toArabig: ''IIVI'' ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	self should: [ RomanToArabigConverter new toArabig: ''IIXVI'' ] raise: Error withExceptionDo: [:error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:38'!
genCase01

	^ 'test01Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:41'!
genCase02

	^ 'test02Generalization

	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:44'!
genCase03
	
	^ 'test03Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:48'!
genCase04
	
	^ 'test04Generalization
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:52'!
genCase05

	^ 'test05Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:55'!
genCase06

	^ 'test06Generalization
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:43:59'!
genCase07
	
	^ 'test07Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:03'!
genCase08
	
	^ 'test08Generalization
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:08'!
genCase09

	^ 'test09Generalization
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:12'!
genCase10
	
	^ 'test10Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:15'!
genCase11

	^ 'test11Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:18'!
genCase12

	^ 'test12Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:21'!
genCase13

	^ 'test13Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:24'!
genCase14

	^ 'test14Generalization

	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'generalization' stamp: 'NR 6/27/2024 12:44:27'!
genCase15

	^ 'test15Generalization

	'! !


!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 18:37:14'!
case01

	^ 'test01I
	
	self assert: (RomanToArabigConverter new toArabig: ''I'') equals: 1 
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 18:55:21'!
case02

	^ 'test02II
	
	self assert: (RomanToArabigConverter new toArabig: ''II'') equals: 2 
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 19:01:02'!
case03

	^ 'test03III
	
	self assert: (RomanToArabigConverter new toArabig: ''III'') equals: 3 
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 20:04:38'!
case04

	^ 'test04V
	
	self assert: (RomanToArabigConverter new toArabig: ''V'') equals: 5 
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:42:57'!
case05

	^ 'test05VItoVIII
	
	self assert: (RomanToArabigConverter new toArabig: ''VI'') equals: 6.
	self assert: (RomanToArabigConverter new toArabig: ''VII'') equals: 7.
	self assert: (RomanToArabigConverter new toArabig: ''VIII'') equals: 8 
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 20:06:54'!
case06

	^ 'test06IV
	
	self assert: (RomanToArabigConverter new toArabig: ''IV'') equals: 4
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 21:37:04'!
case07

	^ 'test07X
	
	self assert: (RomanToArabigConverter new toArabig: ''X'') equals: 10
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/26/2024 21:37:26'!
case08

	^ 'test08IX
	
	self assert: (RomanToArabigConverter new toArabig: ''IX'') equals: 9
																	
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:04'!
case09

	^ 'test09XItoXIX
	
	self assert: (RomanToArabigConverter new toArabig: ''XI'') equals: 11.
	self assert: (RomanToArabigConverter new toArabig: ''XII'') equals: 12.
	self assert: (RomanToArabigConverter new toArabig: ''XIII'') equals: 13.
	self assert: (RomanToArabigConverter new toArabig: ''XIV'') equals: 14.
	self assert: (RomanToArabigConverter new toArabig: ''XV'') equals: 15.
	self assert: (RomanToArabigConverter new toArabig: ''XVI'') equals: 16.
	self assert: (RomanToArabigConverter new toArabig: ''XVII'') equals: 17.
	self assert: (RomanToArabigConverter new toArabig: ''XVIII'') equals: 18.
	self assert: (RomanToArabigConverter new toArabig: ''XIX'') equals: 19.								
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 07:45:31'!
case10

	^ 'test10XXtoXXXIX
	
	self assert: (RomanToArabigConverter new toArabig: ''XX'') equals: 20.
	self assert: (RomanToArabigConverter new toArabig: ''XXIII'') equals: 23.
	self assert: (RomanToArabigConverter new toArabig: ''XXV'') equals: 25.
	self assert: (RomanToArabigConverter new toArabig: ''XXVII'') equals: 27.
	self assert: (RomanToArabigConverter new toArabig: ''XXXI'') equals: 31.
	self assert: (RomanToArabigConverter new toArabig: ''XXXII'') equals: 32.
	self assert: (RomanToArabigConverter new toArabig: ''XXXIV'') equals: 34.
	self assert: (RomanToArabigConverter new toArabig: ''XXXVIII'') equals: 38.
	self assert: (RomanToArabigConverter new toArabig: ''XXXIX'') equals: 39.
															
	'
	! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:09'!
case11

	^ 'test11LtoLIX
	
	self assert: (RomanToArabigConverter new toArabig: ''L'') equals: 50.
	self assert: (RomanToArabigConverter new toArabig: ''LII'') equals: 52.
	self assert: (RomanToArabigConverter new toArabig: ''LIV'') equals: 54.
	self assert: (RomanToArabigConverter new toArabig: ''LVI'') equals: 56.
	self assert: (RomanToArabigConverter new toArabig: ''LIX'') equals: 59.
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:13'!
case12

	^ 'test12LXtoLXXXIX
	
	self assert: (RomanToArabigConverter new toArabig: ''LX'') equals: 60.
	self assert: (RomanToArabigConverter new toArabig: ''LXI'') equals: 61.
	self assert: (RomanToArabigConverter new toArabig: ''LXXIII'') equals: 73.
	self assert: (RomanToArabigConverter new toArabig: ''LXXVI'') equals: 76.
	self assert: (RomanToArabigConverter new toArabig: ''LXXXIV'') equals: 84.
	self assert: (RomanToArabigConverter new toArabig: ''LXXXVII'') equals: 87.
	self assert: (RomanToArabigConverter new toArabig: ''LXXXIX'') equals: 89		.
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:17'!
case13

	^ 'test13XLtoXLIX
	
	self assert: (RomanToArabigConverter new toArabig: ''XL'') equals: 40.
	self assert: (RomanToArabigConverter new toArabig: ''XLI'') equals: 41.
	self assert: (RomanToArabigConverter new toArabig: ''XLII'') equals: 42.
	self assert: (RomanToArabigConverter new toArabig: ''XLIII'') equals: 43.
	self assert: (RomanToArabigConverter new toArabig: ''XLIV'') equals: 44.
	self assert: (RomanToArabigConverter new toArabig: ''XLV'') equals: 45.
	self assert: (RomanToArabigConverter new toArabig: ''XLVI'') equals: 46.
	self assert: (RomanToArabigConverter new toArabig: ''XLVII'') equals: 47.
	self assert: (RomanToArabigConverter new toArabig: ''XLVIII'') equals: 48.
	self assert: (RomanToArabigConverter new toArabig: ''XLIX'') equals: 49.								
	
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:21'!
case14

	^ 'test14XCtoXCIX
	
	self assert: (RomanToArabigConverter new toArabig: ''XC'') equals: 90.
	self assert: (RomanToArabigConverter new toArabig: ''XCI'') equals: 91.
	self assert: (RomanToArabigConverter new toArabig: ''XCII'') equals: 92.
	self assert: (RomanToArabigConverter new toArabig: ''XCIII'') equals: 93.
	self assert: (RomanToArabigConverter new toArabig: ''XCIV'') equals: 94.
	self assert: (RomanToArabigConverter new toArabig: ''XCV'') equals: 95.
	self assert: (RomanToArabigConverter new toArabig: ''XCVI'') equals: 96.
	self assert: (RomanToArabigConverter new toArabig: ''XCVII'') equals: 97.
	self assert: (RomanToArabigConverter new toArabig: ''XCVIII'') equals: 98.
	self assert: (RomanToArabigConverter new toArabig: ''XCIX'') equals: 99.								
																									
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:43:24'!
case15

	^ 'test15CtoCMXCIX
	
	self assert: (RomanToArabigConverter new toArabig: ''C'') equals: 100.
	self assert: (RomanToArabigConverter new toArabig: ''CCII'') equals: 202.
	self assert: (RomanToArabigConverter new toArabig: ''CCCXXX'') equals: 330.
	self assert: (RomanToArabigConverter new toArabig: ''CDIV'') equals: 404.
	self assert: (RomanToArabigConverter new toArabig: ''DL'') equals: 550.
	self assert: (RomanToArabigConverter new toArabig: ''DCVI'') equals: 606.
	self assert: (RomanToArabigConverter new toArabig: ''DCCLXX'') equals: 770.
	self assert: (RomanToArabigConverter new toArabig: ''DCCCVIII'') equals: 808.
	self assert: (RomanToArabigConverter new toArabig: ''CMXC'') equals: 990.
	self assert: (RomanToArabigConverter new toArabig: ''CMXCIX'') equals: 999.
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 08:04:22'!
case16

	^ 'test16InvalidNumeralsFailsToConvert
	
	"Nota: No se separó en casos, porque sino los tests pasaban de entrada..."	
		
	"Out of range"
	self should: [ RomanToArabigConverter new toArabig: '''' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''M'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''MMMDCCLXVI'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"Characters from outside the alphabet"
	self should: [ RomanToArabigConverter new toArabig: ''IIromans'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''x'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
		
	"More than 3 oneChars"
	self should: [ RomanToArabigConverter new toArabig: ''IIII'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''XXXXVI'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''DCCCCI'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''CMIIII'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"fiveChars never repetead"
	self should: [ RomanToArabigConverter new toArabig: ''DLLXI'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''XXXIVVI'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"fiverChars never substracted"
	self should: [ RomanToArabigConverter new toArabig: ''DLCXXII'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''DMCLVXIV'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"I can only substract V and X"
	self should: [ RomanToArabigConverter new toArabig: ''CIL'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"X can only substract L and C"
	self should: [ RomanToArabigConverter new toArabig: ''XM'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	
	"Out of order: TensBeforeHundreds, UnitsBeforeTens, etc.."
	self should: [ RomanToArabigConverter new toArabig: ''LXVIDCCC'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''VIIXXIV'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''CIXC'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	self should: [ RomanToArabigConverter new toArabig: ''IIIX'' ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: ''Invalid roman numeral'' ].
	'! !

!TDDBabyStepsGameRomanToArabig methodsFor: 'cases' stamp: 'NR 6/27/2024 12:44:48'!
numberOfCases

	^ 16! !


!classDefinition: #TDDBabyStepsGameRot13 category: #TDDBabyStepsGame!
TDDBabyStepsGame subclass: #TDDBabyStepsGameRot13
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRot13 methodsFor: 'definition' stamp: 'NR 9/25/2022 04:30:53'!
definition
	
	^ 'ROT13 («rotar 13 posiciones») es un sencillo cifrado César utilizado para ocultar un texto sustituyendo cada letra por la letra que está trece posiciones por delante en el alfabeto. 
	
- A se convierte en N, B se convierte en O y así hasta la M, que se convierte en Z. 
	
- Luego la secuencia se invierte: N se convierte en A, O se convierte en B y así hasta la Z, que se convierte en M. 

Ver gráfico en: https://es.wikipedia.org/wiki/ROT13
Probar en: https://rot13.com/

Ayuda: Considere utilizar los mensajes #asciiValue, #asciiValue: #between:and: cuando sea necesario.

'! !

!TDDBabyStepsGameRot13 methodsFor: 'definition' stamp: 'NR 5/2/2022 02:06:01'!
name 
	
	^ 'Rot13'! !


!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:18'!
model01

	^ 'Character compile: ''asRot13
	
	^$n'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:22'!
model02

	^ 'Character compile: ''asRot13
	
	"1era versión:"
	"self = $a ifTrue: [^$n].
	^$z."
	
	"2da versión (Paso 3: Refactor):"
	"self = $a ifTrue: [^$n].
	self = $m ifTrue: [^$z]."
	
	"Última versión (Paso 3: Refactor):"
	^Character asciiValue: self asciiValue + 13'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:28'!
model03

	^ 'Character compile: ''asRot13
	
	self asciiValue < $n asciiValue ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	^$a'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:32'!
model04

	^ 'Character compile: ''asRot13
	
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

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:37'!
model05

	^ 'Character compile: ''asRot13
	
	(self asciiValue >= $a asciiValue and: [self asciiValue <= $m asciiValue]) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	self asciiValue >= $n asciiValue ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:40'!
model06

	^ 'Character compile: ''asRot13
	
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

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:45'!
model07

	^ 'Character compile: ''asRot13
	
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

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:49'!
model08

	^ 'Character compile: ''asRot13
	
	(self asLowercase asciiValue between: $a asciiValue and: $m asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue + 13].
	
	(self asLowercase asciiValue between: $n asciiValue and: $z asciiValue) ifTrue:
		[^Character asciiValue: self asciiValue - 13].
		
	^self'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:52'!
model09

	^ 'String compile: ''asRot13
	
	^'''''''' ''classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:42:56'!
model10

	^ 'String compile: ''asRot13
	
	self isEmpty ifTrue: [^''''''''].
	
	"1era versión:"
	"self = ''''a'''' ifTrue: [^''''n''''].
	self = ''''M'''' ifTrue: [^''''Z''''].
	self = ''''n'''' ifTrue: [^''''a''''].
	self = ''''{'''' ifTrue: [^''''{'''']."
	
	"Última versión (Paso 3: Refactor):"
	^self first asRot13 asString'' classified: ''printing'' 
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:43:00'!
model11

	^ 'String compile: ''asRot13
	
	self isEmpty ifTrue: [^''''''''].
	
	self size = 1 ifTrue:[^self first asRot13 asString].
	
	^self first asRot13 asString, (self at:2) asRot13 asString'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/8/2024 21:43:04'!
model12

	^ 'String compile: ''asRot13
	
	^self collect: [:aChar | aChar asRot13]'' classified: ''printing''
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/21/2024 07:48:41'!
reset
	
	^ '[ Character removeSelector: #asRot13 ] on: Error do: [].
	[ String removeSelector: #asRot13 ] on: Error do: []'! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/21/2024 21:56:34'!
solutionModelBuilder

	^ IncrementalPartialModelBuilder
	! !

!TDDBabyStepsGameRot13 methodsFor: 'models' stamp: 'NR 6/21/2024 21:55:04'!
userSolutionSourceCodeRetriever
	
	^ '| rot13StringSC rot13CharSC |
	
	rot13CharSC := ''''.
	[ rot13CharSC := Character sourceCodeAt: #asRot13 ] on: Error do: [].
	
	rot13StringSC:=''''.
	[ rot13StringSC :=  String sourceCodeAt: #asRot13 ] on: Error do: [].
	
	^ rot13CharSC, (String with: Character newLineCharacter), (String with: Character newLineCharacter), rot13StringSC'
	! !


!TDDBabyStepsGameRot13 methodsFor: 'step duration' stamp: 'NR 6/7/2024 08:38:04'!
maxStepDuration

	^ Duration minutes: 10! !


!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 9/25/2022 18:12:37'!
extraCase

	^ 'testExtraToCheckGeneralizationOnKata
		
	self assert: ''Ju3er j3 4e3 t01at j3 q0ag a3rq e04q$...'' equals: ''Wh3re w3 4r3 g01ng w3 d0nt n3ed r04d$...'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:13:43'!
genCase01

	^ 'test01GeneralizationCorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:18:44'!
genCase02

	^ 'test02GeneralizationCorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $s equals: $f asRot13.
	self assert: $t equals: $g asRot13.
	self assert: $u equals: $h asRot13
	'
	! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:17:50'!
genCase03
	
	^ 'test03GeneralizationCorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:19:04'!
genCase04
	
	^ 'test04GeneralizationCorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $f equals: $s asRot13.
	self assert: $g equals: $t asRot13.
	self assert: $h equals: $u asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:25:05'!
genCase05

	^ 'test05GeneralizationCharOnTheBelowRangeDoesntChange
	
	self assert: $F equals: $F asRot13.
	self assert: $3 equals: $3 asRot13.
	self assert: $) equals: $) asRot13.
	self assert: $% equals: $% asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:27:46'!
genCase06

	^ 'test06GeneralizationCharOnTheUpperRangeDoesntChange
	
	self assert: $| equals: $| asRot13.
	self assert: $} equals: $} asRot13
	
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:29:30'!
genCase07
	
	^ 'test07GeneralizationCorrectlyEncodesAnUppercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $S equals: $F asRot13.
	self assert: $T equals: $G asRot13.
	self assert: $U equals: $H asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:30:35'!
genCase08
	
	^ 'test08GeneralizationCorrectlyEncodesAnUppercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $F equals: $S asRot13.
	self assert: $G equals: $T asRot13.
	self assert: $H equals: $U asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:31:10'!
genCase09

	^ 'test09GeneralizationTheEmptyStringDoesntChange
	
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:35:12'!
genCase10

	^ 'test10GeneralizationCorrectlyEncodesAOneCharString
	
	self assert: ''s'' equals: ''f'' asRot13.
	self assert: ''G'' equals: ''T'' asRot13.
	self assert: ''4'' equals: ''4'' asRot13.
	self assert: ''~'' equals: ''~'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'generalization' stamp: 'NR 5/13/2024 05:37:44'!
genCase11
	
	^ 'test11GeneralizationCorrectlyEncodesATwoCharString
	
	self assert: ''sh'' equals: ''fu'' asRot13.
	self assert: ''J3'' equals: ''W3'' asRot13
	
	'! !


!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:11:41'!
case01

	^ 'test01CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $n equals: $a asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:11:47'!
case02

	^ 'test02CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $z equals: $m asRot13
	'
	! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:11:51'!
case03
	
	^ 'test03CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $a equals: $n asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:11:55'!
case04
	
	^ 'test04CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $m equals: $z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:11:59'!
case05

	^ 'test05CharOnTheBelowRangeDoesntChange
	
	self assert: $` equals: $` asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:03'!
case06

	^ 'test06CharOnTheUpperRangeDoesntChange
	
	self assert: ${ equals: ${ asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:06'!
case07
	
	^ 'test07CorrectlyEncodesAnUppercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $N equals: $A asRot13.
	self assert: $Z equals: $M asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:10'!
case08
	
	^ 'test08CorrectlyEncodesAnUppercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $A equals: $N asRot13.
	self assert: $M equals: $Z asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:14'!
case09

	^ 'test09TheEmptyStringDoesntChange
	
	self assert: '''' equals: '''' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:18'!
case10

	^ 'test10CorrectlyEncodesAOneCharString
	
	self assert: ''n'' equals: ''a'' asRot13.
	self assert: ''Z'' equals: ''M'' asRot13.
	self assert: ''a'' equals: ''n'' asRot13.
	self assert: ''{'' equals: ''{'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:23'!
case11
	
	^ 'test11CorrectlyEncodesATwoCharString
	
	self assert: ''nm'' equals: ''az'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 9/25/2022 18:12:26'!
case12

	^ 'test12CorrectlyEncodesMoreThanTwoCharString
	
	self assert: ''uByN!!'' equals: ''hOlA!!'' asRot13
	'! !

!TDDBabyStepsGameRot13 methodsFor: 'cases' stamp: 'NR 6/16/2024 07:29:33'!
numberOfCases

	^ 12! !


!classDefinition: #TDDBabyStepsGameBase category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameBase
	instanceVariableNames: 'name testCaseBuilder genCases extraTest currentStep currentStepReturnMessage currentTest journey definition solutionModelBuilder state prematureDecisionVerifierStrategy penaltyTimer maxStepDuration difficultyConfiguration userSolutionSourceCodeRetrieverBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:46:53'!
addEntryToJourney

	currentStepReturnMessage ifNotEmpty: [ journey add: 	currentStepReturnMessage atStep: self currentStep ].
	self clearCurrentStepReturnMessage! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 5/12/2024 02:19:36'!
addEntryToJourneyWithFinalLine: aFinalLineDescriptionToAddToCurrentStepReturnMessage

	currentStepReturnMessage updateAddingDescription: aFinalLineDescriptionToAddToCurrentStepReturnMessage.
	self addEntryToJourney! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 5/1/2024 08:27:38'!
clearCurrentStepReturnMessage
	
	currentStepReturnMessage := TDDBabyStepsGameCodedMessage emptyMessage ! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:47:38'!
finalScoreLineMessage

	| message |
	
	message := 'Tu puntaje final es: {1} puntos de {2} posibles. Tu nota por la kata es un {3}/10.' format: { self score.  self totalObtainablePoints. self formatedGradeAsString }.
	
	self grade < 4 ifTrue: [ message := message, ' Se recomienda repetir la kata.' ].
	
	message := message, difficultyConfiguration gameEndedMessageText.
	
	^ message

	! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:47:47'!
forceNextMessage

	^ 'Pero utilizaste el forceNext para avanzar, por lo que restás {1} punto/s.' format: { self forcedNextPointsCost } ! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:47:58'!
gameEndedAndGeneralizedCorrectlyMessage

	^ self class newLine, '¡Felicitaciones!! ', self gameEndedMessage, ' Has generalizado la solución correctamente.'! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:48:01'!
gameEndedAndGeneralizedIncorrectlyMessage

	^ self class newLine, self gameEndedMessage, ' Pero si bien pasas los tests, no has generalizado la solución lo suficiente.'! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:48:04'!
gameEndedGeneralizedCorrectly
	
	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameEndedCorrectGeneralization description: self gameEndedAndGeneralizedCorrectlyMessage.
	
	currentStepReturnMessage updateAddingMessage: message
	! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:48:11'!
gameEndedMessage

	^ 'Has finalizado el juego/kata.'! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:48:51'!
informGrade
	
	currentStepReturnMessage updateAddingDescription: self class newLine, self finalScoreLineMessage.
	self addEntryToJourney! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 5/12/2024 07:02:59'!
journeyInString

	^ journey formatToString! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:49:07'!
lastAdvancedStepTimestamp

	^ journey lastAdvancedStepTimestamp! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 5/12/2024 08:03:04'!
lastStepTakenIfNone: exceptionBlock

	^ journey lastStepTakenIfNone: exceptionBlock ! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:49:31'!
prematureDecisionsMadeMessage
	
	^ ('¡Te estás adelantando!! Para continuar modifica tu modelo actual por uno más sencillo y menos general.', self class newLine, 'Restás {1} punto/s.') format: { self prematureDecisionsMadePointsCost }! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:49:47'!
revealStepSolutionMessage

	^ 'Al revelar la solución hasta este paso se pierden todos los puntos conseguidos hasta el momento.'! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:50:33'!
testPassedCorrectlyMessage

	^ 'Has completado el test actual, sumás {1} puntos.' format: { self testsPassedBonusPoints }! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:50:38'!
testPassedEarlyMessage

	^ 'Sumás {1} puntos porque pasaste este test de entrada. Avanzás al siguiente test.' format: { self testPassedEarlyBonusPoints }! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/27/2024 12:50:45'!
testsDoNotPassMessage

	^ ( 'No se puede avanzar al próximo test si no pasan todos los tests actuales.', self class newLine, 'Restás {1} punto/s.') format: { self testsDoNotPassPointsCost }! !

!TDDBabyStepsGameBase methodsFor: 'journey' stamp: 'NR 6/21/2024 22:06:19'!
userSolutionSourceCodeRetriever

	^ Compiler evaluate: userSolutionSourceCodeRetrieverBlock ! !


!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 5/1/2022 19:33:40'!
forcedNextPointsCost

	^ 5! !

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 6/27/2024 12:47:54'!
formatedGradeAsString
	
	^ String streamContents: [ :strm | self grade printOn: strm fractionDigits: 2 ]
	! !

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

!TDDBabyStepsGameBase methodsFor: 'points definition' stamp: 'NR 6/27/2024 12:50:54'!
totalObtainablePoints

	^ self totalNumberOfTests * self testsPassedBonusPoints! !


!TDDBabyStepsGameBase methodsFor: 'difficulty' stamp: 'NR 5/14/2024 16:48:41'!
advanceToNextLevelDifficulty

	^ difficultyConfiguration := difficultyConfiguration nextLevel! !

!TDDBabyStepsGameBase methodsFor: 'difficulty' stamp: 'NR 5/14/2024 15:46:09'!
difficultyConfiguration

	^ difficultyConfiguration ! !


!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:47:42'!
finishGameAndInformFinalScore

	state := GameEnded for: self.
	self hasPassedExtraTest 
		ifTrue: [ self gameEndedGeneralizedCorrectly ]
		 ifFalse: [ self gameEndedGeneralizedIncorrectly ].
	self informGrade.
	self advanceToNextLevelDifficulty.
	self unlockDifficultyLevel
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/17/2024 07:19:46'!
forceNextOnNormalStep
	
	self tryToAdvanceNextStepDoing:  [ self stepCompleted ]
	ifPrematureDecisionsMadeDo: [ self stepCompleted. self decreaseScoreAsForcedNext. ] 
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:48:40'!
increaseScoreOnEndedGame
	
	self error: self class increaseScoreOnEndedGameErrorMessage
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:48:44'!
increaseScoreOnNormalStep
	
	self increaseScoreAsCurrentTestsPassed
				
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/12/2024 02:06:43'!
increaseScoreOnPrematureDecisionStep
	
	self increaseScoreAsLatestTestPassedEarly.
	state := OnNormalStep for: self
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/12/2024 02:06:47'!
increaseScoreOnStartingGame
	
	self error: self class increaseScoreOnStartingGameErrorMessage
	
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/1/2024 18:10:50'!
informGameStartsAnd1stTestCreated

	| message |
	
	self clearCurrentStepReturnMessage.
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameStarting description:  'Test01 creado correctamente. Páselo y presione next para continuar.' .
	
	currentStepReturnMessage updateAddingMessage: message.
	
	self addEntryToJourney! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:48:54'!
informStepResultWithCurrentScore

	^ self addEntryToJourneyWithFinalLine: (' Tu puntaje actual es de {1}.' format: { self score })! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 5/3/2022 07:48:00'!
nextOnEndedGame
	
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/17/2024 07:16:48'!
nextOnNormalStep
	
	self tryToAdvanceNextStepDoing: [ self warnAboutPossibleGeneralizationsMissingBeforeCompletingStep ] ifPrematureDecisionsMadeDo: [ self decreaseScoreAsPrematureDecisionsMade ] ! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:49:21'!
nextOnStartingGame
	
	self increaseCurrentStep.
	self addNextTestToTheTestCaseClass.
	state := OnNormalStep for: self.
	self informGameStartsAnd1stTestCreated
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/22/2024 02:38:45'!
rebuildStepSolutionToCurrentStep
	
	^ solutionModelBuilder buildSolutionForStep: currentStep! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 4/29/2024 17:05:25'!
stepSolutionOnNotOngoingGame
	
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/21/2024 22:08:05'!
stepSolutionOnOngoingGame
	
	self clearCurrentStepReturnMessage.
	self eliminateAllCurrentPositivePointsOnStepSolution.
	state := 	OnPrematureDecisionStep for: self.
	self rebuildStepSolutionToCurrentStep.
	self addEntryToJourney
	
! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/17/2024 07:16:48'!
tryToAdvanceNextStepDoing: stepCompletionAction ifPrematureDecisionsMadeDo: prematurePenaltyActionToBeTaken
	
	self clearCurrentStepReturnMessage.
	
	self tryToPassTestsAndEvaluate: [	
		self prematureDecisionMade
			ifTrue: prematurePenaltyActionToBeTaken 
			ifFalse: stepCompletionAction 
		].

	self gameHasEnded 
		ifTrue:[ self finishGameAndInformFinalScore ] 
		ifFalse:[ self informStepResultWithCurrentScore ]
	! !

!TDDBabyStepsGameBase methodsFor: 'game state' stamp: 'NR 6/27/2024 12:51:05'!
unlockDifficultyLevel

	difficultyConfiguration unlock: self name! !


!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 9/25/2022 18:13:36'!
currentStep

	^ currentStep! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/27/2024 12:47:27'!
detectPrematureDecisionOnNewStep
	
	self currentNewTestPassesEarly ifTrue: [ state := OnPrematureDecisionStep for: self ]! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/27/2024 12:48:14'!
gameHasEnded

	^ currentStep > self totalNumberOfTests! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/7/2024 16:40:07'!
gameHasJustStarted

	^ currentStep = 0! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/27/2024 12:48:19'!
gameInLastStep

	^ currentStep = self totalNumberOfTests! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 9/25/2022 18:14:52'!
increaseCurrentStep

	currentStep := currentStep  + 1
! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/27/2024 12:49:27'!
prematureDecisionMade
	
	^ currentStep < self totalNumberOfTests and: [ prematureDecisionVerifierStrategy value ]
	
	"^ currentStep < self numberOfTests and: [ self someOfTheNextTestsPass ]"
	"^ currentStep < self numberOfTests and: [ self hasPassedNextTest ]"! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/22/2024 02:29:15'!
removeUserModelSolution

	^ solutionModelBuilder removeUserModelSolution! !

!TDDBabyStepsGameBase methodsFor: 'game' stamp: 'NR 6/27/2024 12:50:26'!
stepCompleted

	self increaseScore.
	self increaseCurrentStep.
	self detectStepDurationInsideTimeLimits.
	self gameHasEnded 
		ifFalse: [ self addNextTestToTheTestCaseClass.
			self detectPrematureDecisionOnNewStep.
			self detectGeneralizationsMissingOnLastStep ]
! !


!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:47:07'!
currentNewTestPassesEarly
	
	^ currentTest isNil not and: [ self hasPassedCurrentTest ]! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 9/25/2022 18:16:01'!
hasPassedCurrentTest

	^ self runCurrentTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 9/25/2022 18:16:07'!
hasPassedExtraTest

	^ self runExtraTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 9/25/2022 18:16:12'!
hasPassedNextTest

	^ self runNextTest hasPassed! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:49:24'!
nextTest

	^ testCaseBuilder testCaseForStep: currentStep + 1! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:49:50'!
runCurrentTest

	^ self runTestNamed: currentTest
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:49:54'!
runExtraTest

	^ self runTestNamed: (testCaseBuilder compileTestFromMethod: extraTest)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:01'!
runNextTest

	^ self runShadowTest: self nextTest
	
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:04'!
runNextTestNumber: aTestNumber

	^ self runShadowTest: (testCaseBuilder testCaseForStep: aTestNumber)
	
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/22/2024 07:09:47'!
runShadowTest: aCaseToTest

	| testSelector result |
	
	testSelector := testCaseBuilder compileTestFromMethod: aCaseToTest.
	
	result := self runTestNamed: testSelector.
	
	testCaseBuilder removeTest: testSelector.
	
	^ result
	
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:09'!
runSuiteIfPassDo: aTestsPassBlock ifDoesNotPass: aTestsDoesNotPassBlock
		
	| testResult |

	testResult := self testSuite run.	
	
	testResult hasPassed 
		ifTrue: aTestsPassBlock
		ifFalse: aTestsDoesNotPassBlock! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:12'!
runTestNamed: aTestSelector

	| suite |
	
	suite := testCaseBuilder testSuiteForTest: aTestSelector.
	
	^ suite run
	
	! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:22'!
someOfTheNextTestsPass

	^ (currentStep + 1 to: self totalNumberOfTests) anySatisfy: [ :numberOfTest | (self runNextTestNumber: numberOfTest) hasPassed ]! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:50:51'!
totalNumberOfTests

	^ testCaseBuilder totalNumberOfTests ! !

!TDDBabyStepsGameBase methodsFor: 'tests running' stamp: 'NR 6/27/2024 12:51:01'!
tryToPassTestsAndEvaluate: aTestsPassBlock
		
	self runSuiteIfPassDo: aTestsPassBlock
		ifDoesNotPass: [ self decreaseScoreAsTestsDoNotPass. ]
	
	
! !


!TDDBabyStepsGameBase methodsFor: 'test case building' stamp: 'NR 6/22/2024 06:32:05'!
addNextTestToTheTestCaseClass

	currentTest := testCaseBuilder addToTheTestCaseClassTestForStep: currentStep! !

!TDDBabyStepsGameBase methodsFor: 'test case building' stamp: 'NR 6/27/2024 12:49:41'!
removeAllTests

	testCaseBuilder removeAllTests ! !

!TDDBabyStepsGameBase methodsFor: 'test case building' stamp: 'NR 6/27/2024 12:50:41'!
testSuite

	^ testCaseBuilder testSuite ! !


!TDDBabyStepsGameBase methodsFor: 'browse tests' stamp: 'NR 6/22/2024 06:45:26'!
browseTestCase

	testCaseBuilder browseTestCase 
	! !


!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 5/3/2022 08:13:17'!
forceNext
	
	state forceNext
		
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 9/25/2022 18:17:08'!
next

	state next
! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 6/17/2024 07:28:36'!
nextAfterConfirmingWarning

	self tryToAdvanceNextStepDoing: [ self stepCompleted ] ifPrematureDecisionsMadeDo: [ self decreaseScoreAsPrematureDecisionsMade ] ! !

!TDDBabyStepsGameBase methodsFor: 'steps' stamp: 'NR 4/29/2024 16:58:17'!
stepSolution
	
	state stepSolution 
	! !


!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:13:59'!
definition

	^ definition! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 6/27/2024 11:26:15'!
help
	
	^ '0- Iniciar un juego. Si llegó hasta aquí es que ya hizo: 
	
	TDDBabyStepsGameXXXX start.
	
1- Usted comienza con un puntaje de 0 puntos en la dificultad "First Run!!". Al comenzar se creará la clase de test y se abrirá un class browser.  

2- Para obtener el primer caso de test a pasar presione el botón "next".

3- Una vez finalizada la implementación para ese test presione nuevamente el botón de "next":

- Si sus tests pasan, ganará 5 puntos y se le presentará el próximo test.
- Si sus tests no pasan, perderá 1 punto y deberá seguir intentando haciendolos pasar.
- Si sus test pasan pero se adelantó con su implementación (no es mínima) perderá 1 punto y deberá intentar reformularla para no adelanterse pasos.

3''- IMPORTANTISIMO: Tenga SIEMPRE en mente que presionar "next" escribirá un nuevo test por usted. Si desea hacer un "paso 3" de refactor/generalización, hagalo ANTES de presionar "next".

4- Si no logra llegar a la implementación mínima siempre puede presionar el botón "force next" para seguir avanzando. De esta manera se le presentará el próximo test (el cual pasará directamente con la implementación propuesta) y así entenderá en qué se había adelantado. Pero ¡Atención!! De hacerlo se le restaran 5 puntos y ademas el nuevo test presentado no sumará puntos pues ya pasaba de entrada al efectuar el "force next".

5- Preste atención a las indicaciones descriptas en la sección "Step Result". En "Game Journey" podrá ir visualizando el resumen histórico de su trayecto actual en el juego.

6- Cuando los tests se acaben el juego habrá terminado y se le presentará un puntaje junto a su nota final por el ejercicio. Pero ¡Atención nuevamente!! Si sólo se encargó de pasar los tests y nunca generalizó utilizando un paso 3, puede que pierda TODOS su puntos si no logra pasar un último test extra de generalización. Con lo que, ¡No se olviden de hacer pasos 3 y generalizar!!

Notas extras: 
a) Para practicar, antes de presionar "next" puede pensar y anotar en un papel cual cree que sería el próximo test a pasar y así compararlo con el que presenta el juego y comprobar si usted hubiese seguido el mismo camino que el propuesto.
b) Al terminar el juego puede pensar cuales de los tests presentados habría que mantener y cuales podrían eliminarse por estar repetidos. Verificar además los nombres de los mismos comparando dato de test con caso de test.
c) No olvide configurar su nombre de usuario (puede ser un pseudonimo, el juego es anónimo), el curso-facultad-universidad a la que pertenece / organización y fundamentalmente guarde en un lugar seguro su Uuid. El mismo define realmente su usuario en el sistema, y es el que le permite guardar su avance (juegos completados) en el juego.

Niveles de dificultad:

Todos los juegos comienzan en el modo "First Run!!" explicado en la sección anterior. Al superarlo se desbloquea la opción de jugarlos en modo soporte "Support Unlocked". En este nivel de dificultad, recomendado principalmente para aquellos que hayan obtenido una calificación final de menos de 4 en su primera corrida, se les permitirá acceder a ayudas extras. Entre ellas se encuentran:

- "Reveal Step Solution": Revela la solución de la cátedra para el actual paso. Si se utiliza esta opción se pierden todos los puntos obtenidos hasta ese momento en el juego y atención!! que también se perderá la solución hecha hasta ese momento por el jugador, reemplazándose por la de la cátedra.
- "Reset game": Permite re-comenzar el juego, para tomar diferentes decisiones en pasos previos. Nuevamente se eliminará la solución del jugador hasta ese momento.
- Notificación de generalizaciones no efectuadas: El juego avisará cuando era un buen momento para realizar una refactorización/generalización de paso 3 que no fue efectuada. No resta puntos en este modo.
- Notificación de tiempo excedido: Cada vez que se tarde mucho en superar un paso, el juego avisará que se está utilizando mucho tiempo, lo que implica que no se está necesariamente pensando en la solución más simple posible. No resta puntos.

Una vez desbloqueado este modo, siempre se puede volver a acceder al mismo, incluso habiendo cerrado la ventana del juego utilizando:
	
	TDDBabyStepsGameXXXX startUnlocked.
	
Es importante, sin embargo, haber configurado su Uuid desde "Change Uuid" de "First Run!!" con el que haya utilizado al desbloquear el juego en cuestión.

Modo Experto "Expert Challenge!!":

Modo reservado sólo para verdaderos expertos!! En este modo, todas las opciones de soporte estarán desactivadas, y adicionalmente se descontarán puntos cuando:
´
- No se generalizó con un paso 3 en el momento justo: Resta 1 punto.
- Se resta 1 punto por cada vez que se exceda el tiempo propuesto para resolver un paso. Así si el cronómetro en pantalla es de 5 minutos por paso, y se tardan 12 en resolverlo, se restarán 2 puntos.

Sólo se puede acceder al desafío experto por su propia voluntad utilizando:
	
	TDDBabyStepsGameXXXX startExpert.

Leaderboard!!:

Muestrele al mundo su dominio de TDD y alardeé con sus amigos escalando posiciones en nuestro Leaderboard de BabySteps!! Puede buscar su nombre de usuario o pseudonimo en:

	http://babysteps.isw2.com.ar
	
Pero recuerde: Deber haber obtenido al menos 1 punto en su kata, y estar entre los primeras 1000 posiciones históricas. El tiempo que se tarda tambien cuenta para determinar su posición!! 

Buena suerte!!
'! !

!TDDBabyStepsGameBase methodsFor: 'statements' stamp: 'NR 9/25/2022 18:14:09'!
name

	^ name! !


!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:47:04'!
clearUserSolutionAndTests

	self removeUserModelSolution.
	self removeAllTests.
	self initializeToStep0 
	! !

!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:48:58'!
initializeNamed: aName withTestCaseBuilder: aTestCaseBuilder withExtraCase: anExtraCase withGenCases: aGenCases withSolutionModelBuilder: aSolutionModel withUserSolutionSourceCodeRetriever: aUserSolutionSourceCodeRetriever withDefinition: aDefinition withMaxStepDuration: aMaxStepDuration withDifficultyConfiguration: aDifficultyConfiguration
	
	name := aName.
	testCaseBuilder := aTestCaseBuilder.
	solutionModelBuilder := aSolutionModel.
	extraTest :=anExtraCase.
	genCases := aGenCases.
	userSolutionSourceCodeRetrieverBlock := aUserSolutionSourceCodeRetriever.
	definition := aDefinition. 
	maxStepDuration := 	aMaxStepDuration.
	difficultyConfiguration := aDifficultyConfiguration.
	prematureDecisionVerifierStrategy  := [self hasPassedNextTest].
	"prematureDecisionVerifierStrategy  := [self someOfTheNextTestsPass]."
	self initializeToStep0.! !

!TDDBabyStepsGameBase methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:49:02'!
initializeToStep0

	currentStep := 0.
	state := GameStarting for: self.
	journey := TDDBabyStepsGameJourney new.
	self clearCurrentStepReturnMessage.
	penaltyTimer := difficultyConfiguration penaltyTimerClass withGameBase: self timeLimit: maxStepDuration penaltyScore: difficultyConfiguration penaltyTimerPenaltyScore.
	testCaseBuilder createTestCaseClass! !


!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/12/2024 06:48:38'!
decreaseScoreAsForcedNext

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedViaForceNext description: self class newLine, self forceNextMessage points: self forcedNextPointsCost negated. 
	
	currentStepReturnMessage updateAddingMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:47:15'!
decreaseScoreAsPrematureDecisionsMade

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForCantAdvancePrematureDecisionsMade description: self prematureDecisionsMadeMessage points: self prematureDecisionsMadePointsCost negated.
	
	currentStepReturnMessage updateAddingMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:47:19'!
decreaseScoreAsTestsDoNotPass

	| message |
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForCantAdvanceTestsDoNotPass description: self testsDoNotPassMessage points: self testsDoNotPassPointsCost negated.
	
	currentStepReturnMessage updateAddingMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:47:33'!
eliminateAllCurrentPositivePointsOnStepSolution

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForUsedStepSolution description: self revealStepSolutionMessage points: self scoreToSubstractForZeroPoints.
	
	self updateScoreWithMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:48:08'!
gameEndedGeneralizedIncorrectly
	
	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForGameEndedIncompleteGeneralization description: self gameEndedAndGeneralizedIncorrectlyMessage points: self scoreToSubstractForZeroPoints.
	
	self updateScoreWithMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/12/2024 02:11:37'!
increaseScore
	
	state increaseScore
	

	

! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:48:32'!
increaseScoreAsCurrentTestsPassed

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedBabyStepsCorrect description: self testPassedCorrectlyMessage points: self testsPassedBonusPoints.
	
	currentStepReturnMessage updateAddingMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:48:36'!
increaseScoreAsLatestTestPassedEarly

	| message |
	
	message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedTestAlreadyPassedPrematureDecisions description: self testPassedEarlyMessage points: self testPassedEarlyBonusPoints.
	
	currentStepReturnMessage updateAddingMessage: message! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/12/2024 07:01:13'!
score
 
	^ journey score + currentStepReturnMessage points! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 5/8/2024 18:49:44'!
scoreToSubstractForZeroPoints

	self score > 0 ifTrue: [ ^self score negated ] ifFalse: [ ^0 ]! !

!TDDBabyStepsGameBase methodsFor: 'score' stamp: 'NR 6/27/2024 12:51:08'!
updateScoreWithMessage: codedMessage
	
	currentStepReturnMessage updateAddingMessage: codedMessage.
	currentStepReturnMessage updateAddingDescription: ' Tu puntaje actual es de {1}.' format: { self score }
	
	! !


!TDDBabyStepsGameBase methodsFor: 'penalty timer' stamp: 'NR 6/16/2024 19:16:49'!
detectStepDurationInsideTimeLimits
	
	currentStepReturnMessage updateAddingMessage: penaltyTimer alertAfterMessage ! !

!TDDBabyStepsGameBase methodsFor: 'penalty timer' stamp: 'NR 6/27/2024 12:49:12'!
maxStepDuration

	^ maxStepDuration! !


!TDDBabyStepsGameBase methodsFor: 'generalizations' stamp: 'NR 6/16/2024 19:16:49'!
detectGeneralizationsMissingOnLastStep
	
	| detector |

	detector := difficultyConfiguration missingStepGeneralizationDetectorClass withGameBase: self forStep: currentStep -1 penaltyScore: difficultyConfiguration missingStepGeneralizationDetectorPenaltyScore.
	
	currentStepReturnMessage updateAddingMessage: detector alertAfterMessage 
! !

!TDDBabyStepsGameBase methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:49:57'!
runGeneralizationTestNumber: aTestNumber
	
	| genTest |
	
	aTestNumber = self totalNumberOfTests ifTrue: [ genTest := extraTest ] ifFalse: [ genTest := genCases at: aTestNumber ].
	
	^ self runShadowTest: genTest
	
	! !

!TDDBabyStepsGameBase methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:51:13'!
warnAboutPossibleGeneralizationsMissingBeforeCompletingStep
	
	| detector |
	
	difficultyConfiguration visibleSupportOptions 
		ifTrue: [ detector := difficultyConfiguration missingStepGeneralizationDetectorClass withGameBase: self forStep: currentStep.
				currentStepReturnMessage updateAddingMessage: detector warningBeforeMessage.
				currentStepReturnMessage hasConfirmationWarning ifFalse: [ self stepCompleted ] ] 
		ifFalse: [ self stepCompleted ]
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameBase class' category: #TDDBabyStepsGame!
TDDBabyStepsGameBase class
	instanceVariableNames: ''!

!TDDBabyStepsGameBase class methodsFor: 'instance creation' stamp: 'NR 6/22/2024 05:30:53'!
startNamed: aName withTestCaseBuilder: aTestCaseBuilder withExtraCase:extraCase withGenCases: genCases withSolutionModelBuilder: modelBuilder withUserSolutionSourceCodeRetriever: solutionSourceCode withDefinition: aDefinition withMaxStepDuration: aMaxStepDuration withDifficultyConfiguration: aDifficultyConfiguration
	
	^self new initializeNamed: aName withTestCaseBuilder: aTestCaseBuilder withExtraCase: extraCase withGenCases: genCases withSolutionModelBuilder: modelBuilder withUserSolutionSourceCodeRetriever: solutionSourceCode withDefinition: aDefinition withMaxStepDuration: aMaxStepDuration withDifficultyConfiguration: aDifficultyConfiguration ! !


!TDDBabyStepsGameBase class methodsFor: 'error messages' stamp: 'NR 5/3/2022 09:20:42'!
increaseScoreOnEndedGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego terminado.'! !

!TDDBabyStepsGameBase class methodsFor: 'error messages' stamp: 'NR 10/13/2022 06:13:34'!
increaseScoreOnStartingGameErrorMessage
	
	^ 'No se pueden sumar puntos de un juego que recíen comienza (sin tests).'! !


!TDDBabyStepsGameBase class methodsFor: 'journey' stamp: 'NR 5/12/2024 06:47:45'!
newLine

	^ String with: Character newLineCharacter
	
	! !


!classDefinition: #TDDBabyStepsGameCodedMessage category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameCodedMessage
	instanceVariableNames: 'codes description points confirmationWarningMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameCodedMessage methodsFor: 'evaluating' stamp: 'NR 6/27/2024 12:51:34'!
hasConfirmationWarning

	^ confirmationWarningMessage ~= ''! !

!TDDBabyStepsGameCodedMessage methodsFor: 'evaluating' stamp: 'NR 5/1/2024 07:52:36'!
ifNotEmpty: aBlock

	^description ifNotEmpty: aBlock! !


!TDDBabyStepsGameCodedMessage methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:51:21'!
codes

	^ codes! !

!TDDBabyStepsGameCodedMessage methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:51:28'!
confirmationWarning

	^ confirmationWarningMessage ! !

!TDDBabyStepsGameCodedMessage methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:51:31'!
description

	^ description! !

!TDDBabyStepsGameCodedMessage methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:51:52'!
points
	
	^ points! !


!TDDBabyStepsGameCodedMessage methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:51:39'!
initializeEmptyMessage

	codes := Set new.
	description := ''.
	points := 0.
	confirmationWarningMessage := ''! !

!TDDBabyStepsGameCodedMessage methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:51:43'!
initializeWith: aCode description: startingDescription

	codes := Set with: aCode.
	description := startingDescription.
	points := 0.
	confirmationWarningMessage := ''! !

!TDDBabyStepsGameCodedMessage methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:51:46'!
initializeWith: aCode description: startingDescription confirmationWarningMessage: warningMessage

	codes := Set with: aCode.
	description := startingDescription.
	confirmationWarningMessage := warningMessage.
	points := 0! !

!TDDBabyStepsGameCodedMessage methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:51:49'!
initializeWith: aCode description: startingDescription points: somePoints

	codes := Set with: aCode.
	description := startingDescription.
	points:= somePoints.
	confirmationWarningMessage := ''! !


!TDDBabyStepsGameCodedMessage methodsFor: 'updating' stamp: 'NR 5/1/2024 09:18:03'!
updateAddingDescription: newDescriptionPartToAdd
	
	description := description, newDescriptionPartToAdd! !

!TDDBabyStepsGameCodedMessage methodsFor: 'updating' stamp: 'NR 5/1/2024 19:31:06'!
updateAddingDescription: newDescriptionPartToAdd format: aCollection
	
	description := description, newDescriptionPartToAdd format: aCollection ! !

!TDDBabyStepsGameCodedMessage methodsFor: 'updating' stamp: 'NR 6/27/2024 12:51:59'!
updateAddingMessage: newMessagePartToAdd
	
	codes := codes union: newMessagePartToAdd codes.
	points := points + newMessagePartToAdd points.
	self updateAddingDescription: newMessagePartToAdd description.
	self updateAddingWarning: newMessagePartToAdd confirmationWarning.! !

!TDDBabyStepsGameCodedMessage methodsFor: 'updating' stamp: 'NR 6/27/2024 12:52:02'!
updateAddingWarning: newWarningPartToAdd
	
	confirmationWarningMessage := confirmationWarningMessage, newWarningPartToAdd! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameCodedMessage class' category: #TDDBabyStepsGame!
TDDBabyStepsGameCodedMessage class
	instanceVariableNames: ''!

!TDDBabyStepsGameCodedMessage class methodsFor: 'instance creation' stamp: 'NR 5/1/2024 19:15:39'!
emptyMessage

	^self new initializeEmptyMessage ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'instance creation' stamp: 'NR 5/1/2024 09:13:16'!
withCode: code description: startingDescription

	^self new initializeWith: code description: startingDescription! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'instance creation' stamp: 'NR 6/17/2024 06:16:09'!
withCode: code description: startingDescription confirmationWarningMessage: warningMessage

	^self new initializeWith: code description: startingDescription confirmationWarningMessage: warningMessage! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'instance creation' stamp: 'NR 5/8/2024 17:29:47'!
withCode: code description: startingDescription points: somePoints

	^self new initializeWith: code description: startingDescription points: somePoints ! !


!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:30'!
codeForAdvancedBabyStepsCorrect

	^ #AdvancedBabyStepCorrect! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:27'!
codeForAdvancedButTookTooLong

	^ #AdvancedButTookTooLong! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:36'!
codeForAdvancedMissingStepGeneralizations

	^ #AdvancedMissingStepGeneralizations! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:41'!
codeForAdvancedTestAlreadyPassedPrematureDecisions

	^ #AdvancedTestAlreadyPassedByPrematureDecisions! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:45'!
codeForAdvancedViaForceNext

	^ #AdvancedViaForceNext ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:49'!
codeForCantAdvancePrematureDecisionsMade

	^ #CantAdvanceBecausePrematureDecisionsWereMade! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:52'!
codeForCantAdvanceTestsDoNotPass

	^ #CantAdvanceTestsDoNotPass! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:10:57'!
codeForGameEndedCorrectGeneralization

	^ #GameEndedCorrectGeneralization ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:11:01'!
codeForGameEndedIncompleteGeneralization

	^ #GameEndedIncompleteGeneralization ! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:11:04'!
codeForGameReseted

	^ #GameReseted! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:11:08'!
codeForGameStarting

	^ #GameStarted! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:11:12'!
codeForUsedStepSolution

	^ #UsedStepSolution! !

!TDDBabyStepsGameCodedMessage class methodsFor: 'code definition' stamp: 'NR 6/16/2024 21:11:16'!
codeForWarningBeforeMissingGeneralizations

	^ #WarningBeforeMissingGeneralizations! !


!classDefinition: #TDDBabyStepsGameDifficultyConfiguration category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameDifficultyConfiguration
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:52:17'!
missingStepGeneralizationDetectorClass

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:52:20'!
missingStepGeneralizationDetectorPenaltyScore

	self subclassResponsibility! !


!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'logging' stamp: 'NR 5/14/2024 16:37:19'!
name

	self subclassResponsibility! !


!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:52:14'!
isUnlocked: aGameName

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'level progression' stamp: 'NR 5/14/2024 16:46:11'!
nextLevel

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:52:40'!
unlock: aGameName

	self subclassResponsibility! !


!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'UI' stamp: 'NR 6/27/2024 12:52:11'!
gameEndedMessageText

	^ ''.! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'UI' stamp: 'NR 6/27/2024 12:52:34'!
textForHelpLabelLine1

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'UI' stamp: 'NR 6/27/2024 12:52:36'!
textForHelpLabelLine2

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'UI' stamp: 'NR 5/14/2024 18:22:21'!
visibleSupportOptions

	self subclassResponsibility! !


!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'timer' stamp: 'NR 5/14/2024 19:02:40'!
formatTimerLine: lastStepTimestamp maxStepDuration: maxStepDuration

	^ ((DateAndTime now - lastStepTimestamp) truncateTo: (Duration seconds: 1)) asString! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'timer' stamp: 'NR 6/27/2024 12:52:27'!
penaltyTimerClass

	self subclassResponsibility! !

!TDDBabyStepsGameDifficultyConfiguration methodsFor: 'timer' stamp: 'NR 6/27/2024 12:52:30'!
penaltyTimerPenaltyScore

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameDifficultyConfiguration class' category: #TDDBabyStepsGame!
TDDBabyStepsGameDifficultyConfiguration class
	instanceVariableNames: ''!

!TDDBabyStepsGameDifficultyConfiguration class methodsFor: 'code definition' stamp: 'NR 5/14/2024 16:30:16'!
codeForExpertMode

	^ #ExpertMode
	! !

!TDDBabyStepsGameDifficultyConfiguration class methodsFor: 'code definition' stamp: 'NR 5/14/2024 16:30:35'!
codeForFirstRun

	^ #FirstRun
	! !

!TDDBabyStepsGameDifficultyConfiguration class methodsFor: 'code definition' stamp: 'NR 6/8/2024 21:49:20'!
codeForSupportUnlocked

	^ #SupportUnlocked
	! !


!classDefinition: #TDDBabyStepsExpertMode category: #TDDBabyStepsGame!
TDDBabyStepsGameDifficultyConfiguration subclass: #TDDBabyStepsExpertMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsExpertMode methodsFor: 'generalizations' stamp: 'NR 6/16/2024 19:19:37'!
missingStepGeneralizationDetectorClass 

	^ MissingStepGeneralizationExplicitWarningsAndAlerts
! !

!TDDBabyStepsExpertMode methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:53:04'!
missingStepGeneralizationDetectorPenaltyScore

	^ 1
! !


!TDDBabyStepsExpertMode methodsFor: 'timer' stamp: 'NR 5/14/2024 19:00:23'!
formatTimerLine: lastStepTimestamp maxStepDuration: maxStepDuration

	^ ((maxStepDuration - (DateAndTime now - lastStepTimestamp)) truncateTo: (Duration seconds: 1)) asString! !

!TDDBabyStepsExpertMode methodsFor: 'timer' stamp: 'NR 6/27/2024 12:53:09'!
penaltyTimerClass
	
	^ PenaltyTimerExplicitWarnings ! !

!TDDBabyStepsExpertMode methodsFor: 'timer' stamp: 'NR 6/27/2024 12:53:13'!
penaltyTimerPenaltyScore
	
	^ 1! !


!TDDBabyStepsExpertMode methodsFor: 'logging' stamp: 'NR 5/14/2024 16:37:19'!
name

	^ self class codeForExpertMode ! !


!TDDBabyStepsExpertMode methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:52:59'!
isUnlocked: aGameName

	^ true! !

!TDDBabyStepsExpertMode methodsFor: 'level progression' stamp: 'NR 5/14/2024 16:42:49'!
nextLevel

	^ self! !

!TDDBabyStepsExpertMode methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:53:22'!
unlock: aGameName
! !


!TDDBabyStepsExpertMode methodsFor: 'UI' stamp: 'NR 6/27/2024 12:53:16'!
textForHelpLabelLine1

	^ 'Expert Mode Challenge!!'! !

!TDDBabyStepsExpertMode methodsFor: 'UI' stamp: 'NR 6/27/2024 12:53:18'!
textForHelpLabelLine2

	^ 'All Support Features Disabled'! !

!TDDBabyStepsExpertMode methodsFor: 'UI' stamp: 'NR 5/14/2024 18:22:21'!
visibleSupportOptions

	^ false! !


!classDefinition: #TDDBabyStepsFirstRun category: #TDDBabyStepsGame!
TDDBabyStepsGameDifficultyConfiguration subclass: #TDDBabyStepsFirstRun
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsFirstRun methodsFor: 'generalizations' stamp: 'NR 6/16/2024 19:19:50'!
missingStepGeneralizationDetectorClass 

	^ MissingStepGeneralizationNoExplicitWarningsAndAlerts
! !

!TDDBabyStepsFirstRun methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:53:37'!
missingStepGeneralizationDetectorPenaltyScore

	^ 0

! !


!TDDBabyStepsFirstRun methodsFor: 'timer' stamp: 'NR 6/27/2024 12:53:43'!
penaltyTimerClass
	
	^ PenaltyTimerNoExplicitWarnings ! !

!TDDBabyStepsFirstRun methodsFor: 'timer' stamp: 'NR 6/27/2024 12:53:46'!
penaltyTimerPenaltyScore
	
	^ 0! !


!TDDBabyStepsFirstRun methodsFor: 'logging' stamp: 'NR 5/14/2024 16:37:19'!
name

	^ self class codeForFirstRun ! !


!TDDBabyStepsFirstRun methodsFor: 'UI' stamp: 'NR 6/27/2024 12:53:29'!
gameEndedMessageText

	^ TDDBabyStepsGameBase newLine, 'ATENCIÓN: Se han desbloqueado todas las opciones de SOPORTE al juego para las próximas corridas, entre las cuales están las soluciones paso a paso, la capacidad de resetear el juego para comenzar nuevamente, los avisos de omisión a generalizaciones posibles en un paso determinado, etc... Estas se mantendrán mientras se utilice el mismo Uuid de usuario. Presione RESET GAME para recomenzar...'! !

!TDDBabyStepsFirstRun methodsFor: 'UI' stamp: 'NR 6/27/2024 12:53:49'!
textForHelpLabelLine1

	^ 'First Run!!'! !

!TDDBabyStepsFirstRun methodsFor: 'UI' stamp: 'NR 6/27/2024 12:53:52'!
textForHelpLabelLine2

	^ 'All Support Features Disabled'! !

!TDDBabyStepsFirstRun methodsFor: 'UI' stamp: 'NR 5/14/2024 18:22:21'!
visibleSupportOptions

	^ false! !


!TDDBabyStepsFirstRun methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:53:32'!
isUnlocked: aGameName

	^ true! !

!TDDBabyStepsFirstRun methodsFor: 'level progression' stamp: 'NR 5/14/2024 16:43:33'!
nextLevel

	^ TDDBabyStepsSupportUnlocked new! !

!TDDBabyStepsFirstRun methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:53:54'!
unlock: aGameName
	
	! !


!classDefinition: #TDDBabyStepsSupportUnlocked category: #TDDBabyStepsGame!
TDDBabyStepsGameDifficultyConfiguration subclass: #TDDBabyStepsSupportUnlocked
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsSupportUnlocked methodsFor: 'generalizations' stamp: 'NR 6/16/2024 19:19:37'!
missingStepGeneralizationDetectorClass

	^ MissingStepGeneralizationExplicitWarningsAndAlerts
! !

!TDDBabyStepsSupportUnlocked methodsFor: 'generalizations' stamp: 'NR 6/27/2024 12:54:07'!
missingStepGeneralizationDetectorPenaltyScore

	^ 0

! !


!TDDBabyStepsSupportUnlocked methodsFor: 'timer' stamp: 'NR 6/27/2024 12:54:13'!
penaltyTimerClass
	
	^ PenaltyTimerExplicitWarnings ! !

!TDDBabyStepsSupportUnlocked methodsFor: 'timer' stamp: 'NR 6/27/2024 12:54:16'!
penaltyTimerPenaltyScore
	
	^ 0! !


!TDDBabyStepsSupportUnlocked methodsFor: 'logging' stamp: 'NR 5/14/2024 16:37:19'!
name

	^ self class codeForSupportUnlocked ! !


!TDDBabyStepsSupportUnlocked methodsFor: 'UI' stamp: 'NR 6/27/2024 12:54:19'!
textForHelpLabelLine1

	^ 'Warning: "Reveal..." and "Reset..." are destructive actions'! !

!TDDBabyStepsSupportUnlocked methodsFor: 'UI' stamp: 'NR 6/27/2024 12:54:22'!
textForHelpLabelLine2

	^ 'Your models and/or progression will be lost!!'! !

!TDDBabyStepsSupportUnlocked methodsFor: 'UI' stamp: 'NR 5/14/2024 18:22:21'!
visibleSupportOptions

	^ true! !


!TDDBabyStepsSupportUnlocked methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:54:02'!
isUnlocked: aGameName

	| user |
	
	user := TDDBabyStepsUniqueUser  new.
	^ user isGame: aGameName completedAtDifficulty: self class codeForSupportUnlocked ! !

!TDDBabyStepsSupportUnlocked methodsFor: 'level progression' stamp: 'NR 5/14/2024 16:43:52'!
nextLevel

	^ self! !

!TDDBabyStepsSupportUnlocked methodsFor: 'level progression' stamp: 'NR 6/27/2024 12:54:25'!
unlock: aGameName
	
	| user |
	
	user := TDDBabyStepsUniqueUser  new.
	user completedGame: aGameName atDifficulty: self class codeForSupportUnlocked ! !


!classDefinition: #TDDBabyStepsGameJourney category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameJourney
	instanceVariableNames: 'timeStampedJourney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameJourney methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:54:44'!
initialize
	
	timeStampedJourney := OrderedCollection new! !


!TDDBabyStepsGameJourney methodsFor: 'converting' stamp: 'NR 5/12/2024 08:03:35'!
formatToString

	^ timeStampedJourney reverse inject: '' into:[ :finalLog :aJournalEntry | finalLog, '- ', (aJournalEntry at: 'codedMessage') description , TDDBabyStepsGameBase newLine ]! !


!TDDBabyStepsGameJourney methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:54:47'!
lastAdvancedStepTimestamp

	| lastStepNumber |
	
	lastStepNumber := (timeStampedJourney lastIfEmpty: [ ^ self error: self class findLastStepTimestampOnEmptyJournalErrorMessage ]) at: 'stepNumber'.
	
	^ (timeStampedJourney detect: [ :journeyEntry | (journeyEntry at: 'stepNumber') = lastStepNumber]) at: 'timestamp'! !

!TDDBabyStepsGameJourney methodsFor: 'accessing' stamp: 'NR 6/27/2024 12:54:50'!
lastStepTakenIfNone: exceptionBlock

	^ timeStampedJourney lastIfEmpty: exceptionBlock ! !


!TDDBabyStepsGameJourney methodsFor: 'updating' stamp: 'NR 6/27/2024 12:54:35'!
add: aCodedMessage atStep: aStepNumber
	
	| journeyEntry |
	
	journeyEntry := Dictionary new.
	
	journeyEntry 
		at: 'timestamp' put: DateAndTime now;
		at: 'codedMessage' put: aCodedMessage;
		at: 'stepNumber' put: aStepNumber.
		
	timeStampedJourney add: journeyEntry
	
	! !


!TDDBabyStepsGameJourney methodsFor: 'points' stamp: 'NR 6/27/2024 12:54:53'!
score

	^ timeStampedJourney sum: [ :aJournalEntry | (aJournalEntry at: 'codedMessage') points ] ifEmpty: [ ^0 ]
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameJourney class' category: #TDDBabyStepsGame!
TDDBabyStepsGameJourney class
	instanceVariableNames: ''!

!TDDBabyStepsGameJourney class methodsFor: 'error message' stamp: 'NR 5/15/2024 05:37:49'!
findLastStepTimestampOnEmptyJournalErrorMessage

	^ 'El journey está vacio.'! !


!classDefinition: #TDDBabyStepsGameMissingStepGeneralizationDetector category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameMissingStepGeneralizationDetector
	instanceVariableNames: 'gameBase stepNumber result penaltyScore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:55:08'!
initializeWith: aGameBase forStep: aStepNumber

	self initializeWith: aGameBase forStep: aStepNumber penaltyScore: 0
	! !

!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:55:11'!
initializeWith: aGameBase forStep: aStepNumber penaltyScore: aScore

	gameBase := aGameBase.
	stepNumber := aStepNumber.
	penaltyScore := aScore! !


!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'tests' stamp: 'NR 6/27/2024 12:55:03'!
detect
	
	result := gameBase runGeneralizationTestNumber: stepNumber.
	^ result
	! !


!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'detection results' stamp: 'NR 6/16/2024 19:16:49'!
alertAfterMessage
	
	self subclassResponsibility ! !

!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'detection results' stamp: 'NR 6/27/2024 12:55:15'!
penaltyScore

	^ penaltyScore ! !

!TDDBabyStepsGameMissingStepGeneralizationDetector methodsFor: 'detection results' stamp: 'NR 6/16/2024 19:18:42'!
warningBeforeMessage
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameMissingStepGeneralizationDetector class' category: #TDDBabyStepsGame!
TDDBabyStepsGameMissingStepGeneralizationDetector class
	instanceVariableNames: ''!

!TDDBabyStepsGameMissingStepGeneralizationDetector class methodsFor: 'initialization' stamp: 'NR 5/8/2024 19:30:57'!
withGameBase: aGameBase forStep: aStepNumber

	^self new initializeWith: aGameBase forStep: aStepNumber ! !

!TDDBabyStepsGameMissingStepGeneralizationDetector class methodsFor: 'initialization' stamp: 'NR 5/14/2024 05:42:26'!
withGameBase: aGameBase forStep: aStepNumber penaltyScore: aScore

	^self new initializeWith: aGameBase forStep: aStepNumber penaltyScore: aScore ! !


!classDefinition: #MissingStepGeneralizationExplicitWarningsAndAlerts category: #TDDBabyStepsGame!
TDDBabyStepsGameMissingStepGeneralizationDetector subclass: #MissingStepGeneralizationExplicitWarningsAndAlerts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!MissingStepGeneralizationExplicitWarningsAndAlerts methodsFor: 'messages' stamp: 'NR 6/16/2024 19:41:00'!
afterMissingStepGeneralizationAlertMessage
	
	| message |
	
	message := gameBase class newLine, 'Atención: Se podría haber generalizado en el paso anterior. Prestar atención a potenciales refactors antes de presionar Next.'.
	
	penaltyScore > 0 ifTrue: [message :=' Restás {1} punto/s.' format: { penaltyScore }].
	
	^message! !

!MissingStepGeneralizationExplicitWarningsAndAlerts methodsFor: 'messages' stamp: 'NR 6/27/2024 12:55:26'!
beforeMissingStepGeneralizationWarningMessage
	
	| message |
	
	message := 'Atención: Antes de seguir avanzando es posible generalizar/refactorizar (paso 3).'.
	
	^message! !


!MissingStepGeneralizationExplicitWarningsAndAlerts methodsFor: 'detection results' stamp: 'NR 6/16/2024 22:47:41'!
alertAfterMessage
	
	result isNil ifTrue: [ self detect ].
	
	result hasPassed
		ifFalse: [ ^ TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedMissingStepGeneralizations description: self afterMissingStepGeneralizationAlertMessage points: self penaltyScore negated ] 
		ifTrue: [ ^ TDDBabyStepsGameCodedMessage emptyMessage ]
		 ! !

!MissingStepGeneralizationExplicitWarningsAndAlerts methodsFor: 'detection results' stamp: 'NR 6/27/2024 12:55:29'!
warningBeforeMessage
	
	result isNil ifTrue: [ self detect ].
	
	result hasPassed
		ifFalse: [ | message | 
				message := TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForWarningBeforeMissingGeneralizations description: self beforeMissingStepGeneralizationWarningMessage confirmationWarningMessage: self beforeMissingStepGeneralizationWarningMessage. 
				message updateAddingWarning: gameBase class newLine, '¿Continuar de todas maneras? '.
				^ message ] 
		ifTrue: [ ^ TDDBabyStepsGameCodedMessage emptyMessage ]
		 ! !


!classDefinition: #MissingStepGeneralizationNoExplicitWarningsAndAlerts category: #TDDBabyStepsGame!
TDDBabyStepsGameMissingStepGeneralizationDetector subclass: #MissingStepGeneralizationNoExplicitWarningsAndAlerts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!MissingStepGeneralizationNoExplicitWarningsAndAlerts methodsFor: 'detection results' stamp: 'NR 6/16/2024 22:47:09'!
alertAfterMessage

	result isNil ifTrue: [ self detect ].

	result hasPassed
		ifFalse: [ ^ TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedMissingStepGeneralizations description: '' ] 
		ifTrue: [ ^ TDDBabyStepsGameCodedMessage emptyMessage ]
	! !

!MissingStepGeneralizationNoExplicitWarningsAndAlerts methodsFor: 'detection results' stamp: 'NR 6/16/2024 22:46:51'!
warningBeforeMessage

	^ TDDBabyStepsGameCodedMessage emptyMessage! !


!classDefinition: #TDDBabyStepsGamePenaltyTimer category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGamePenaltyTimer
	instanceVariableNames: 'gameBase penaltyScore timeLimit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGamePenaltyTimer methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:55:44'!
initializeWith: aGameBase timeLimit: maxDuration

	self initializeWith: aGameBase timeLimit: maxDuration penaltyScore: 0! !

!TDDBabyStepsGamePenaltyTimer methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:55:48'!
initializeWith: aGameBase timeLimit: maxDuration penaltyScore: aScore 

	gameBase := aGameBase.
	penaltyScore  := 	aScore.
	timeLimit := maxDuration! !


!TDDBabyStepsGamePenaltyTimer methodsFor: 'points' stamp: 'NR 6/27/2024 12:55:51'!
penaltyScore

	^ penaltyScore ! !


!TDDBabyStepsGamePenaltyTimer methodsFor: 'timers' stamp: 'NR 6/27/2024 12:55:40'!
finalTimeForStep
	
	^ DateAndTime now - gameBase lastAdvancedStepTimestamp
	
	
	! !

!TDDBabyStepsGamePenaltyTimer methodsFor: 'timers' stamp: 'NR 6/27/2024 12:55:54'!
tookTooLong

	^ self finalTimeForStep > timeLimit 
	! !


!TDDBabyStepsGamePenaltyTimer methodsFor: 'messages' stamp: 'NR 6/16/2024 19:16:49'!
alertAfterMessage
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGamePenaltyTimer class' category: #TDDBabyStepsGame!
TDDBabyStepsGamePenaltyTimer class
	instanceVariableNames: ''!

!TDDBabyStepsGamePenaltyTimer class methodsFor: 'instance creation' stamp: 'NR 5/12/2024 07:25:03'!
withGameBase: aGameBase timeLimit: maxDuration 

	^ self new initializeWith: aGameBase timeLimit: maxDuration! !

!TDDBabyStepsGamePenaltyTimer class methodsFor: 'instance creation' stamp: 'NR 5/14/2024 05:45:06'!
withGameBase: aGameBase timeLimit: maxDuration penaltyScore: aScore

	^ self new initializeWith: aGameBase timeLimit: maxDuration penaltyScore: aScore ! !


!classDefinition: #PenaltyTimerExplicitWarnings category: #TDDBabyStepsGame!
TDDBabyStepsGamePenaltyTimer subclass: #PenaltyTimerExplicitWarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!PenaltyTimerExplicitWarnings methodsFor: 'points' stamp: 'NR 6/27/2024 12:56:02'!
pointsToSubstract: timeDifference
	
	| penaltyTimeZones |
	
	penaltyTimeZones := OrderedCollection with: timeLimit with: timeLimit * 2 with: timeLimit * 3 with: timeLimit * 4 with: timeLimit *5.
      
  	^ (((penaltyTimeZones detect: [ :duration | timeDifference <= duration	 ] ifNone:[ timeLimit * 6 ]) / timeLimit) - 1) * self penaltyScore! !


!PenaltyTimerExplicitWarnings methodsFor: 'messages' stamp: 'NR 6/27/2024 12:55:59'!
alertAfterMessage
	
	| timeDifference pointsToSubstract |
	
	timeDifference := self finalTimeForStep.
	
	(timeDifference <= timeLimit)
		ifFalse: [pointsToSubstract := self pointsToSubstract: timeDifference.
			^ TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedButTookTooLong description: (self tookTooLongWarningMessage: pointsToSubstract) points: pointsToSubstract negated ] 
		ifTrue: [ ^ TDDBabyStepsGameCodedMessage emptyMessage ]
	! !

!PenaltyTimerExplicitWarnings methodsFor: 'messages' stamp: 'NR 6/27/2024 12:56:05'!
tookTooLongWarningMessage: pointsToSubstract
	
	| message |
	
	message := gameBase class newLine, 'Atención: Se tardó demasiado tiempo en completar el paso anterior. Trate de dar pasos más simples y/o pequeños.'.
	
	penaltyScore > 0 ifTrue: [message :=message,' Restás {1} punto/s. {2} por cada {3} extras utilizados (hasta MAX de {4} punto/s).' format: { pointsToSubstract. penaltyScore. timeLimit. penaltyScore * 5}].
	
	^message! !


!classDefinition: #PenaltyTimerNoExplicitWarnings category: #TDDBabyStepsGame!
TDDBabyStepsGamePenaltyTimer subclass: #PenaltyTimerNoExplicitWarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!PenaltyTimerNoExplicitWarnings methodsFor: 'messages' stamp: 'NR 6/27/2024 12:56:12'!
alertAfterMessage

	self tookTooLong  
		ifTrue: [ ^ TDDBabyStepsGameCodedMessage withCode: TDDBabyStepsGameCodedMessage codeForAdvancedButTookTooLong description: '' ] 
		ifFalse: [ ^ TDDBabyStepsGameCodedMessage emptyMessage ]
	! !


!classDefinition: #TDDBabyStepsGameRestInterface category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameRestInterface
	instanceVariableNames: 'codesForGameName codesForGameDifficulty'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRestInterface methodsFor: 'configuration' stamp: 'NR 6/8/2024 09:04:23'!
port
	
	^ 80
	

	
	
! !

!TDDBabyStepsGameRestInterface methodsFor: 'configuration' stamp: 'NR 6/8/2024 18:24:16'!
url

	^ 'http://babysteps.aeon.com.ar:', self port asString
	
		
	
	
! !


!TDDBabyStepsGameRestInterface methodsFor: 'request' stamp: 'NR 6/27/2024 11:10:08'!
asyncRequest: requestName parameters: fieldDict onFailure: aBlockContingencyHandler

	[ | resp |			
		[
			resp := WebClient htmlSubmit: (self url,'/',requestName) fields: fieldDict method: 'POST'.
						
			resp isSuccess ifFalse:aBlockContingencyHandler.
			
		] on: Error do: []
	
	] fork
! !

!TDDBabyStepsGameRestInterface methodsFor: 'request' stamp: 'NR 6/10/2024 09:52:16'!
request: requestName parameters: fieldDict onFailure: aBlockContingencyHandler
	
	[| resp |			
		resp := WebClient htmlSubmit: (self url,'/',requestName) fields: fieldDict.		
					
		resp isSuccess 
			ifTrue:[^ WebUtils jsonDecode: ((resp content) readStream)] 
			ifFalse:[^ aBlockContingencyHandler value: resp content].
			
	] on: Error do: [:anError | aBlockContingencyHandler value: anError messageText]
		
		
		
	
	
! !


!TDDBabyStepsGameRestInterface methodsFor: 'encoding' stamp: 'NR 6/8/2024 17:29:58'!
codeForGameDifficulty: aGameDifficultyConfiguration

	^ codesForGameDifficulty at: aGameDifficultyConfiguration! !

!TDDBabyStepsGameRestInterface methodsFor: 'encoding' stamp: 'NR 6/8/2024 17:29:51'!
codeForGameName: aGameName
	
	^ codesForGameName at: aGameName ! !

!TDDBabyStepsGameRestInterface methodsFor: 'encoding' stamp: 'NR 6/21/2024 08:41:37'!
correctlyEncodeSpecialSymbolsForGetRequest: textWithSpecialSymbols
	
	"was needed for the GET version... now it works using POST..."
	"^ textWithSpecialSymbols asUnaccented copyReplaceAll: ' ' with: '%20'"
	
	^ textWithSpecialSymbols

		! !

!TDDBabyStepsGameRestInterface methodsFor: 'encoding' stamp: 'NR 6/27/2024 10:46:26'!
correctlyEncodeSpecialSymbolsForJsonUtils: textWithSpecialSymbols
	
	"was needed for the GET version... now it works using POST..."
	"^ (textWithSpecialSymbols asUnaccented copyReplaceAll: '¡' with: '!!') copyReplaceAll: 'ñ' with: 'n'"
	
	^ textWithSpecialSymbols copyReplaceAll: '+' with: '##**##'! !


!TDDBabyStepsGameRestInterface methodsFor: 'initialization' stamp: 'NR 6/8/2024 17:11:39'!
codesForGameDifficulty
	
	^Dictionary new
		at: TDDBabyStepsGameDifficultyConfiguration codeForFirstRun put: 0;
		at: TDDBabyStepsGameDifficultyConfiguration codeForSupportUnlocked put: 1;
		at: TDDBabyStepsGameDifficultyConfiguration codeForExpertMode put: 2;
		yourself ! !

!TDDBabyStepsGameRestInterface methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:56:21'!
codesForGameName
	
	^Dictionary new
		at: 'Contador' put: 0;
		at: 'Rot13' put: 1;
		at: 'PrimeFactors' put: 2;
		at: 'Anagrams' put: 3;
		at: 'RomanNumerals' put: 4;
		at: 'RomanToArabig' put: 5;
		at: 'Minesweeper' put: 7;
		at: 'Bowling' put: 8;
		yourself ! !

!TDDBabyStepsGameRestInterface methodsFor: 'initialization' stamp: 'NR 6/8/2024 17:13:01'!
initialize
	
	codesForGameName := self codesForGameName.
	codesForGameDifficulty := self codesForGameDifficulty ! !


!classDefinition: #TDDBabyStepsGameRestLogger category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameRestLogger
	instanceVariableNames: 'loggedSteps beginningTimestamp gameId gameDifficultyId gameEndedRecord restInterface codesForStepResults'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameRestLogger methodsFor: 'encoding' stamp: 'NR 6/8/2024 17:31:10'!
codeForStepResults: aStepResult

	^ codesForStepResults at: aStepResult ! !

!TDDBabyStepsGameRestLogger methodsFor: 'encoding' stamp: 'NR 6/27/2024 10:39:27'!
encodeGameEndedRecordToJsonAndDictionaryToSend

	| fieldDict jsonGameEndedRecord |
	
	jsonGameEndedRecord := WebUtils jsonEncode: gameEndedRecord.
	fieldDict := Dictionary new.
	fieldDict at: 'dict' put: (restInterface correctlyEncodeSpecialSymbolsForGetRequest: jsonGameEndedRecord).
	
	^ fieldDict
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'encoding' stamp: 'NR 6/25/2024 09:40:10'!
formatDurationAsString: aDuration

	| d h m s n aStream |
	
	aStream := ReadWriteStream on: String new.
	
	d := aDuration days abs.
	h := aDuration hours abs.
	m := aDuration minutes abs.
 	s := aDuration seconds abs truncated.
	n := aDuration nanoSeconds abs. 	aDuration negative ifTrue: [ aStream nextPut: $- ].
	d printOn: aStream length: 3 zeroPadded: true. aStream nextPut: $:.
	h printOn: aStream length: 2 zeroPadded: true. aStream nextPut: $:.
	m printOn: aStream length: 2 zeroPadded: true. aStream nextPut: $:.
	s printOn: aStream length: 2 zeroPadded: true.
	n = 0 ifFalse: [
		| z ps |
		aStream nextPut: $..
		ps := n printString padded: #left to: 9 with: $0. 
		z := ps findLast: [ :c | c digitValue > 0 ].
		z := #(3 6 9) detect: [ :ez | ez >= z ].	"print either milliseconds, microseconds or nanoseconds"
		ps from: 1 to: z do: [ :c | aStream nextPut: c ] ].
	
	^ aStream contents! !


!TDDBabyStepsGameRestLogger methodsFor: 'subscribe to' stamp: 'NR 6/27/2024 12:56:43'!
followGameEndingEventOn: aGameView

	aGameView addGameEndingObserver: [:aPossibleAbruptEndingStatus :aScore :aGrade | self gameEnded: aPossibleAbruptEndingStatus withFinalScore: aScore andGrade: aGrade ]! !

!TDDBabyStepsGameRestLogger methodsFor: 'subscribe to' stamp: 'NR 6/27/2024 12:56:46'!
followGameJourneyChangesOn: aGameView

	aGameView addGameJourneyObserver: [:aCodedMessage :aStepNumber :aSolutionSourceCode | self updateGameJourney: aCodedMessage step: aStepNumber  solutionSourceCode: aSolutionSourceCode ]! !

!TDDBabyStepsGameRestLogger methodsFor: 'subscribe to' stamp: 'NR 5/14/2024 16:35:48'!
followGameStartedEventOn: aGameView

	aGameView addGameStartedObserver: [ :aGameName :aGameDifficulty | self startingGame: aGameName on: aGameDifficulty ]! !


!TDDBabyStepsGameRestLogger methodsFor: 'event handlers' stamp: 'NR 6/25/2024 09:39:17'!
gameEnded: aPosssibleAbruptEndingStatus withFinalScore: aScore andGrade: aGrade
	
	|  fieldDict nowTimestamp user |
	
	gameEndedRecord := Dictionary new.
	nowTimestamp :=  DateAndTime now.
	user := TDDBabyStepsUniqueUser new.
	
	gameEndedRecord 
		at: 'beginningTimestamp' put: beginningTimestamp asString;
		at: 'endingTimestamp' put: nowTimestamp asString;
		at: 'totalTime' put: (self formatDurationAsString: ((nowTimestamp - beginningTimestamp) roundTo: (Duration milliSeconds: 1)));
		at: 'userId' put: user userId;
		at: 'userName' put: (restInterface correctlyEncodeSpecialSymbolsForJsonUtils: user userName);
		at: 'courseFaculty' put: (restInterface correctlyEncodeSpecialSymbolsForJsonUtils: user courseFaculty);
		at: 'gameId' put: gameId;
		at: 'steps' put: loggedSteps asArray;
		at: 'gameDifficultyid' put: gameDifficultyId;
		at: 'reset' put: aPosssibleAbruptEndingStatus;
		at: 'finalPoints' put: aScore;
		at: 'finalGrade' put: aGrade.
	
	fieldDict := self encodeGameEndedRecordToJsonAndDictionaryToSend.
	
	restInterface asyncRequest: self requestName parameters: fieldDict onFailure: self sendLighterPayloadOnFailure
	! !

!TDDBabyStepsGameRestLogger methodsFor: 'event handlers' stamp: 'NR 6/8/2024 19:19:18'!
startingGame: aGameName on: aGameDifficulty
	
	loggedSteps := OrderedCollection new.
	beginningTimestamp := DateAndTime now.
	gameId := restInterface codeForGameName: aGameName.
	gameDifficultyId := restInterface codeForGameDifficulty: aGameDifficulty
	
		
		
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'event handlers' stamp: 'NR 6/8/2024 17:34:42'!
updateGameJourney: codedMessage step: stepNumber solutionSourceCode: aSolutionSC
	
	| stepRecord descriptionFixed aSolutionSCFixed |
	
	stepRecord := Dictionary new.
	
	descriptionFixed := restInterface correctlyEncodeSpecialSymbolsForJsonUtils: codedMessage description.
	aSolutionSCFixed := restInterface correctlyEncodeSpecialSymbolsForJsonUtils:  aSolutionSC.
	
	 stepRecord 
		at: 'stepTimestamp' put: DateAndTime now asString;
		at: 'stepNumber' put: stepNumber;
		at: 'stepResult' put: ((codedMessage codes collect:[ :code | self codesForStepResults at: code ]) asArray);
		at: 'sourceCode' put: aSolutionSCFixed;
		at: 'description' put: descriptionFixed;
		at: 'points' put: codedMessage points.
		
	loggedSteps add: stepRecord
	

	! !


!TDDBabyStepsGameRestLogger methodsFor: 'initialization' stamp: 'NR 6/16/2024 19:34:21'!
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
		at: TDDBabyStepsGameCodedMessage codeForAdvancedMissingStepGeneralizations put: 9;
		at: TDDBabyStepsGameCodedMessage codeForAdvancedButTookTooLong put: 10;
		at: TDDBabyStepsGameCodedMessage codeForWarningBeforeMissingGeneralizations put: 11;
		yourself ! !

!TDDBabyStepsGameRestLogger methodsFor: 'initialization' stamp: 'NR 6/8/2024 17:28:06'!
initialize

	restInterface := TDDBabyStepsGameRestInterface new.
	codesForStepResults := 	self codesForStepResults ! !


!TDDBabyStepsGameRestLogger methodsFor: 'rest interface' stamp: 'NR 5/25/2024 17:03:33'!
deleteSourceCodeSolutionsFromGameEndedRecordButLast

	| steps |
	
	steps := (gameEndedRecord at: 'steps').
	1 to: steps size -1 do: [ :i | (steps at: i) at: 'sourceCode' put: '' ]
	! !

!TDDBabyStepsGameRestLogger methodsFor: 'rest interface' stamp: 'NR 6/27/2024 12:56:36'!
deleteStepDescriptionsFromGameEndedRecord

	(gameEndedRecord at: 'steps') do: [ :step | step at: 'description' put: '' ]

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'rest interface' stamp: 'NR 6/12/2024 21:58:10'!
requestName

	^ 'babysteps/toDatabasePost'! !

!TDDBabyStepsGameRestLogger methodsFor: 'rest interface' stamp: 'NR 6/27/2024 12:56:58'!
sendLighterPayloadOnFailure

	^ [ | fieldDict |
	self deleteStepDescriptionsFromGameEndedRecord.
	fieldDict := self encodeGameEndedRecordToJsonAndDictionaryToSend.
	self asyncRequest: self requestName parameters: fieldDict onFailure: self sendLightestPayloadOnFailure ]
	
	
	

	! !

!TDDBabyStepsGameRestLogger methodsFor: 'rest interface' stamp: 'NR 5/25/2024 01:56:41'!
sendLightestPayloadOnFailure

	^ [ | fieldDict |
	self deleteSourceCodeSolutionsFromGameEndedRecordButLast.
	fieldDict := self encodeGameEndedRecordToJsonAndDictionaryToSend.
	self asyncRequest: self requestName parameters: fieldDict onFailure: [] ]
	
	
	

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameRestLogger class' category: #TDDBabyStepsGame!
TDDBabyStepsGameRestLogger class
	instanceVariableNames: ''!

!TDDBabyStepsGameRestLogger class methodsFor: 'instance creation' stamp: 'NR 5/1/2024 22:47:04'!
followGameView: aGameView
	
	^self new followGameJourneyChangesOn: aGameView;
		followGameStartedEventOn: aGameView;
		followGameEndingEventOn:  aGameView ! !


!classDefinition: #TDDBabyStepsGameState category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameState
	instanceVariableNames: 'gameBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameState methodsFor: 'initialization' stamp: 'NR 6/21/2024 23:04:27'!
initializeWith: aGameBase

	gameBase := aGameBase! !


!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 08:11:07'!
forceNext
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 5/3/2022 07:49:44'!
increaseScore
	
	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 9/25/2022 18:18:58'!
next

	self subclassResponsibility! !

!TDDBabyStepsGameState methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
stepSolution

	gameBase stepSolutionOnOngoingGame! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameState class' category: #TDDBabyStepsGame!
TDDBabyStepsGameState class
	instanceVariableNames: ''!

!TDDBabyStepsGameState class methodsFor: 'instance creation' stamp: 'NR 6/21/2024 23:04:02'!
for: aGameBase
	
	^ self new initializeWith: aGameBase! !


!classDefinition: #GameEnded category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #GameEnded
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameEnded methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
forceNext
	
	gameBase nextOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
increaseScore

	gameBase increaseScoreOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
next
	
	gameBase nextOnEndedGame! !

!GameEnded methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
stepSolution
	
	gameBase stepSolutionOnNotOngoingGame! !


!classDefinition: #GameStarting category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #GameStarting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!GameStarting methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
forceNext
	
	gameBase nextOnStartingGame! !

!GameStarting methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
increaseScore

	gameBase increaseScoreOnStartingGame! !

!GameStarting methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
next
	
	gameBase nextOnStartingGame! !

!GameStarting methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
stepSolution
	
	gameBase stepSolutionOnNotOngoingGame! !


!classDefinition: #OnNormalStep category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #OnNormalStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
forceNext

	gameBase forceNextOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
increaseScore

	gameBase increaseScoreOnNormalStep! !

!OnNormalStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
next

	gameBase nextOnNormalStep! !


!classDefinition: #OnPrematureDecisionStep category: #TDDBabyStepsGame!
TDDBabyStepsGameState subclass: #OnPrematureDecisionStep
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
forceNext

	gameBase forceNextOnNormalStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
increaseScore

	gameBase increaseScoreOnPrematureDecisionStep! !

!OnPrematureDecisionStep methodsFor: 'game actions' stamp: 'NR 6/21/2024 23:04:18'!
next

	gameBase nextOnNormalStep! !


!classDefinition: #TDDBabyStepsGameViewModel category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsGameViewModel
	instanceVariableNames: 'model stepResult gameJourneyObservers gameStartedObservers gameEndingObservers stepStartTimestamp gameStartTimestamp previousStepDuration previousStep previousStepPoints confirmationWarningReceiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsGameViewModel methodsFor: 'initialization' stamp: 'NR 6/27/2024 12:57:20'!
clearGameView

	previousStep := model currentStep.
	stepResult := ''.
	previousStepPoints  := model score! !

!TDDBabyStepsGameViewModel methodsFor: 'initialization' stamp: 'NR 5/11/2024 23:29:59'!
initializeFor: aGame
	
	model := aGame.
	"gameJourneyObservers := WeakIdentitySet new."
	gameJourneyObservers := OrderedCollection new.
	gameStartedObservers := OrderedCollection new.
	gameEndingObservers := OrderedCollection new.
	
	self clearGameView! !


!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 5/11/2024 19:48:49'!
currentStep

	^ model currentStep! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 9/25/2022 18:19:36'!
forceNext

	self informResultOf: [ model forceNext ]! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 6/27/2024 12:57:40'!
informResultOf: aNextStepBlock
	
	previousStep := self currentStep.

	aNextStepBlock value.
	
	self informStepResult! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 9/24/2022 20:39:39'!
next
	
	self informResultOf: [ model next ]
! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 6/17/2024 07:28:36'!
nextAfterConfirmingWarning

	self informResultOf: [ model nextAfterConfirmingWarning ]! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 6/7/2024 16:52:48'!
resetGame
	
	self notifyPossibleReset.
	model clearUserSolutionAndTests.
	self clearGameView.
	self informStart! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 5/11/2024 23:33:37'!
score

	^ model score! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 6/27/2024 12:58:33'!
start

	model browseTestCase. 
	model clearUserSolutionAndTests.
	self informStart! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 5/11/2024 23:33:52'!
stepSolution
	
	self informResultOf: [ model stepSolution ]
	! !

!TDDBabyStepsGameViewModel methodsFor: 'steps' stamp: 'NR 6/27/2024 12:58:43'!
totalNumberOfTests

	^ model totalNumberOfTests ! !


!TDDBabyStepsGameViewModel methodsFor: 'statements' stamp: 'NR 6/27/2024 12:57:31'!
formatJourney

	^ model journeyInString ! !

!TDDBabyStepsGameViewModel methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:07'!
openDefinition

	TextModel new contents: model definition; openLabel: 'Enunciado ', model name! !

!TDDBabyStepsGameViewModel methodsFor: 'statements' stamp: 'NR 9/25/2022 18:20:10'!
openHelp

	TextModel new contents: model help; openLabel: model name, ' Ayuda'! !


!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 5/11/2024 20:23:19'!
gameAdvancedToNextStep

	^ previousStep < model currentStep! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 5/11/2024 19:39:46'!
gameJourneyText
	
	^ self formatJourney! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 6/27/2024 12:57:43'!
informStart
	
	stepStartTimestamp:= DateAndTime now. 
	gameStartTimestamp:= DateAndTime now.
	
	self notifyGameStartedObservers: model name
	
! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 6/21/2024 21:55:04'!
informStepResult
	
	| stepResultCodedMessage |
	
	stepResultCodedMessage := (model lastStepTakenIfNone: [ ^self ]) at:'codedMessage'.
      
	self gameAdvancedToNextStep 
		ifTrue: [ 		self resetStepCounters.
				self notifyGameJourneyObservers: stepResultCodedMessage withSolutionSourceCode: model userSolutionSourceCodeRetriever.
				model gameHasEnded ifTrue: [self notifyGameEndingObserversGameReallyFinished ]
		]
		ifFalse: [		self notifyGameJourneyObservers: stepResultCodedMessage withSolutionSourceCode: ''.
				stepResultCodedMessage hasConfirmationWarning ifTrue: [ self requestConfirmationOnWarning: stepResultCodedMessage ] 
		].
	! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 6/27/2024 12:58:27'!
resetStepCounters

	previousStepDuration := DateAndTime now - stepStartTimestamp.
	stepStartTimestamp:= DateAndTime now! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 5/11/2024 19:48:12'!
stepResultText
	
	^ stepResult! !

!TDDBabyStepsGameViewModel methodsFor: 'private' stamp: 'NR 5/11/2024 19:44:13'!
stepResultText: aTextToShow

	stepResult := aTextToShow ! !


!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 6/27/2024 12:57:56'!
notifyGameEndingObservers: aPosssibleAbruptEndingStatus withScore: aScore andGrade: aGrade

	gameEndingObservers do: [ :anObserver | anObserver value: aPosssibleAbruptEndingStatus value: aScore value: aGrade ]
! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 5/15/2024 07:05:12'!
notifyGameEndingObserversGameReallyFinished

	| aPosssibleAbruptEndingStatus |
	
	aPosssibleAbruptEndingStatus := false.
	self notifyGameEndingObservers: aPosssibleAbruptEndingStatus withScore: model score andGrade: model formatedGradeAsString ! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 5/15/2024 07:04:32'!
notifyGameEndingObserversNotFinishedResettedGame
	
	| aPosssibleAbruptEndingStatus |
	
	aPosssibleAbruptEndingStatus := true.
	self notifyGameEndingObservers: aPosssibleAbruptEndingStatus withScore: -1  andGrade: '-1'
! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 6/27/2024 12:58:02'!
notifyGameJourneyObservers: codedMessage withSolutionSourceCode: currentSolutionSC
	
	gameJourneyObservers do: [ :anObserver | anObserver value: codedMessage value: self currentStep value: currentSolutionSC ]
! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 5/14/2024 16:37:19'!
notifyGameStartedObservers: aGameName

	gameStartedObservers do: [ :anObserver | anObserver value: aGameName value: model difficultyConfiguration name ]
! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 6/7/2024 16:52:48'!
notifyPossibleReset

	^ (model gameHasEnded or: [ model gameHasJustStarted ]) ifFalse:[ self notifyGameEndingObserversNotFinishedResettedGame ]! !

!TDDBabyStepsGameViewModel methodsFor: 'notify observers' stamp: 'NR 6/17/2024 07:28:36'!
requestConfirmationOnWarning: codedMessage

	"So far the only confirmation warning is the current step missing generalizations... No need to make it more complex..."
	
	confirmationWarningReceiver value: codedMessage confirmationWarning value: [ self nextAfterConfirmingWarning ] value: []. 
! !


!TDDBabyStepsGameViewModel methodsFor: 'observer suscription' stamp: 'NR 5/1/2024 22:39:47'!
addGameEndingObserver: observer

	gameEndingObservers add: observer

! !

!TDDBabyStepsGameViewModel methodsFor: 'observer suscription' stamp: 'NR 5/1/2024 21:14:00'!
addGameJourneyObserver: observer

	gameJourneyObservers add: observer

! !

!TDDBabyStepsGameViewModel methodsFor: 'observer suscription' stamp: 'NR 5/1/2024 22:39:24'!
addGameStartedObserver: observer

	gameStartedObservers add: observer

! !

!TDDBabyStepsGameViewModel methodsFor: 'observer suscription' stamp: 'NR 6/27/2024 12:57:23'!
confirmationWarningReceiver: suscriber

	confirmationWarningReceiver := suscriber

! !


!TDDBabyStepsGameViewModel methodsFor: 'difficulty' stamp: 'NR 5/14/2024 16:39:45'!
difficultyConfiguration

	^ model difficultyConfiguration ! !


!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:57:37'!
gameStartTimestamp
	
	 ^ gameStartTimestamp ! !

!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:57:48'!
maxStepDuration

	^ model maxStepDuration ! !

!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:58:12'!
previousStepDuration
	
	 ^ previousStepDuration ! !

!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:58:16'!
previousStepPoints
	
	 ^ previousStepPoints! !

!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:58:19'!
previousStepPoints: stepPoints
	
	 previousStepPoints := stepPoints ! !

!TDDBabyStepsGameViewModel methodsFor: 'timers' stamp: 'NR 6/27/2024 12:58:40'!
stepStartTimestamp
	
	 ^ stepStartTimestamp ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsGameViewModel class' category: #TDDBabyStepsGame!
TDDBabyStepsGameViewModel class
	instanceVariableNames: ''!

!TDDBabyStepsGameViewModel class methodsFor: 'instance creation' stamp: 'NR 4/30/2024 06:47:31'!
for: aGame

	^ self new initializeFor: aGame! !


!classDefinition: #TDDBabyStepsSolutionModelBuilder category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsSolutionModelBuilder
	instanceVariableNames: 'stepSolutionModels resetBlock testCaseBuilder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsSolutionModelBuilder methodsFor: 'initialization' stamp: 'NR 6/27/2024 13:00:29'!
initializeWithModels: theStepSolutionModels withTestCaseBuilder: aTestCaseBuilder reset: aResetBlock

	stepSolutionModels := theStepSolutionModels.
	testCaseBuilder := aTestCaseBuilder.
	resetBlock := aResetBlock ! !


!TDDBabyStepsSolutionModelBuilder methodsFor: 'model building' stamp: 'NR 6/22/2024 07:20:34'!
buildSolutionForStep: stepNumber

	^ [ self buildForStep: stepNumber ] 
	on: Error 
	do: [	 self removeUserModelSolution. 
		testCaseBuilder removeAllTests.
		testCaseBuilder createTestCaseClass.
		testCaseBuilder addToTheTestCaseClassAllTestsUntilStep: stepNumber.
		self buildForStep: stepNumber ]
		

	! !

!TDDBabyStepsSolutionModelBuilder methodsFor: 'model building' stamp: 'NR 6/22/2024 02:26:27'!
removeUserModelSolution

	^ Compiler evaluate: resetBlock! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsSolutionModelBuilder class' category: #TDDBabyStepsGame!
TDDBabyStepsSolutionModelBuilder class
	instanceVariableNames: ''!

!TDDBabyStepsSolutionModelBuilder class methodsFor: 'instance creation' stamp: 'NR 6/22/2024 05:25:12'!
withModels: stepSolutionModels withTestCaseBuilder: aTestCaseBuilder reset: aResetBlock

	^ self new initializeWithModels: stepSolutionModels withTestCaseBuilder: aTestCaseBuilder reset: aResetBlock ! !


!classDefinition: #AbsoluteCompleteModelBuilder category: #TDDBabyStepsGame!
TDDBabyStepsSolutionModelBuilder subclass: #AbsoluteCompleteModelBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!AbsoluteCompleteModelBuilder methodsFor: 'building - private' stamp: 'NR 6/21/2024 22:56:05'!
buildForStep: stepNumber

	^ Compiler evaluate: (stepSolutionModels at: stepNumber) 
! !


!classDefinition: #IncrementalPartialModelBuilder category: #TDDBabyStepsGame!
TDDBabyStepsSolutionModelBuilder subclass: #IncrementalPartialModelBuilder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!IncrementalPartialModelBuilder methodsFor: 'building - private' stamp: 'NR 6/21/2024 22:56:30'!
buildForStep: stepNumber

	 ^ 1 to: stepNumber do: [ :step | Compiler evaluate: (stepSolutionModels at: step) ]! !


!classDefinition: #TDDBabyStepsTestCaseBuilder category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsTestCaseBuilder
	instanceVariableNames: 'name testCases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsTestCaseBuilder methodsFor: 'initialization' stamp: 'NR 6/27/2024 13:00:56'!
initializeWithCases: theTestCases forGameNamed: aName

	testCases := theTestCases.
	name := aName! !


!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/22/2024 07:18:20'!
addToTheTestCaseClassAllTestsUntilStep: stepNumber

	1 to: stepNumber do: [ :step | self addToTheTestCaseClassTestForStep: step ]! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/22/2024 07:15:22'!
addToTheTestCaseClassTestForStep: step

	^ self testCaseClass compile: (testCases at: step) classified: 'tests'! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/27/2024 13:00:48'!
compileTestFromMethod: aTestMethod

	^ self testCaseClass compile: aTestMethod classified: 'tests'! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/27/2024 13:00:52'!
createTestCaseClass

	Compiler evaluate: self testCaseDefinition! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/27/2024 13:01:20'!
testSuite

	^ TestSuite forClass: self testCaseClass! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test building' stamp: 'NR 6/27/2024 13:01:23'!
testSuiteForTest: aTestSelector

	^ TestSuite forCompiledMethod: self testCaseClass >> aTestSelector! !


!TDDBabyStepsTestCaseBuilder methodsFor: 'test removing' stamp: 'NR 6/27/2024 13:00:59'!
removeAllTests

	self testCaseClass selectors do:  [ :selector | self testCaseClass removeSelector: selector ].
	self testCaseClass removeFromSystem! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'test removing' stamp: 'NR 6/27/2024 13:01:02'!
removeTest: testSelector

	self testCaseClass removeSelector: testSelector! !


!TDDBabyStepsTestCaseBuilder methodsFor: 'definition' stamp: 'NR 6/22/2024 07:07:29'!
testCaseCategory

	^ 'TDDBabyStepsGame', name capitalized! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'definition' stamp: 'NR 6/27/2024 13:01:09'!
testCaseClass

	^ Smalltalk at: self testCaseName ! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'definition' stamp: 'NR 6/27/2024 13:01:11'!
testCaseDefinition

	^ 'TestCase subclass: #{1}
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''{2}''' format: {self testCaseName. self testCaseCategory }! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'definition' stamp: 'NR 6/27/2024 13:01:17'!
testCaseName

	^ ('TDDBabySteps{1}Test' format: { name capitalized }) asSymbol! !


!TDDBabyStepsTestCaseBuilder methodsFor: 'accessing' stamp: 'NR 6/27/2024 13:01:14'!
testCaseForStep: step

	^ testCases at: step! !

!TDDBabyStepsTestCaseBuilder methodsFor: 'accessing' stamp: 'NR 6/27/2024 13:01:26'!
totalNumberOfTests

	^ testCases size! !


!TDDBabyStepsTestCaseBuilder methodsFor: 'browse tests' stamp: 'NR 6/27/2024 13:00:45'!
browseTestCase

	BrowserWindow fullOnClass: self testCaseClass! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsTestCaseBuilder class' category: #TDDBabyStepsGame!
TDDBabyStepsTestCaseBuilder class
	instanceVariableNames: ''!

!TDDBabyStepsTestCaseBuilder class methodsFor: 'as yet unclassified' stamp: 'NR 6/22/2024 05:27:26'!
withCases: testCases forGameNamed: aName
	
	^ self new initializeWithCases: testCases forGameNamed: aName ! !


!classDefinition: #TDDBabyStepsUniqueUser category: #TDDBabyStepsGame!
Object subclass: #TDDBabyStepsUniqueUser
	instanceVariableNames: 'userId userName courseFaculty gameDifficultiesCompleted restInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGame'!

!TDDBabyStepsUniqueUser methodsFor: 'initialization' stamp: 'NR 6/10/2024 09:55:41'!
cleanGameDifficultiesAchieved

	^ gameDifficultiesCompleted :=  Set new! !

!TDDBabyStepsUniqueUser methodsFor: 'initialization' stamp: 'NR 6/8/2024 18:46:45'!
courseFactoryDefaultName

	^ 'ISW1-FCEN-UBA'! !

!TDDBabyStepsUniqueUser methodsFor: 'initialization' stamp: 'NR 6/10/2024 10:13:55'!
initialize

	restInterface := TDDBabyStepsGameRestInterface new.
	courseFaculty := self courseFactoryDefaultName.
	self initializeUserId 
! !

!TDDBabyStepsUniqueUser methodsFor: 'initialization' stamp: 'NR 6/7/2024 17:17:45'!
initializeUserId
	
	self userId: (UUIDGenerator default generateRandomBitsOfLength: 56)
	
	
! !

!TDDBabyStepsUniqueUser methodsFor: 'initialization' stamp: 'NR 6/7/2024 08:32:15'!
initializeUserName
	
	userName := Utilities authorName
	
	
! !


!TDDBabyStepsUniqueUser methodsFor: 'asserting' stamp: 'NR 6/27/2024 13:01:34'!
assertValidUuid: anUuid

	anUuid isNumber ifFalse: [ self error: self class uuidNotANumberErrorMessage ].
	
	(anUuid between: 0 and: self maxInt64Value) ifFalse: [ self error: self class uuidExceeds64bitsNumberErrorMessage ]

	

	! !

!TDDBabyStepsUniqueUser methodsFor: 'asserting' stamp: 'NR 6/27/2024 13:02:09'!
maxInt64Value

	^ 9223372036854775807! !


!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/10/2024 10:41:11'!
changeLoggedUser: anUuid

	self assertValidUuid: anUuid.
		
	userId := anUuid.
	self backupUserId.
	self cleanGameDifficultiesAchieved! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/7/2024 08:31:40'!
courseFaculty
	
	^ courseFaculty! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/7/2024 08:31:51'!
courseFaculty: aCourseFaculty
	
	courseFaculty := aCourseFaculty! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/7/2024 07:27:07'!
userId
	
	userId isNil ifTrue: [ self initializeUserId ].
	
	^userId
! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/10/2024 10:40:56'!
userId: anUuid
	
	(anUuid ~= userId) ifTrue: [ self changeLoggedUser: anUuid ]
	! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/7/2024 08:32:29'!
userName
	
	userName isNil ifTrue: [ self initializeUserName ].

	^ userName! !

!TDDBabyStepsUniqueUser methodsFor: 'accessing' stamp: 'NR 6/7/2024 08:31:08'!
userName: aUserName
	
	userName := aUserName! !


!TDDBabyStepsUniqueUser methodsFor: 'game difficulties completion' stamp: 'NR 6/27/2024 13:01:47'!
completedGame: aGameName atDifficulty: aGameDifficulty

	gameDifficultiesCompleted add: (aGameName -> aGameDifficulty)! !

!TDDBabyStepsUniqueUser methodsFor: 'game difficulties completion' stamp: 'NR 6/8/2024 21:39:46'!
isGame: aGameName completedAtDifficulty: aGameDifficulty

	^ (gameDifficultiesCompleted includes: (aGameName -> aGameDifficulty)) 
		ifTrue: [^ true ] 
		ifFalse:[ (self isGame: aGameName completedInTheServersLogAtDifficulty: aGameDifficulty)
				 ifTrue:[  self completedGame: aGameName atDifficulty: aGameDifficulty. ^ true ]
				ifFalse:[ ^ false ] ]

	! !

!TDDBabyStepsUniqueUser methodsFor: 'game difficulties completion' stamp: 'NR 6/8/2024 19:25:15'!
isGame: aGameName completedInTheServersLogAtDifficulty: aGameDifficulty
	
	| fieldDict gameDifficultyId gameId |
	
	gameId := restInterface codeForGameName: aGameName.
	gameDifficultyId := restInterface codeForGameDifficulty: aGameDifficulty.
	
	fieldDict := Dictionary newFromPairs: {'userUuid'. userId . 'gameId'. gameId. 'gameDifficultyId'. gameDifficultyId}.		
	
	^ restInterface request: self requestName parameters: fieldDict onFailure: [ :errorContent | ^ false ]
		! !

!TDDBabyStepsUniqueUser methodsFor: 'game difficulties completion' stamp: 'NR 6/8/2024 19:16:12'!
requestName

	^ 'babysteps/isGameDifficultyCompletedFor'
		! !


!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/7/2024 07:58:02'!
backupFilename

	^ 'babyStepsUuids.txt'! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/27/2024 13:01:39'!
backupUserId

	(self isUuidAlreadyLoggedLast: userId asString) ifFalse: [ self fileOutUuidAsBackup: userId ]
	
	! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/7/2024 08:31:30'!
backupUuidHistoryAsStream

	self backupUuidHistoryFileEntry 	assureExistence.
	^ReadStream on: self backupUuidHistoryFileEntry fileContents 
	! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/7/2024 07:58:02'!
backupUuidHistoryFileEntry

	^ (DirectoryEntry smalltalkImageDirectory // self backupFilename) asFileEntry! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/7/2024 07:57:15'!
fileOutUuidAsBackup: anUuidAsString

	self backupUuidHistoryFileEntry appendStreamDo: [ :fileStream |fileStream nextPutAll: anUuidAsString asString; newLine ]! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/27/2024 13:01:56'!
findLastBackupUuid: stream
	
	| lastLineRead line |
	
	[ (line := stream nextLine) notNil ] whileTrue: [ lastLineRead := line ].
	^ lastLineRead
	! !

!TDDBabyStepsUniqueUser methodsFor: 'file out' stamp: 'NR 6/27/2024 13:02:06'!
isUuidAlreadyLoggedLast: anUuidAsString

	| lastUuid |
	
	lastUuid := self findLastBackupUuid: self backupUuidHistoryAsStream.
	^(lastUuid = anUuidAsString)
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TDDBabyStepsUniqueUser class' category: #TDDBabyStepsGame!
TDDBabyStepsUniqueUser class
	instanceVariableNames: 'uniqueInstance'!

!TDDBabyStepsUniqueUser class methodsFor: 'class initialization' stamp: 'NR 5/2/2024 16:00:03'!
initialize

	uniqueInstance := self basicNew initialize! !


!TDDBabyStepsUniqueUser class methodsFor: 'instance creation' stamp: 'NR 5/2/2024 15:53:38'!
new

	^uniqueInstance! !


!TDDBabyStepsUniqueUser class methodsFor: 'error messages' stamp: 'NR 6/8/2024 06:18:42'!
uuidExceeds64bitsNumberErrorMessage

	^ 'Max signed 64 bits number exceeded.'! !

!TDDBabyStepsUniqueUser class methodsFor: 'error messages' stamp: 'NR 6/8/2024 06:13:17'!
uuidNotANumberErrorMessage

	^ 'Invalid Uuid. Uuid must be a number.'! !

TDDBabyStepsUniqueUser initialize!