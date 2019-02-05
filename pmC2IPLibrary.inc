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

! geometries
g:NotDefined        EQUATE(1000)
g:Point             EQUATE(1001)
g:Line              EQUATE(1002)
g:FreeLine          EQUATE(1003)
g:AxisAdvance       EQUATE(1010)

! Action Type Equates
aTpy:notDefined     EQUATE('')

aTpy:AxisOfAdvance                              EQUATE('151400')    ! Axis Of Advance
aTpy:AxisOfAdvance_FriendlyAirborne_Aviation        EQUATE('151401')    ! Axis Of Advance / Friendly Airborne/Aviation
aTpy:AxisOfAdvance_AttackHelicopter                 EQUATE('151402')    ! Axis Of Advance / Attack Helicopte
aTpy:AxisOfAdvance_MainAttack                       EQUATE('151403')    ! Axis Of Advance / Main Attack
aTpy:AxisOfAdvance_SupportingAttack                 EQUATE('151404')    ! Axis Of Advance / Supporting Attack
aTpy:AxisOfAdvance_SupportingAttackPlanned          EQUATE('151405')    ! Axis Of Advance / Supporting Attack Planned or On Order
aTpy:AxisOfAdvance_Feint                            EQUATE('151406')    ! Axis Of Advance / Feint
aTpy:AxisOfAdvance_EnemyConfirmed                   EQUATE('151407')    ! Axis Of Advance / Enemy Confirmed
aTpy:AxisOfAdvance_EnemyTemplated_Suspected         EQUATE('151408')    ! Axis Of Advance / Enemy Templated or Suspected


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

! Actions Queue Structure
ActionsQueue         QUEUE, TYPE
ActionName              STRING(100)
ActionType              LONG
ActionTypeCode          STRING(10)
ActionPointsNumber      LONG
xPos                    LONG, DIM(100)
yPos                    LONG, DIM(100)
                    END


PosRecord           GROUP, TYPE
xPos                        LONG
yPos                        LONG
                    END

PosList            QUEUE, TYPE
xPos                        LONG
yPos                        LONG
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

!Action Basic Record Structure
ActionBasicRecord   GROUP, TYPE
ActionName              STRING(100)
ActionType              LONG
ActionTypeCode          STRING(10)
ActionPointsNumber      LONG
xPos                    LONG, DIM(100)
yPos                    LONG, DIM(100)
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

UnitsCollection       CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
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
AddNode                 PROCEDURE(*UnitBasicRecord pUrec), LONG
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
ChangeNodePos           PROCEDURE(LONG nXPos, LONG nYPos), LONG
                    END

ActionsCollection     CLASS, MODULE('ActionsCollection.clw'), LINK('ActionsCollection.clw'), TYPE
al                          &ActionsQueue

Construct                   PROCEDURE()
Destruct                    PROCEDURE()

InsertAction                PROCEDURE(ActionBasicRecord parec)
                    END

    

! Generic C2IP structure
C2IP                CLASS, MODULE('C2IP.clw'), LINK('C2IP.clw'), TYPE
Name                    STRING(100)
ul                      &UnitsCollection
tmpul                   &UnitsCollection
tmpUnitName             STRING(100), PRIVATE

! Draw representation
drwImg                  &Draw
TakeEvent               PROCEDURE(), VIRTUAL
geometry                LONG        ! geometry equates
isSelection             BOOL, PROTECTED
isMouseDown             BOOL, PROTECTED
isPointsCollection      BOOL, PROTECTED


! referenced C2IPs list
refC2IPs                &C2IPsList

labelEditMode           BOOL, PRIVATE

Construct               PROCEDURE
Destruct                PROCEDURE
Redraw                  PROCEDURE, PROTECTED, VIRTUAL


InitDraw                PROCEDURE(Draw pDraw), LONG

DisplaySelection        PROCEDURE, PROTECTED
DisplaySelection        PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
DisplayUnselection      PROCEDURE, PROTECTED
DisplayUnselection      PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED

!DrawNode variants
DrawNode_MainSymbol     PROCEDURE(), PROTECTED
DrawNode_HQ             PROCEDURE(), PROTECTED

DrawNode_Default        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

Draw_innerSine          PROCEDURE(), PROTECTED
Draw_innerEllipse       PROCEDURE(), PROTECTED
Draw_medianLine         PROCEDURE(), PROTECTED
Draw_secondDiag         PROCEDURE(), PROTECTED
Draw_innerPapillon      PROCEDURE(), PROTECTED
Draw_innerSmallClepsydra        PROCEDURE(), PROTECTED
Draw_innerSmallRoundPapillon    PROCEDURE(), PROTECTED
Draw_innerRoundPapillon PROCEDURE(), PROTECTED
Draw_innerTriangle      PROCEDURE(), PROTECTED
Draw_innerFork          PROCEDURE(), PROTECTED

DrawNode_Amphibious     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Antiarmor     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Antiarmor_Armored     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Antiarmor_Motorized    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Armor          PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Armor_Recon    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Armor_Amphibious       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_ArmyAviation       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_ArmyAviation_Recon PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_AviationComposite   PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_AviationFixedWing  PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_AviationFixedWing_Recon     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Combat             PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_CombinedArms       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Infantry       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Infantry_Amphibious    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Infantry_Armored       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Infantry_MainGunSystem PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Infantry_Motorized     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Infantry_FightingVehicle       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Observer       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Reconnaissance         PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Reconnaissance_Recon       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Reconnaissance_Marine      PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Reconnaissance_Motorized   PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Engineer       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Engineer_Mechanized       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Engineer_Motorized        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED
DrawNode_Engineer_Recon           PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

DrawNode_Echelon        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PROTECTED

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
Unselect                PROCEDURE(), LONG
MoveTo                  PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL

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
                    END

! Organization Chart structure
OrgChartC2IP        CLASS(C2IP), MODULE('OrgChartC2IP.clw'), LINK('OrgChartC2IP.clw'), TYPE

! Unit basic record structure
urec                    GROUP(UnitBasicRecord)
                        END

TakeEvent               PROCEDURE(), VIRTUAL

selTreePos              LONG, PRIVATE
maxTreePos              LONG, PRIVATE
selQueuePos             LONG, PRIVATE

uNameEntry              STRING(100), PRIVATE
bIsHQEntry              BOOL, PRIVATE
nEchelon                LONG, PRIVATE


Construct               PROCEDURE                           
Destruct                PROCEDURE

Redraw                  PROCEDURE, PROTECTED, VIRTUAL



InsertNode              PROCEDURE
InsertNode              PROCEDURE(*UnitBasicRecord pUrec), LONG
GetNode                 PROCEDURE(*UnitBasicRecord pURec), LONG
DeleteNode              PROCEDURE
DisableNode             PROCEDURE

SelUp                   PROCEDURE
SelDown                 PROCEDURE

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL

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
OverlayC2IP         CLASS(C2IP), MODULE('OverlayC2IP.clw'), LINK('OverlayC2IP.clw'), TYPE
map                     STRING(100)
al                      &ActionsCollection

TakeEvent               PROCEDURE(), VIRTUAL

Preview_Line            PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
Preview_Arrow           PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
Preview_FreeLine        PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
Draw_AxisAdvance        PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED

p1x                     LONG, PROTECTED
p1y                     LONG, PROTECTED
PolyPoints              LONG, PROTECTED
pp                      &PosList, PROTECTED

TakePoints              PROCEDURE(LONG nGeometry)


Construct               PROCEDURE
Destruct                PROCEDURE

Redraw                  PROCEDURE, PROTECTED, VIRTUAL

DeployBSO               PROCEDURE(*UnitBasicRecord pUrec, LONG nXPos, LONG nYPos), BOOL

! referenced C2IPs
AttachC2IP              PROCEDURE(STRING sFileName), LONG
AttachMap               PROCEDURE(STRING sFileName), LONG

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
MoveTo                  PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL

TakeNodeAction          PROCEDURE(LONG nOption), LONG
NodeActionsMenuOptions  PROCEDURE(), STRING

DA_SupportingAttack     PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_AxisOfAdvance        PROCEDURE(PosRecord startPos, PosRecord endPos)
TakePoints              PROCEDURE(PosRecord startPos, PosRecord endPos)    

InsertAction            PROCEDURE()

DrawAction                      PROCEDURE()
                    END




