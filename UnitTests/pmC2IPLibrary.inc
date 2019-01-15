! Unit Types Equates
uTpy:notDefined     EQUATE('')
!uTpy:infantry       EQUATE(1001)

uTpy:Amphibious                             EQUATE('120300')    ! Amphibious                
uTpy:Antitank_Antiarmor                     EQUATE('120400')    ! Antitank/Antiarmor                
uTpy:Antitank_Antiarmor:Armored             EQUATE('120401')    ! Antitank/Antiarmor->Armored                
uTpy:Antitank_Antiarmor:Motorized           EQUATE('120402')    ! Antitank/Antiarmor->Motorized
uTpy:Armor_Armored_Mechanized:Self_Propelled_Tracked                EQUATE('120500')    ! Armor/Armored/Mechanized/Self-Propelled/Tracked
uTpy:Armor_Armored_Mechanized:Self_Propelled_Tracked:Reconnaissance_Cavalry_Scout   EQUATE('120501')    !Armor/Armored/Mechanized/Self-Propelled/Tracked->Reconnaissance/Cavalry/Scout
uTpy:Armor_Armored_Mechanized:Self_Propelled_Tracked:Amphibious     EQUATE('120502')    ! Armor/Armored/Mechanized/Self-Propelled/Tracked->Amphibious
uTpy:Army_Aviation_Aviation_Rotary_Wing                             EQUATE('120600')    ! Army Aviation/Aviation Rotary Wing
uTpy:Army_Aviation_Aviation_Rotary_Wing:Reconnaissance              EQUATE('120601')    ! Army Aviation/Aviation Rotary Wing->Reconnaissance
uTpy:Aviation_Composite                     EQUATE('120700')        ! Aviation Composite
uTpy:Aviation_Fixed_Wing                    EQUATE('120800')        ! Aviation Fixed Wing
uTpy:Aviation_Fixed_Wing:Reconnaissance     EQUATE('120801')    ! Aviation Fixed Wing->Reconnaissance
uTpy:Combat                                 EQUATE('120900')        ! Combat
uTpy:Combined_Arms                          EQUATE('121000')        ! Combined Arms
uTpy:Infantry                               EQUATE('121100')        ! Infantry
uTpy:Infantry_Amphibious                    EQUATE('121101')    ! Infantry Amphibious
uTpy:Infantry_Armored_Mechanized_Tracked    EQUATE('121102')    ! Infantry Armored/Mechanized/Tracked
uTpy:Infantry_Main_Gun_System               EQUATE('121103')    ! Infantry Main Gun System
uTpy:Infantry_Motorized                     EQUATE('121104')    ! Infantry Motorized
uTpy:Infantry_Infantry_Fighting_Vehicle     EQUATE('121105')    ! Infantry Infantry Fighting Vehicle
uTpy:Observer                               EQUATE('121200')    ! Observer
uTpy:Reconnaissance_Cavalry_Scout           EQUATE('121300')    ! Reconnaissance/Cavalry/Scout
uTpy:Reconnaissance_Cavalry_Scout:Reconnaissance_Surveillance       EQUATE('121301')    ! Reconnaissance/Cavalry/Scout -> Reconnaissance and Surveillance
uTpy:Reconnaissance_Cavalry_Scout_Marine    EQUATE('121302')    ! Reconnaissance/Cavalry/Scout -> Marine
uTpy:Reconnaissance_Cavalry_Scout_Motorized EQUATE('121303')    ! Reconnaissance/Cavalry/Scout -> Motorized
uTpy:Sea_Air_Land_SEAL                      EQUATE('121400')    ! Sea Air Land (SEAL)
uTpy:Snipper                                EQUATE('121500')    ! Snipper
            

OMIT('__uTpyEquates')
            OF '121600'
                ! Surveillance
            OF '121700'
                ! Special Forces
            OF '121800'
                ! Special Operations Forces (SOF)
            OF '121801'
                ! Special Operations Forces (SOF) -> 	Fixed Wing MISO
            OF '121802'
                ! Special Operations Forces (SOF) -> 	Ground
            OF '121803'
                ! Special Operations Forces (SOF) -> 	Special Boat
            OF '121804'
                ! Special Operations Forces (SOF) -> 	Special SSNR
            OF '121805'
                ! Special Operations Forces (SOF) -> 	Underwater Demolition Team
            OF '121900'
                ! Unmanned Aerial Systems
            OF '130000'
                ! Fires
            OF '130100'
                ! Air Defense
            OF '130101'
                ! Air Defense -> Main Gun System
            OF '130102'
                ! Air Defense -> Missile
            OF '130200'
                ! Air/Land Naval Gunfire Liaison
            OF '130300'
                ! Field Artillery
            OF '130301'
                ! Field Artillery -> Self-propelled
            OF '130302'
                ! Field Artillery -> Target Acquisition
            OF '130400'
                ! Field Artillery Observer
            OF '130500'
                ! Joint Fire Support
            OF '130600'
                ! Meteorological
            OF '130700'
                ! Missile
            OF '130800'
                ! Mortar
            OF '130801'
                ! Mortar -> Armored/Mechanized/Tracked
            OF '130802'
                ! Mortar ->	Self-Propelled Wheeled
            OF '130803'
                ! Mortar -> Towed
            OF '130900'
                ! Survey
            OF '140000'
                ! Protection
            OF '140100'
                ! Chemical Biological Radiological Nuclear Defense
            OF '140101'
                ! Chemical Biological Radiological Nuclear Defense -> Mechanized
            OF '140102'
                ! Chemical Biological Radiological Nuclear Defense -> Motorized
            OF '140103'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance
            OF '140104'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance Armored
            OF '140105'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance Equipped
            OF '140200'
                ! Combat Support (Maneuver Enhancement)
            OF '140300'
                ! Criminal Investigation Division
            OF '140400'
                ! Diving
            OF '140500'
                ! Dog
            OF '140600'
                ! Drilling
            OF '140700'
                ! Engineer
                IF SELF.DrawNode_Engineer(FALSE) = TRUE THEN
                END
            OF '140701'
                ! Engineer -> Mechanized
                IF SELF.DrawNode_Engineer_Mechanized(FALSE) = TRUE THEN
                END
            OF '140702'
                ! Engineer -> Motorized
                IF SELF.DrawNode_Engineer_Motorized(FALSE) = TRUE THEN
                END
    OF '140703'
        
        
        __uTpyEquates

! Echelon Equates
echTpy:notDefined   EQUATE(1100)
echTpy:Team         EQUATE(1101)
echTpy:Squad        EQUATE(1102)
echTpy:Section      EQUATE(1103)
echTpy:Platoon      EQUATE(1104)
echTpy:Company      EQUATE(1105)
echTpy:Battalion    EQUATE(1106)
echTpy:Regiment     EQUATE(1107)
echTpy:Brigade      EQUATE(1108)
echTpy:Division     EQUATE(1109)
echTpy:Corps        EQUATE(1110)
echTpy:Army         EQUATE(1111)
echTpy:ArmyGroup    EQUATE(1112)
echTpy:Theater      EQUATE(1113)
echTpy:Command      EQUATE(1114)

! Hostility Equates
hTpy:notDefined     EQUATE(1500)
hTpy:Unknown        EQUATE(1501)
hTpy:AssumedFriend  EQUATE(1502)
hTpy:Friend         EQUATE(1503)
hTpy:Neutral        EQUATE(1504)
hTpy:Suspect        EQUATE(1505)
hTpy:Hostile        EQUATE(1506)

! Hostility Color
COLOR:notDefined    EQUATE(COLOR:Yellow)
COLOR:Unknown       EQUATE(COLOR:Yellow)
COLOR:AssumedFriend EQUATE(COLOR:Aqua)
COLOR:Friend        EQUATE(COLOR:Aqua)
COLOR:Neutral       EQUATE(COLOR:Green)
COLOR:Suspect       EQUATE(COLOR:Red)
COLOR:Hostile       EQUATE(COLOR:Red)

! Disable for selection color
COLOR:NodeDisabled  EQUATE(COLOR:Gray)

! entry fields
!?uNameEntry         EQUATE(900)
!?uTypeList          EQUATE(901)
!?uHQ                EQUATE(902)
!?ListSymbology      EQUATE(903)

! Units Queue Structure
UnitsList           QUEUE, TYPE
UnitName                STRING(100)
UnitType                LONG
UnitTypeCode            STRING(10)
Echelon                 LONG
Hostility               LONG
IsHQ                    BOOL
xPos                    LONG
yPos                    LONG
TreePos                 LONG
markForDel              BOOL
markForDisbl            BOOL
                    END

! Unit Basic Record Structure
UnitBasicRecord     GROUP, TYPE
UnitName                    STRING(100)
UnitType                    LONG
UnitTypeCode                STRING(10)
Echelon                     LONG
Hostility                   LONG
IsHQ                        BOOL
xPos                        LONG
yPos                        LONG
TreePos                     LONG
                    END

! Reference C2IPs Queue Structure
C2IPsList           QUEUE, TYPE
C2IPPath                STRING(100)
C2IPName                STRING(100)
                    END


BSO                 CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
urec                    GROUP(UnitBasicRecord)
                        END

Construct               PROCEDURE()
Destruct                PROCEDURE()

                    END

BSOCollection       CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
ul                      &UnitsList
tmpul                   &UnitsList, PRIVATE
urec                    GROUP(UnitBasicRecord)
                        END

selTreePos              LONG, PRIVATE
maxTreePos              LONG, PRIVATE
selQueuePos             LONG, PRIVATE

Construct               PROCEDURE()
Destruct                PROCEDURE()

prepRndName             PROCEDURE(), STRING, PRIVATE
insertFirstNode         PROCEDURE(), PRIVATE
prepNewNode             PROCEDURE(LONG nPosition), PRIVATE
moveNodesToTmp          PROCEDURE(LONG nStartPos, LONG nEndPos), PRIVATE
moveNodesBackFromTmp    PROCEDURE(LONG nStartPos), PRIVATE
addEmptyNode            PROCEDURE(), PRIVATE
insertCurrentPrepNode   PROCEDURE(LONG nPosition), PRIVATE
insertLastNode          PROCEDURE(), PRIVATE

InsertNode              PROCEDURE
InsertNode              PROCEDURE(*UnitBasicRecord pUrec), LONG
GetNode                 PROCEDURE(*UnitBasicRecord pURec), LONG
GetNode                 PROCEDURE(), BOOl
DeleteNode              PROCEDURE
DisableNode             PROCEDURE

SelUp                   PROCEDURE(), BOOL
SelDown                 PROCEDURE(), BOOL
SelLeft                 PROCEDURE(), BOOL
SelRight                PROCEDURE(), BOOL

Records                 PROCEDURE(), LONG
Pointer                 PROCEDURE(), LONG
GetCurrentSelPos        PROCEDURE(), LONG
Get                     PROCEDURE(), BOOL
UnitName                PROCEDURE(), STRING
SetUnitName             PROCEDURE(STRING sUnitName), BOOL
UnitTypeCode            PROCEDURE(), STRING
SetUnitTypeCode         PROCEDURE(STRING sUnitTypeCode), BOOL
Echelon                 PROCEDURE(), LONG
SetEchelon              PROCEDURE(LONG nEchelon), BOOL
xPos                    PROCEDURE(), LONG
yPos                    PROCEDURE(), LONG
Hostility               PROCEDURE(), LONG
SetHostility            PROCEDURE(LONG nHostility), LONG
markForDisbl            PROCEDURE(), BOOL
isHQ                    PROCEDURE(), BOOL
SetHQ                   PROCEDURE(BOOL bIsHQ), BOOL
TreePos                 PROCEDURE(), LONG

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG
                    END
    

! Generic C2IP structure
C2IP                CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
Name                    STRING(100)
!ul                      &UnitsList
!tmpul                   &UnitsList, PRIVATE
ul                      &BSOCollection
tmpul                   &BSOCollection
tmpUnitName             STRING(100), PRIVATE

! Draw representation
drwImg                  &Draw

! referenced C2IPs list
refC2IPs                &C2IPsList

labelEditMode           BOOL, PRIVATE

Construct               PROCEDURE
Destruct                PROCEDURE
InitDraw                PROCEDURE(Draw pDraw), LONG

                    END

! Organization Chart structure
OrgChartC2IP        CLASS(C2IP), MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE

! Unit basic record structure
urec                    GROUP(UnitBasicRecord)
                        END

selTreePos              LONG, PRIVATE
maxTreePos              LONG, PRIVATE
selQueuePos             LONG, PRIVATE

uNameEntry              STRING(100), PRIVATE
bIsHQEntry              BOOL, PRIVATE
nEchelon                LONG, PRIVATE


Construct               PROCEDURE                           
Destruct                PROCEDURE

Redraw                  PROCEDURE, PRIVATE
DrawNode                PROCEDURE(LONG nUnitType=0), LONG, PRIVATE

!DrawNode variants
DrawNode_Default        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

Draw_innerSine          PROCEDURE(), PRIVATE
Draw_innerEllipse       PROCEDURE(), PRIVATE
Draw_medianLine         PROCEDURE(), PRIVATE
Draw_secondDiag         PROCEDURE(), PRIVATE
Draw_innerPapillon      PROCEDURE(), PRIVATE
Draw_innerSmallClepsydra        PROCEDURE(), PRIVATE
Draw_innerSmallRoundPapillon    PROCEDURE(), PRIVATE
Draw_innerRoundPapillon PROCEDURE(), PRIVATE
Draw_innerTriangle      PROCEDURE(), PRIVATE
Draw_innerFork          PROCEDURE(), PRIVATE

DrawNode_Amphibious     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Antiarmor     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Antiarmor_Armored     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Antiarmor_Motorized    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Armor          PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Armor_Recon    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Armor_Amphibious       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_ArmyAviation       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_ArmyAviation_Recon PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_AviationComposite   PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_AviationFixedWing  PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_AviationFixedWing_Recon     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Combat             PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_CombinedArms       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Infantry       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Amphibious    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Armored       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_MainGunSystem PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Motorized     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_FightingVehicle       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Observer       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Reconnaissance         PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Reconnaissance_Recon       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Reconnaissance_Marine      PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Reconnaissance_Motorized   PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Engineer       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Engineer_Mechanized       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Engineer_Motorized        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Engineer_Recon           PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Echelon        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

InsertNode              PROCEDURE
InsertNode              PROCEDURE(*UnitBasicRecord pUrec), LONG
GetNode                 PROCEDURE(*UnitBasicRecord pURec), LONG
DeleteNode              PROCEDURE
DisableNode             PROCEDURE

DisplaySelection        PROCEDURE, PRIVATE
DisplaySelection        PROCEDURE(LONG nXPos, LONG nYPos), PRIVATE
DisplayUnselection      PROCEDURE, PRIVATE
DisplayUnselection      PROCEDURE(LONG nXPos, LONG nYPos), PRIVATE

SelUp                   PROCEDURE
SelDown                 PROCEDURE
SelLeft                 PROCEDURE
SelRight                PROCEDURE

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG
Unselect                PROCEDURE(), LONG


GetUnitName             PROCEDURE(), STRING
SetUnitName             PROCEDURE(STRING sUnitName), LONG

GetUnitTypeCode         PROCEDURE(), STRING
SetUnitTypeCode         PROCEDURE(STRING sUnitTypeCode), LONG

GetEchelon              PROCEDURE(), LONG
SetEchelon              PROCEDURE(LONG nEchelon), LONG

GetHostility            PROCEDURE(), LONG
SetHostility            PROCEDURE(LONG nHostility), LONG

GetHQ                   PROCEDURE(), BOOL
SetHQ                   PROCEDURE(BOOL bIsHQ), BOOL

! persistence layer
Save                    PROCEDURE(), LONG
Save                    PROCEDURE(STRING sFileName), LONG
Load                    PROCEDURE(STRING sFileName), LONG

! referenced C2IPs
AttachC2IP              PROCEDURE(STRING sFileName), LONG
DetachC2IP              PROCEDURE(LONG nOption), LONG

TakeEvent               PROCEDURE(UNSIGNED nKeyCode), LONG
checkLabelEditMode      PROCEDURE, PRIVATE

TakeNodeAction          PROCEDURE(LONG nOption), LONG
NodeActionsMenuOptions  PROCEDURE(), STRING

TakeEchelon             PROCEDURE(LONG nOption), LONG, PRIVATE
EchelonMenuOptions      PROCEDURE(), STRING, PRIVATE

TakeHostility           PROCEDURE(LONG nOption), LONG, PRIVATE
HostilityMenuOptions    PROCEDURE(), STRING, PRIVATE
                    END

! Overlay structure
OverlayC2IP         CLASS(C2IP), MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
!Name                    STRING(100)
!ul                      &UnitsList

Construct               PROCEDURE
Destruct                PROCEDURE
                    END




