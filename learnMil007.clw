

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL007.INC'),ONCE        !Local module procedure declarations
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
  GlobalErrors.SetProcedureName('U_MissionTASKORG')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?MissTSK:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
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
  FDCB9.Init(C2IP:Name,?C2IP:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:C2IPExplorer,ThisWindow,GlobalErrors,0,1,0)
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

