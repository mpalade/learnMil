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
g:Rectangle         EQUATE(1004)
g:Polygon           EQUATE(1005)
g:FreeHand          EQUATE(1006)

g:AxisAdvance       EQUATE(1010)
g:Ambush            EQUATE(1011)
g:Circle            EQUATE(1012)
g:LineWithBase      EQUATE(1013)

g:LineWithHeader    EQUATE(1014)
g:Block             EQUATE(1014)

g:Breach            EQUATE(1015)

! Action Type Equates
aTpy:notDefined             EQUATE('notDefined')
aTpy:notDef_Line            EQUATE('Line')
aTpy:notDef_Rectangle       EQUATE('Rectangle')
aTpy:notDef_Polygon         EQUATE('Polygon')
aTpy:notDef_FreeHand        EQUATE('FreeHand')

aTpy:AdvanceToContact       EQUATE('900000')    ! Advance To Contact

aTpy:Incident                       EQUATE('110000') ! Incident
aTpy:CriminalActivityIncident       EQUATE('110100') ! Criminal Activity Incident
aTpy:CAI_Arrest                     EQUATE('110101') ! Criminal Activity Incident / Arrest

aTpy:Block          EQUATE('340100')    ! Block
aTpy:Breach         EQUATE('340200')    ! Breach
aTpy:Bypass         EQUATE('340300')    ! Bypass
aTpy:Canalize       EQUATE('340400')    ! Canalize
aTpy:Clear          EQUATE('340500')    ! Clear
aTpy:Counterattack  EQUATE('340600')    ! Counterattack
aTpy:CounterattackByFire    EQUATE('340700') ! Counterattack by Fire
aTpy:Delay          EQUATE('340800')    ! Delay
aTpy:Destroy        EQUATE('340900')    ! Destroy
aTpy:Disrupt        EQUATE('341000')    ! Disrupt
aTpy:Fix            EQUATE('341100')    ! Fix
aTpy:FollowAndAssume        EQUATE('341200')    ! Follow and Assume
aTpy:FollowAndSupport       EQUATE('341300')    ! Follow and Support
aTpy:Interdict      EQUATE('341400')    ! Interdict
aTpy:Isolate        EQUATE('341500')    ! Isolate
aTpy:Neutralize     EQUATE('341600')    ! Neutralize
aTpy:Occupy         EQUATE('341700')    ! Occupy
aTpy:Penetrate      EQUATE('341800')    ! Penetrate
aTpy:ReliefInPlace  EQUATE('341900')    ! Relief in Place (RIP)
aTpy:Retire         EQUATE('342000')    ! Retire
aTpy:Secure         EQUATE('342100')    ! Secure
aTpy:Security       EQUATE('342200')    ! Security
aTpy:Security_Cover     EQUATE('342201')    ! Security / Cover
aTpy:Security_Guard     EQUATE('342202')    ! Security / Guard
aTpy:Security_Screen    EQUATE('342203')    ! Security / Screen
aTpy:Seize          EQUATE('342300')    ! Seize
aTpy:Withdraw       EQUATE('342400')    ! Withdraw
aTpy:WithdrawUnderPressure  EQUATE('342500')    ! Withdraw Under Pressure

    ! no representation
!aTpy:LineOfContact  EQUATE('140200')        ! Line Of Contact
    
aTpy:PhaseLine      EQUATE('140300')        ! Phase Line
aTpy:ForwardEdge    EQUATE('140400')        ! Forward Edge of the Battle Area
aTpy:ForwardEdge_Proposed   EQUATE('140401')        ! Forward Edge of the Battle Area / Proposed or On Order
aTpy:PrincipleDirectionOfFire       EQUATE('140500')    ! Principle Direction of Fire

aTpy:DirectionOfAttack                      EQUATE('140600')    ! Direction of Attack
aTpy:DirectionOfAttack_FriendlyAviation     EQUATE('140601')    ! Direction of Attack / Friendly Aviation
aTpy:DirectionOfAttack_FriendlyDirectionOfMainAttack                    EQUATE('140602')    ! Direction of Attack / Friendly Direction of Main Attack
aTpy:DirectionOfAttack_FriendlyDirectionOfSupportingAttack              EQUATE('140603')    ! Direction of Attack / 	Friendly Direction of Supporting Attack
aTpy:DirectionOfAttack_Feint                        EQUATE('140605')    ! Direction of Attack / Feint
aTpy:DirectionOfAttack_EnemyConfirmed               EQUATE('140606')    ! Direction of Attack / Enemy Confirmed
aTpy:DirectionOfAttack_EnemyTemplated               EQUATE('140607')    ! Direction of Attack / Enemy Templated or Suspected

aTpy:FinalCoordinationLine  EQUATE('140700')          ! Final Coordination Line
aTpy:InfiltrationLane       EQUATE('140800')          ! Infiltration Lane
aTpy:LimitOfAdvance         EQUATE('140900')          ! Limit of Advance
aTpy:LineofDeparture        EQUATE('141000')          ! Line of Departure
aTpy:LineofContact          EQUATE('141100')          ! Line of Departure/Line of Contact
aTpy:ProbableLineofDeployment       EQUATE('141200')        ! Probable Line of Deployment
aTpy:AirheadLine                    EQUATE('141300')        ! Airhead Line
aTpy:BridgeheadLine EQUATE('141400')        ! Bridgehead Line
aTpy:HoldingLine    EQUATE('141500')        ! Holding Line
aTpy:ReleaseLine    EQUATE('141600')        ! Release Line
aTpy:Ambush         EQUATE('141700')        ! Ambush


aTpy:AxisOfAdvance                                  EQUATE('151400')    ! Axis Of Advance
aTpy:AxisOfAdvance_FriendlyAirborne_Aviation        EQUATE('151401')    ! Axis Of Advance / Friendly Airborne/Aviation
aTpy:AxisOfAdvance_AttackHelicopter                 EQUATE('151402')    ! Axis Of Advance / Attack Helicopte
aTpy:AxisOfAdvance_MainAttack                       EQUATE('151403')    ! Axis Of Advance / Main Attack
aTpy:AxisOfAdvance_SupportingAttack                 EQUATE('151404')    ! Axis Of Advance / Supporting Attack
aTpy:AxisOfAdvance_SupportingAttackPlanned          EQUATE('151405')    ! Axis Of Advance / Supporting Attack Planned or On Order
aTpy:AxisOfAdvance_Feint                            EQUATE('151406')    ! Axis Of Advance / Feint
aTpy:AxisOfAdvance_EnemyConfirmed                   EQUATE('151407')    ! Axis Of Advance / Enemy Confirmed
aTpy:AxisOfAdvance_EnemyTemplated_Suspected         EQUATE('151408')    ! Axis Of Advance / Enemy Templated or Suspected
aTpy:AssaultPosition                                EQUATE('151500')    ! Assault Position
aTpy:AttackPosition                                 EQUATE('151600')    ! Attack Position
aTpy:Objective      EQUATE('151700')    ! Objective
aTpy:Encirclement   EQUATE('151800')    ! Encirclement
aTpy:Encirclement_Friendly  EQUATE('151801')    ! Encirclement / Friendly
aTpy:Encirclement_Enemy     EQUATE('151802')    ! Encirclement / Enemy
aTpy:PenetratioBox          EQUATE('151900')    ! Penetration Box
aTpy:AttackByFirePosition   EQUATE('152000')    ! Attack By Fire Position
aTpy:SupportByFire  EQUATE('152100')    ! Support By Fire
aTpy:SearchArea     EQUATE('152200')    ! Search Are / Reconnaissance Area


! Units Queue Structure
UnitsQueue           QUEUE, TYPE
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

! Queue of BSOs (Classes)
UnitsClassQueue     QUEUE, TYPE
unit                    &BSO
                    END


! Actions Queue Structure
    ! should become obsolete
ActionsQueue         QUEUE, TYPE
ActionName              STRING(100)
ActionType              LONG
ActionTypeCode          STRING(10)
ActionPointsNumber      LONG
!xPos                    LONG, DIM(100)
!yPos                    LONG, DIM(100)
ActionPoints            &PosList
APoints                 &PointsCollection
!Resources                   &UnitsQueue
                        END

! Queue of Actions (Classes)
ActionsClassQueue   QUEUE, TYPE
action                  &Action
                    END


! Action with Resources Queue Structure
    ! should become obsolete
ActResQueue         QUEUE(ActionsQueue)
Resources               &UnitsQueue
                    END

! Queue of Action with Resources (Classes)
ActResClassQueue    QUEUE(ActionsClassQueue)
resources               &UnitsClassQueue
                    END


! Action with Resources and Targets Queue Structure
    ! should become obsolete
ActResTargetsQueue  QUEUE(ActResQueue)
ActTargets              &ActionsQueue
BSOTargets              &UnitsQueue
                    END

! Queue of Actions with Resources and Targets (Classes)
ActResTargetsClassQueue     QUEUE(ActResClassQueue)
actTargets                      &ActionsClassQueue
BSOtargets                      &UnitsClassQueue
                            END

! Position Record
PosRecord           GROUP, TYPE
xPos                        LONG
yPos                        LONG
                    END

! List of Positions
PosList            QUEUE, TYPE
xPos                        LONG
yPos                        LONG
                    END

! PosListClass Queue is necessary


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
!xPos                    LONG, DIM(100)
!yPos                    LONG, DIM(100)
ActionPoints            &PosList

editableText            STRING(100)
                    END


! Reference C2IPs Queue Structure
C2IPsList           QUEUE, TYPE
C2IPPath                STRING(100)
C2IPName                STRING(100)
                    END


! C2IP Utilities
C2IPUtilities       INTERFACE
Log                     PROCEDURE(), STRING
                    END

! C2IP Operators
C2IPOperators       INTERFACE
Eql                     PROCEDURE(PosList l1, PosList l2), BOOL
    END
    


BSO                 CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
urec                    GROUP(UnitBasicRecord)
                        END

Construct               PROCEDURE()
Init                    PROCEDURE(*UnitBasicRecord pUrec), BOOL
Destruct                PROCEDURE()

                    END

Action              CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
arec                    GROUP(ActionBasicRecord)
                        END
! the firs 2 points - usually for most actions
xPos1                   LONG, PRIVATE
yPos1                   LONG, PRIVATE
xPos2                   LONG, PRIVATE
yPos2                   LONG, PRIVATE
! lowerX, lowerY, highestX, highestY - the points that define the containing rectangle
lowestX                 LONG, PRIVATE
lowestY                 LONG, PRIVATE
highestX                LONG, PRIVATE
highestY                LONG, PRIVATE

Construct               PROCEDURE()
Init                    PROCEDURE(*ActionBasicRecord pArec), BOOL
Destruct                PROCEDURE()

ComputeSelectRectangle  PROCEDURE(), PRIVATE
GetAnchorPoints         PROCEDURE(*LONG pLowestX, *LONG pLowestY, *LONG pHighestX, *LONG pHighestY), BOOL
SetText                 PROCEDURE(STRING sText), BOOL

CheckLineByMouse        PROCEDURE(LONG nXPos, LONG nYPos), LONG
CheckRectangleByMouse   PROCEDURE(LONG nXPos, LONG nYPos), LONG
CheckFreeHandByMouse    PROCEDURE(LONG nXPos, LONG nYPos), LONG
                    END


! Points Collection Class
! a collection of Point Onjects
PointsCollection        CLASS, MODULE('PointsCollection.clw'), LINK('PointsCollection.clw'), TYPE
pl                          &PosList

Construct                   PROCEDURE()
Destruct                    PROCEDURE()

Init                        PROCEDURE(LONG nXpos, LONG nYPos), BOOL
Init                        PROCEDURE(*PosRecord pPRec), BOOL

InsertPoint                 PROCEDURE(LONG nXPos, LONG nYPos), BOOL
InsertPoint                 PROCEDURE(*PosRecord pPRec), BOOL
                        END

! Units Collection Class
! a collection of Units Objects
UnitsCollection       CLASS, MODULE('pmC2IPLibrary.clw'), LINK('pmC2IPLibrary.clw'), TYPE
ul                          &UnitsQueue
collection                  &UnitsClassQueue

tmpul                   &UnitsQueue, PRIVATE
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
InsertNode              PROCEDURE(*BSO pBSO), BOOL
AddNode                 PROCEDURE(*UnitBasicRecord pUrec), LONG
GetNode                 PROCEDURE(*UnitBasicRecord pURec), LONG
GetNode                 PROCEDURE(LONG Pointer, *UnitBasicRecord pURec), BOOL
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
CheckByMouse            PROCEDURE(LONG nXPos, LONG nYPos), LONG    
ChangeNodePos           PROCEDURE(LONG nXPos, LONG nYPos), LONG
                    END


! Actions Colleciton Class
! a collection of Actions Objects
ActionsCollection           CLASS, IMPLEMENTS(C2IPOperators), | 
                        MODULE('ActionsCollection.clw'), LINK('ActionsCollection.clw'), TYPE
al                          &ActResTargetsQueue         ! a queue of action records
collection                  &ActResTargetsClassQueue    ! a queue of action classes

Construct                   PROCEDURE()
Destruct                    PROCEDURE()

! Move all action points with dx & dy
ChangeActionPos             PROCEDURE(LONG nPos, LONG nDX, LONG nDY), BOOL

InsertAction                PROCEDURE(ActionBasicRecord parec)
InsertAction                PROCEDURE(ActionBasicRecord parec, UnitBasicRecord purec)
InsertAction                PROCEDURE(*Action pAction, *BSO pBSO)
InsertAction                PROCEDURE(ActionBasicRecord parec, UnitBasicRecord purec, UnitBasicRecord pTarget_urec)
InsertAction                PROCEDURE(ActionBasicRecord parec, UnitBasicRecord purec, ActionBasicRecord pTarget_arec)
GetAction                   PROCEDURE(LONG nPointer, *ActionBasicRecord pARec), LONG
GetAction                   PROCEDURE(LONG nPointer, *Action pAction), LONG
SelectByMouse               PROCEDURE(LONG nXPos, LONG nYPos), LONG
CheckByMouse                PROCEDURE(LONG nXPos, LONG nYPos), LONG
CheckLineByMouse            PROCEDURE(LONG nXPos, LONG nYPos), LONG
                    END

    

! Generic C2IP structure
C2IP                CLASS, IMPLEMENTS(C2IPUtilities), MODULE('C2IP.clw'), LINK('C2IP.clw'), TYPE
Name                    STRING(100)
ul                      &UnitsCollection
tmpul                   &UnitsCollection
tmpUnitName             STRING(100), PRIVATE
lastOperation           STRING(100), PROTECTED

! Draw representation
drwImg                  &Draw
TakeEvent               PROCEDURE(), VIRTUAL
geometry                LONG        ! geometry equates
isSelection             BOOL, PROTECTED
isABSOSelected          PROCEDURE(), BOOL
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
CheckByMouse            PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
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
TakeMouseDown           PROCEDURE(), PRIVATE
TakeMouseMove           PROCEDURE(), PRIVATE
TakeMouseUp             PROCEDURE(), PRIVATE

    ! draw actions preview (during visual construction)
Draw_Line               PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_Line               PROCEDURE(PosRecord startPos, PosRecord endPos)
Draw_Rectangle          PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_Rectangle          PROCEDURE(PosRecord startPos, PosRecord endPos)
Draw_Polygon            PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_Polygon            PROCEDURE(PosRecord startPos, PosRecord endPos)
Draw_FreeHand           PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_FreeHand           PROCEDURE()
Reset_FreeHand          PROCEDURE(), PRIVATE

Preview_Arrow           PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
Preview_FreeLine        PROCEDURE(LONG nXPos, LONG nYPos), PROTECTED
Draw_AxisAdvance        PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_Ambush             PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_Circle             PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_LineWithBase       PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED
Draw_LineWithHeader     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED

Draw_Breach             PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview = FALSE), PROTECTED

!actionType              LONG, PROTECTED
actionTypeCode          STRING(10), PROTECTED
p1x                     LONG, PROTECTED
p1y                     LONG, PROTECTED
PolyPoints              LONG, PROTECTED
pp                      &PosList, PROTECTED

refSelectedXPos         LONG, PRIVATE
refSelectedYPos         LONG, PRIVATE
isDrawingSelection      BOOL, PROTECTED
isBSOMoved              BOOL, PROTECTED
isDrawingMoved          BOOL, PROTECTED
selectedDrawingPos      LONG, PRIVATE
selectedDrawing         GROUP(ActionBasicRecord), PRIVATE
                        END
selectedDrawingClass    &Action
textBuffer              STRING(100), PRIVATE


TakePoints              PROCEDURE(LONG nGeometry)


Construct               PROCEDURE
Destruct                PROCEDURE

Redraw                  PROCEDURE, PROTECTED, VIRTUAL

DeployBSO               PROCEDURE(*UnitBasicRecord pUrec, LONG nXPos, LONG nYPos), BOOL

! referenced C2IPs
AttachC2IP              PROCEDURE(STRING sFileName), LONG
AttachMap               PROCEDURE(STRING sFileName), LONG

SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
SelectDrawingByMouse    PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
CheckByMouse            PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
CheckDrawingByMouse     PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
MoveTo                  PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL
MoveDrawingTo           PROCEDURE(LONG nXPos, LONG nYPos), LONG, VIRTUAL

SetGeometry             PROCEDURE(LONG nGeometry), LONG
SetActionTypeCode       PROCEDURE(STRING sActionTypeCode), LONG
SetAction               PROCEDURE(STRING sActionTypeCode, LONG nGeometry), LONG
TakeNodeAction          PROCEDURE(LONG nOption), LONG
NodeActionsMenuOptions  PROCEDURE(), STRING

    ! Draw final actions representations
DA_SupportingAttack     PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_AxisOfAdvance        PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_Ambush               PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_Arrest               PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_Block                PROCEDURE(PosRecord startPos, PosRecord endPos)
DA_Breach               PROCEDURE(PosRecord startPos, PosRecord endPos)

TakePoints              PROCEDURE(PosRecord startPos, PosRecord endPos)    

InsertAction            PROCEDURE()

DrawAction              PROCEDURE()

prevBSOSelection        LONG, PROTECTED
prevActionSelection     LONG, PROTECTED
DisplaySelection        PROCEDURE(LONG nAPointer)
DisplayUnselection      PROCEDURE(LONG nAPointer)


! persistence layer
!Save                    PROCEDURE(), LONG
Save                    PROCEDURE(STRING sFileName), LONG
Load                    PROCEDURE(STRING sFileName), LONG
                    END




