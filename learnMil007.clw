

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL007.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LEARNMIL002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LEARNMIL003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LEARNMIL004.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LEARNMIL008.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LEARNMIL010.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form MissionTASKORG
!!! </summary>
U_MissionTASKORG PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(OrgMissions)
                       PROJECT(OrgMiss:ID)
                       PROJECT(OrgMiss:Organization)
                       JOIN(myOrg:PKID,OrgMiss:Organization)
                         PROJECT(myOrg:Name)
                         PROJECT(myOrg:ID)
                       END
                     END
FDCB9::View:FileDropCombo VIEW(C2IPExplorer)
                       PROJECT(C2IPExp:ID)
                       PROJECT(C2IPExp:C2IP)
                       JOIN(C2IP:PKID,C2IPExp:C2IP)
                         PROJECT(C2IP:Name)
                         PROJECT(C2IP:ID)
                         PROJECT(C2IP:Type)
                         JOIN(tpyC2IP:PKID,C2IP:Type)
                           PROJECT(tpyC2IP:Code)
                           PROJECT(tpyC2IP:ID)
                         END
                       END
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?myOrg:Name
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
OrgMiss:ID             LIKE(OrgMiss:ID)               !Primary key field - type derived from field
myOrg:ID               LIKE(myOrg:ID)                 !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?C2IP:Name
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
C2IPExp:ID             LIKE(C2IPExp:ID)               !Primary key field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Related join file key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::MissTSK:Record LIKE(MissTSK:RECORD),THREAD
QuickWindow          WINDOW('Form MissionTASKORG'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_MissionTASKORG'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?MissTSK:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(MissTSK:ID),DECIMAL(12)
                           PROMPT('Mission:'),AT(8,34),USE(?MissTSK:Mission:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,34,48,10),USE(MissTSK:Mission),DECIMAL(12)
                           PROMPT('TASKORG C2IP:'),AT(8,48),USE(?MissTSK:TASKORGC2IP:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,48,48,10),USE(MissTSK:TASKORGC2IP),DECIMAL(12)
                           COMBO(@s100),AT(115,34,291,10),USE(myOrg:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@'), |
  FROM(Queue:FileDropCombo),IMM
                           COMBO(@s100),AT(115,48,291,9),USE(C2IP:Name),DROP(5),FORMAT('100L(2)|M~C2IP Name~C(0)@s' & |
  '100@40L(2)|M~C2IP Type~C(0)@s20@'),FROM(Queue:FileDropCombo:1),IMM
                         END
                       END
                       BUTTON('&OK'),AT(259,68,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(313,68,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(365,68,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

FDCB8                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
                     END

FDCB9                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:1         !Reference to browse queue type
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Mission''s TaskOrg'
  OF InsertRecord
    ActionMessage = 'Define New TaskOrg'
  OF ChangeRecord
    ActionMessage = 'Modify TaskOrg'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_MissionTASKORG')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?MissTSK:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(MissTSK:Record,History::MissTSK:Record)
  SELF.AddHistoryField(?MissTSK:ID,1)
  SELF.AddHistoryField(?MissTSK:Mission,2)
  SELF.AddHistoryField(?MissTSK:TASKORGC2IP,3)
  SELF.AddUpdateFile(Access:MissionTASKORG)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MissionTASKORG
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?MissTSK:ID{PROP:ReadOnly} = True
    ?MissTSK:Mission{PROP:ReadOnly} = True
    ?MissTSK:TASKORGC2IP{PROP:ReadOnly} = True
    DISABLE(?myOrg:Name)
    DISABLE(?C2IP:Name)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_MissionTASKORG',QuickWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(myOrg:Name,?myOrg:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:OrgMissions,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(OrgMiss:PKID)
  FDCB8.AddField(myOrg:Name,FDCB8.Q.myOrg:Name) !List box control field - type derived from field
  FDCB8.AddField(OrgMiss:ID,FDCB8.Q.OrgMiss:ID) !Primary key field - type derived from field
  FDCB8.AddField(myOrg:ID,FDCB8.Q.myOrg:ID) !Related join file key field - type derived from field
  FDCB8.AddUpdateField(OrgMiss:ID,MissTSK:Mission)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  FDCB9.Init(C2IP:Name,?C2IP:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:C2IPExplorer,ThisWindow,GlobalErrors,1,1,0)
  FDCB9.AskProcedure = 1
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(C2IPExp:KOrganization)
  FDCB9.AddField(C2IP:Name,FDCB9.Q.C2IP:Name) !List box control field - type derived from field
  FDCB9.AddField(tpyC2IP:Code,FDCB9.Q.tpyC2IP:Code) !List box control field - type derived from field
  FDCB9.AddField(C2IPExp:ID,FDCB9.Q.C2IPExp:ID) !Primary key field - type derived from field
  FDCB9.AddField(C2IP:ID,FDCB9.Q.C2IP:ID) !Related join file key field - type derived from field
  FDCB9.AddField(tpyC2IP:ID,FDCB9.Q.tpyC2IP:ID) !Related join file key field - type derived from field
  FDCB9.AddUpdateField(C2IPExp:C2IP,MissTSK:TASKORGC2IP)
  ThisWindow.AddItem(FDCB9.WindowComponent)
  FDCB9.DefaultFill = 0
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:C2IPExplorer.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_MissionTASKORG',QuickWindow)          ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    UpdateC2IPs
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?C2IP:Name
      FDCB9.TakeAccepted()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Window
!!! </summary>
create_COP PROCEDURE (ULONG pOrgRef, ULONG pMissionRef)

sCOPName             STRING(100)                           ! 
nC2IERef             DECIMAL(7)                            ! 
nC2IPRef             DECIMAL(7)                            ! 
QuickWindow          WINDOW('Create COP'),AT(,,523,345),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,HLP('create_COP'),SYSTEM
                       BUTTON('&OK'),AT(367,329,49,14),USE(?Ok),LEFT,ICON('WAOK.ICO'),FLAT,MSG('Accept operation'), |
  TIP('Accept Operation')
                       BUTTON('&Cancel'),AT(420,329,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel Operation'), |
  TIP('Cancel Operation')
                       BUTTON('&Help'),AT(472,329,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       PROMPT('Name:'),AT(2,10),USE(?sCOPName:Prompt)
                       ENTRY(@s100),AT(53,10,361,10),USE(sCOPName)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('create_COP')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Ok
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Ok,RequestCancelled)                    ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Ok,RequestCompleted)                    ! Add the close control to the window manger
  END
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IEs.Open                                       ! File _C2IEs used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IPContent.SetOpenRelated()
  Relate:_C2IPContent.Open                                 ! File _C2IPContent used by this procedure, so make sure it's RelationManager is open
  Access:type_C2IP.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:_C2IPs.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_C2IE.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('create_COP',QuickWindow)                   ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  ! Create COP C2IP
  
  sCOPName = ''
  LOOP 10 TIMES
      sCOPName = CLIP(sCOPName) & CHR(RANDOM(97, 122))    
  END
  
  
  IF LEN(CLIP(sCOPName))>0 THEN
      ! Create default OVERLAY C2IE
      Access:_C2IEs.PrimeAutoInc()
      nC2IERef    = _C2IE:ID
      tpyC2IE:Code    = 'OVERLAY'
      IF Access:type_C2IE.Fetch(tpyC2IE:KCode) = Level:Benign THEN
          _C2IE:Type  = tpyC2IE:ID
      END
      _C2IE:Name  = sCOPName
      IF Access:_C2IEs.TryInsert() = Level:Benign THEN        
          ! Create COP C2IP
          Access:_C2IPs.PrimeAutoInc()
          nC2IPRef    = _C2IP:ID
          tpyC2IP:Code     = 'COP'
          IF Access:type_C2IP.Fetch(tpyC2IP:KCode) = Level:Benign THEN
              _C2IP:Type  = tpyC2IP:ID
          END
          _C2IP:Name  = sCOPName
          
          IF Access:_C2IPs.TryInsert() = Level:Benign THEN
              ! Create association C2IP - C2IE
              
              Access:_C2IPContent.PrimeAutoInc()
              _C2IPCt:C2IPPackage = nC2IPRef
              _C2IPCt:C2IEInstance    = nC2IERef
              IF Access:_C2IPContent.TryInsert() = Level:Benign THEN
                  !MESSAGE('COP created')
                  
                  ! Add the new C2IP to the current C2IP Explorer
                  Access:C2IPExplorer.PrimeAutoInc()
                  C2IPExp:Organization    = pOrgRef                
                  C2IPExp:C2IP            = nC2IPRef
                  C2IPExp:Mission         = pMissionRef
                  
                  IF Access:C2IPExplorer.TryInsert() = Level:Benign THEN
                      MESSAGE('C2IP COP created')
                  END
                  
              END
              
          END
          
      END
      
  
  END
  
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:C2IPExplorer.Close
    Relate:_C2IEs.Close
    Relate:_C2IPContent.Close
  END
  IF SELF.Opened
    INIMgr.Update('create_COP',QuickWindow)                ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Ok
      ThisWindow.Update()
      ! Update COP C2IP Name
      
      _C2IP:Name  = sCOPName
      
      IF LEN(CLIP(sCOPName))>0 THEN
          IF Access:_C2IPs.TryUpdate() = Level:Benign THEN
              ! COP C2IP Name saved
          END
          
      
      END
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! COP Editor
!!! </summary>
COPApp PROCEDURE (ULONG pC2IPRef,ULONG pOrgRef,ULONG pMissionRef,ULONG pTASKORGC2IPRef)

CurrentTab           STRING(80)                            ! 
vOvrlRef             DECIMAL(7),DIM(20)                    ! 
nOvrlRef             STRING(20)                            ! 
selC2IPRef           DECIMAL(7)                            ! 
selC2IPName          STRING(100)                           ! 
selC2IERef           DECIMAL(7)                            ! 
selC2IEBSORef        DECIMAL(7)                            ! 
selBSORef            DECIMAL(7)                            ! 
selBSOHostility      DECIMAL(7)                            ! 
sBSOTypeCode         STRING(20)                            ! 
sBSOHostilityCode    STRING(20)                            ! 
sBSOCode             STRING(20)                            ! 
sC2IETypeCode        STRING(20)                            ! 
sMoveToOvrlOptMenu   STRING(100)                           ! 
nMoveToOvrlSelection SIGNED                                ! 
vActPoints           LONG,DIM(20)                          ! 
sCOPName             STRING(100)                           ! 
sPrevCOPName         STRING(100)                           ! 
nC2IERef             DECIMAL(7)                            ! 
nC2IPRef             DECIMAL(7)                            ! 
COPBSOs              QUEUE,PRE(copBSO)                     ! 
C2IEUnitRef          DECIMAL(7)                            ! 
xPos                 DECIMAL(7)                            ! 
yPos                 DECIMAL(7)                            ! 
                     END                                   ! 
bBSOFoundOnCanvas    BYTE                                  ! 
nBSOFoundPos         ULONG                                 ! 
BRW1::View:Browse    VIEW(C2IPContent)
                       PROJECT(C2IPCt:ID)
                       PROJECT(C2IPCt:C2IPPackage)
                       PROJECT(C2IPCt:C2IEInstance)
                       JOIN(C2IE:PKID,C2IPCt:C2IEInstance)
                         PROJECT(C2IE:Name)
                         PROJECT(C2IE:ID)
                         PROJECT(C2IE:Type)
                         JOIN(tpyC2IE:PKID,C2IE:Type)
                           PROJECT(tpyC2IE:Code)
                           PROJECT(tpyC2IE:ID)
                         END
                       END
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
C2IPCt:ID              LIKE(C2IPCt:ID)                !List box control field - type derived from field
C2IPCt:C2IPPackage     LIKE(C2IPCt:C2IPPackage)       !List box control field - type derived from field
C2IPCt:C2IEInstance    LIKE(C2IPCt:C2IEInstance)      !List box control field - type derived from field
tpyC2IE:Code           LIKE(tpyC2IE:Code)             !List box control field - type derived from field
C2IE:Name              LIKE(C2IE:Name)                !List box control field - type derived from field
C2IE:ID                LIKE(C2IE:ID)                  !Related join file key field - type derived from field
tpyC2IE:ID             LIKE(tpyC2IE:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW9::View:Browse    VIEW(c2ieTaskOrg)
                       PROJECT(c2ieTO:ID)
                       PROJECT(c2ieTO:C2IE)
                       JOIN(P,'UniP:ID=c2ieTO:Parent')
                         PROJECT(UniP:Code)
                       END
                       JOIN(C1,'UniC1:ID=c2ieTO:Child1')
                         PROJECT(UniC1:Code)
                       END
                       JOIN(C2,'UniC2:ID=c2ieTO:Child2')
                         PROJECT(UniC2:Code)
                       END
                       JOIN(C3,'UniC3:ID=c2ieTO:Child3')
                         PROJECT(UniC3:Code)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
UniP:Code              LIKE(UniP:Code)                !List box control field - type derived from field
UniC1:Code             LIKE(UniC1:Code)               !List box control field - type derived from field
UniC2:Code             LIKE(UniC2:Code)               !List box control field - type derived from field
UniC3:Code             LIKE(UniC3:Code)               !List box control field - type derived from field
c2ieTO:ID              LIKE(c2ieTO:ID)                !Primary key field - type derived from field
c2ieTO:C2IE            LIKE(c2ieTO:C2IE)              !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW10::View:Browse   VIEW(c2ieUnits)
                       PROJECT(c2ieUni:ID)
                       PROJECT(c2ieUni:Hostility)
                       PROJECT(c2ieUni:C2IE)
                       PROJECT(c2ieUni:Unit)
                       JOIN(Uni:PKID,c2ieUni:Unit)
                         PROJECT(Uni:Code)
                         PROJECT(Uni:Name)
                         PROJECT(Uni:ID)
                         PROJECT(Uni:BSOType)
                         JOIN(tpyBSO:PKID,Uni:BSOType)
                           PROJECT(tpyBSO:Code)
                           PROJECT(tpyBSO:ID)
                         END
                       END
                       JOIN(tpyHstl:PKID,c2ieUni:Hostility)
                         PROJECT(tpyHstl:Code)
                         PROJECT(tpyHstl:ID)
                       END
                       JOIN(_meta_c2ieUni:Kc2ieUni,c2ieUni:ID)
                         PROJECT(_meta_c2ieUni:movedToOverlay)
                       END
                       JOIN(c2ieUniPos:Kc2ieUnit,c2ieUni:ID)
                         PROJECT(c2ieUniPos:xPos)
                         PROJECT(c2ieUniPos:yPos)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:2
c2ieUni:ID             LIKE(c2ieUni:ID)               !List box control field - type derived from field
tpyBSO:Code            LIKE(tpyBSO:Code)              !List box control field - type derived from field
Uni:Code               LIKE(Uni:Code)                 !List box control field - type derived from field
Uni:Name               LIKE(Uni:Name)                 !List box control field - type derived from field
Uni:Name_Icon          LONG                           !Entry's icon ID
c2ieUni:Hostility      LIKE(c2ieUni:Hostility)        !List box control field - type derived from field
tpyHstl:Code           LIKE(tpyHstl:Code)             !List box control field - type derived from field
_meta_c2ieUni:movedToOverlay LIKE(_meta_c2ieUni:movedToOverlay) !List box control field - type derived from field
c2ieUniPos:xPos        LIKE(c2ieUniPos:xPos)          !List box control field - type derived from field
c2ieUniPos:yPos        LIKE(c2ieUniPos:yPos)          !List box control field - type derived from field
c2ieUni:C2IE           LIKE(c2ieUni:C2IE)             !Browse key field - type derived from field
Uni:ID                 LIKE(Uni:ID)                   !Related join file key field - type derived from field
tpyBSO:ID              LIKE(tpyBSO:ID)                !Related join file key field - type derived from field
tpyHstl:ID             LIKE(tpyHstl:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW11::View:Browse   VIEW(c2ieUnitsPositions)
                       PROJECT(c2ieUniPos:c2ieUnit)
                       PROJECT(c2ieUniPos:xPos)
                       PROJECT(c2ieUniPos:yPos)
                       PROJECT(c2ieUniPos:ID)
                     END
Queue:Browse:3       QUEUE                            !Queue declaration for browse/combo box using ?List:3
c2ieUniPos:c2ieUnit    LIKE(c2ieUniPos:c2ieUnit)      !List box control field - type derived from field
c2ieUniPos:xPos        LIKE(c2ieUniPos:xPos)          !List box control field - type derived from field
c2ieUniPos:yPos        LIKE(c2ieUniPos:yPos)          !List box control field - type derived from field
c2ieUniPos:ID          LIKE(c2ieUniPos:ID)            !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('COP App'),AT(,,799,346),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('OverlayEditorApp2'),SYSTEM
                       LIST,AT(10,30,130,124),USE(?Browse:1),HVSCROLL,FORMAT('0R(2)|M~ID~C(0)@n-10.0@0R(2)|M~C' & |
  '2IP Pck~C(0)@n-10.0@0R(2)|M~ID~C(0)@n-10.0@[40R(2)|M~C2IE Type~C(0)@s20@100R(2)|M~C2' & |
  'IE Name~C(0)@s100@]|~C2IE (Information Element)~'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he C2IPContent file')
                       BUTTON('&Insert'),AT(9,156,37,14),USE(?Insert:4),LEFT,FLAT,MSG('Insert a Record'),TIP('Insert a Record')
                       BUTTON('&Change'),AT(39,156,37,14),USE(?Change:4),LEFT,DEFAULT,FLAT,MSG('Change the Record'), |
  TIP('Change the Record')
                       BUTTON('&Delete'),AT(79,156,36,14),USE(?Delete:4),LEFT,FLAT,MSG('Delete the Record'),TIP('Delete the Record')
                       LIST,AT(9,194,281,100),USE(?List),DECIMAL(12),HVSCROLL,FORMAT('[60L(2)|M~1stOrdEch~C(0)' & |
  '@s20@60L(2)|M~1stOrdSubOrd~C(0)@s20@60L(2)|M~2ndOrdSubOrd~C(0)@s20@60L(2)|M~3rddOrdS' & |
  'ubOrd~C(0)@s20@]|~TASKORG~'),FROM(Queue:Browse),IMM,VCR
                       BUTTON('Move to Overlay'),AT(369,280),USE(?BUTTON_MoveToOverlay)
                       LIST,AT(143,30,205,124),USE(?List:2),HVSCROLL,DRAGID('moveToOvrl'),FORMAT('0L(2)|M~ID~D' & |
  '(12)@n-10.0@[40L(2)|M~BSO Type~C(0)@s20@40L(2)|M~BSO Code~C(0)@s20@80L(2)|MI~BSO Nam' & |
  'e~C(0)@s100@0L(2)|M~Hostility~D(12)@n-10.0@]|~BSO~40L(2)|M~Hostility~C(0)@s20@0L(2)|' & |
  'M~Moved~C(0)@n3@0L(2)|M~x Pos~D(12)@n-10.0@0L(2)|M~y Pos~D(12)@n-10.0@'),FROM(Queue:Browse:2), |
  IMM,VCR
                       BUTTON('&Insert'),AT(144,158,42,12),USE(?Insert)
                       BUTTON('&Change'),AT(185,158,42,12),USE(?Change)
                       BUTTON('&Delete'),AT(228,158,42,12),USE(?Delete)
                       LIST,AT(353,30,82,124),USE(?List:3),DECIMAL(12),FORMAT('0L(2)|M~ID~D(12)@n-10.0@40L(2)|' & |
  'M~xPos~C(0)@n-10.0@40L(2)|M~yPos~C(0)@n-10.0@'),FROM(Queue:Browse:3),IMM
                       BUTTON('&Insert'),AT(353,160,42,12),USE(?Insert:2)
                       BUTTON('&Change'),AT(353,170,42,12),USE(?Change:2)
                       BUTTON('&Delete'),AT(394,170,42,12),USE(?Delete:2)
                       BUTTON('Define Action'),AT(369,298),USE(?BUTTON1)
                       BUTTON('Action Properties'),AT(353,193),USE(?BUTTON_ActProp)
                       BUTTON('&Close'),AT(568,329,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(621,329,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       IMAGE,AT(442,2,355,322),USE(?Draw)
                       PROMPT('Name:'),AT(9,9),USE(?sCOPName:Prompt)
                       ENTRY(@s100),AT(50,8,385,10),USE(sCOPName),FONT(,,,FONT:regular)
                       REGION,AT(442,2,363,324),USE(?PANEL1),DROPID('moveToOvrl'),IMM
                       BUTTON('compute COPBSOs'),AT(9,298),USE(?BUTTON2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRWC2IPContent       CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepRealClass                        ! Default Step Manager
BRWC2IETaskorg       CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

BRW9::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRWC2IEBSOs          CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
SetQueueRecord         PROCEDURE(),DERIVED
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW10::Sort0:Locator StepLocatorClass                      ! Default Locator
BRWBOSPos            CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:3                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW11::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW10::EIPManager    BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List:2
EditInPlace::c2ieUni:ID EditEntryClass                     ! Edit-in-place class for field c2ieUni:ID
EditInPlace::tpyBSO:Code EditEntryClass                    ! Edit-in-place class for field tpyBSO:Code
EditInPlace::Uni:Code EditEntryClass                       ! Edit-in-place class for field Uni:Code
EditInPlace::Uni:Name EditEntryClass                       ! Edit-in-place class for field Uni:Name
EditInPlace::c2ieUni:Hostility EditEntryClass              ! Edit-in-place class for field c2ieUni:Hostility
EditInPlace::tpyHstl:Code EditEntryClass                   ! Edit-in-place class for field tpyHstl:Code
EditInPlace::_meta_c2ieUni:movedToOverlay EditEntryClass   ! Edit-in-place class for field _meta_c2ieUni:movedToOverlay
EditInPlace::c2ieUniPos:xPos EditEntryClass                ! Edit-in-place class for field c2ieUniPos:xPos
EditInPlace::c2ieUniPos:yPos EditEntryClass                ! Edit-in-place class for field c2ieUniPos:yPos
BRW11::EIPManager    BrowseEIPManager                      ! Browse EIP Manager for Browse using ?List:3
EditInPlace::c2ieUniPos:c2ieUnit EditEntryClass            ! Edit-in-place class for field c2ieUniPos:c2ieUnit
EditInPlace::c2ieUniPos:xPos EditEntryClass                ! Edit-in-place class for field c2ieUniPos:xPos
EditInPlace::c2ieUniPos:yPos EditEntryClass                ! Edit-in-place class for field c2ieUniPos:yPos
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

! ----- DrwOverlay --------------------------------------------------------------------------
DrwOverlay           Class(Draw)
    ! derived method declarations
                     End  ! DrwOverlay
! ----- end DrwOverlay -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
_newCOPC2IP         ROUTINE
DATA
CODE
    

        IF LEN(CLIP(sCOPName))>0 THEN
            ! Create default OVERLAY C2IE
            Access:_C2IEs.PrimeAutoInc()
            nC2IERef    = _C2IE:ID            
            tpyC2IE:Code    = 'OVERLAY'
            IF Access:type_C2IE.Fetch(tpyC2IE:KCode) = Level:Benign THEN
                _C2IE:Type  = tpyC2IE:ID
            END
            _C2IE:Name  = sCOPName
            IF Access:_C2IEs.TryInsert() = Level:Benign THEN        
                ! Create COP C2IP
                Access:_C2IPs.PrimeAutoInc()
                nC2IPRef    = _C2IP:ID
                selC2IPRef  = nC2IPRef
                tpyC2IP:Code     = 'COP'
                IF Access:type_C2IP.Fetch(tpyC2IP:KCode) = Level:Benign THEN
                    _C2IP:Type  = tpyC2IP:ID
                END
                _C2IP:Name  = sCOPName
                
                IF Access:_C2IPs.TryInsert() = Level:Benign THEN
                    ! Create association C2IP - C2IE
                    
                    Access:_C2IPContent.PrimeAutoInc()
                    _C2IPCt:C2IPPackage = nC2IPRef
                    _C2IPCt:C2IEInstance    = nC2IERef
                    IF Access:_C2IPContent.TryInsert() = Level:Benign THEN
                        !MESSAGE('COP created')
                        
                        ! Add the new C2IP to the current C2IP Explorer
                        Access:C2IPExplorer.PrimeAutoInc()
                        C2IPExp:Organization    = pOrgRef                
                        C2IPExp:C2IP            = nC2IPRef
                        C2IPExp:Mission         = pMissionRef
                        
                        IF Access:C2IPExplorer.TryInsert() = Level:Benign THEN
                            !MESSAGE('C2IP COP created')
                        END
                        
                    END
                    
                END
                
            END
            

        END
    
    EXIT
    
_attachTASKORGC2IP  ROUTINE
DATA
CODE
    
    ! attach TASKORG C2IP
    Access:_C2IPContent.PrimeAutoInc()
    _C2IPCt:C2IPPackage = nC2IPRef
    
    
    ! reference C2IE associated to the C2iP
    C2IPCt:C2IPPackage = pTASKORGC2IPRef
    IF Access:C2IPContent.TryFetch(C2IPCt:KC2IP) = Level:Benign THEN
        _C2IPCt:C2IEInstance    = C2IPCt:C2IEInstance
    END
    
                    IF Access:_C2IPContent.TryInsert() = Level:Benign THEN
                        !MESSAGE('COP created')                                               
                        
                    END
    EXIT
    
_drawUnits          ROUTINE
    DATA

    CODE
    
        DrwOverlay.Blank(COLOR:White)
        DrwOverlay.Display()    
        
    ! loop C2IP Content (list of C2IEs)
    SET(_C2IPContent)
    LOOP
        IF Access:_C2IPContent.Next() = Level:Benign THEN
            IF _C2IPCt:C2IPPackage = selC2IPRef THEN
                selC2IERef  = _C2IPCt:C2IEInstance
                
                ! Determine C2IE type
                ! Locate C2IE in C2IEs table and find out C2IE type
                _C2IE:ID    = _C2IPCt:C2IEInstance
                IF Access:_C2IEs.TryFetch(_C2IE:PKID) = Level:Benign THEN
                    ! Evaluate C2IE type
                    ! Locate C2IE type in type_C2IE table
                    tpyC2IE:ID = _C2IE:Type
                    IF Access:type_C2IE.TryFetch(tpyC2IE:PKID) = Level:Benign THEN
                        sC2IETypeCode= tpyC2IE:Code
                        CASE tpyC2IE:Code
                        OF 'OVERLAY'
                            ! Computer the number of Overlays
                            IF nOvrlRef < 20 THEN
                                ! increase the C2IE references (of type OVERLAY)
                                nOvrlRef  = nOvrlRef + 1
                                vOvrlRef[nOvrlRef] = _C2IE:ID
                            END
                                                        
                            ! Add C2IE Name to Options Menu
                            IF LEN(CLIP(sMoveToOvrlOptMenu))<>0 THEN                            
                                sMoveToOvrlOptMenu  = CLIP(sMoveToOvrlOptMenu) & '|' & CLIP(_C2IE:Name)
                            ELSE
                                sMoveToOvrlOptMenu  = CLIP(_C2IE:Name)
                            END
                            
                        OF 'TASKORG'
                        OF 'COP'
                        ELSE
                            
                        END
                        
                    END                                
                END                                
                
                ! loop C2IE Units (list of Units/list of BSOs)
                SET(_c2ieUnits)
                LOOP
                    IF Access:_c2ieUnits.Next() = Level:Benign THEN
                        IF _c2ieUni:C2IE = selC2IERef THEN
                            ! Display BSO code/short name
                            ! Determine BSO type code 
                            ! Determine BSO hostility code                                                        
                            
                            ! Determine BSO Hostility code
                            tpyHstl:ID  = _c2ieUni:Hostility
                            IF Access:type_Hostility.TryFetch(tpyHstl:PKID) = Level:Benign THEN
                                sBSOHostilityCode   = CLIP(tpyHstl:Code)
                            END                            
                            
                            ! look for BSO in the BSO table
                            _Uni:ID = _c2ieUni:Unit
                            IF Access:_Units.TryFetch(_Uni:PKID) = Level:Benign THEN
                                ! BSO found
                                ! Determine BSO code/short name
                                sBSOCode    = _Uni:Code
                                !DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, _Uni:Code)
                                !MESSAGE('found ' & _Uni:Code)
                                
                                ! Determine BSO type code / Unit/Actions/Tactical graphics, aso
                                tpyBSO:ID = _Uni:BSOType                                
                                IF Access:type_BSO.TryFetch(tpyBSO:PKID) = Level:Benign THEN
                                    sBSOTypeCode    = CLIP(tpyBSO:Code)
                                END                                                                                                
                            END
                            
                            ! Determine positions
                            _c2ieUniPos:c2ieUnit = _c2ieUni:ID
                            IF Access:_c2ieUnitsPositions.TryFetch(_c2ieUniPos:Kc2ieUnit) = Level:Benign THEN                            
                                ! Draw depending on the BSO Type
                                CASE CLIP(sBSOTypeCode)
                                OF 'Unit'
                                    ! Draw depending on the BSO used Hostility
                                    ! Check hostility
                                    CASE CLIP(sBSOHostilityCode)
                                    OF 'Friendly'
                                        !Friendly
                                        DrwOverlay.Box(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Aqua)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    OF 'Enemy'
                                        !Enemy
                                        DrwOverlay.Box(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Red)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    ELSE
                                        !Default friendly
                                        DrwOverlay.Box(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Aqua)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    END
                                OF 'Action'
                                    ! Determine Action type - TBD
                                    
                                    ! Determine Action Drawing Positions
                                    _FillActionVectorPositions(_c2ieUniPos:xPos, _c2ieUniPos:yPos, vActPoints)
                                    
                                    CASE CLIP(sBSOHostilityCode)
                                    OF 'Friendly'
                                        ! Friendly
                                        DrwOverlay.Polygon(vActPoints, COLOR:Aqua, 7)
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    OF 'Enemy'
                                        ! Enemy
                                        DrwOverlay.Polygon(vActPoints, COLOR:Red, 7)
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    ELSE
                                        ! default Friendly
                                        DrwOverlay.Polygon(vActPoints, COLOR:Aqua, 7)
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    END                                    
                                    
                                OF 'TactGraph'
                                    ! Draw depending on the BSO used Hostility
                                    ! Check hostility
                                    CASE CLIP(sBSOHostilityCode)
                                    OF 'Friendly'
                                        !Friendly
                                        DrwOverlay.Ellipse(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Aqua)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    OF 'Enemy'
                                        !Enemy
                                        DrwOverlay.Ellipse(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Red)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    ELSE
                                        !Default friendly
                                        DrwOverlay.Ellipse(_c2ieUniPos:xPos, _c2ieUniPos:yPos, 50, 30, COLOR:Aqua)                        
                                        ! Draw BSO Name
                                        DrwOverlay.Show(_c2ieUniPos:xPos + 5, _c2ieUniPos:yPos + 11, sBSOCode)
                                    END
                                END                                                                                                                              
                                
                            END
                            
                                                
                        END
                    ELSE
                        BREAK
                    END
                END
            END
        ELSE
            BREAK                
        END
    END              
    
        DrwOverlay.Display()
    EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('COPApp')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:C1.Open                                           ! File C1 used by this procedure, so make sure it's RelationManager is open
  Relate:C2.Open                                           ! File C2 used by this procedure, so make sure it's RelationManager is open
  Relate:C2IPContent.SetOpenRelated()
  Relate:C2IPContent.Open                                  ! File C2IPContent used by this procedure, so make sure it's RelationManager is open
  Relate:C3.Open                                           ! File C3 used by this procedure, so make sure it's RelationManager is open
  Relate:P.Open                                            ! File P used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IEs.Open                                       ! File _C2IEs used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IPContent.SetOpenRelated()
  Relate:_C2IPContent.Open                                 ! File _C2IPContent used by this procedure, so make sure it's RelationManager is open
  Relate:_Units.Open                                       ! File _Units used by this procedure, so make sure it's RelationManager is open
  Relate:_c2ieUnits.Open                                   ! File _c2ieUnits used by this procedure, so make sure it's RelationManager is open
  Relate:_c2ieUnitsPositions.Open                          ! File _c2ieUnitsPositions used by this procedure, so make sure it's RelationManager is open
  Relate:_meta_c2ieUnits2.Open                             ! File _meta_c2ieUnits2 used by this procedure, so make sure it's RelationManager is open
  Relate:c2ieUnits.SetOpenRelated()
  Relate:c2ieUnits.Open                                    ! File c2ieUnits used by this procedure, so make sure it's RelationManager is open
  Access:type_C2IP.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:_C2IPs.UseFile                                    ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_C2IE.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_Hostility.UseFile                            ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_BSO.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:C2IPs.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRWC2IPContent.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:C2IPContent,SELF) ! Initialize the browse manager
  BRWC2IETaskorg.Init(?List,Queue:Browse.ViewPosition,BRW9::View:Browse,Queue:Browse,Relate:c2ieTaskOrg,SELF) ! Initialize the browse manager
  BRWC2IEBSOs.Init(?List:2,Queue:Browse:2.ViewPosition,BRW10::View:Browse,Queue:Browse:2,Relate:c2ieUnits,SELF) ! Initialize the browse manager
  BRWBOSPos.Init(?List:3,Queue:Browse:3.ViewPosition,BRW11::View:Browse,Queue:Browse:3,Relate:c2ieUnitsPositions,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
    QuickWindow{PROP:Buffer} = 1 ! Remove flicker when animating.
    DrwOverlay.Init(?Draw)
  Do DefineListboxStyle
  BRWC2IPContent.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon C2IPCt:C2IPPackage for sort order 1
  BRWC2IPContent.AddSortOrder(BRW1::Sort0:StepClass,C2IPCt:KC2IP) ! Add the sort order for C2IPCt:KC2IP for sort order 1
  BRWC2IPContent.AddRange(C2IPCt:C2IPPackage,selC2IPRef)   ! Add single value range limit for sort order 1
  BRWC2IPContent.AddLocator(BRW1::Sort0:Locator)           ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,C2IPCt:C2IPPackage,1,BRWC2IPContent) ! Initialize the browse locator using  using key: C2IPCt:KC2IP , C2IPCt:C2IPPackage
  BRWC2IPContent.AddField(C2IPCt:ID,BRWC2IPContent.Q.C2IPCt:ID) ! Field C2IPCt:ID is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(C2IPCt:C2IPPackage,BRWC2IPContent.Q.C2IPCt:C2IPPackage) ! Field C2IPCt:C2IPPackage is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(C2IPCt:C2IEInstance,BRWC2IPContent.Q.C2IPCt:C2IEInstance) ! Field C2IPCt:C2IEInstance is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(tpyC2IE:Code,BRWC2IPContent.Q.tpyC2IE:Code) ! Field tpyC2IE:Code is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(C2IE:Name,BRWC2IPContent.Q.C2IE:Name) ! Field C2IE:Name is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(C2IE:ID,BRWC2IPContent.Q.C2IE:ID) ! Field C2IE:ID is a hot field or requires assignment from browse
  BRWC2IPContent.AddField(tpyC2IE:ID,BRWC2IPContent.Q.tpyC2IE:ID) ! Field tpyC2IE:ID is a hot field or requires assignment from browse
  BRWC2IETaskorg.Q &= Queue:Browse
  BRWC2IETaskorg.AddSortOrder(,c2ieTO:KC2IE)               ! Add the sort order for c2ieTO:KC2IE for sort order 1
  BRWC2IETaskorg.AddRange(c2ieTO:C2IE,selC2IERef)          ! Add single value range limit for sort order 1
  BRWC2IETaskorg.AddLocator(BRW9::Sort0:Locator)           ! Browse has a locator for sort order 1
  BRW9::Sort0:Locator.Init(,c2ieTO:C2IE,1,BRWC2IETaskorg)  ! Initialize the browse locator using  using key: c2ieTO:KC2IE , c2ieTO:C2IE
  BRWC2IETaskorg.AddField(UniP:Code,BRWC2IETaskorg.Q.UniP:Code) ! Field UniP:Code is a hot field or requires assignment from browse
  BRWC2IETaskorg.AddField(UniC1:Code,BRWC2IETaskorg.Q.UniC1:Code) ! Field UniC1:Code is a hot field or requires assignment from browse
  BRWC2IETaskorg.AddField(UniC2:Code,BRWC2IETaskorg.Q.UniC2:Code) ! Field UniC2:Code is a hot field or requires assignment from browse
  BRWC2IETaskorg.AddField(UniC3:Code,BRWC2IETaskorg.Q.UniC3:Code) ! Field UniC3:Code is a hot field or requires assignment from browse
  BRWC2IETaskorg.AddField(c2ieTO:ID,BRWC2IETaskorg.Q.c2ieTO:ID) ! Field c2ieTO:ID is a hot field or requires assignment from browse
  BRWC2IETaskorg.AddField(c2ieTO:C2IE,BRWC2IETaskorg.Q.c2ieTO:C2IE) ! Field c2ieTO:C2IE is a hot field or requires assignment from browse
  BRWC2IEBSOs.Q &= Queue:Browse:2
  BRWC2IEBSOs.AddSortOrder(,c2ieUni:KC2IE)                 ! Add the sort order for c2ieUni:KC2IE for sort order 1
  BRWC2IEBSOs.AddRange(c2ieUni:C2IE,selC2IERef)            ! Add single value range limit for sort order 1
  BRWC2IEBSOs.AddLocator(BRW10::Sort0:Locator)             ! Browse has a locator for sort order 1
  BRW10::Sort0:Locator.Init(,c2ieUni:C2IE,1,BRWC2IEBSOs)   ! Initialize the browse locator using  using key: c2ieUni:KC2IE , c2ieUni:C2IE
  ?List:2{PROP:IconList,1} = '~.\resources\deployed.ico'
  BRWC2IEBSOs.AddField(c2ieUni:ID,BRWC2IEBSOs.Q.c2ieUni:ID) ! Field c2ieUni:ID is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(tpyBSO:Code,BRWC2IEBSOs.Q.tpyBSO:Code) ! Field tpyBSO:Code is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(Uni:Code,BRWC2IEBSOs.Q.Uni:Code)    ! Field Uni:Code is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(Uni:Name,BRWC2IEBSOs.Q.Uni:Name)    ! Field Uni:Name is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(c2ieUni:Hostility,BRWC2IEBSOs.Q.c2ieUni:Hostility) ! Field c2ieUni:Hostility is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(tpyHstl:Code,BRWC2IEBSOs.Q.tpyHstl:Code) ! Field tpyHstl:Code is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(_meta_c2ieUni:movedToOverlay,BRWC2IEBSOs.Q._meta_c2ieUni:movedToOverlay) ! Field _meta_c2ieUni:movedToOverlay is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(c2ieUniPos:xPos,BRWC2IEBSOs.Q.c2ieUniPos:xPos) ! Field c2ieUniPos:xPos is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(c2ieUniPos:yPos,BRWC2IEBSOs.Q.c2ieUniPos:yPos) ! Field c2ieUniPos:yPos is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(c2ieUni:C2IE,BRWC2IEBSOs.Q.c2ieUni:C2IE) ! Field c2ieUni:C2IE is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(Uni:ID,BRWC2IEBSOs.Q.Uni:ID)        ! Field Uni:ID is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(tpyBSO:ID,BRWC2IEBSOs.Q.tpyBSO:ID)  ! Field tpyBSO:ID is a hot field or requires assignment from browse
  BRWC2IEBSOs.AddField(tpyHstl:ID,BRWC2IEBSOs.Q.tpyHstl:ID) ! Field tpyHstl:ID is a hot field or requires assignment from browse
  BRWBOSPos.Q &= Queue:Browse:3
  BRWBOSPos.AddSortOrder(,c2ieUniPos:Kc2ieUnit)            ! Add the sort order for c2ieUniPos:Kc2ieUnit for sort order 1
  BRWBOSPos.AddRange(c2ieUniPos:c2ieUnit,selC2IEBSORef)    ! Add single value range limit for sort order 1
  BRWBOSPos.AddLocator(BRW11::Sort0:Locator)               ! Browse has a locator for sort order 1
  BRW11::Sort0:Locator.Init(,c2ieUniPos:c2ieUnit,1,BRWBOSPos) ! Initialize the browse locator using  using key: c2ieUniPos:Kc2ieUnit , c2ieUniPos:c2ieUnit
  BRWBOSPos.AddField(c2ieUniPos:c2ieUnit,BRWBOSPos.Q.c2ieUniPos:c2ieUnit) ! Field c2ieUniPos:c2ieUnit is a hot field or requires assignment from browse
  BRWBOSPos.AddField(c2ieUniPos:xPos,BRWBOSPos.Q.c2ieUniPos:xPos) ! Field c2ieUniPos:xPos is a hot field or requires assignment from browse
  BRWBOSPos.AddField(c2ieUniPos:yPos,BRWBOSPos.Q.c2ieUniPos:yPos) ! Field c2ieUniPos:yPos is a hot field or requires assignment from browse
  BRWBOSPos.AddField(c2ieUniPos:ID,BRWBOSPos.Q.c2ieUniPos:ID) ! Field c2ieUniPos:ID is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('COPApp',QuickWindow)                       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRWC2IPContent.AskProcedure = 1                          ! Will call: U_c2ipContent
  BRWC2IPContent.AddToolbarTarget(Toolbar)                 ! Browse accepts toolbar control
  BRWC2IPContent.ToolbarItem.HelpButton = ?Help
  BRWC2IETaskorg.AddToolbarTarget(Toolbar)                 ! Browse accepts toolbar control
  BRWC2IETaskorg.ToolbarItem.HelpButton = ?Help
  BRWC2IEBSOs.AddToolbarTarget(Toolbar)                    ! Browse accepts toolbar control
  BRWC2IEBSOs.ToolbarItem.HelpButton = ?Help
  BRWBOSPos.AddToolbarTarget(Toolbar)                      ! Browse accepts toolbar control
  BRWBOSPos.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  ! passed parameters
  ! C2IP reference = COP reference
  !MESSAGE('pC2IPRef = ' & pC2IPref)
  selC2IPRef  = pC2IPRef
  nC2IPRef    = pC2IPRef
  
  ! Create COP C2IP if this an empty COP C2IP
  
  IF pC2IPRef =0 THEN
      ! New COP C2IP
      sCOPName = ''
      LOOP 10 TIMES
          sCOPName = CLIP(sCOPName) & CHR(RANDOM(97, 122))    
      END
      DISPLAY(sCOPName)
      QuickWindow{PROP:Text}='COP App (' & CLIP(sCOPName) & '.c2ip)'
  
      ! create new COP C2IP
      DO _newCOPC2IP
      
      IF pTASKORGC2IPRef <> 0 THEN
          ! Attach TASKORG C2IP to the new COP C2IP
          DO _attachTASKORGC2IP
      END
  END
  
  BRWC2IPContent.ResetFromFile()
  
  
  
  
  
  
  ! Display C2IP Name
  
  IF pC2IPRef <> 0 THEN
      C2IP:ID = selC2IPRef
      IF Access:C2IPs.TryFetch(C2IP:PKID) = Level:Benign THEN
          selC2IPName = C2IP:Name
          QuickWindow{PROP:Text}='COP App (' & CLIP(selC2IPName) & '.c2ip)'
          
          sCOPName        = C2IP:Name
          sPrevCOPName    = C2IP:Name
          DISPLAY(sCOPName)
      END
  END
  ! default inits
  sMoveToOvrlOptMenu  = ''
  
  ! reset conter of C2IP Content references
  nOvrlRef  = 0
  ! Display Overlay Units
  
  DO _DrawUnits
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
          DrwOverlay.Kill()
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:C1.Close
    Relate:C2.Close
    Relate:C2IPContent.Close
    Relate:C3.Close
    Relate:P.Close
    Relate:_C2IEs.Close
    Relate:_C2IPContent.Close
    Relate:_Units.Close
    Relate:_c2ieUnits.Close
    Relate:_c2ieUnitsPositions.Close
    Relate:_meta_c2ieUnits2.Close
    Relate:c2ieUnits.Close
  END
  IF SELF.Opened
    INIMgr.Update('COPApp',QuickWindow)                    ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    EXECUTE Number
      U_c2ipContent
      U_c2ieBSOs
      U_c2ieBSOs
    END
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON_MoveToOverlay
      ThisWindow.Update()
      ! Move to Overlay Options Menu
      !optionsMenu#     = POPUP('Option1|Option2',,,)
      nMoveToOvrlSelection    = POPUP(CLIP(sMoveToOvrlOptMenu),,,)
      
      !MESSAGE('Overlay ' & vOvrlRef[nMoveToOvrlSelection])
      
      Access:_c2ieUnits.PrimeAutoInc()
      _c2ieUni:C2IE  = vOvrlRef[nMoveToOvrlSelection]
      _c2ieUni:Unit = selBSORef
      _c2ieUni:Hostility  = selBSOHostility
      IF Access:_c2ieUnits.TryInsert() = Level:Benign THEN
          ! Make the Unit is moved to Overlay
          _meta_c2ieUni2:c2ieUni  = BRWC2IEBSOs.Q.c2ieUni:ID
          IF Access:_meta_c2ieUnits2.Fetch(_meta_c2ieUni2:Kc2ieUni) = Level:Benign THEN
              _meta_c2ieUni2:movedToOverlay   = TRUE
              IF Access:_meta_c2ieUnits2.TryUpdate() = Level:Benign THEN
                  ! meta data saved
                  !MESSAGE('meta data saved')
              END
          ELSE
              Access:_meta_c2ieUnits2.PrimeAutoInc()
              _meta_c2ieUni2:c2ieUni  = BRWC2IEBSOs.Q.c2ieUni:ID
              _meta_c2ieUni2:movedToOverlay   = TRUE
              IF Access:_meta_c2ieUnits2.TryInsert() = Level:Benign THEN
                  !meta data inserted
                  !MESSAGE('meta data inserted')
              END       
          END 
      ELSE
          !Access:_c2ieUnits.Throw(Msg:InsertFailed)       !handle the error
          Access:_c2ieUnits.CancelAutoInc ()
      
      END
      
      
      
    OF ?Insert:2
      ThisWindow.Update()
      ! Refresh drawing
      DO _drawUnits
    OF ?Change:2
      ThisWindow.Update()
      ! refresh drawing
      DO _drawUnits
    OF ?Delete:2
      ThisWindow.Update()
      ! Refresh drawing
      DO _drawUnits
    OF ?BUTTON_ActProp
      ThisWindow.Update()
      ! View Action Properties
      
      sBSOTypeCode    = BRWC2IEBSOs.q.tpyBSO:Code
      
      CASE CLIP(sBSOTypeCode)
      OF 'Unit'
      OF 'Action'
          !GlobalRequest = ChangeRecord
          B_c2ieActionDetails()
      ELSE
          ! nothing to do
      END
    OF ?Close
      ThisWindow.Update()
      ! Save COP C2IP Name
      !MESSAGE('nC2IPRef = ' & nC2IPRef)
      _C2IP:ID    = nC2IPRef
      IF Access:_C2IPs.Fetch(_C2IP:PKID)  = Level:Benign THEN
          _C2IP:Name  = sCOPName
          IF Access:_C2IPs.TryUpdate() = Level:Benign THEN
              ! COP C2IP Name saved succesfully
          ELSE
              MESSAGE('Access:_C2IPs.TryUpdate() error')
          END
      ELSE
          MESSAGE('Access:_C2IPs.Fetch(_C2IP:PKID) error')
      END
      
      
      OMIT('__C2IEName')
      ! Save COP C2IE Name
      MESSAGE('nC2EPRef = ' & nC2IERef)
      _C2IE:ID    = nC2IERef
      IF Access:_C2IEs.Fetch(_C2IE:PKID) = Level:Benign THEN
          ! C2IE Name = C2IP Name
          _C2IE:Name  = sCOPName
          IF Access:_C2IEs.TryUpdate() = Level:Benign THEN
              ! COP C2IE Name save succesfully
          ELSE
              MESSAGE('Access:_C2IEs.TryUpdate() error')
          END
      ELSE
          MESSAGE('Access:_C2IEs.Fetch(_C2IE:PKID) error')
      END
      
      __C2IEName
      
      
    OF ?sCOPName
      ! Refresh C2IP Name
      
      QuickWindow{PROP:Text}='COP App (' & CLIP(sCOPName) & '.c2ip)'
    OF ?PANEL1
      ! identify BSO object
      
      mouseX# = DrwOverlay.MouseX()
      mouseY# = DrwOverlay.MouseY()
      
      !MESSAGE('xPos = ' & mouseX# & ', yPos = ' & mouseY#)
      
      bBSOFoundOnCanvas   = FALSE
      i# = 1
      LOOP
          GET(COPBSOs, i#)
          IF ERRORCODE() THEN
              BREAK
          END   
          !MESSAGE('ref = ' & copBSO:C2IEUnitRef & ' xpos= ' & copBSO:xPos & ' ypos= ' & copBSO:yPos)
          IF (copBSO:xPos < mouseX#) AND (mouseX# < copBSO:xPos + 50) THEN
              IF (copBSO:yPos < mouseY#) AND (mouseY# < copBSO:yPos + 30) THEN
                  ! Object found
                  !MESSAGE('found object')            
                  bBSOFoundOnCanvas = TRUE
                  nBSOFoundPos    = i#
                  BREAK            
              END
              
          END
          i# = i# + 1
          
      END
    OF ?BUTTON2
      ThisWindow.Update()
      ! Add BSO to queue
      
      LOOP i# = 1 TO RECORDS(BRWC2IEBSOs.q)
          GET(BRWC2IEBSOs.q, i#)
          
          !MESSAGE('ref = ' & BRWC2IEBSOs.q.c2ieUni:ID & ' xpos = ' & BRWC2IEBSOs.q.c2ieUniPos:xPos & ' ypos = ' & BRWC2IEBSOs.q.c2ieUniPos:yPos)
          
          copBSO:C2IEUnitRef  = BRWC2IEBSOs.q.c2ieUni:ID
          copBSO:xPos         = BRWC2IEBSOs.q.c2ieUniPos:xPos
          copBSO:yPos         = BRWC2IEBSOs.q.c2ieUniPos:yPos
          
          ADD(COPBSOs)
          CLEAR(COPBSOs)
      END
      
      !MESSAGE('units = ' & RECORDS(COPBSOs))
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?PANEL1
    CASE EVENT()
    OF EVENT:MouseUp
      ! BSO new positions
      
      IF bBSOFoundOnCanvas = TRUE THEN
          _c2ieUniPos:c2ieUnit    = copBSO:C2IEUnitRef
          IF Access:_c2ieUnitsPositions.TryFetch(_c2ieUniPos:Kc2ieUnit) = Level:Benign THEN
              mouseX# = DrwOverlay.MouseX()
              mouseY# = DrwOverlay.MouseY()
              _c2ieUniPos:xPos    = mouseX#
              _c2ieUniPos:yPos    = mouseY#
              IF Access:_c2ieUnitsPositions.TryUpdate() = Level:Benign THEN
                  ! Position updated
                  !MESSAGE('pos updated')
                  
                  copBSO:xPos = mouseX#
                  copBSO:yPos = mouseY#
                  PUT(COPBSOs)
                  IF ERRORCODE() THEN
                      MESSAGE('queue error')
                  END
                  
                  
                  DO _drawUnits
              END
              
          END
          
      END
    OF EVENT:Drop
      ! Move to Overlay
      !optionsMenu#     = POPUP('Option1|Option2',,,)
      !nMoveToOvrlSelection    = POPUP(CLIP(sMoveToOvrlOptMenu),,,)
      nMoveToOvrlSelection    = 1
      
      !MESSAGE('Overlay ' & vOvrlRef[nMoveToOvrlSelection])
      
      Access:_c2ieUnits.PrimeAutoInc()
      _c2ieUni:C2IE  = vOvrlRef[nMoveToOvrlSelection]
      _c2ieUni:Unit = selBSORef
      _c2ieUni:Hostility  = selBSOHostility
      IF Access:_c2ieUnits.TryInsert() = Level:Benign THEN
          
          ! Add default positions
          Access:_UnitsPositions.PrimeAutoInc()
          _c2ieUniPos:c2ieUnit = _c2ieUni:ID
          _c2ieUniPos:xPos = DrwOverlay.MouseX()
          _c2ieUniPos:yPos = DrwOverlay.MouseY()
          IF Access:_c2ieUnitsPositions.TryInsert() = Level:Benign THEN
              ! position defined
          END
          
          
          ! Make the Unit is moved to Overlay
          _meta_c2ieUni2:c2ieUni  = BRWC2IEBSOs.Q.c2ieUni:ID
          IF Access:_meta_c2ieUnits2.Fetch(_meta_c2ieUni2:Kc2ieUni) = Level:Benign THEN
              _meta_c2ieUni2:movedToOverlay   = TRUE
              IF Access:_meta_c2ieUnits2.TryUpdate() = Level:Benign THEN
                  ! meta data saved
                  !MESSAGE('meta data saved')
              END
          ELSE
              Access:_meta_c2ieUnits2.PrimeAutoInc()
              _meta_c2ieUni2:c2ieUni  = BRWC2IEBSOs.Q.c2ieUni:ID
              _meta_c2ieUni2:movedToOverlay   = TRUE
              IF Access:_meta_c2ieUnits2.TryInsert() = Level:Benign THEN
                  !meta data inserted
                  !MESSAGE('meta data inserted')
              END       
          END 
      ELSE
          !Access:_c2ieUnits.Throw(Msg:InsertFailed)       !handle the error
          Access:_c2ieUnits.CancelAutoInc ()
      
      END
      ! Refresh drawing
      DO _drawUnits
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


BRWC2IPContent.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:4
    SELF.ChangeControl=?Change:4
    SELF.DeleteControl=?Delete:4
  END


BRWC2IPContent.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! C2IE reference
  
  selC2IERef  = BRWC2IPContent.q.C2IE:ID
  BRWC2IETaskorg.ResetFromFile()


BRWC2IEBSOs.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW10::EIPManager                            ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::c2ieUni:ID,1)
  SELF.AddEditControl(EditInPlace::tpyBSO:Code,2)
  SELF.AddEditControl(EditInPlace::Uni:Code,3)
  SELF.AddEditControl(EditInPlace::Uni:Name,4)
  SELF.AddEditControl(EditInPlace::c2ieUni:Hostility,6)
  SELF.AddEditControl(EditInPlace::tpyHstl:Code,7)
  SELF.AddEditControl(EditInPlace::_meta_c2ieUni:movedToOverlay,8)
  SELF.AddEditControl(EditInPlace::c2ieUniPos:xPos,9)
  SELF.AddEditControl(EditInPlace::c2ieUniPos:yPos,10)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRWC2IEBSOs.SetQueueRecord PROCEDURE

  CODE
  PARENT.SetQueueRecord
  
  IF (BRWC2IEBSOs.q._meta_c2ieUni:movedToOverlay=TRUE)
    SELF.Q.Uni:Name_Icon = 1                               ! Set icon from icon list
  ELSE
    SELF.Q.Uni:Name_Icon = 0
  END


BRWC2IEBSOs.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! selected BSO
  selC2IEBSORef   = BRWC2IEBSOs.q.c2ieUni:ID
  selBSORef   = BRWC2IEBSOs.q.Uni:ID
  selBSOHostility = BRWC2IEBSOs.q.c2ieUni:Hostility


BRWBOSPos.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  SELF.EIP &= BRW11::EIPManager                            ! Set the EIP manager
  SELF.AddEditControl(EditInPlace::c2ieUniPos:c2ieUnit,1)
  SELF.AddEditControl(EditInPlace::c2ieUniPos:xPos,2)
  SELF.AddEditControl(EditInPlace::c2ieUniPos:yPos,3)
  SELF.DeleteAction = EIPAction:Always
  SELF.ArrowAction = EIPAction:Default+EIPAction:Remain+EIPAction:RetainColumn
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! ORBAT - TASKORG Transfers
!!! </summary>
View_ORBAT_TASKORGTransfers PROCEDURE 

selC2IEORBATRef      DECIMAL(7)                            ! 
selC2IETASKORGRef    DECIMAL(7)                            ! 
selBSOForC2DisplayRef DECIMAL(7)                           ! 
sNewTaskOrgName      STRING(100)                           ! 
sC2RelCode           STRING(20)                            ! 
BSOFromNodeOrder     DECIMAL(2)                            ! 
BSOToNodeOrder       DECIMAL(2)                            ! 
BSOFromRef           DECIMAL(7)                            ! 
BSOToRef             DECIMAL(7)                            ! 
BSOParentRef         DECIMAL(7)                            ! 
BRW5::View:Browse    VIEW(_C2IP_ORBATs)
                       PROJECT(_C2IP_Orbats:Name)
                       PROJECT(_C2IP_Orbats:ID)
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
_C2IP_Orbats:Name      LIKE(_C2IP_Orbats:Name)        !List box control field - type derived from field
_C2IP_Orbats:ID        LIKE(_C2IP_Orbats:ID)          !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW6::View:Browse    VIEW(_C2IP_TaskOrgs)
                       PROJECT(_C2IPTsk:Name)
                       PROJECT(_C2IPTsk:ID)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
_C2IPTsk:Name          LIKE(_C2IPTsk:Name)            !List box control field - type derived from field
_C2IPTsk:ID            LIKE(_C2IPTsk:ID)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW7::View:Browse    VIEW(C2IPContent)
                       PROJECT(C2IPCt:ID)
                       PROJECT(C2IPCt:C2IPPackage)
                       PROJECT(C2IPCt:C2IEInstance)
                       JOIN(_C2IEORB:PKID,C2IPCt:C2IEInstance)
                         PROJECT(_C2IEORB:ID)
                         PROJECT(_C2IEORB:Name)
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
_C2IEORB:ID            LIKE(_C2IEORB:ID)              !List box control field - type derived from field
_C2IEORB:Name          LIKE(_C2IEORB:Name)            !List box control field - type derived from field
C2IPCt:ID              LIKE(C2IPCt:ID)                !Primary key field - type derived from field
C2IPCt:C2IPPackage     LIKE(C2IPCt:C2IPPackage)       !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(_C2IPContent)
                       PROJECT(_C2IPCt:C2IEInstance)
                       PROJECT(_C2IPCt:ID)
                       PROJECT(_C2IPCt:C2IPPackage)
                       JOIN(_C2IE_TASKORGs,'_C2IETSK:ID=_C2IPCt:C2IEInstance')
                         PROJECT(_C2IETSK:ID)
                         PROJECT(_C2IETSK:Name)
                       END
                     END
Queue:Browse:3       QUEUE                            !Queue declaration for browse/combo box using ?List:4
_C2IETSK:ID            LIKE(_C2IETSK:ID)              !List box control field - type derived from field
_C2IETSK:Name          LIKE(_C2IETSK:Name)            !List box control field - type derived from field
_C2IPCt:C2IEInstance   LIKE(_C2IPCt:C2IEInstance)     !Browse hot field - type derived from field
_C2IPCt:ID             LIKE(_C2IPCt:ID)               !Primary key field - type derived from field
_C2IPCt:C2IPPackage    LIKE(_C2IPCt:C2IPPackage)      !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW9::View:Browse    VIEW(_c2ieBSO_ORBATs)
                       PROJECT(_c2ieBSOORB:C2IE)
                       PROJECT(_c2ieBSOORB:ID)
                       PROJECT(_c2ieBSOORB:Unit)
                       JOIN(Uni:PKID,_c2ieBSOORB:Unit)
                         PROJECT(Uni:Code)
                         PROJECT(Uni:Name)
                         PROJECT(Uni:ID)
                       END
                     END
Queue:Browse:4       QUEUE                            !Queue declaration for browse/combo box using ?List:5
_c2ieBSOORB:C2IE       LIKE(_c2ieBSOORB:C2IE)         !List box control field - type derived from field
Uni:Code               LIKE(Uni:Code)                 !List box control field - type derived from field
Uni:Name               LIKE(Uni:Name)                 !List box control field - type derived from field
_c2ieBSOORB:ID         LIKE(_c2ieBSOORB:ID)           !Primary key field - type derived from field
Uni:ID                 LIKE(Uni:ID)                   !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW10::View:Browse   VIEW(_c2ieBSO_TASKORGs)
                       PROJECT(_c2ieBSOTSK:C2IE)
                       PROJECT(_c2ieBSOTSK:ID)
                       PROJECT(_c2ieBSOTSK:Unit)
                       JOIN(_Uni:PKID,_c2ieBSOTSK:Unit)
                         PROJECT(_Uni:Code)
                         PROJECT(_Uni:Name)
                         PROJECT(_Uni:ID)
                       END
                       JOIN(c2iUniTrf:Kc2ieUnit,_c2ieBSOTSK:ID)
                         PROJECT(c2iUniTrf:C2IE_From)
                         JOIN(_C2IEFromTrf:PKID,c2iUniTrf:C2IE_From)
                           PROJECT(_C2IEFromTrf:Name)
                           PROJECT(_C2IEFromTrf:ID)
                         END
                       END
                     END
Queue:Browse:5       QUEUE                            !Queue declaration for browse/combo box using ?List:6
_c2ieBSOTSK:C2IE       LIKE(_c2ieBSOTSK:C2IE)         !List box control field - type derived from field
_Uni:Code              LIKE(_Uni:Code)                !List box control field - type derived from field
_Uni:Name              LIKE(_Uni:Name)                !List box control field - type derived from field
_C2IEFromTrf:Name      LIKE(_C2IEFromTrf:Name)        !List box control field - type derived from field
_c2ieBSOTSK:ID         LIKE(_c2ieBSOTSK:ID)           !Primary key field - type derived from field
_Uni:ID                LIKE(_Uni:ID)                  !Related join file key field - type derived from field
_C2IEFromTrf:ID        LIKE(_C2IEFromTrf:ID)          !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW12::View:Browse   VIEW(_c2ieOrgChart_ORBATs)
                       PROJECT(_c2ieOC_ORB:ID)
                       PROJECT(_c2ieOC_ORB:C2IE)
                       JOIN(C1,'UniC1:ID=_c2ieOC_ORB:Child1')
                         PROJECT(UniC1:ID)
                         PROJECT(UniC1:Code)
                       END
                       JOIN(C2,'UniC2:ID=_c2ieOC_ORB:Child2')
                         PROJECT(UniC2:ID)
                         PROJECT(UniC2:Code)
                       END
                       JOIN(C3,'UniC3:ID=_c2ieOC_ORB:Child3')
                         PROJECT(UniC3:ID)
                         PROJECT(UniC3:Code)
                       END
                       JOIN(P,'UniP:ID=_c2ieOC_ORB:Parent')
                         PROJECT(UniP:ID)
                         PROJECT(UniP:Code)
                       END
                     END
Queue:Browse:6       QUEUE                            !Queue declaration for browse/combo box using ?List:7
UniP:ID                LIKE(UniP:ID)                  !List box control field - type derived from field
UniC1:ID               LIKE(UniC1:ID)                 !List box control field - type derived from field
UniC2:ID               LIKE(UniC2:ID)                 !List box control field - type derived from field
UniC3:ID               LIKE(UniC3:ID)                 !List box control field - type derived from field
UniP:Code              LIKE(UniP:Code)                !List box control field - type derived from field
UniC1:Code             LIKE(UniC1:Code)               !List box control field - type derived from field
UniC2:Code             LIKE(UniC2:Code)               !List box control field - type derived from field
UniC3:Code             LIKE(UniC3:Code)               !List box control field - type derived from field
_c2ieOC_ORB:ID         LIKE(_c2ieOC_ORB:ID)           !Primary key field - type derived from field
_c2ieOC_ORB:C2IE       LIKE(_c2ieOC_ORB:C2IE)         !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW13::View:Browse   VIEW(_c2ieOrgChart_TASKORGs)
                       PROJECT(_c2ieOC_TSK:Parent)
                       PROJECT(_c2ieOC_TSK:Child1)
                       PROJECT(_c2ieOC_TSK:Child2)
                       PROJECT(_c2ieOC_TSK:Child3)
                       PROJECT(_c2ieOC_TSK:ID)
                       PROJECT(_c2ieOC_TSK:C2IE)
                       JOIN(P,'UniP:ID=_c2ieOC_TSK:Parent')
                         PROJECT(UniP:Code)
                       END
                       JOIN(C1,'UniC1:ID=_c2ieOC_TSK:Child1')
                         PROJECT(UniC1:Code)
                       END
                       JOIN(C2,'UniC2:ID=_c2ieOC_TSK:Child2')
                         PROJECT(UniC2:Code)
                       END
                       JOIN(C3,'UniC3:ID=_c2ieOC_TSK:Child3')
                         PROJECT(UniC3:Code)
                       END
                     END
Queue:Browse:7       QUEUE                            !Queue declaration for browse/combo box using ?List:8
_c2ieOC_TSK:Parent     LIKE(_c2ieOC_TSK:Parent)       !List box control field - type derived from field
_c2ieOC_TSK:Child1     LIKE(_c2ieOC_TSK:Child1)       !List box control field - type derived from field
_c2ieOC_TSK:Child2     LIKE(_c2ieOC_TSK:Child2)       !List box control field - type derived from field
_c2ieOC_TSK:Child3     LIKE(_c2ieOC_TSK:Child3)       !List box control field - type derived from field
UniP:Code              LIKE(UniP:Code)                !List box control field - type derived from field
UniC1:Code             LIKE(UniC1:Code)               !List box control field - type derived from field
UniC2:Code             LIKE(UniC2:Code)               !List box control field - type derived from field
UniC3:Code             LIKE(UniC3:Code)               !List box control field - type derived from field
_c2ieOC_TSK:ID         LIKE(_c2ieOC_TSK:ID)           !Primary key field - type derived from field
_c2ieOC_TSK:C2IE       LIKE(_c2ieOC_TSK:C2IE)         !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW14::View:Browse   VIEW(c2ieUnitsC2Relationships)
                       PROJECT(c2ieUniC2Rel:ID)
                       PROJECT(c2ieUniC2Rel:c2ieUnit)
                       JOIN(FC,'UniFC:ID=c2ieUniC2Rel:FC')
                         PROJECT(UniFC:Code)
                       END
                       JOIN(OpCom,'UniOpCom:ID=c2ieUniC2Rel:OpCom')
                         PROJECT(UniOpCom:Code)
                       END
                       JOIN(OpCon,'UniOpCon:ID=c2ieUniC2Rel:OpCon')
                         PROJECT(UniOpCon:Code)
                       END
                       JOIN(TaCom,'UniTaCom:ID=c2ieUniC2Rel:TaCom')
                         PROJECT(UniTaCom:Code)
                       END
                       JOIN(TaCon,'UniTaCon:ID=c2ieUniC2Rel:TaCon')
                         PROJECT(UniTaCon:Code)
                       END
                       JOIN(Adm,'UniAdm:ID=c2ieUniC2Rel:Adm')
                         PROJECT(UniAdm:Code)
                       END
                     END
Queue:Browse:8       QUEUE                            !Queue declaration for browse/combo box using ?List:9
c2ieUniC2Rel:ID        LIKE(c2ieUniC2Rel:ID)          !List box control field - type derived from field
UniFC:Code             LIKE(UniFC:Code)               !List box control field - type derived from field
UniOpCom:Code          LIKE(UniOpCom:Code)            !List box control field - type derived from field
UniOpCon:Code          LIKE(UniOpCon:Code)            !List box control field - type derived from field
UniTaCom:Code          LIKE(UniTaCom:Code)            !List box control field - type derived from field
UniTaCon:Code          LIKE(UniTaCon:Code)            !List box control field - type derived from field
UniAdm:Code            LIKE(UniAdm:Code)              !List box control field - type derived from field
c2ieUniC2Rel:c2ieUnit  LIKE(c2ieUniC2Rel:c2ieUnit)    !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW18::View:Browse   VIEW(c2ieUnitsCommandPosts)
                       PROJECT(c2ieUniCP:ID)
                       PROJECT(c2ieUniCP:c2ieUnit)
                       PROJECT(c2ieUniCP:UnitAsCP)
                       PROJECT(c2ieUniCP:CPType)
                       JOIN(Uni:PKID,c2ieUniCP:UnitAsCP)
                         PROJECT(Uni:Code)
                         PROJECT(Uni:ID)
                       END
                       JOIN(tpyCP:PKID,c2ieUniCP:CPType)
                         PROJECT(tpyCP:Code)
                         PROJECT(tpyCP:ID)
                       END
                     END
Queue:Browse:9       QUEUE                            !Queue declaration for browse/combo box using ?List:10
Uni:Code               LIKE(Uni:Code)                 !List box control field - type derived from field
tpyCP:Code             LIKE(tpyCP:Code)               !List box control field - type derived from field
c2ieUniCP:ID           LIKE(c2ieUniCP:ID)             !Primary key field - type derived from field
c2ieUniCP:c2ieUnit     LIKE(c2ieUniCP:c2ieUnit)       !Browse key field - type derived from field
Uni:ID                 LIKE(Uni:ID)                   !Related join file key field - type derived from field
tpyCP:ID               LIKE(tpyCP:ID)                 !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
FDCB11::View:FileDropCombo VIEW(type_C2Rel)
                       PROJECT(tpyC2Rel:Code)
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?tpyC2Rel:Code
tpyC2Rel:Code          LIKE(tpyC2Rel:Code)            !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('ORBAT - TASKORG Transfers'),AT(,,673,417),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,HLP('ORBAT_TASKORGTransfers'),SYSTEM
                       BUTTON('&OK'),AT(517,401,49,14),USE(?Ok),LEFT,ICON('WAOK.ICO'),FLAT,MSG('Accept operation'), |
  TIP('Accept Operation')
                       REGION,AT(499,163,164,127),USE(?PANEL1),HIDE,IMM
                       BUTTON('&Cancel'),AT(569,401,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel Operation'), |
  TIP('Cancel Operation')
                       BUTTON('&Help'),AT(622,401,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       LIST,AT(3,12,150,70),USE(?List),HVSCROLL,FORMAT('100L(2)|M~ORBAT Name~C(0)@s100@'),FROM(Queue:Browse), |
  IMM
                       LIST,AT(254,12,150,70),USE(?List:2),HVSCROLL,FORMAT('100L(2)|M~TaskOrg Name~C(0)@s100@'),FROM(Queue:Browse:1), |
  IMM
                       LIST,AT(43,49,150,34),USE(?List:3),HVSCROLL,FORMAT('0L(2)|M~ID~D(12)@n-10.0@100L(2)|M~T' & |
  'ASKORG C2IE Name~C(0)@s100@'),FROM(Queue:Browse:2),IMM
                       LIST,AT(299,49,150,34),USE(?List:4),HVSCROLL,FORMAT('0L(2)|M~ID~D(12)@n-10.0@100L(2)|M~' & |
  'TASKORG C2IE Name~C(0)@s100@'),FROM(Queue:Browse:3),IMM
                       LIST,AT(5,294,149,100),USE(?List:5),HVSCROLL,FORMAT('0L(2)|M~ID~D(12)@n-10.0@[40L(2)|M~' & |
  'Code~C(0)@s20@100L(2)|M~Name~C(0)@s100@]|~Unit~'),FROM(Queue:Browse:4),IMM
                       LIST,AT(201,294,246,100),USE(?List:6),HVSCROLL,FORMAT('0L(2)|M~ID~D(12)@n-10.0@[40L(2)|' & |
  'M~Code~C(0)@s20@100L(2)|M~Name~C(0)@s100@]|~Unit~[100L(2)|M~Name~C(0)@s100@]|~TASKOR' & |
  'G C2IP/C2IE Source~'),FROM(Queue:Browse:5),IMM
                       BUTTON('Create TaskOrg'),AT(381,399),USE(?BUTTON1)
                       BUTTON('Move to TaskOrg'),AT(2,401),USE(?BUTTON2)
                       PROMPT('TaskOrg Name:'),AT(225,404),USE(?sNewTaskOrgName:Prompt)
                       ENTRY(@s100),AT(281,404,96,10),USE(sNewTaskOrgName)
                       LIST,AT(3,87,150,79),USE(?List:7),HVSCROLL,DRAGID('transferBSO'),FORMAT('0L(2)|M~ID~D(1' & |
  '2)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@40' & |
  'L(2)|M~My Echelon~C(0)@s20@40L(2)|M~1st Level~C(0)@s20@40L(2)|M~2nd Level~C(0)@s20@4' & |
  '0L(2)|M~3rd Level~C(0)@s20@'),FROM(Queue:Browse:6),IMM
                       LIST,AT(254,87,246,79),USE(?List:8),HVSCROLL,DROPID('transferBSO'),FORMAT('0L(2)|M~ID~D' & |
  '(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.0@' & |
  '40L(2)|M~My Echelon~L(0)@s20@40L(2)|M~1st Level~L(0)@s20@40L(2)|M~2nd Level~L(0)@s20' & |
  '@40L(2)|M~3rd Level~L(0)@s20@'),FROM(Queue:Browse:7),IMM
                       LIST,AT(453,294,218,34),USE(?List:9),DECIMAL(12),FORMAT('0L(2)|M~ID~D(12)@n-10.0@40L(2)' & |
  '|M~FC~C(0)@s20@40L(2)|M~OpCom~C(0)@s20@40L(2)|M~OpCon~C(0)@s20@40L(2)|M~TaCom~C(0)@s' & |
  '20@40L(2)|M~TaCon~C(0)@s20@40L(2)|M~Adm~C(0)@s20@'),FROM(Queue:Browse:8),IMM
                       COMBO(@s20),AT(157,87,92,10),USE(tpyC2Rel:Code),DROP(5),FORMAT('80L(2)|M~Code~L(0)@s20@'), |
  FROM(Queue:FileDropCombo),IMM
                       IMAGE,AT(2,170,248,119),USE(?Draw)
                       IMAGE,AT(253,170,247,119),USE(?Draw:2)
                       IMAGE,AT(504,170,167,119),USE(?Draw:3),HVSCROLL,HIDE
                       BUTTON('is HQ'),AT(505,98,87),USE(?BUTTON3)
                       BUTTON('Define Command Post'),AT(504,116),USE(?BUTTON4)
                       LIST,AT(453,333,217,47),USE(?List:10),FORMAT('80L(2)|M~Unit Code~C(0)@s20@80L(2)|M~Comm' & |
  'and Post Type~C(0)@s20@'),FROM(Queue:Browse:9),IMM
                       BUTTON('&Insert'),AT(470,384,42,12),USE(?Insert:2)
                       BUTTON('&Change'),AT(512,384,42,12),USE(?Change:2)
                       BUTTON('&Delete'),AT(554,384,42,12),USE(?Delete:2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeFieldEvent         PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

BRW_C2IPORBAT        CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
                     END

BRW5::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW6                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
                     END

BRW6::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW_C2IEORBAT        CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW7::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW_C2IETASKORG      CLASS(BrowseClass)                    ! Browse using ?List:4
Q                      &Queue:Browse:3                !Reference to browse queue
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW_BSOORBAT         CLASS(BrowseClass)                    ! Browse using ?List:5
Q                      &Queue:Browse:4                !Reference to browse queue
                     END

BRW9::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW_BSOTASKORG       CLASS(BrowseClass)                    ! Browse using ?List:6
Q                      &Queue:Browse:5                !Reference to browse queue
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW10::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW_BSOORBAT2        CLASS(BrowseClass)                    ! Browse using ?List:7
Q                      &Queue:Browse:6                !Reference to browse queue
                     END

BRW12::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW_BSOTASKORG2      CLASS(BrowseClass)                    ! Browse using ?List:8
Q                      &Queue:Browse:7                !Reference to browse queue
                     END

BRW13::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW_C2Rel            CLASS(BrowseClass)                    ! Browse using ?List:9
Q                      &Queue:Browse:8                !Reference to browse queue
                     END

BRW14::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW18                CLASS(BrowseClass)                    ! Browse using ?List:10
Q                      &Queue:Browse:9                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW18::Sort0:Locator StepLocatorClass                      ! Default Locator
FDCB11               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo           !Reference to browse queue type
                     END

! ----- DrwFrom --------------------------------------------------------------------------
DrwFrom              Class(Draw)
    ! derived method declarations
                     End  ! DrwFrom
! ----- end DrwFrom -----------------------------------------------------------------------
! ----- DrwTo --------------------------------------------------------------------------
DrwTo                Class(Draw)
    ! derived method declarations
                     End  ! DrwTo
! ----- end DrwTo -----------------------------------------------------------------------
! ----- DrwOCFrom --------------------------------------------------------------------------
DrwOCFrom            Class(DrawPaint)
    ! derived method declarations
                     End  ! DrwOCFrom
! ----- end DrwOCFrom -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
_drawOrgChartFrom       ROUTINE
DATA
CODE
    
    DrwFrom.Blank(COLOR:White)
    DrwFrom.Display()

    i# = 0
    SET(c2ieTaskOrg)
    LOOP
        IF Access:c2ieTaskOrg.Next() = Level:Benign THEN
            IF c2ieTO:C2IE = selC2IEORBATRef THEN
                i# = i# + 1
                
                IF c2ieTO:Parent <> 0 THEN    
                    DrwFrom.Box(1, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwFrom.Line(1 + 25, i#*30, 1, 10)
                    
                    UniP:ID = c2ieTO:Parent
                    IF Access:P.TryFetch(UniP:PKID) = Level:Benign THEN
                        DrwFrom.Show(1 + 5, (i#-1)*30+11, UniP:Code)
                    END
                    
                END
                IF c2ieTO:Child1 <> 0 THEN
                    DrwFrom.Box(50, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwFrom.Line(50 + 25, i#*30, 1, 10)
                    
                    UniC1:ID = c2ieTO:Child1
                    IF Access:C1.TryFetch(UniC1:PKID) = Level:Benign THEN
                        DrwFrom.Show(50 + 5, (i#-1)*30+11, UniC1:Code)
                    END
                    
                END
                IF c2ieTO:Child2 <> 0 THEN
                    DrwFrom.Box(100, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwFrom.Line(100 + 25, i#*30, 1, 10)
                    
                    UniC2:ID = c2ieTO:Child2
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwFrom.Show(100 + 5, (i#-1)*30+11, UniC2:Code)
                    END
                   
                END
                IF c2ieTO:Child3 <> 0 THEN
                    DrwFrom.Box(150, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwFrom.Line(100 + 25, i#*30, 1, 10)
                    
                    UniC2:ID = c2ieTO:Child3
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwFrom.Show(150 + 5, (i#-1)*30+11, UniC2:Code)
                    END
                   
                END
            END
            
            
        ELSE
            BREAK
        END
    END

    DrwFrom.Display()
    
    
    EXIT
    
_drawOrgChartTo       ROUTINE
DATA
CODE
    
    DrwTo.Blank(COLOR:White)
    DrwTo.Display()

    i# = 0
    SET(c2ieTaskOrg)
    LOOP
        IF Access:c2ieTaskOrg.Next() = Level:Benign THEN
            IF c2ieTO:C2IE = selC2IETASKORGRef THEN
                i# = i# + 1
                
                IF c2ieTO:Parent <> 0 THEN    
                    DrwTo.Box(1, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwTo.Line(1 + 25, i#*30, 1, 10)
                    
                    UniP:ID = c2ieTO:Parent
                    IF Access:P.TryFetch(UniP:PKID) = Level:Benign THEN
                        DrwTo.Show(1 + 5, (i#-1)*30+11, UniP:Code)
                    END
                    
                END
                IF c2ieTO:Child1 <> 0 THEN
                    DrwTo.Box(50, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwTo.Line(50 + 25, i#*30, 1, 10)
                    
                    UniC1:ID = c2ieTO:Child1
                    IF Access:C1.TryFetch(UniC1:PKID) = Level:Benign THEN
                        DrwTo.Show(50 + 5, (i#-1)*30+11, UniC1:Code)
                    END
                    
                END
                IF c2ieTO:Child2 <> 0 THEN
                    DrwTo.Box(100, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwTo.Line(100 + 25, i#*30, 1, 10)
                    
                    UniC2:ID = c2ieTO:Child2
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwTo.Show(100 + 5, (i#-1)*30+11, UniC2:Code)
                    END
                   
                END
                IF c2ieTO:Child3 <> 0 THEN
                    DrwTo.Box(150, (i#-1)*30 + 1, 50, 30, COLOR:Aqua)
                    !DrwTo.Line(100 + 25, i#*30, 1, 10)
                    
                    UniC2:ID = c2ieTO:Child3
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwTo.Show(150 + 5, (i#-1)*30+11, UniC2:Code)
                    END
                   
                END
            END
            
            
        ELSE
            BREAK
        END
    END

    DrwTo.Display()
    
    
    EXIT
    
_drawOCFrom       ROUTINE
DATA
CODE
    
    Clear(DrwOCFrom.ItemQueue)
    
    j# = DrwOCFrom._items
    MESSAGE('j# = ' & j#)
    !LOOP i# = 1 TO DrwOCFrom._items
    !    DrwOCFrom.DeleteItem(i#)        
    !END
    !MESSAGE('i# = ' & i#)
    !DrwOCFrom.DrawItems()
    
    DrwOCFrom.Blank(COLOR:White)
    DrwOCFrom.SetCanvasSize(DrwOCFrom.width *1.2, DrwOCFrom.Height * 1.2)  ! a bit larger to demonstrate scrolling
    DrwOCFrom.SetGrid(true)
    
    !DrwOCFrom.Blank(COLOR:White)
    !DrwOCFrom.Display()

    i# = 0
    SET(c2ieTaskOrg)
    LOOP
        IF Access:c2ieTaskOrg.Next() = Level:Benign THEN
            IF c2ieTO:C2IE = selC2IEORBATRef THEN
                i# = i# + 1
                
                insert# = TRUE
                IF 2*i# <= DrwOCFrom._items THEN 
                    DrwOCFrom.WithItem(i#)
                    insert# = FALSE
                END
                                
                IF c2ieTO:Parent <> 0 THEN    
                    DrwOCFrom.ItemQueue.type = create:box
                    DrwOCFrom.ItemQueue.xpos = 1
                    DrwOCFrom.ItemQueue.ypos = (i#-1)*30 + 1
                    DrwOCFrom.ItemQueue.width = 50
                    DrwOCFrom.ItemQueue.height = 30
                    DrwOCFrom.ItemQueue.BoxBorderColor = COLOR:Black
                    DrwOCFrom.ItemQueue.BoxFillColor = COLOR:Aqua
                    
                    IF insert# = TRUE THEN
                        DrwOCFrom.AddItem()
                    END                    
                    
                    UniP:ID = c2ieTO:Parent
                    IF Access:P.TryFetch(UniP:PKID) = Level:Benign THEN
                        DrwOCFrom.ItemQueue.type = create:string
                        DrwOCFrom.ItemQueue.TextValue = UniP:Code
                        DrwOCFrom.ItemQueue.FontName = 'Tahoma'
                        DrwOCFrom.ItemQueue.xpos = 1 + 5
                        DrwOCFrom.ItemQueue.FontColor = color:black
                        DrwOCFrom.ItemQueue.FontSize = 10
                        DrwOCFrom.ItemQueue.ypos = (i#-1)*30+11
                        DrwOCFrom.ItemQueue.FontStyle = FONT:Regular
                        
                        IF insert# = TRUE THEN
                            DrwOCFrom.AddItem()
                        END                                                
                    END
                    
                END
                IF c2ieTO:Child1 <> 0 THEN
                    DrwOCFrom.ItemQueue.type = create:box
                    DrwOCFrom.ItemQueue.xpos = 50
                    DrwOCFrom.ItemQueue.ypos = (i#-1)*30 + 1
                    DrwOCFrom.ItemQueue.width = 50
                    DrwOCFrom.ItemQueue.height = 30
                    DrwOCFrom.ItemQueue.BoxBorderColor = COLOR:Black
                    DrwOCFrom.ItemQueue.BoxFillColor = COLOR:Aqua
                    
                    IF insert# = TRUE THEN
                        DrwOCFrom.AddItem()
                    END
                    
                    UniC1:ID = c2ieTO:Child1
                    IF Access:C1.TryFetch(UniC1:PKID) = Level:Benign THEN
                        DrwOCFrom.ItemQueue.type = create:string
                        DrwOCFrom.ItemQueue.TextValue = UniC1:Code
                        DrwOCFrom.ItemQueue.FontName = 'Tahoma'
                        DrwOCFrom.ItemQueue.xpos = 50 + 5
                        DrwOCFrom.ItemQueue.FontColor = color:black
                        DrwOCFrom.ItemQueue.FontSize = 10
                        DrwOCFrom.ItemQueue.ypos = (i#-1)*30+11
                        DrwOCFrom.ItemQueue.FontStyle = FONT:Regular
                        
                        IF insert# = TRUE THEN
                            DrwOCFrom.AddItem()
                        END                                                
                    END
                    
                END
                IF c2ieTO:Child2 <> 0 THEN
                    DrwOCFrom.ItemQueue.type = create:box
                    DrwOCFrom.ItemQueue.xpos = 100
                    DrwOCFrom.ItemQueue.ypos = (i#-1)*30 + 1
                    DrwOCFrom.ItemQueue.width = 50
                    DrwOCFrom.ItemQueue.height = 30
                    DrwOCFrom.ItemQueue.BoxBorderColor = COLOR:Black
                    DrwOCFrom.ItemQueue.BoxFillColor = COLOR:Aqua
                    
                    IF insert# = TRUE THEN
                        DrwOCFrom.AddItem()
                    END                    
                    
                    UniC2:ID = c2ieTO:Child2
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwOCFrom.ItemQueue.type = create:string
                        DrwOCFrom.ItemQueue.TextValue = UniC2:Code
                        DrwOCFrom.ItemQueue.FontName = 'Tahoma'
                        DrwOCFrom.ItemQueue.xpos = 100 + 5
                        DrwOCFrom.ItemQueue.FontColor = color:black
                        DrwOCFrom.ItemQueue.FontSize = 10
                        DrwOCFrom.ItemQueue.ypos = (i#-1)*30+11
                        DrwOCFrom.ItemQueue.FontStyle = FONT:Regular
                        
                        IF insert# = TRUE THEN
                            DrwOCFrom.AddItem()
                        END                                                
                    END
                   
                END
                IF c2ieTO:Child3 <> 0 THEN
                    DrwOCFrom.ItemQueue.type = create:box
                    DrwOCFrom.ItemQueue.xpos = 100 +25
                    DrwOCFrom.ItemQueue.ypos = (i#-1)*30 + 1
                    DrwOCFrom.ItemQueue.width = 50
                    DrwOCFrom.ItemQueue.height = 30
                    DrwOCFrom.ItemQueue.BoxBorderColor = COLOR:Black
                    DrwOCFrom.ItemQueue.BoxFillColor = COLOR:Aqua
                    
                    IF insert# = TRUE THEN
                        DrwOCFrom.AddItem()
                    END                                       
                    
                    UniC2:ID = c2ieTO:Child3
                    IF Access:C2.TryFetch(UniC2:PKID) = Level:Benign THEN
                        DrwOCFrom.ItemQueue.type = create:string
                        DrwOCFrom.ItemQueue.TextValue = UniC3:Code
                        DrwOCFrom.ItemQueue.FontName = 'Tahoma'
                        DrwOCFrom.ItemQueue.xpos = 150 + 5
                        DrwOCFrom.ItemQueue.FontColor = color:black
                        DrwOCFrom.ItemQueue.FontSize = 10
                        DrwOCFrom.ItemQueue.ypos = (i#-1)*30+11
                        DrwOCFrom.ItemQueue.FontStyle = FONT:Regular
                        
                        IF insert# = TRUE THEN
                            DrwOCFrom.AddItem()
                        END                                            
                        
                    END
                   
                END
            END
            
            
        ELSE
            BREAK
        END
    END

    DrwOCFrom.DrawItems()
    
    
    EXIT
    

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('View_ORBAT_TASKORGTransfers')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Ok
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Ok,RequestCancelled)                    ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Ok,RequestCompleted)                    ! Add the close control to the window manger
  END
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:Adm.Open                                          ! File Adm used by this procedure, so make sure it's RelationManager is open
  Relate:C1.Open                                           ! File C1 used by this procedure, so make sure it's RelationManager is open
  Relate:C2.Open                                           ! File C2 used by this procedure, so make sure it's RelationManager is open
  Relate:C2IPContent.Open                                  ! File C2IPContent used by this procedure, so make sure it's RelationManager is open
  Relate:C3.Open                                           ! File C3 used by this procedure, so make sure it's RelationManager is open
  Relate:FC.Open                                           ! File FC used by this procedure, so make sure it's RelationManager is open
  Relate:OpCom.Open                                        ! File OpCom used by this procedure, so make sure it's RelationManager is open
  Relate:OpCon.Open                                        ! File OpCon used by this procedure, so make sure it's RelationManager is open
  Relate:P.Open                                            ! File P used by this procedure, so make sure it's RelationManager is open
  Relate:TaCom.Open                                        ! File TaCom used by this procedure, so make sure it's RelationManager is open
  Relate:TaCon.Open                                        ! File TaCon used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IE_TASKORGs.SetOpenRelated()
  Relate:_C2IE_TASKORGs.Open                               ! File _C2IE_TASKORGs used by this procedure, so make sure it's RelationManager is open
  Relate:_C2IPContent.SetOpenRelated()
  Relate:_C2IPContent.Open                                 ! File _C2IPContent used by this procedure, so make sure it's RelationManager is open
  Relate:_c2ieBSO_ORBATs.Open                              ! File _c2ieBSO_ORBATs used by this procedure, so make sure it's RelationManager is open
  Relate:_c2ieBSO_TASKORGs.Open                            ! File _c2ieBSO_TASKORGs used by this procedure, so make sure it's RelationManager is open
  Relate:_c2ieOrgChart_ORBATs.SetOpenRelated()
  Relate:_c2ieOrgChart_ORBATs.Open                         ! File _c2ieOrgChart_ORBATs used by this procedure, so make sure it's RelationManager is open
  Relate:c2ieUnitsC2Relationships.Open                     ! File c2ieUnitsC2Relationships used by this procedure, so make sure it's RelationManager is open
  Relate:type_C2Rel.Open                                   ! File type_C2Rel used by this procedure, so make sure it's RelationManager is open
  Access:c2ieTaskOrg.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  BRW_C2IPORBAT.Init(?List,Queue:Browse.ViewPosition,BRW5::View:Browse,Queue:Browse,Relate:_C2IP_ORBATs,SELF) ! Initialize the browse manager
  BRW6.Init(?List:2,Queue:Browse:1.ViewPosition,BRW6::View:Browse,Queue:Browse:1,Relate:_C2IP_TaskOrgs,SELF) ! Initialize the browse manager
  BRW_C2IEORBAT.Init(?List:3,Queue:Browse:2.ViewPosition,BRW7::View:Browse,Queue:Browse:2,Relate:C2IPContent,SELF) ! Initialize the browse manager
  BRW_C2IETASKORG.Init(?List:4,Queue:Browse:3.ViewPosition,BRW8::View:Browse,Queue:Browse:3,Relate:_C2IPContent,SELF) ! Initialize the browse manager
  BRW_BSOORBAT.Init(?List:5,Queue:Browse:4.ViewPosition,BRW9::View:Browse,Queue:Browse:4,Relate:_c2ieBSO_ORBATs,SELF) ! Initialize the browse manager
  BRW_BSOTASKORG.Init(?List:6,Queue:Browse:5.ViewPosition,BRW10::View:Browse,Queue:Browse:5,Relate:_c2ieBSO_TASKORGs,SELF) ! Initialize the browse manager
  BRW_BSOORBAT2.Init(?List:7,Queue:Browse:6.ViewPosition,BRW12::View:Browse,Queue:Browse:6,Relate:_c2ieOrgChart_ORBATs,SELF) ! Initialize the browse manager
  BRW_BSOTASKORG2.Init(?List:8,Queue:Browse:7.ViewPosition,BRW13::View:Browse,Queue:Browse:7,Relate:_c2ieOrgChart_TASKORGs,SELF) ! Initialize the browse manager
  BRW_C2Rel.Init(?List:9,Queue:Browse:8.ViewPosition,BRW14::View:Browse,Queue:Browse:8,Relate:c2ieUnitsC2Relationships,SELF) ! Initialize the browse manager
  BRW18.Init(?List:10,Queue:Browse:9.ViewPosition,BRW18::View:Browse,Queue:Browse:9,Relate:c2ieUnitsCommandPosts,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
    QuickWindow{PROP:Buffer} = 1 ! Remove flicker when animating.
    DrwFrom.Init(?Draw)
    QuickWindow{PROP:Buffer} = 1 ! Remove flicker when animating.
    DrwTo.Init(?Draw:2)
    QuickWindow{PROP:Buffer} = 1 ! Remove flicker when animating.
    DrwOCFrom.Init(?Draw:3)
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW_C2IPORBAT.Q &= Queue:Browse
  BRW_C2IPORBAT.AddSortOrder(,_C2IP_Orbats:PKID)           ! Add the sort order for _C2IP_Orbats:PKID for sort order 1
  BRW_C2IPORBAT.AddLocator(BRW5::Sort0:Locator)            ! Browse has a locator for sort order 1
  BRW5::Sort0:Locator.Init(,_C2IP_Orbats:ID,1,BRW_C2IPORBAT) ! Initialize the browse locator using  using key: _C2IP_Orbats:PKID , _C2IP_Orbats:ID
  BRW_C2IPORBAT.SetFilter('(_C2IP_Orbats:Type = 2)')       ! Apply filter expression to browse
  BRW_C2IPORBAT.AddField(_C2IP_Orbats:Name,BRW_C2IPORBAT.Q._C2IP_Orbats:Name) ! Field _C2IP_Orbats:Name is a hot field or requires assignment from browse
  BRW_C2IPORBAT.AddField(_C2IP_Orbats:ID,BRW_C2IPORBAT.Q._C2IP_Orbats:ID) ! Field _C2IP_Orbats:ID is a hot field or requires assignment from browse
  BRW6.Q &= Queue:Browse:1
  BRW6.AddSortOrder(,_C2IPTsk:PKID)                        ! Add the sort order for _C2IPTsk:PKID for sort order 1
  BRW6.AddLocator(BRW6::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW6::Sort0:Locator.Init(,_C2IPTsk:ID,1,BRW6)            ! Initialize the browse locator using  using key: _C2IPTsk:PKID , _C2IPTsk:ID
  BRW6.SetFilter('(_C2IPTsk:Type=2)')                      ! Apply filter expression to browse
  BRW6.AddField(_C2IPTsk:Name,BRW6.Q._C2IPTsk:Name)        ! Field _C2IPTsk:Name is a hot field or requires assignment from browse
  BRW6.AddField(_C2IPTsk:ID,BRW6.Q._C2IPTsk:ID)            ! Field _C2IPTsk:ID is a hot field or requires assignment from browse
  BRW_C2IEORBAT.Q &= Queue:Browse:2
  BRW_C2IEORBAT.AddSortOrder(,C2IPCt:KC2IP)                ! Add the sort order for C2IPCt:KC2IP for sort order 1
  BRW_C2IEORBAT.AddRange(C2IPCt:C2IPPackage,Relate:C2IPContent,Relate:_C2IP_ORBATs) ! Add file relationship range limit for sort order 1
  BRW_C2IEORBAT.AddLocator(BRW7::Sort0:Locator)            ! Browse has a locator for sort order 1
  BRW7::Sort0:Locator.Init(,C2IPCt:C2IPPackage,1,BRW_C2IEORBAT) ! Initialize the browse locator using  using key: C2IPCt:KC2IP , C2IPCt:C2IPPackage
  BRW_C2IEORBAT.SetFilter('(_C2IEORB:Type=2)')             ! Apply filter expression to browse
  BRW_C2IEORBAT.AddField(_C2IEORB:ID,BRW_C2IEORBAT.Q._C2IEORB:ID) ! Field _C2IEORB:ID is a hot field or requires assignment from browse
  BRW_C2IEORBAT.AddField(_C2IEORB:Name,BRW_C2IEORBAT.Q._C2IEORB:Name) ! Field _C2IEORB:Name is a hot field or requires assignment from browse
  BRW_C2IEORBAT.AddField(C2IPCt:ID,BRW_C2IEORBAT.Q.C2IPCt:ID) ! Field C2IPCt:ID is a hot field or requires assignment from browse
  BRW_C2IEORBAT.AddField(C2IPCt:C2IPPackage,BRW_C2IEORBAT.Q.C2IPCt:C2IPPackage) ! Field C2IPCt:C2IPPackage is a hot field or requires assignment from browse
  BRW_C2IETASKORG.Q &= Queue:Browse:3
  BRW_C2IETASKORG.AddSortOrder(,_C2IPCt:KC2IP)             ! Add the sort order for _C2IPCt:KC2IP for sort order 1
  BRW_C2IETASKORG.AddRange(_C2IPCt:C2IPPackage,Relate:_C2IPContent,Relate:_C2IP_TaskOrgs) ! Add file relationship range limit for sort order 1
  BRW_C2IETASKORG.AddLocator(BRW8::Sort0:Locator)          ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,_C2IPCt:C2IPPackage,1,BRW_C2IETASKORG) ! Initialize the browse locator using  using key: _C2IPCt:KC2IP , _C2IPCt:C2IPPackage
  BRW_C2IETASKORG.SetFilter('(_C2IETSK:Type=2)')           ! Apply filter expression to browse
  BRW_C2IETASKORG.AddField(_C2IETSK:ID,BRW_C2IETASKORG.Q._C2IETSK:ID) ! Field _C2IETSK:ID is a hot field or requires assignment from browse
  BRW_C2IETASKORG.AddField(_C2IETSK:Name,BRW_C2IETASKORG.Q._C2IETSK:Name) ! Field _C2IETSK:Name is a hot field or requires assignment from browse
  BRW_C2IETASKORG.AddField(_C2IPCt:C2IEInstance,BRW_C2IETASKORG.Q._C2IPCt:C2IEInstance) ! Field _C2IPCt:C2IEInstance is a hot field or requires assignment from browse
  BRW_C2IETASKORG.AddField(_C2IPCt:ID,BRW_C2IETASKORG.Q._C2IPCt:ID) ! Field _C2IPCt:ID is a hot field or requires assignment from browse
  BRW_C2IETASKORG.AddField(_C2IPCt:C2IPPackage,BRW_C2IETASKORG.Q._C2IPCt:C2IPPackage) ! Field _C2IPCt:C2IPPackage is a hot field or requires assignment from browse
  BRW_BSOORBAT.Q &= Queue:Browse:4
  BRW_BSOORBAT.AddSortOrder(,_c2ieBSOORB:KC2IE)            ! Add the sort order for _c2ieBSOORB:KC2IE for sort order 1
  BRW_BSOORBAT.AddRange(_c2ieBSOORB:C2IE,selC2IEORBATRef)  ! Add single value range limit for sort order 1
  BRW_BSOORBAT.AddLocator(BRW9::Sort0:Locator)             ! Browse has a locator for sort order 1
  BRW9::Sort0:Locator.Init(,_c2ieBSOORB:C2IE,1,BRW_BSOORBAT) ! Initialize the browse locator using  using key: _c2ieBSOORB:KC2IE , _c2ieBSOORB:C2IE
  BRW_BSOORBAT.AddField(_c2ieBSOORB:C2IE,BRW_BSOORBAT.Q._c2ieBSOORB:C2IE) ! Field _c2ieBSOORB:C2IE is a hot field or requires assignment from browse
  BRW_BSOORBAT.AddField(Uni:Code,BRW_BSOORBAT.Q.Uni:Code)  ! Field Uni:Code is a hot field or requires assignment from browse
  BRW_BSOORBAT.AddField(Uni:Name,BRW_BSOORBAT.Q.Uni:Name)  ! Field Uni:Name is a hot field or requires assignment from browse
  BRW_BSOORBAT.AddField(_c2ieBSOORB:ID,BRW_BSOORBAT.Q._c2ieBSOORB:ID) ! Field _c2ieBSOORB:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT.AddField(Uni:ID,BRW_BSOORBAT.Q.Uni:ID)      ! Field Uni:ID is a hot field or requires assignment from browse
  BRW_BSOTASKORG.Q &= Queue:Browse:5
  BRW_BSOTASKORG.AddSortOrder(,_c2ieBSOTSK:KC2IE)          ! Add the sort order for _c2ieBSOTSK:KC2IE for sort order 1
  BRW_BSOTASKORG.AddRange(_c2ieBSOTSK:C2IE,selC2IETASKORGRef) ! Add single value range limit for sort order 1
  BRW_BSOTASKORG.AddLocator(BRW10::Sort0:Locator)          ! Browse has a locator for sort order 1
  BRW10::Sort0:Locator.Init(,_c2ieBSOTSK:C2IE,1,BRW_BSOTASKORG) ! Initialize the browse locator using  using key: _c2ieBSOTSK:KC2IE , _c2ieBSOTSK:C2IE
  BRW_BSOTASKORG.SetFilter('(c2iUniTrf:BSO_From = _c2ieBSOTSK:Unit)') ! Apply filter expression to browse
  BRW_BSOTASKORG.AddField(_c2ieBSOTSK:C2IE,BRW_BSOTASKORG.Q._c2ieBSOTSK:C2IE) ! Field _c2ieBSOTSK:C2IE is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_Uni:Code,BRW_BSOTASKORG.Q._Uni:Code) ! Field _Uni:Code is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_Uni:Name,BRW_BSOTASKORG.Q._Uni:Name) ! Field _Uni:Name is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_C2IEFromTrf:Name,BRW_BSOTASKORG.Q._C2IEFromTrf:Name) ! Field _C2IEFromTrf:Name is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_c2ieBSOTSK:ID,BRW_BSOTASKORG.Q._c2ieBSOTSK:ID) ! Field _c2ieBSOTSK:ID is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_Uni:ID,BRW_BSOTASKORG.Q._Uni:ID) ! Field _Uni:ID is a hot field or requires assignment from browse
  BRW_BSOTASKORG.AddField(_C2IEFromTrf:ID,BRW_BSOTASKORG.Q._C2IEFromTrf:ID) ! Field _C2IEFromTrf:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.Q &= Queue:Browse:6
  BRW_BSOORBAT2.AddSortOrder(,_c2ieOC_ORB:KC2IE)           ! Add the sort order for _c2ieOC_ORB:KC2IE for sort order 1
  BRW_BSOORBAT2.AddRange(_c2ieOC_ORB:C2IE,selC2IEORBATRef) ! Add single value range limit for sort order 1
  BRW_BSOORBAT2.AddLocator(BRW12::Sort0:Locator)           ! Browse has a locator for sort order 1
  BRW12::Sort0:Locator.Init(,_c2ieOC_ORB:C2IE,1,BRW_BSOORBAT2) ! Initialize the browse locator using  using key: _c2ieOC_ORB:KC2IE , _c2ieOC_ORB:C2IE
  BRW_BSOORBAT2.AddField(UniP:ID,BRW_BSOORBAT2.Q.UniP:ID)  ! Field UniP:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC1:ID,BRW_BSOORBAT2.Q.UniC1:ID) ! Field UniC1:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC2:ID,BRW_BSOORBAT2.Q.UniC2:ID) ! Field UniC2:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC3:ID,BRW_BSOORBAT2.Q.UniC3:ID) ! Field UniC3:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniP:Code,BRW_BSOORBAT2.Q.UniP:Code) ! Field UniP:Code is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC1:Code,BRW_BSOORBAT2.Q.UniC1:Code) ! Field UniC1:Code is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC2:Code,BRW_BSOORBAT2.Q.UniC2:Code) ! Field UniC2:Code is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(UniC3:Code,BRW_BSOORBAT2.Q.UniC3:Code) ! Field UniC3:Code is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(_c2ieOC_ORB:ID,BRW_BSOORBAT2.Q._c2ieOC_ORB:ID) ! Field _c2ieOC_ORB:ID is a hot field or requires assignment from browse
  BRW_BSOORBAT2.AddField(_c2ieOC_ORB:C2IE,BRW_BSOORBAT2.Q._c2ieOC_ORB:C2IE) ! Field _c2ieOC_ORB:C2IE is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.Q &= Queue:Browse:7
  BRW_BSOTASKORG2.AddSortOrder(,_c2ieOC_TSK:KC2IE)         ! Add the sort order for _c2ieOC_TSK:KC2IE for sort order 1
  BRW_BSOTASKORG2.AddRange(_c2ieOC_TSK:C2IE,selC2IETASKORGRef) ! Add single value range limit for sort order 1
  BRW_BSOTASKORG2.AddLocator(BRW13::Sort0:Locator)         ! Browse has a locator for sort order 1
  BRW13::Sort0:Locator.Init(,_c2ieOC_TSK:C2IE,1,BRW_BSOTASKORG2) ! Initialize the browse locator using  using key: _c2ieOC_TSK:KC2IE , _c2ieOC_TSK:C2IE
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:Parent,BRW_BSOTASKORG2.Q._c2ieOC_TSK:Parent) ! Field _c2ieOC_TSK:Parent is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:Child1,BRW_BSOTASKORG2.Q._c2ieOC_TSK:Child1) ! Field _c2ieOC_TSK:Child1 is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:Child2,BRW_BSOTASKORG2.Q._c2ieOC_TSK:Child2) ! Field _c2ieOC_TSK:Child2 is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:Child3,BRW_BSOTASKORG2.Q._c2ieOC_TSK:Child3) ! Field _c2ieOC_TSK:Child3 is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(UniP:Code,BRW_BSOTASKORG2.Q.UniP:Code) ! Field UniP:Code is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(UniC1:Code,BRW_BSOTASKORG2.Q.UniC1:Code) ! Field UniC1:Code is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(UniC2:Code,BRW_BSOTASKORG2.Q.UniC2:Code) ! Field UniC2:Code is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(UniC3:Code,BRW_BSOTASKORG2.Q.UniC3:Code) ! Field UniC3:Code is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:ID,BRW_BSOTASKORG2.Q._c2ieOC_TSK:ID) ! Field _c2ieOC_TSK:ID is a hot field or requires assignment from browse
  BRW_BSOTASKORG2.AddField(_c2ieOC_TSK:C2IE,BRW_BSOTASKORG2.Q._c2ieOC_TSK:C2IE) ! Field _c2ieOC_TSK:C2IE is a hot field or requires assignment from browse
  BRW_C2Rel.Q &= Queue:Browse:8
  BRW_C2Rel.AddSortOrder(,c2ieUniC2Rel:Kc2ieUnit)          ! Add the sort order for c2ieUniC2Rel:Kc2ieUnit for sort order 1
  BRW_C2Rel.AddRange(c2ieUniC2Rel:c2ieUnit,selBSOForC2DisplayRef) ! Add single value range limit for sort order 1
  BRW_C2Rel.AddLocator(BRW14::Sort0:Locator)               ! Browse has a locator for sort order 1
  BRW14::Sort0:Locator.Init(,c2ieUniC2Rel:c2ieUnit,1,BRW_C2Rel) ! Initialize the browse locator using  using key: c2ieUniC2Rel:Kc2ieUnit , c2ieUniC2Rel:c2ieUnit
  BRW_C2Rel.AddField(c2ieUniC2Rel:ID,BRW_C2Rel.Q.c2ieUniC2Rel:ID) ! Field c2ieUniC2Rel:ID is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniFC:Code,BRW_C2Rel.Q.UniFC:Code)    ! Field UniFC:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniOpCom:Code,BRW_C2Rel.Q.UniOpCom:Code) ! Field UniOpCom:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniOpCon:Code,BRW_C2Rel.Q.UniOpCon:Code) ! Field UniOpCon:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniTaCom:Code,BRW_C2Rel.Q.UniTaCom:Code) ! Field UniTaCom:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniTaCon:Code,BRW_C2Rel.Q.UniTaCon:Code) ! Field UniTaCon:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(UniAdm:Code,BRW_C2Rel.Q.UniAdm:Code)  ! Field UniAdm:Code is a hot field or requires assignment from browse
  BRW_C2Rel.AddField(c2ieUniC2Rel:c2ieUnit,BRW_C2Rel.Q.c2ieUniC2Rel:c2ieUnit) ! Field c2ieUniC2Rel:c2ieUnit is a hot field or requires assignment from browse
  BRW18.Q &= Queue:Browse:9
  BRW18.AddSortOrder(,c2ieUniCP:Kc2ieUnit)                 ! Add the sort order for c2ieUniCP:Kc2ieUnit for sort order 1
  BRW18.AddRange(c2ieUniCP:c2ieUnit,selBSOForC2DisplayRef) ! Add single value range limit for sort order 1
  BRW18.AddLocator(BRW18::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW18::Sort0:Locator.Init(,c2ieUniCP:c2ieUnit,1,BRW18)   ! Initialize the browse locator using  using key: c2ieUniCP:Kc2ieUnit , c2ieUniCP:c2ieUnit
  BRW18.AddField(Uni:Code,BRW18.Q.Uni:Code)                ! Field Uni:Code is a hot field or requires assignment from browse
  BRW18.AddField(tpyCP:Code,BRW18.Q.tpyCP:Code)            ! Field tpyCP:Code is a hot field or requires assignment from browse
  BRW18.AddField(c2ieUniCP:ID,BRW18.Q.c2ieUniCP:ID)        ! Field c2ieUniCP:ID is a hot field or requires assignment from browse
  BRW18.AddField(c2ieUniCP:c2ieUnit,BRW18.Q.c2ieUniCP:c2ieUnit) ! Field c2ieUniCP:c2ieUnit is a hot field or requires assignment from browse
  BRW18.AddField(Uni:ID,BRW18.Q.Uni:ID)                    ! Field Uni:ID is a hot field or requires assignment from browse
  BRW18.AddField(tpyCP:ID,BRW18.Q.tpyCP:ID)                ! Field tpyCP:ID is a hot field or requires assignment from browse
  INIMgr.Fetch('View_ORBAT_TASKORGTransfers',QuickWindow)  ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW18.AskProcedure = 1                                   ! Will call: U_c2ieUniCPs
  FDCB11.Init(tpyC2Rel:Code,?tpyC2Rel:Code,Queue:FileDropCombo.ViewPosition,FDCB11::View:FileDropCombo,Queue:FileDropCombo,Relate:type_C2Rel,ThisWindow,GlobalErrors,0,1,0)
  FDCB11.Q &= Queue:FileDropCombo
  FDCB11.AddSortOrder(tpyC2Rel:PKID)
  FDCB11.AddField(tpyC2Rel:Code,FDCB11.Q.tpyC2Rel:Code) !List box control field - type derived from field
  FDCB11.AddUpdateField(tpyC2Rel:Code,sC2RelCode)
  ThisWindow.AddItem(FDCB11.WindowComponent)
  FDCB11.DefaultFill = 0
  BRW_C2IPORBAT.AddToolbarTarget(Toolbar)                  ! Browse accepts toolbar control
  BRW_C2IPORBAT.ToolbarItem.HelpButton = ?Help
  BRW6.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW6.ToolbarItem.HelpButton = ?Help
  BRW_C2IEORBAT.AddToolbarTarget(Toolbar)                  ! Browse accepts toolbar control
  BRW_C2IEORBAT.ToolbarItem.HelpButton = ?Help
  BRW_C2IETASKORG.AddToolbarTarget(Toolbar)                ! Browse accepts toolbar control
  BRW_C2IETASKORG.ToolbarItem.HelpButton = ?Help
  BRW_BSOORBAT.AddToolbarTarget(Toolbar)                   ! Browse accepts toolbar control
  BRW_BSOORBAT.ToolbarItem.HelpButton = ?Help
  BRW_BSOTASKORG.AddToolbarTarget(Toolbar)                 ! Browse accepts toolbar control
  BRW_BSOTASKORG.ToolbarItem.HelpButton = ?Help
  BRW_BSOORBAT2.AddToolbarTarget(Toolbar)                  ! Browse accepts toolbar control
  BRW_BSOORBAT2.ToolbarItem.HelpButton = ?Help
  BRW_BSOTASKORG2.AddToolbarTarget(Toolbar)                ! Browse accepts toolbar control
  BRW_BSOTASKORG2.ToolbarItem.HelpButton = ?Help
  BRW_C2Rel.AddToolbarTarget(Toolbar)                      ! Browse accepts toolbar control
  BRW_C2Rel.ToolbarItem.HelpButton = ?Help
  BRW18.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  BRW18.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
          DrwFrom.Kill()
          DrwTo.Kill()
          DrwOCFrom.Kill()
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:Adm.Close
    Relate:C1.Close
    Relate:C2.Close
    Relate:C2IPContent.Close
    Relate:C3.Close
    Relate:FC.Close
    Relate:OpCom.Close
    Relate:OpCon.Close
    Relate:P.Close
    Relate:TaCom.Close
    Relate:TaCon.Close
    Relate:_C2IE_TASKORGs.Close
    Relate:_C2IPContent.Close
    Relate:_c2ieBSO_ORBATs.Close
    Relate:_c2ieBSO_TASKORGs.Close
    Relate:_c2ieOrgChart_ORBATs.Close
    Relate:c2ieUnitsC2Relationships.Close
    Relate:type_C2Rel.Close
  END
  IF SELF.Opened
    INIMgr.Update('View_ORBAT_TASKORGTransfers',QuickWindow) ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    U_c2ieUniCPs
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?BUTTON1
      ThisWindow.Update()
      ! Call create New TaskOrg Object procedure
      _createNewTaskOrgObject(CLIP(sNewTaskOrgName))
      
      BRW_C2IETASKORG.ResetFromFile()
    OF ?BUTTON2
      ThisWindow.Update()
      ! add BSO Transfer
      
      ! C2IP Orbat reference
      ! C2IE Orbat reference
      ! BSO Orbat reference
      ! C2IE Taskorg reference
      
      !MESSAGE ('call ' & BRW_C2IPORBAT.q._C2IP_Orbats:ID & '---' & BRW_C2IEORBAT.q._C2IEORB:ID & '---' & BRW_BSOORBAT.q.Uni:ID & '---' & BRW_C2IETASKORG.q._C2IETSK:ID)
      _addBSOTransferToTaskOrgObject(BRW_C2IPORBAT.q._C2IP_Orbats:ID, | 
          BRW_C2IEORBAT.q._C2IEORB:ID, | 
          BRW_BSOORBAT.q.Uni:ID, |
          BRW_C2IETASKORG.q._C2IETSK:ID)
          
          
          BRW_BSOTASKORG.ResetFromFile()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeFieldEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all field specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeFieldEvent()
  CASE FIELD()
  OF ?PANEL1
    ! Pass events
    
        DrwOCFrom.TakeEvent()
  OF ?List:8
    CASE EVENT()
    OF EVENT:Drop
      ! Transfer BSO from ORBAT to TASKORG
      !optionsMenu#     = POPUP('Option1|Option2',,,)
      !nMoveToOvrlSelection    = POPUP(CLIP(sMoveToOvrlOptMenu),,,)
      !nMoveToOvrlSelection    = 1
      
      BSOFromNodeOrder = 0
      BSOToNodeOrder = 0
      
      ! BSO from
      IF LEN(CLIP(BRW_BSOORBAT2.q.UniP:Code)) > 0 THEN
          BSOFromNodeOrder = 1
          BSOFromRef  = UniP:ID
      END
      IF LEN(CLIP(BRW_BSOORBAT2.q.UniC1:Code)) > 0 THEN
          BSOFromNodeOrder = 2
          BSOFromRef  = UniC1:ID
      END
      IF LEN(CLIP(BRW_BSOORBAT2.q.UniC2:Code)) > 0 THEN
          BSOFromNodeOrder = 3
          BSOFromRef  = UniC2:ID
      END
      IF LEN(CLIP(BRW_BSOORBAT2.q.UniC3:Code)) > 0 THEN
          BSOFromNodeOrder = 4   
          BSOFromRef  = UniC3:ID
      END
      !MESSAGE('BSOFromNodeOrder = ' & BSOFromNodeOrder)
      
      ! BSO To
      !MESSAGE('rec = ' & RECORDS(BRW_BSOTASKORG2.q))
      IF RECORDS(BRW_BSOTASKORG2.q) = 0 THEN
          BSOToNodeOrder = 0
          ! Parent reference is not available (MAIN node)
          BSOParentRef    = 0
      ELSE
          IF BRW_BSOTASKORG2.q._c2ieOC_TSK:Parent <> 0 THEN
              BSOToNodeOrder = 1
              BSOParentRef    = BRW_BSOTASKORG2.q._c2ieOC_TSK:Parent
          END
          IF BRW_BSOTASKORG2.q._c2ieOC_TSK:Child1 <> 0 THEN
              BSOToNodeOrder = 2
              BSOParentRef    = BRW_BSOTASKORG2.q._c2ieOC_TSK:Child1
          END
          IF BRW_BSOTASKORG2.q._c2ieOC_TSK:Child2 <> 0 THEN
              BSOToNodeOrder = 3
              BSOParentRef    = BRW_BSOTASKORG2.q._c2ieOC_TSK:Child2
          END
          IF BRW_BSOTASKORG2.q._c2ieOC_TSK:Child3 <> 0 THEN
              BSOToNodeOrder = 4
              BSOParentRef    = BRW_BSOTASKORG2.q._c2ieOC_TSK:Child3
          END
      END   
      
      !MESSAGE('BSOToNodeOrder = ' & BSOToNodeOrder)
      
      ! Update c2ie TaskOrg
      IF Access:c2ieTaskOrg.PrimeRecord() = Level:Benign THEN    
          c2ieTO:C2IE    = BRW_C2IETASKORG.q._C2IETSK:ID
          CASE BSOToNodeOrder
          OF 0
              ! Insert as Parent
              c2ieTO:Parent  = BSOFromRef
          OF 1
              ! Insert as Child1
              c2ieTO:Child1  = BSOFromRef
          OF 2
              ! Insert as Child2
              c2ieTO:Child2  = BSOFromRef
          OF 3
              ! Insert as Child3
              c2ieTO:Child3  = BSOFromRef    
          OF 4
              ! Insert as Child4
              c2ieTO:Child4  = BSOFromRef
          END
      
          IF Access:c2ieTaskOrg.TryInsert() = Level:Benign THEN
              !MESSAGE('TASKORG updated')     
          ELSE
              Access:c2ieTaskOrg.CancelAutoInc()
          END
      
          BRW_BSOTASKORG2.ResetFromFile()
      END
      ! add BSO Transfer
      
      ! C2IP Orbat reference
      ! C2IE Orbat reference
      ! BSO Orbat reference
      ! C2IE Taskorg reference
      
      !MESSAGE ('call ' & BRW_C2IPORBAT.q._C2IP_Orbats:ID & '---' & BRW_C2IEORBAT.q._C2IEORB:ID & '---' & BRW_BSOORBAT.q.Uni:ID & '---' & BRW_C2IETASKORG.q._C2IETSK:ID)
      !_addBSOTransferToTaskOrgObject(BRW_C2IPORBAT.q._C2IP_Orbats:ID, | 
      !    BRW_C2IEORBAT.q._C2IEORB:ID, | 
      !    BSOFromRef, |
      !    BRW_C2IETASKORG.q._C2IETSK:ID)
          
          
          !MESSAGE('BSOParentRef = ' & BSOParentRef)
      _addBSOTransferToTaskOrgObject2(BRW_C2IPORBAT.q._C2IP_Orbats:ID, | 
          BRW_C2IEORBAT.q._C2IEORB:ID, | 
          BSOFromRef, |
          BRW_C2IETASKORG.q._C2IETSK:ID, |
          sC2RelCode, |
          BSOParentRef)    
          
          
      BRW_BSOTASKORG.ResetFromFile()
      BRW_C2Rel.ResetFromFile()
    END
  END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


BRW_C2IEORBAT.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! current selection selC2IEORBATRef
  
  selC2IEORBATRef = BRW_C2IEORBAT.q._C2IEORB:ID
  
  DO _drawOrgChartFrom
  
  !DrawPaint does not work properly at the moment
  !DO _drawOCFrom


BRW_C2IETASKORG.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! current selection selC2IETASKORGRef
  
  selC2IETASKORGRef = BRW_C2IETASKORG.q._C2IETSK:ID
  
  DO _drawOrgChartTo


BRW_BSOTASKORG.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! current selection BSO for C2 Relationships Display
  selBSOForC2DisplayRef   = BRW_BSOTASKORG.q._c2ieBSOTSK:ID


BRW18.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END

!!! <summary>
!!! Generated from procedure template - Source
!!! create New COP Object
!!! </summary>
_createNewCOPObject  PROCEDURE  (STRING pCOPName,ULONG pOrgRef,ULONG pMissionRef) ! Declare Procedure
nC2IERef             DECIMAL(7)                            ! 
nC2IPRef             DECIMAL(7)                            ! 

  CODE
! Create COP C2IP

IF LEN(CLIP(pCOPName))>0 THEN
    ! Create default OVERLAY C2IE
    Access:_C2IEs.PrimeAutoInc()
    nC2IERef    = _C2IE:ID
    tpyC2IE:Code    = 'OVERLAY'
    IF Access:type_C2IE.Fetch(tpyC2IE:KCode) = Level:Benign THEN
        _C2IE:Type  = tpyC2IE:ID
    END
    _C2IE:Name  = pCOPName
    IF Access:_C2IEs.TryInsert() = Level:Benign THEN        
        ! Create COP C2IP
        Access:_C2IPs.PrimeAutoInc()
        nC2IPRef    = _C2IP:ID
        tpyC2IP:Code     = 'COP'
        IF Access:type_C2IP.Fetch(tpyC2IP:KCode) = Level:Benign THEN
            _C2IP:Type  = tpyC2IP:ID
        END
        _C2IP:Name  = pCOPName
        
        IF Access:_C2IPs.TryInsert() = Level:Benign THEN
            ! Create association C2IP - C2IE
            
            Access:_C2IPContent.PrimeAutoInc()
            _C2IPCt:C2IPPackage = nC2IPRef
            _C2IPCt:C2IEInstance    = nC2IERef
            IF Access:_C2IPContent.TryInsert() = Level:Benign THEN
                !MESSAGE('COP created')
                
                ! Add the new C2IP to the current C2IP Explorer
                Access:C2IPExplorer.PrimeAutoInc()
                C2IPExp:Organization    = pOrgRef                
                C2IPExp:C2IP            = nC2IPRef
                C2IPExp:Mission         = pMissionRef
                
                IF Access:C2IPExplorer.TryInsert() = Level:Benign THEN
                    MESSAGE('C2IP COP created')
                END
                
            END
            
        END
        
    END
    

END

!!! <summary>
!!! Generated from procedure template - Source
!!! create New Taskorg Object
!!! </summary>
_createNewTaskOrgObject PROCEDURE  (STRING pTaskOrgName)   ! Declare Procedure
nC2IERef             DECIMAL(7)                            ! 
nC2IPRef             DECIMAL(7)                            ! 

  CODE
! Create TASKORG C2IP

IF LEN(CLIP(pTaskOrgName))>0 THEN
    ! Create default TASKORG C2IE
    Access:_C2IEs.PrimeAutoInc()
    nC2IERef    = _C2IE:ID
    tpyC2IE:Code    = 'TASKORG'
    IF Access:type_C2IE.Fetch(tpyC2IE:KCode) = Level:Benign THEN
        _C2IE:Type  = tpyC2IE:ID
    END
    _C2IE:Name  = pTaskOrgName
    IF Access:_C2IEs.TryInsert() = Level:Benign THEN        
        ! Create TASKORG C2IP
        Access:_C2IPs.PrimeAutoInc()
        nC2IPRef    = _C2IP:ID
        tpyC2IP:Code     = 'TASKORG'
        IF Access:type_C2IP.Fetch(tpyC2IP:KCode) = Level:Benign THEN
            _C2IP:Type  = tpyC2IP:ID
        END
        _C2IP:Name  = pTaskOrgName
        
        IF Access:_C2IPs.TryInsert() = Level:Benign THEN
            ! Create association C2IP - C2IE
            
            Access:_C2IPContent.PrimeAutoInc()
            _C2IPCt:C2IPPackage = nC2IPRef
            _C2IPCt:C2IEInstance    = nC2IERef
            IF Access:_C2IPContent.TryInsert() = Level:Benign THEN
                !MESSAGE('TaskOrg created')
                
                OMIT('__noCompile'_)
                ! Add the new C2IP to the current C2IP Explorer
                Access:C2IPExplorer.PrimeAutoInc()
                C2IPExp:Organization    = pOrgRef                
                C2IPExp:C2IP            = nC2IPRef
                C2IPExp:Mission         = pMissionRef
                
                IF Access:C2IPExplorer.TryInsert() = Level:Benign THEN
                    MESSAGE('C2IP COP created')
                END
                
                __noCompile
                
            END
            
        END
        
    END
    

END

!!! <summary>
!!! Generated from procedure template - Source
!!! add BSO Transfer to Taskorg Object
!!! </summary>
_addBSOTransferToTaskOrgObject PROCEDURE  (ULONG pC2IPRef, ULONG pC2IEFromRef, ULONG pBSORef, ULONG pC2IEToRef) ! Declare Procedure

  CODE
    ! add BSO Tranfer
    
    Access:_c2ieUnits.Open()
    Access:c2ieUnitTransfer.Open()
    
    !MESSAGE('receoved ' & pC2IPRef & '---' & pC2IEFromRef & '---' & pBSORef & '---' & pC2IEToRef)

    IF Access:_c2ieUnits.PrimeAutoInc() = Level:Benign THEN
        _c2ieUni:C2IE   = pC2IEToRef
        _c2ieUni:Unit   = pBSORef
        _c2ieUni:Hostility  = 1
        
        IF Access:_c2ieUnits.TryInsert() = Level:Benign THEN
            ! BSO inserted into C2IE list of Units/BSOs                                    
            
            ! Update BSO Transfers List
            IF Access:c2ieUnitTransfer.PrimeAutoInc() = Level:Benign THEN
                
                c2iUniTrf:c2ieUnit    = _c2ieUni:ID
                
                c2iUniTrf:C2IE_From     = pC2IEFromRef
                c2iUniTrf:C2IE_To       = pC2IEToRef
            
                c2iUniTrf:BSO_From    = pBSORef
                c2iUniTrf:BSO_To      = _c2ieUni:Unit
                
                IF Access:c2ieUnitTransfer.TryInsert() = Level:Benign THEN
                    !MESSAGE('BSO Transfer created')
                ELSE
                    MESSAGE('Access:c2ieUnitTransfer TryInsert error')
                END
            ELSE
                MESSAGE('Access:c2ieUnitTransfer error prime insert')
                
            END
        ELSE
            MESSAGE('Access:_c2ieUnits TryInsert error')
                        
            
        END
    ELSE
        MESSAGE('Access:_c2ieUnits error prime insert')
    END

    Access:c2ieUnitTransfer.Close()
    Access:_c2ieUnits.Close()



!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the _c2ieBSO_TASKORGs file
!!! </summary>
B__c2ieBSO_TASKORGs PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(_c2ieBSO_TASKORGs)
                       PROJECT(_c2ieBSOTSK:ID)
                       PROJECT(_c2ieBSOTSK:C2IE)
                       PROJECT(_c2ieBSOTSK:Unit)
                       PROJECT(_c2ieBSOTSK:Hostility)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
_c2ieBSOTSK:ID         LIKE(_c2ieBSOTSK:ID)           !List box control field - type derived from field
_c2ieBSOTSK:C2IE       LIKE(_c2ieBSOTSK:C2IE)         !List box control field - type derived from field
_c2ieBSOTSK:Unit       LIKE(_c2ieBSOTSK:Unit)         !List box control field - type derived from field
_c2ieBSOTSK:Hostility  LIKE(_c2ieBSOTSK:Hostility)    !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the _c2ieBSO_TASKORGs file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B__c2ieBSO_TASKORGs'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~' & |
  'ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the _c2ieBSO_TASKORGs file')
                       BUTTON('&Select'),AT(8,158,49,14),USE(?Select:2),LEFT,ICON('WASELECT.ICO'),FLAT,MSG('Select the Record'), |
  TIP('Select the Record')
                       BUTTON('&View'),AT(61,158,49,14),USE(?View:3),LEFT,ICON('WAVIEW.ICO'),FLAT,MSG('View Record'), |
  TIP('View Record')
                       BUTTON('&Insert'),AT(114,158,49,14),USE(?Insert:4),LEFT,ICON('WAINSERT.ICO'),FLAT,MSG('Insert a Record'), |
  TIP('Insert a Record')
                       BUTTON('&Change'),AT(167,158,49,14),USE(?Change:4),LEFT,ICON('WACHANGE.ICO'),DEFAULT,FLAT, |
  MSG('Change the Record'),TIP('Change the Record')
                       BUTTON('&Delete'),AT(220,158,49,14),USE(?Delete:4),LEFT,ICON('WADELETE.ICO'),FLAT,MSG('Delete the Record'), |
  TIP('Delete the Record')
                       SHEET,AT(4,4,269,172),USE(?CurrentTab)
                         TAB('&1) PKID'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Close'),AT(171,180,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(224,180,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepRealClass                        ! Default Step Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('B__c2ieBSO_TASKORGs')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:_c2ieBSO_TASKORGs.Open                            ! File _c2ieBSO_TASKORGs used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:_c2ieBSO_TASKORGs,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon _c2ieBSOTSK:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,_c2ieBSOTSK:PKID) ! Add the sort order for _c2ieBSOTSK:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,_c2ieBSOTSK:ID,1,BRW1)         ! Initialize the browse locator using  using key: _c2ieBSOTSK:PKID , _c2ieBSOTSK:ID
  BRW1.AddField(_c2ieBSOTSK:ID,BRW1.Q._c2ieBSOTSK:ID)      ! Field _c2ieBSOTSK:ID is a hot field or requires assignment from browse
  BRW1.AddField(_c2ieBSOTSK:C2IE,BRW1.Q._c2ieBSOTSK:C2IE)  ! Field _c2ieBSOTSK:C2IE is a hot field or requires assignment from browse
  BRW1.AddField(_c2ieBSOTSK:Unit,BRW1.Q._c2ieBSOTSK:Unit)  ! Field _c2ieBSOTSK:Unit is a hot field or requires assignment from browse
  BRW1.AddField(_c2ieBSOTSK:Hostility,BRW1.Q._c2ieBSOTSK:Hostility) ! Field _c2ieBSOTSK:Hostility is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B__c2ieBSO_TASKORGs',QuickWindow)          ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U__c2ieBSO_TASKORGs
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:_c2ieBSO_TASKORGs.Close
  END
  IF SELF.Opened
    INIMgr.Update('B__c2ieBSO_TASKORGs',QuickWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    U__c2ieBSO_TASKORGs
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:4
    SELF.ChangeControl=?Change:4
    SELF.DeleteControl=?Delete:4
  END
  SELF.ViewControl = ?View:3                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Form _c2ieBSO_TASKORGs
!!! </summary>
U__c2ieBSO_TASKORGs PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
History::_c2ieBSOTSK:Record LIKE(_c2ieBSOTSK:RECORD),THREAD
QuickWindow          WINDOW('Form _c2ieBSO_TASKORGs'),AT(,,163,98),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('U__c2ieBSO_TASKORGs'),SYSTEM
                       SHEET,AT(4,4,155,72),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?c2ieUni:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(_c2ieBSOTSK:ID),DECIMAL(12)
                           PROMPT('ID:'),AT(8,34),USE(?c2ieUni:C2IE:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,34,48,10),USE(_c2ieBSOTSK:C2IE),DECIMAL(12)
                           PROMPT('ID:'),AT(8,48),USE(?c2ieUni:Unit:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,48,48,10),USE(_c2ieBSOTSK:Unit),DECIMAL(12),REQ
                           PROMPT('ID:'),AT(8,62),USE(?c2ieUni:Hostility:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,62,48,10),USE(_c2ieBSOTSK:Hostility),DECIMAL(12)
                         END
                       END
                       BUTTON('&OK'),AT(4,80,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(57,80,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(110,80,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Ask                    PROCEDURE(),DERIVED
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
ToolbarForm          ToolbarUpdateClass                    ! Form Toolbar Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

CurCtrlFeq          LONG
FieldColorQueue     QUEUE
Feq                   LONG
OldColor              LONG
                    END

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Ask PROCEDURE

  CODE
  CASE SELF.Request                                        ! Configure the action message text
  OF ViewRecord
    ActionMessage = 'View Record'
  OF InsertRecord
    ActionMessage = 'Record Will Be Added'
  OF ChangeRecord
    ActionMessage = 'Record Will Be Changed'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U__c2ieBSO_TASKORGs')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?c2ieUni:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(_c2ieBSOTSK:Record,History::_c2ieBSOTSK:Record)
  SELF.AddHistoryField(?_c2ieBSOTSK:ID,1)
  SELF.AddHistoryField(?_c2ieBSOTSK:C2IE,2)
  SELF.AddHistoryField(?_c2ieBSOTSK:Unit,3)
  SELF.AddHistoryField(?_c2ieBSOTSK:Hostility,4)
  SELF.AddUpdateFile(Access:_c2ieBSO_TASKORGs)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:_c2ieBSO_TASKORGs.Open                            ! File _c2ieBSO_TASKORGs used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:_c2ieBSO_TASKORGs
  IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing ! Setup actions for ViewOnly Mode
    SELF.InsertAction = Insert:None
    SELF.DeleteAction = Delete:None
    SELF.ChangeAction = Change:None
    SELF.CancelAction = Cancel:Cancel
    SELF.OkControl = 0
  ELSE
    SELF.ChangeAction = Change:Caller                      ! Changes allowed
    SELF.CancelAction = Cancel:Cancel+Cancel:Query         ! Confirm cancel
    SELF.OkControl = ?OK
    IF SELF.PrimeUpdate() THEN RETURN Level:Notify.
  END
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?_c2ieBSOTSK:ID{PROP:ReadOnly} = True
    ?_c2ieBSOTSK:C2IE{PROP:ReadOnly} = True
    ?_c2ieBSOTSK:Unit{PROP:ReadOnly} = True
    ?_c2ieBSOTSK:Hostility{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U__c2ieBSO_TASKORGs',QuickWindow)          ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:_c2ieBSO_TASKORGs.Close
  END
  IF SELF.Opened
    INIMgr.Update('U__c2ieBSO_TASKORGs',QuickWindow)       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run()
  IF SELF.Request = ViewRecord                             ! In View Only mode always signal RequestCancelled
    ReturnValue = RequestCancelled
  END
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the type_StdEqp file
!!! </summary>
B_typeStdEq PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(type_StdEqp)
                       PROJECT(tpyStdEqp:ID)
                       PROJECT(tpyStdEqp:Name)
                       PROJECT(tpyStdEqp:Code)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
tpyStdEqp:ID           LIKE(tpyStdEqp:ID)             !List box control field - type derived from field
tpyStdEqp:Name         LIKE(tpyStdEqp:Name)           !List box control field - type derived from field
tpyStdEqp:Code         LIKE(tpyStdEqp:Code)           !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the type_StdEqp file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_typeStdEq'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@80L(2)|M~' & |
  'Name~L(2)@s100@80L(2)|M~Code~L(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the ' & |
  'type_StdEqp file')
                       BUTTON('&Select'),AT(8,158,49,14),USE(?Select:2),LEFT,ICON('WASELECT.ICO'),FLAT,MSG('Select the Record'), |
  TIP('Select the Record')
                       BUTTON('&View'),AT(61,158,49,14),USE(?View:3),LEFT,ICON('WAVIEW.ICO'),FLAT,MSG('View Record'), |
  TIP('View Record')
                       BUTTON('&Insert'),AT(114,158,49,14),USE(?Insert:4),LEFT,ICON('WAINSERT.ICO'),FLAT,MSG('Insert a Record'), |
  TIP('Insert a Record')
                       BUTTON('&Change'),AT(167,158,49,14),USE(?Change:4),LEFT,ICON('WACHANGE.ICO'),DEFAULT,FLAT, |
  MSG('Change the Record'),TIP('Change the Record')
                       BUTTON('&Delete'),AT(220,158,49,14),USE(?Delete:4),LEFT,ICON('WADELETE.ICO'),FLAT,MSG('Delete the Record'), |
  TIP('Delete the Record')
                       SHEET,AT(4,4,269,172),USE(?CurrentTab)
                         TAB('&1) PKID'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Close'),AT(171,180,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(224,180,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
BRW1                 CLASS(BrowseClass)                    ! Browse using ?Browse:1
Q                      &Queue:Browse:1                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW1::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW1::Sort0:StepClass StepRealClass                        ! Default Step Manager
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('B_typeStdEq')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:type_StdEqp.Open                                  ! File type_StdEqp used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:type_StdEqp,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon tpyStdEqp:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,tpyStdEqp:PKID)  ! Add the sort order for tpyStdEqp:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,tpyStdEqp:ID,1,BRW1)           ! Initialize the browse locator using  using key: tpyStdEqp:PKID , tpyStdEqp:ID
  BRW1.AddField(tpyStdEqp:ID,BRW1.Q.tpyStdEqp:ID)          ! Field tpyStdEqp:ID is a hot field or requires assignment from browse
  BRW1.AddField(tpyStdEqp:Name,BRW1.Q.tpyStdEqp:Name)      ! Field tpyStdEqp:Name is a hot field or requires assignment from browse
  BRW1.AddField(tpyStdEqp:Code,BRW1.Q.tpyStdEqp:Code)      ! Field tpyStdEqp:Code is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_typeStdEq',QuickWindow)                  ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_typeStdEq
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:type_StdEqp.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_typeStdEq',QuickWindow)               ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.Run PROCEDURE(USHORT Number,BYTE Request)

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Run(Number,Request)
  IF SELF.Request = ViewRecord
    ReturnValue = RequestCancelled                         ! Always return RequestCancelled if the form was opened in ViewRecord mode
  ELSE
    GlobalRequest = Request
    U_typeStdEq
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  SELF.SelectControl = ?Select:2
  SELF.HideSelect = 1                                      ! Hide the select button when disabled
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:4
    SELF.ChangeControl=?Change:4
    SELF.DeleteControl=?Delete:4
  END
  SELF.ViewControl = ?View:3                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Source
!!! add BSO Transfer to Taskorg Object
!!! </summary>
_addBSOTransferToTaskOrgObject2 PROCEDURE  (ULONG pC2IPRef,ULONG pC2IEFromRef,ULONG pBSORef,ULONG pC2IEToRef,STRING pC2RelCode,ULONG pBSOParentRef) ! Declare Procedure

  CODE
    ! add BSO Tranfer
    
    Access:_c2ieUnits.Open()
    Access:c2ieUnitTransfer.Open()
    Access:c2ieUnitsC2Relationships.Open()
    
    !MESSAGE('receoved ' & pC2IPRef & '---' & pC2IEFromRef & '---' & pBSORef & '---' & pC2IEToRef)

    IF Access:_c2ieUnits.PrimeAutoInc() = Level:Benign THEN
        _c2ieUni:C2IE   = pC2IEToRef
        _c2ieUni:Unit   = pBSORef
        _c2ieUni:Hostility  = 1
        
        IF Access:_c2ieUnits.TryInsert() = Level:Benign THEN
            ! BSO inserted into C2IE list of Units/BSOs
            
            ! Update BSO C2 Relationships
            IF Access:c2ieUnitsC2Relationships.PrimeRecord() = Level:Benign THEN
                    !MESSAGE('the new _c2ieUni:ID = ' & _c2ieUni:ID)
                    c2ieUniC2Rel:c2ieUnit   = _c2ieUni:ID
                    CASE CLIP(pC2RelCode)
                    OF 'FC'
                        ! Full Command
                        c2ieUniC2Rel:FC = pBSOParentRef
                    OF 'OpCom'
                        ! OpCom
                        c2ieUniC2Rel:OpCom  = pBSOParentRef
                    OF 'OpCon'
                        ! OpCon
                        c2ieUniC2Rel:OpCon  = pBSOParentRef
                    OF 'TaCom'
                        ! TaCom
                        c2ieUniC2Rel:TaCom  = pBSOParentRef
                    OF 'TaCon'
                        ! TaCon
                        c2ieUniC2Rel:TaCon  = pBSOParentRef
                    OF 'Adm'
                        ! Administrative
                        c2ieUniC2Rel:Adm    = pBSOParentRef
                    ELSE
                        ! default FC
                        ! Full Command
                        c2ieUniC2Rel:FC = pBSOParentRef
                    END    
                
                IF Access:c2ieUnitsC2Relationships.TryInsert() = Level:Benign THEN
                    ! C2 Relationship added    
                ELSE
                    Access:c2ieUnitsC2Relationships.CancelAutoInc()                    
                END
                
            END
            
            
            ! Update BSO Transfers List
            IF Access:c2ieUnitTransfer.PrimeAutoInc() = Level:Benign THEN
                
                c2iUniTrf:c2ieUnit    = _c2ieUni:ID
                
                c2iUniTrf:C2IE_From     = pC2IEFromRef
                c2iUniTrf:C2IE_To       = pC2IEToRef
            
                c2iUniTrf:BSO_From    = pBSORef
                c2iUniTrf:BSO_To      = _c2ieUni:Unit
                
                IF Access:c2ieUnitTransfer.TryInsert() = Level:Benign THEN
                    !MESSAGE('BSO Transfer created')
                ELSE
                    MESSAGE('Access:c2ieUnitTransfer TryInsert error')
                END
            ELSE
                MESSAGE('Access:c2ieUnitTransfer error prime insert')                
            END
        ELSE
            MESSAGE('Access:_c2ieUnits TryInsert error')
                        
            
        END
    ELSE
        MESSAGE('Access:_c2ieUnits error prime insert')
    END

    Access:c2ieUnitsC2Relationships.Close()
    Access:c2ieUnitTransfer.Close()
    Access:_c2ieUnits.Close()



