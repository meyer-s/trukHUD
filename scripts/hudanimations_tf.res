// sample animation script
//
//
// commands:
//	Animate <panel name> <variable> <target value> <interpolator> <start time> <duration>
//		variables:
//			FgColor
//			BgColor
//			Position
//			Size
//			Blur		(hud panels only)
//			TextColor	(hud panels only)
//			Ammo2Color	(hud panels only)
//			Alpha		(hud weapon selection only)
//			SelectionAlpha  (hud weapon selection only)
//			TextScan	(hud weapon selection only)
//
//		interpolator:
//			Linear
//			Accel - starts moving slow, ends fast
//			Deaccel - starts moving fast, ends slow
//			Spline - simple ease in/out curve
//			Pulse - < freq > over the duration, the value is pulsed (cosine) freq times ending at the dest value (assuming freq is integral)
//			Flicker - < randomness factor 0.0 to 1.0 > over duration, each frame if random # is less than factor, use end value, otherwise use prev value
//
//	RunEvent <event name> <start time>
//		starts another even running at the specified time
//
//	StopEvent <event name> <start time>
//		stops another event that is current running at the specified time
//
//	StopAnimation <panel name> <variable> <start time>
//		stops all animations refering to the specified variable in the specified panel
//
//	StopPanelAnimations <panel name> <start time>
//		stops all active animations operating on the specified panel
//
//  SetFont <panel name> <fontparameter> <fontname from scheme> <set time> 
//
//	SetTexture <panel name> <textureidname> <texturefilename> <set time>
//
//  SetString <panel name> <string varname> <stringvalue> <set time>

event LevelInit
{
}

event OpenWeaponSelectionMenu
{
	StopEvent CloseWeaponSelectionMenu	0.0
	StopEvent WeaponPickup				0.0

	// make the display visible
	Animate HudWeaponSelection Alpha 		"128"		Linear 0.0 0.1
	Animate HudWeaponSelection SelectionAlpha 	"255"	Linear 0.0 0.1
	Animate HudWeaponSelection FgColor		"FgColor"	Linear 0.0 0.1
	//Animate HudWeaponSelection TextColor	"BrightFg"	Linear 0.0 0.1
	Animate HudWeaponSelection TextScan		"1" 		Linear 0.0 0.1
}

event CloseWeaponSelectionMenu
{
	StopEvent CloseWeaponSelectionMenu	0.0
	StopEvent WeaponPickup				0.0

	// make the display visible
	Animate HudWeaponSelection Alpha 		"128"		Linear 0.0 0.1
	Animate HudWeaponSelection SelectionAlpha 	"255"	Linear 0.0 0.1
	Animate HudWeaponSelection FgColor		"FgColor"	Linear 0.0 0.1
	//Animate HudWeaponSelection TextColor	"BrightFg"	Linear 0.0 0.1
	Animate HudWeaponSelection TextScan		"1" 		Linear 0.0 0.1
}


event MenuOpen
{
	StopEvent	MenuClose 0.0 

	// fade in
	Animate HudMenu Alpha 		"255"		Linear 0.0 0.1
	Animate HudMenu SelectionAlpha 	"255"		Linear 0.0 0.1
	Animate HudMenu FgColor		"FgColor"		Linear 0.0 0.1
	Animate HudMenu MenuColor		"MenuColor"	Linear  0.0 0.1
	Animate HudMenu ItemColor		"ItemColor"	Linear 0.0 0.1
	Animate HudMenu TextScan		"1"		Linear 0.0 0.1

	// Undo any blur
	Animate HudMenu		Blur		"1"			Linear	0.0		0.01
}

event MenuClose
{	
	// Hide it
	Animate HudMenu Alpha 		"0" Linear 0.0 1
	Animate HudMenu SelectionAlpha 	"0" Linear 0.0 1
	Animate HudMenu FgColor		"0 0 0 0" Linear 0.0 1
	Animate HudMenu MenuColor		"0 0 0 0" Linear 0.0 1
	Animate HudMenu ItemColor		"0 0 0 0" Linear 0.0 1
}

event MenuPulse
{
	Animate HudMenu		Blur		"7"			Linear	0.0		0.1
	Animate HudMenu		Blur		"2"			Deaccel	0.1		0.1
	Animate HudMenu		Blur		"7"			Linear	0.2		0.1
	Animate HudMenu		Blur		"2"			Deaccel	0.3		0.1
	Animate HudMenu		Blur		"7"			Linear	0.4		0.1
	Animate HudMenu		Blur		"2"			Deaccel	0.5		0.1
	Animate	HudMenu		Blur		"1"			Deaccel	0.6		0.4
}

event TimerIncrement
{
	Animate HudTimer		Blur		"7"			Linear	0.0	0.1
	Animate HudTimer		Blur		"2"			Deaccel	0.1		0.8
	Animate	HudTimer		Blur		"0"			Deaccel	1.1		1.5
}

event TimerDecrement
{
	Animate HudTimer		Blur		"7"			Linear	0.0	0.1
	Animate HudTimer		Blur		"2"			Deaccel	0.1		0.8
	Animate	HudTimer		Blur		"0"			Deaccel	1.1		1.5
}


event ResourceIncrement
{
	Animate HudResources		Blur			"3"			Linear	0.0	0.0
	Animate HudResources		PulseAmount		"0"			Linear	0.0	0.01
	Animate HudResources		Blur			"1"			Deaccel	0.1	1.5
	Animate HudResources		PulseAmount		"1"			Linear	0.1	2

	Animate HudResources		PulseAmount		"0"			Linear	2	2
}

event ResourceDecrement
{
	Animate HudResources		Blur			"7"			Linear	0.0	0.0
	Animate HudResources		PulseAmount		"0"			Linear	0.0	0.01
	Animate HudResources		Blur			"1"			Deaccel	0.1	1.5
	Animate HudResources		PulseAmount		"1"			Linear	0.1	2

	Animate HudResources		PulseAmount		"0"			Linear	2	2
}

event ResourcePickup
{
	Animate HudResourcesPickup	Alpha			"255"			Linear	0	0
	Animate HudResourcesPickup	Position		"80 r40"		Linear	0	0
	Animate HudResourcesPickup	Position		"80 r120"		Deaccel	0	1
	Animate HudResourcesPickup	Blur			"7"			Deaccel 0	0.2
	Animate HudResourcesPickup	Alpha			"0"			Deaccel	.8	0.2
	Animate	HudResourcesPickup	Blur		"1"			Deaccel	0.2	0.3
}

event HintMessageShow
{
	Animate HudHintDisplay HintSize	"1"		Deaccel 0.0	0.3
	Animate HudHintDisplay FgColor	"FgColor" 	Linear 0.4      0.4

	// flash text
	Animate HudHintDisplay FgColor	"FgColor" 	Linear 1.5 0.01
	Animate HudHintDisplay FgColor	"255 220 0 255" Linear 2.0 0.2
	Animate HudHintDisplay FgColor	"FgColor" 	Linear 2.2 0.2
	Animate HudHintDisplay FgColor	"255 220 0 255" Linear 3.0 0.2
	Animate HudHintDisplay FgColor	"FgColor" 	Linear 3.2 0.2

	// hide the panel after a while	
	Animate HudHintDisplay FgColor	"255 220 0 0"   Linear  10.0 	0.2
	Animate HudHintDisplay HintSize	"0"		Deaccel 10.2	0.3
}


event HintMessageHide
{
	Animate HudHintDisplay FgColor	"255 220 0 0"   Linear  0.0 	0.2
	Animate HudHintDisplay HintSize	"0"		Deaccel 0.2	0.3
}

event KeyHintMessageShow
{
	// show the hints
	Animate HudHintKeyDisplay Alpha	255 Linear 0.0 0.5

	// flash text
	Animate HudHintKeyDisplay FgColor	"FgColor" 	Linear 0.0 0.01
	Animate HudHintKeyDisplay FgColor	"255 220 0 255" Linear 0.5 0.2
	Animate HudHintKeyDisplay FgColor	"FgColor" 	Linear 0.7 0.2
	Animate HudHintKeyDisplay FgColor	"255 220 0 255" Linear 1.5 0.2
	Animate HudHintKeyDisplay FgColor	"FgColor" 	Linear 1.7 0.2

	// hide the panel after a while	
	Animate HudHintKeyDisplay Alpha	0 Linear 12.0 1.0
}

event KeyHintMessageHide
{
	Animate HudHintKeyDisplay Alpha	0 Linear 0.0 0.5
}

//===========================================

//Health Bonus Pulse
event HudHealthBonusPulse
{
	Animate	PlayerStatusHealthBonusImage 	Alpha		"150"		Linear 0.0 0.2
	Animate	PlayerStatusHealthBonusImage 	Alpha		"75"		Linear 0.2 0.2
	
	Animate PlayerStatusHealthValue			FgColor		"OmpHPBuff"	Accel 0.0 0.0
	Animate PlayerStatusHealthValueSpec		FgColor		"OmpSpecHPBuff"	Accel 0.0 0.0

	RunEvent HudHealthBonusPulseLoop	0.4
}

// call to loop HudHealthBonusPulse
event HudHealthBonusPulseLoop
{
	RunEvent HudHealthBonusPulse 0.0
}

event HudHealthBonusPulseStop
{
	Animate PlayerStatusHealthValue			FgColor		"OmpHP"		Accel 0.0 0.0
	Animate PlayerStatusHealthValueSpec		FgColor		"OmpSpecHP"		Accel 0.0 0.0

	StopEvent HudHealthBonusPulse 0.0
	StopEvent HudHealthBonusPulseLoop 0.0
}

//===========================================

//Health Dying Pulse
event HudHealthDyingPulse
{
	Animate	PlayerStatusHealthBonusImage 	Alpha		"255"		Linear 0.0 0.075
	Animate	PlayerStatusHealthBonusImage 	Alpha		"0"			Linear 0.125 0.075
	
	Animate PlayerStatusHealthValue			FgColor		"OmpHPLow"	Accel 0.0 0.0
	Animate PlayerStatusHealthValueSpec		FgColor		"OmpSpecHPLow"	Accel 0.0 0.0
	
	RunEvent HudHealthDyingPulseLoop	0.25
}

// call to loop HudHealthDyingPulse
event HudHealthDyingPulseLoop
{
	RunEvent HudHealthDyingPulse 0.0
}

event HudHealthDyingPulseStop
{
	Animate PlayerStatusHealthValue			FgColor		"OmpHP"		Accel 0.0 0.0
	Animate PlayerStatusHealthValueSpec		FgColor		"OmpSpecHP"		Accel 0.0 0.0
	
	StopEvent HudHealthDyingPulse 0.0
	StopEvent HudHealthDyingPulseLoop 0.0
}

//===========================================

event HudLowAmmoPulse
{
	Animate	HudWeaponLowAmmoImage		Alpha		"255"		Linear 0.0 0.075
	Animate	HudWeaponLowAmmoImage		Alpha		"0"			Linear 0.125 0.075
	
	//Animate AmmoInClip			FgColor		"OmpAmmoClipLow1"	Linear 0.0 0.075
	//Animate AmmoInClip			FgColor		"OmpAmmoClipLow2"	Linear 0.125 0.075

	//Animate AmmoInReserve		FgColor		"OmpAmmoReserveLow1"	Linear 0.0 0.075
	//Animate AmmoInReserve		FgColor		"OmpAmmoReserveLow2"	Linear 0.125 0.075

	//Animate AmmoNoClip			FgColor		"OmpAmmoClipLow1"	Linear 0.0 0.075
	//Animate AmmoNoClip			FgColor		"OmpAmmoClipLow2"	Linear 0.125 0.075

	RunEvent HudLowAmmoPulseLoop	0.25
}

// call to loop HudLowAmmoPulse
event HudLowAmmoPulseLoop
{
	RunEvent HudLowAmmoPulse 0.0
}

event HudLowAmmoPulseStop
{
	StopEvent HudLowAmmoPulse 0.0
	StopEvent HudLowAmmoPulseLoop 0.0

	//Animate AmmoInClip		FgColor		"OmpAmmoClip"		Accel 0.0 0.0
	//Animate AmmoInReserve	FgColor		"OmpAmmoReserve"	Accel 0.0 0.0
	//Animate AmmoNoClip		FgColor		"OmpAmmoClip"		Accel 0.0 0.0
}

//===========================================

event ControlPointIconShrink
{
	Animate HudControlPointIcons icon_expand "0" Linear 0.0 0.2
}

event ControlPointIconGrow
{
	Animate HudControlPointIcons icon_expand "4" Linear 0.0 0.2
}

// Metal Account

//activecolor - instantly turn red, fade back to yellow
event AccountMoneyRemoved
{
	Animate HudAccount		FgColor	"HudIcon_Red" Linear 0.0 0.0001
	Animate HudAccount		FgColor	"OrangeDim" Accel 0.0 3.0

	Animate	HudAccount		Ammo2Color "HudIcon_Red" Linear 0.0 0.0001
	Animate HudAccount		Ammo2Color "0 0 0 0" Accel 0.0 3.0
}

//activecolor - instantly turn green, fade back to yellow
event AccountMoneyAdded
{
	Animate HudAccount		FgColor	"HudIcon_Green" Linear 0.0 0.0001
	Animate HudAccount		FgColor	"OrangeDim" Accel 0.0 3.0

	Animate HudAccount		Ammo2Color "HudIcon_Green" Accel 0.0 0.0001
	Animate HudAccount		Ammo2Color "0 0 0 0" Accel 0.0 3.0
}

event AccountMoneyInvisible
{
	Animate HudAccount		FgColor	"OrangeDim" Accel 0.0 0.0001
	Animate HudAccount		Ammo2Color "0 0 0 0" Accel 0.0 0.0001
}

//===========================================

event FlagOutlineHide
{
	Animate OutlineImage	Alpha		"0"				Linear 0.0 0.1
}

// Local player flag pickup/drop
event FlagOutline
{
	RunEvent FlagOutlineHide 0.0
	Animate OutlineImage	Alpha		"255"			Linear 0.1 0.2
	
	Animate OutlineImage	Position	"c-200 140"		Linear 0.1 0.2
	Animate OutlineImage	Size		"400 200"		Linear 0.1 0.2

	Animate OutlineImage	Position	"c-50 r137"		Linear 0.7 0.2	[$WIN32]
	Animate OutlineImage	Position	"c-50 r158"		Linear 0.7 0.2	[$X360]
	Animate OutlineImage	Size		"100 50"		Linear 0.7 0.2
	
	Animate OutlineImage	Alpha		"0"				Linear 0.9 0.1
}

//===========================================

// Spy Disguise
event HudSpyDisguiseChanged
{
	//Animate PlayerStatusSpyOutlineImage		Alpha		"255"			Linear 0.0 0.2
	
	//Animate PlayerStatusSpyOutlineImage		Position	"c-200 c-200"	Linear 0.0 0.2
	//Animate PlayerStatusSpyOutlineImage		Size		"400 400"		Linear 0.0 0.2

	RunEvent HudSpyDisguiseHide	0.7
}

event HudSpyDisguiseHide
{
	//Animate PlayerStatusSpyOutlineImage		Position	"3 413"			Linear 0.0 0.2
	//Animate PlayerStatusSpyOutlineImage		Size		"55 55"			Linear 0.0 0.2
	
	//Animate PlayerStatusSpyOutlineImage		Alpha		"0"				Linear 0.2 0.1
}

event HudSpyDisguiseFadeIn
{
	RunEvent HudSpyDisguiseChanged	0
	//Animate PlayerStatusSpyImage			Alpha		"255"			Linear 0.9 0.1	
	Animate PlayerStatusClassImage			Alpha		"255"			Linear 0.0 0.0
}

event HudSpyDisguiseFadeOut
{
	RunEvent HudSpyDisguiseChanged	0
	//Animate PlayerStatusSpyImage			Alpha		"0"				Linear 0.9 0.1	
	Animate PlayerStatusClassImage			Alpha		"0"			Linear 0.0 0.0
}

//===========================================

// Show the Overtime panel
event OvertimeShow
{
	Animate OvertimeLabel				Alpha		"255"			Linear 0.0 0.1	
	Animate OvertimeBG					Alpha		"255"			Linear 0.0 0.1	
}


event HudSnapShotReminderIn
{
	Animate ScreenshotPanel		Position	"c-83 -50"	Linear 0.0 0.001
	Animate ScreenshotPanel		Position	"c-83 13"	Spline 0.001 0.2
}

event HudReplayReminderIn	// Places the replay reminder in the same place as the snapshot reminder
{
	Animate ReplayReminder		Position	"c-83 -50"	Linear 0.0 0.001
	Animate ReplayReminder		Position	"c-83 13"	Spline 0.001 0.2
}

event HudReplayReminderIn2	// Puts the panel below the snapshot panel
{
	Animate ReplayReminder		Position	"c-83 -50"	Linear 0.0 0.001
	Animate ReplayReminder		Position	"c-83 53"	Spline 0.001 0.2
}

event HudReplayTipIn
{
	Animate ReplayTip			Position	"10 -100"	Linear 0.0 0.001
	Animate ReplayTip			Position	"10 6"		Spline 0.001 0.1
}

event HudReplayTipOut
{
	Animate ReplayTip			Position	"10 6"		Linear 0.0 0.001
	Animate ReplayTip			Position	"10 -100"	Spline 0.001 0.1
}

event HudTournamentSetupPanelOpen
{
	Animate HudTournamentSetup	Position	"c-60 -70"	Linear 0.0 0.001
	Animate HudTournamentSetup	Position	"c-60 64"	Spline 0.001 0.2
}

event HudTournamentSetupPanelClose
{
	Animate HudTournamentSetup	Position	"c-60 64"	Linear 0.0 0.001
	Animate HudTournamentSetup	Position	"c-60 -70"	Spline 0.001 0.2
}


//====================================

// Flash the medic charge hud when we have full charge

event HudMedicCharged
{
	Animate	ChargeLabel 	FgColor		"OmpMedicCharge1"		Linear 0.0 0.1
	Animate	ChargeLabel 	FgColor		"OmpMedicCharge2"		Linear 0.3 0.4
	
	Animate	ChargeMeter 	FgColor		"OmpMedicCharge1"		Linear 0.0 0.1
	Animate	ChargeMeter 	FgColor		"OmpMedicCharge2"		Linear 0.3 0.4

	RunEvent HudMedicChargedLoop	0.6
}

// call to loop HudHealthBonusPulse
event HudMedicChargedLoop
{
	RunEvent HudMedicCharged 0.0
}

event HudMedicChargedStop
{
	StopEvent HudMedicCharged 0.0
	StopEvent HudMedicChargedLoop 0.0
	
	Animate	ChargeLabel 	FgColor		"OmpAmmoClip"		Linear 0.0 0.0001
	Animate	ChargeMeter 	FgColor		"255 255 255 255"		Linear 0.0 0.0001
}

//====================================

event VideoCaptionFadeIn
{
	Animate VideoCaption	Alpha		"255"			Linear 0.0 0.1
}

event VideoCaptionFadeOut
{
	Animate VideoCaption	Alpha		"0"				Linear 0.0 0.1
}

//====================================

// arena

event ArenaVsPanelOnShow
{
	Animate bluepanel	Position	"-200 50"	Linear 0.0 0.001
	Animate redpanel	Position	"r-200 140"	Linear 0.0 0.001
	Animate vslabel	Alpha	"0"		Linear 0.0 0.001
		
	RunEvent ArenaVsPanelSlideIn	1.0
	RunEvent ArenaVsPanelSlideOut	4.8
}

event ArenaVsPanelSlideIn
{
	Animate bluepanel	Position	"c-100 50"	Spline 0.0 0.2
	Animate redpanel	Position	"c-100 140"	Spline 0.0 0.2
	Animate vslabel	Alpha	"255"	Linear 0.15 0.2
}

event ArenaVsPanelSlideOut
{
	Animate bluepanel	Position	"-200 50"	Spline 0.0 0.2	
	Animate redpanel	Position	"r-200 140"	Spline 0.0 0.2
	Animate vslabel	Alpha	"0"		Linear 0.0 0.05
}

//===========================================

//Cart Alarm Pulse
event HudCartAlarmPulse
{
	Animate	EscortItemImageAlert 	Alpha		"160"		Linear 0.0 0.3
	Animate	EscortItemImageAlert 	Alpha		"0"		Linear 0.6 0.3
	
	RunEvent HudCartAlarmPulseLoop	1.2
}

event HudCartAlarmPulseLoop
{
	RunEvent HudCartAlarmPulse 0.0
}

event HudCartAlarmPulseStop
{
	StopEvent HudCartAlarmPulse 0.0
	StopEvent HudCartAlarmPulseLoop 0.0
}

//===========================================

// Active Timer BG Pulse
event ActiveTimerBGPulse
{
	Animate	ActiveTimerBG 	Alpha		"0"			Linear 0.1 0.1
	Animate	ActiveTimerBG 	Alpha		"255"		Linear 0.3 0.1
	
	Animate	ActiveTimerBG 	Alpha		"0"			Linear 0.5 0.1
	Animate	ActiveTimerBG 	Alpha		"255"		Linear 0.7 0.1
	
	Animate	ActiveTimerBG 	Alpha		"0"			Linear 0.9 0.1
	Animate	ActiveTimerBG 	Alpha		"255"		Linear 1.1 0.1
}

//===========================================

event TeamsFullArrowAnimate
{
	Animate TeamsFullArrow	Position	"c-118 165"		Linear	0	0
	Animate TeamsFullArrow	Position	"c-118 180"		Linear	0	0.4
	Animate TeamsFullArrow	Position	"c-118 165"		Linear	0.4	0.4
	
	RunEvent TeamsFullArrowAnimateLoop	0.8
}

event TeamsFullArrowAnimateLoop
{
	RunEvent TeamsFullArrowAnimate 0.0
}

event TeamsFullArrowAnimateEnd
{
	StopEvent TeamsFullArrowAnimate 0.0
	StopEvent TeamsFullArrowAnimateLoop 0.0
}

//===========================================

event TrainingHudBounce
{
	Animate ObjectiveStatusTraining	Position		"c-160 r187"		Linear 0 0
	Animate ObjectiveStatusTraining	Position		"c-160 r127"		Bounce 0.0 2.0
}

event TrainingPressSpacebarBlink
{
	Animate	PressSpacebarToContinue 	Alpha		"255"		Linear 0.0 0.1
	Animate	PressSpacebarToContinue 	Alpha		"0"			Linear 0.2 0.1
		
	Animate	PressSpacebarToContinue 	Alpha		"255"		Linear 0.4 0.1
	Animate	PressSpacebarToContinue 	Alpha		"0"			Linear 0.6 0.1
	
	Animate	PressSpacebarToContinue 	Alpha		"255"		Linear 0.8 0.1
	Animate	PressSpacebarToContinue 	Alpha		"0"			Linear 1.0 0.1
	
	Animate	PressSpacebarToContinue 	Alpha		"255"		Linear 1.2 0.1

	RunEvent TrainingPressSpacebarBlinkLoop		3.0
}

event TrainingPressSpacebarBlinkLoop
{
	RunEvent TrainingPressSpacebarBlink			0.0
}

event TrainingPressSpacebarBlinkStop
{
	StopEvent TrainingPressSpacebarBlink			0.0
	StopEvent TrainingPressSpacebarBlinkLoop 		0.0
}

//===========================================

event IntroMovieContinueBlink
{
	Animate	continue 	Alpha		"255"		Linear 0.0 0.1
	Animate	continue 	Alpha		"0"			Linear 0.2 0.1
		
	Animate	continue 	Alpha		"255"		Linear 0.4 0.1
	Animate	continue 	Alpha		"0"			Linear 0.6 0.1
	
	Animate	continue 	Alpha		"255"		Linear 0.8 0.1
	Animate	continue 	Alpha		"0"			Linear 1.0 0.1
	
	Animate	continue 	Alpha		"255"		Linear 1.2 0.1

	RunEvent IntroMovieContinueBlinkLoop		2.0
}

event IntroMovieContinueBlinkLoop
{
	RunEvent IntroMovieContinueBlink			0.0
}

event IntroMovieContinueBlinkStop
{
	StopEvent IntroMovieContinueBlink			0.0
	StopEvent IntroMovieContinueBlinkLoop 		0.0
}

//===========================================

event HasMOTDBlink
{
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.0 0.1
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"0"			Linear 0.2 0.1
		
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.4 0.1
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"0"			Linear 0.6 0.1
	
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.8 0.1
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"0"			Linear 1.0 0.1
	
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"255"		Linear 1.2 0.1

	RunEvent HasMOTDBlinkLoop		2.0
}

event HasMOTDBlinkLoop
{
	RunEvent HasMOTDBlink			0.0
}

event HasMOTDBlinkStop
{
	StopEvent HasMOTDBlink				0.0
	StopEvent HasMOTDBlinkLoop 		0.0
	Animate	MOTD_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.0 0.1
}

//===========================================

event HasNotificationsBlink
{
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.0 0.1
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"0"			Linear 0.2 0.1
		
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.4 0.1
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"0"			Linear 0.6 0.1
	
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.8 0.1
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"0"			Linear 1.0 0.1
	
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"255"		Linear 1.2 0.1

	RunEvent HasNotificationsBlinkLoop		2.0
}

event HasNotificationsBlinkLoop
{
	RunEvent HasNotificationsBlink			0.0
}

event HasNotificationsBlinkStop
{
	StopEvent HasNotificationsBlink				0.0
	StopEvent HasNotificationsBlinkLoop 		0.0
	Animate	Notifications_ShowButtonPanel_SB 	Alpha		"255"		Linear 0.0 0.1
}

//===========================================

event AddToCartBlink
{
	Animate	CartButton	BgColor	"TanDark"		Linear 0.0 0.01
	Animate	CartButton	BgColor	"255 150 0 255"	Linear 0.1 0.01
		
	Animate	CartButton 	BgColor	"TanDark"		Linear 0.2 0.01
	Animate	CartButton 	BgColor	"255 150 0 255"	Linear 0.3 0.01
	
	Animate	CartButton 	BgColor	"TanDark"		Linear 0.4 0.01
	Animate	CartButton 	BgColor	"255 150 0 255"	Linear 0.5 0.01
	
	Animate	CartButton	BgColor	"TanDark"		Linear 0.6 0.01
	Animate	CartButton	BgColor	"255 150 0 255"	Linear 0.7 0.01
		
	Animate	CartButton 	BgColor	"TanDark"		Linear 0.8 0.01
	Animate	CartButton 	BgColor	"255 150 0 255"	Linear 0.9 0.01
	
	Animate	CartButton 	BgColor	"TanDark"		Linear 1.0 0.01
}

//===========================================

event NotificationsPresentBlink
{
	Animate	NotificationsPresentPanel 	Alpha		"255"		Linear 0.0 0.1
	Animate	NotificationsPresentPanel 	Alpha		"0"			Linear 0.2 0.1
		
	Animate	NotificationsPresentPanel 	Alpha		"255"		Linear 0.4 0.1
	Animate	NotificationsPresentPanel 	Alpha		"0"			Linear 0.6 0.1
	
	Animate	NotificationsPresentPanel 	Alpha		"255"		Linear 0.8 0.1
	Animate	NotificationsPresentPanel 	Alpha		"0"			Linear 1.0 0.1
	
	Animate	NotificationsPresentPanel 	Alpha		"255"		Linear 1.2 0.1

	RunEvent NotificationsPresentBlinkLoop		2.0
}

event NotificationsPresentBlinkLoop
{
	RunEvent NotificationsPresentBlink			0.0
}

event NotificationsPresentBlinkStop
{
	StopEvent NotificationsPresentBlink				0.0
	StopEvent NotificationsPresentBlinkLoop 		0.0
	Animate	NotificationsPresentPanel 	Alpha		"255"		Linear 0.0 0.1
}

//===========================================

event DamagedPlayer
{
	//Animate	OmpCrosshairPlus		FgColor "255 0 0 255"		Accel 0.0 0.0
	//Animate	OmpCrosshairPlus		FgColor "255 0 255 255"		Accel 0.2 0.0

	//Animate	OmpCrosshairPlusSmall	FgColor "255 0 0 255"		Accel 0.0 0.0
	//Animate	OmpCrosshairPlusSmall	FgColor "255 0 255 255"		Accel 0.2 0.0

	//Animate	OmpCrosshairCircle		FgColor "255 0 0 255"		Accel 0.0 0.0
	//Animate	OmpCrosshairCircle		FgColor "225 225 225 30"	Accel 0.2 0.0
}

//===========================================

event SpyWarningFlash
{
	Animate	EnemyCountImageBG	BgColor	"RedSolid"		Linear 0.0 0.01
	Animate	EnemyCountImageBG	BgColor	"TanLight"		Linear 0.21 0.01
	
	RunEvent	SpyWarningFlashLoop		0.42
}

event SpyWarningFlashLoop
{
	RunEvent SpyWarningFlash			0.0
}
 
event SpyWarningFlashEnd
{
	StopEvent SpyWarningFlash			0.0
	StopEvent SpyWarningFlashLoop		0.0
}

event HudReadyPulse
{
	Animate	TournamentInstructionsLabel 	FgColor		"TanLight"		Linear 0.0 0.1
	Animate	TournamentInstructionsLabel 	FgColor		"RedSolid"		Linear 0.3 0.4

	RunEvent HudReadyPulseLoop	0.5
}

event HudReadyPulseLoop
{
	RunEvent HudReadyPulse			0.0
}

event HudReadyPulseEnd
{
	Animate	TournamentInstructionsLabel 	FgColor		"TanLight"		Linear 0.0 0.1
	
	StopEvent HudReadyPulse			0.0
	StopEvent HudReadyPulseLoop		0.0
}

// Respec in Win
event RespecEarnedPulse
{
	Animate	RespecTextLabelWin	FgColor	"OmpText"		Linear 0.0 0.1
	Animate	RespecTextLabelWin	FgColor	"RedSolid"		Linear 0.3 0.4
	
	RunEvent RespecEarnedPulseLoop		0.5
}

event RespecEarnedPulseLoop
{
	RunEvent RespecEarnedPulse			0.0
}

event RespecEarnedPulseEnd
{
	Animate	RespecTextLabelWin 	FgColor		"OmpText"		Linear 0.0 0.1
	
	StopEvent RespecEarnedPulse			0.0
	StopEvent RespecEarnedPulseLoop		0.0
}

// Respec on Loss
event RespecEarnedPulseLoss
{
	Animate	RespecTextLabelLoss	FgColor	"OmpText"		Linear 0.0 0.1
	Animate	RespecTextLabelLoss	FgColor	"RedSolid"		Linear 0.3 0.4
	
	RunEvent RespecEarnedPulseLoopLoss		0.5
}

event RespecEarnedPulseLoopLoss
{
	RunEvent RespecEarnedPulseLoss			0.0
}

event RespecEarnedPulseEndLoss
{
	Animate	RespecTextLabelLoss FgColor		"OmpText"		Linear 0.0 0.1
	Animate	RespecTextLabelLoss FgColor		"OmpText"		Linear 0.0 0.1
	
	StopEvent RespecEarnedPulseLoss		0.0
	StopEvent RespecEarnedPulseLoopLoss	0.0
}

event RDPositiveScorePulse
{
	Animate Score FgColor	"25 255 25 255"		Linear 0.0 0.0
	Animate Score FgColor	"TanLight"			Linear 0.1 0.2

	Animate Score Position	"3 5"		Deaccel 0.0 0.05
	Animate Score Position	"3 10"		Accel 0.05 0.2

	Animate ScoreShadow FgColor	"0 0 0 200"		Deaccel 0.0 0.05
	Animate ScoreShadow FgColor	"0 0 0 255"		Accel 0.1 0.2
}

event RDNegativeScorePulse
{
	Animate Score FgColor	"255 75 75 255"		Linear 0.0 0.0
	Animate Score FgColor	"TanLight"			Linear 0.1 0.2

	Animate Score Position	"3 5"		Deaccel 0.0 0.05
	Animate Score Position	"3 10"		Accel 0.05 0.2

	Animate ScoreShadow FgColor	"0 0 0 200"		Deaccel 0.0 0.05
	Animate ScoreShadow FgColor	"0 0 0 255"		Accel 0.1 0.2
}

event QuestNotification_Present
{
	Animate MainContainer Position	"r0 94"		Deaccel 0		0
	Animate MainContainer Position	"r115 94"		Deaccel	0.01	0.4
}

event QuestNotification_Hide
{
	Animate MainContainer Position	"r115 94"		Deaccel	0		0
	Animate MainContainer Position	"r0 94"			Deaccel 0.01	0.4
}

event ItemCard_ShowPinHint
{
	Animate PinLabel Position	"0 -20"	Deaccel	0	0

	Animate PinLabel FgColor	"TanLight"	Linear 0.2 0
	Animate PinLabel Position	"0 0"	Deaccel 0.2	0.2
}

event ItemCard_HidePinHint
{
	Animate PinLabel Position	"0 5"	Deaccel	0	0.3

	Animate PinLabel Position	"0 -20"	Accel 0.3	0.1
}

event ItemCard_ShowCloseButton
{
	Animate CloseButton Position	"-8 -68"	Deaccel	0	0.3

	Animate CloseButton Position	"-8 -68"	Accel 0.3	0.1
}

event ItemCard_HideCloseButton
{
	Animate CloseButton Position	"-30 -90"	Deaccel	0	0.0
}

event QuestItem_StaticPhoto_Reveal
{
	Animate StaticPhoto Alpha	"0"	Accel		0	2
}

event HideStamp
{
	SetVisible ApplyStampButton		0					0
}

event CollectionCrafting_Intro
{
	// Reset
	SetVisible ApplyStampButton		0					0
	SetVisible Stamp				0					0
	Animate Stamp					xpos c140	Accel	0 0
	Animate DrawingPanel			xpos c0		Accel	0 0
	Animate DrawingPanel			wide 0		Accel	0 0
	Animate LetterFront				xpos c0		Accel	0 0
	Animate LetterFront				wide 0		Accel	0 0
	Animate LetterBack_Top		xpos c-250	Accel	0 0
	Animate LetterBack_Top		ypos 400	Accel	0 0
	Animate LetterBack_Top		wide 500	Accel	0 0
	Animate LetterBack_Bottom		xpos c-250	Accel	0 0
	Animate LetterBack_Bottom		ypos 400	Accel	0 0
	Animate LetterBack_Bottom		wide 500	Accel	0 0
	Animate LetterBack_Flap			xpos c-250	Accel	0 0
	Animate LetterBack_Flap			ypos 400	Accel	0 0
	Animate LetterBack_Flap			wide 500	Accel	0 0
	Animate LetterBack_Flap			tall 0		Deaccel 0.6 0.4
	Animate LetterBack_Top			ypos 400	Accel	0 0
	SetVisible ReturnModel			0					0
	Animate SendEvelopeButton		ypos 280	Accel	0 0
	SetVisible	SendEvelopeButton		 0				0 
	SetVisible ResponseTimeout		0					0
	SetVisible WaitingForResponse	0					0

	SetVisible ShowExplanationsButton1			1					0
	SetVisible ShowExplanationsButton2			0					0
	Animate TradeUpContainer	wide 800	Accel 0 0	

	// Slide paper down
	Animate TradeUpContainer Position	"0 60"	Deaccel	0	0.3

	// Slider BG up
	Animate BG			Position	"0 34"	Deaccel	0	0.3

	// Fade dimmer down
	Animate Dimmer Alpha "255" Linear 0 0.4
}

event CollectionCrafting_LetterStart
{
	// Slide envelope up
	FireCommand	0.0 "playsound ui/trade_up_envelope_slide_in.wav"
	Animate LetterBack_Bottom	ypos 60	Deaccel 0 0.3
	Animate LetterBack_Flap		ypos 60	Deaccel 0 0.3
	Animate LetterBack_Top		ypos 60	Deaccel 0 0.3
	SetVisible ShowExplanationsButton1	0		0

	// Close flap
	FireCommand	0.3 "playsound ui/trade_up_envelope_fold.wav"
	Animate LetterBack_Flap		tall 250 Deaccel 0.4 0.2
	
	// Start Flip
	FireCommand	0.8 "playsound ui/trade_up_envelope_spin.wav"
	Animate TradeUpContainer	wide 0	Accel 0.8 0	
	Animate LetterBack_Bottom	wide 0	Accel 0.8 0.2
	Animate LetterBack_Bottom	xpos c0	Accel 0.8 0.2
	Animate LetterBack_Flap		wide 0	Accel 0.8 0.2
	Animate LetterBack_Flap		xpos c0	Accel 0.8 0.2
	Animate LetterBack_Top		wide 0	Accel 0.8 0.2
	Animate LetterBack_Top		xpos c0	Accel 0.8 0.2
	
	// End Flips
	Animate LetterFront			xpos c-250	Deaccel 1.0 0.2
	Animate LetterFront			wide 500	Deaccel 1.0 0.2
	Animate DrawingPanel		xpos c-250	Deaccel 1.0 0.2
	Animate DrawingPanel		wide 500	Deaccel 1.0 0.2
	SetVisible ApplyStampButton	1					1.3
	SetVisible ShowExplanationsButton2	1			1.3
}

event CollectionCrafting_PlaceStamp
{
	SetVisible Stamp				1					0
	SetVisible ApplyStampButton		0					0
	FireCommand	0 "playsound ui/trade_up_apply_stamp.wav"
}

event CollectionCrafting_LetterSend
{
	SetVisible ShowExplanationsButton2	0			0
	SetVisible	SendEvelopeButton		0			0 
	Animate Stamp				xpos	c70	Deaccel	0 0.3
	Animate LetterFront			xpos	c-320	Deaccel 0 0.3
	Animate DrawingPanel		xpos	c-320	Deaccel 0 0.3

	RunEventChild BehindItemParticlePanel PlayEnvelopSendParticles 0.3
	Animate Stamp				xpos 1120	Accel 0.3 0.2
	Animate LetterFront			xpos 1000	Accel 0.3 0.2
	Animate DrawingPanel		xpos 1000	Accel 0.3 0.2
	SetVisible CloseButton		0					0
	FireCommand	0.2 "playsound ui/trade_up_envelope_slide_out.wav"
}

event PlayNewItemParticles
{
	FireCommand 0 "start0"
}

event PlayCrateSmashParticles
{
	FireCommand 0 "start1"
}

event PlayEnvelopSendParticles
{
	FireCommand 0 "start2"
}

event ShowFoundLabels
{
	Animate YouTradedForLabel alpha 0 Linear 0 0
	Animate ItemName		alpha 0 Linear 0 0

	Animate YouTradedForLabel alpha 255 Linear 3 1
	Animate ItemName		alpha 255 Linear 3 1
}

event CollectionCrafting_ItemRecieved
{
	RunEventChild NewItemPanel ShowFoundLabels	0
	FireCommand 0	"playcratesequence1"
	SetVisible	NewItemPanel					0 0 
	SetVisible ReturnModel						1 0.05
	RunEventChild BehindItemParticlePanel PlayCrateSmashParticles 0.2

	FireCommand	0 "playsound ui/trade_up_crate_smash.wav"

	SetVisible	NewItemPanel	  1			1.5 
	SetVisible CloseButton		  1			1.5

	FireCommand 2.1 "playcratesequence2"
	RunEventChild BehindItemParticlePanel PlayNewItemParticles 1.5
	
	FireCommand	1.0 "playsound ../player/taunt_medic_heroic.wav"
}

event CollectionCrafting_OKBlink_Repeatable
{
	Animate OkButton	FgColor Red		 Linear 0 0.1
	Animate OkButton	FgColor TanLight Linear 0.1 0.1
}

event CollectionCrafting_OKBlink
{
	RunEvent CollectionCrafting_OKBlink_Repeatable 0
	RunEvent CollectionCrafting_OKBlink_Repeatable 0.2
	RunEvent CollectionCrafting_OKBlink_Repeatable 0.4
	RunEvent CollectionCrafting_OKBlink_Repeatable 0.6
}


event CollectionCrafting_ShowSendButton
{
	SetVisible	SendEvelopeButton	  1					0 
	Animate SendEvelopeButton		ypos	320 Deaccel 0 0.5
}

event CollectionCrafting_ShowWaiting
{
	SetVisible WaitingForResponse	1	0
}

event CollectionCrafting_HideWaiting
{
	SetVisible WaitingForResponse	0	0
}

event CollectionCrafting_ShowFailure
{
	SetVisible ResponseTimeout	1	0
	SetVisible CloseButton		1	0
}