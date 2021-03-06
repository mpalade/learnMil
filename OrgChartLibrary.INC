!ABCIncludeFile
OMIT('_EndOfInclude_',_OrgChartLibrary_)
_OrgChartLibrary_ EQUATE(1)
! Unit Types Equates
uTpy:notDefined     EQUATE(1000)
uTpy:infantry       EQUATE(1001)

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
! JSON objects

json        JSONClass
collection  &JSONClass
! entry fields

?uNameEntry         EQUATE(900)
?uTypeList          EQUATE(901)
?uHQ                EQUATE(902)

?ListSymbology      EQUATE(903)
!!! <summary>
!!! Generated class template - SourceClass
!!! OrgChartC2IP
!!! </summary>
! Organization Chart structure
OrgChartC2IP        CLASS, TYPE
Name                    STRING(100)
ul                      &UnitsList
tmpul                   &UnitsList, PRIVATE
tmpUnitName             STRING(100), PRIVATE

! Draw representation
drwImg                  &Draw
! Previewer representation
!prwImg                  &Draw

! referenced C2IPs list
refC2IPs                &C2IPsList

! Unit basic record structure
urec                    GROUP
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

selTreePos              LONG, PRIVATE
maxTreePos              LONG, PRIVATE
selQueuePos             LONG, PRIVATE

labelEditMode           BOOL, PRIVATE
uNameEntry              STRING(100), PRIVATE
bIsHQEntry              BOOL, PRIVATE
nEchelon                LONG, PRIVATE


Construct               PROCEDURE
InitDraw                PROCEDURE(Draw pDraw), LONG                           
!InitPreview             PROCEDURE(Draw pDraw), LONG

Redraw                  PROCEDURE, PRIVATE
DrawNode                PROCEDURE(LONG nUnitType=0), LONG, PRIVATE

!DrawNode variants
DrawNode_Default        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Amphibious    PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Armored       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_MainGunSystem PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_Motorized     PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE
DrawNode_Infantry_FightingVehicle       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

DrawNode_Observer       PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE


DrawNode_Echelon        PROCEDURE(BOOL bAutoDisplay=TRUE), LONG, PRIVATE

InsertNode              PROCEDURE, PRIVATE
InsertNode              PROCEDURE(*UnitBasicRecord pUrec), LONG
GetNode                 PROCEDURE(*UnitBasicRecord pURec), LONG
DeleteNode              PROCEDURE, PRIVATE
DisableNode             PROCEDURE
DisplaySelection        PROCEDURE, PRIVATE
DisplayUnselection      PROCEDURE, PRIVATE
SelUp                   PROCEDURE, PRIVATE
SelDown                 PROCEDURE, PRIVATE
SelLeft                 PROCEDURE, PRIVATE
SelRight                PROCEDURE, PRIVATE
SelectByMouse           PROCEDURE(LONG nXPos, LONG nYPos), LONG
Unselect                PROCEDURE(), LONG
Destruct                PROCEDURE

GetUnitName             PROCEDURE(), STRING
SetUnitName             PROCEDURE(STRING sUnitName), LONG

GetUnitType             PROCEDURE(), STRING
SetUnitType             PROCEDURE(LONG nUnitType), LONG
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
_EndOfInclude_
