

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL006.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LEARNMIL007.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form TheaterOfOps
!!! </summary>
U_TOOs PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
History::TOO:Record  LIKE(TOO:RECORD),THREAD
QuickWindow          WINDOW('Form TheaterOfOps'),AT(,,358,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_TOOs'),SYSTEM
                       SHEET,AT(4,4,350,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?TOO:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(TOO:ID),DECIMAL(12)
                           PROMPT('Name:'),AT(8,34),USE(?TOO:Name:Prompt),TRN
                           ENTRY(@s100),AT(61,34,289,10),USE(TOO:Name)
                           PROMPT('Code:'),AT(8,48),USE(?TOO:Code:Prompt),TRN
                           ENTRY(@s20),AT(61,48,84,10),USE(TOO:Code)
                         END
                       END
                       BUTTON('&OK'),AT(199,66,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(252,66,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(305,66,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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
  GlobalErrors.SetProcedureName('U_TOOs')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?TOO:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(TOO:Record,History::TOO:Record)
  SELF.AddHistoryField(?TOO:ID,1)
  SELF.AddHistoryField(?TOO:Name,2)
  SELF.AddHistoryField(?TOO:Code,3)
  SELF.AddUpdateFile(Access:TheaterOfOps)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:TheaterOfOps.Open                                 ! File TheaterOfOps used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:TheaterOfOps
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
    ?TOO:ID{PROP:ReadOnly} = True
    ?TOO:Name{PROP:ReadOnly} = True
    ?TOO:Code{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_TOOs',QuickWindow)                       ! Restore window settings from non-volatile store
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
    Relate:TheaterOfOps.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_TOOs',QuickWindow)                    ! Save window data to non-volatile store
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
!!! Browse the MilMissions file
!!! </summary>
B_Missions PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(MilMissions)
                       PROJECT(Miss:ID)
                       PROJECT(Miss:Name)
                       PROJECT(Miss:Code)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
Miss:ID                LIKE(Miss:ID)                  !List box control field - type derived from field
Miss:Name              LIKE(Miss:Name)                !List box control field - type derived from field
Miss:Code              LIKE(Miss:Code)                !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the MilMissions file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_Missions'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@80L(2)|M~' & |
  'Name~L(2)@s100@80L(2)|M~Code~L(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the ' & |
  'MilMissions file')
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
                       BUTTON('View OrgMissions'),AT(4,180,49,14),USE(?BrowseOrgMissions),LEFT,ICON('WACHILD.ICO'), |
  FLAT,MSG('View Child File'),TIP('View Child File')
                       BUTTON('&Close'),AT(171,180,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(224,180,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
Run                    PROCEDURE(USHORT Number,BYTE Request),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
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
  GlobalErrors.SetProcedureName('B_Missions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MilMissions.Open                                  ! File MilMissions used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:MilMissions,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon Miss:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,Miss:PKID)       ! Add the sort order for Miss:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,Miss:ID,1,BRW1)                ! Initialize the browse locator using  using key: Miss:PKID , Miss:ID
  BRW1.AddField(Miss:ID,BRW1.Q.Miss:ID)                    ! Field Miss:ID is a hot field or requires assignment from browse
  BRW1.AddField(Miss:Name,BRW1.Q.Miss:Name)                ! Field Miss:Name is a hot field or requires assignment from browse
  BRW1.AddField(Miss:Code,BRW1.Q.Miss:Code)                ! Field Miss:Code is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_Missions',QuickWindow)                   ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_Missions
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
    Relate:MilMissions.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_Missions',QuickWindow)                ! Save window data to non-volatile store
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
    U_Missions
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
    OF ?BrowseOrgMissions
      ThisWindow.Update()
      BrowseOrgMissionsByOrgMiss:KMission()
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
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
!!! Browse the OrgMissions file by OrgMiss:KMission
!!! </summary>
BrowseOrgMissionsByOrgMiss:KMission PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(OrgMissions)
                       PROJECT(OrgMiss:ID)
                       PROJECT(OrgMiss:Organization)
                       PROJECT(OrgMiss:Mission)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
OrgMiss:ID             LIKE(OrgMiss:ID)               !List box control field - type derived from field
OrgMiss:Organization   LIKE(OrgMiss:Organization)     !List box control field - type derived from field
OrgMiss:Mission        LIKE(OrgMiss:Mission)          !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the OrgMissions file by OrgMiss:KMission'),AT(,,224,198),FONT('Microsoft ' & |
  'Sans Serif',8,,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('BrowseOrgM' & |
  'issionsByOrgMiss:KMission'),SYSTEM
                       LIST,AT(8,30,208,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@52R(2)|M~' & |
  'Organization~C(0)@n-10.0@48R(2)|M~Mission~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he OrgMissions file')
                       BUTTON('&View'),AT(8,158,49,14),USE(?View:2),LEFT,ICON('WAVIEW.ICO'),FLAT,MSG('View Record'), |
  TIP('View Record')
                       BUTTON('&Insert'),AT(61,158,49,14),USE(?Insert:3),LEFT,ICON('WAINSERT.ICO'),FLAT,MSG('Insert a Record'), |
  TIP('Insert a Record')
                       BUTTON('&Change'),AT(114,158,49,14),USE(?Change:3),LEFT,ICON('WACHANGE.ICO'),DEFAULT,FLAT, |
  MSG('Change the Record'),TIP('Change the Record')
                       BUTTON('&Delete'),AT(167,158,49,14),USE(?Delete:3),LEFT,ICON('WADELETE.ICO'),FLAT,MSG('Delete the Record'), |
  TIP('Delete the Record')
                       SHEET,AT(4,4,216,172),USE(?CurrentTab)
                         TAB('&1) KMission'),USE(?Tab:2)
                         END
                       END
                       BUTTON('&Close'),AT(118,180,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(171,180,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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
  GlobalErrors.SetProcedureName('BrowseOrgMissionsByOrgMiss:KMission')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MilMissions.SetOpenRelated()
  Relate:MilMissions.Open                                  ! File MilMissions used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:OrgMissions,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon OrgMiss:Mission for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,OrgMiss:KMission) ! Add the sort order for OrgMiss:KMission for sort order 1
  BRW1.AddRange(OrgMiss:Mission,Relate:OrgMissions,Relate:MilMissions) ! Add file relationship range limit for sort order 1
  BRW1.AddField(OrgMiss:ID,BRW1.Q.OrgMiss:ID)              ! Field OrgMiss:ID is a hot field or requires assignment from browse
  BRW1.AddField(OrgMiss:Organization,BRW1.Q.OrgMiss:Organization) ! Field OrgMiss:Organization is a hot field or requires assignment from browse
  BRW1.AddField(OrgMiss:Mission,BRW1.Q.OrgMiss:Mission)    ! Field OrgMiss:Mission is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('BrowseOrgMissionsByOrgMiss:KMission',QuickWindow) ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: UpdateOrgMissions
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
    Relate:MilMissions.Close
  END
  IF SELF.Opened
    INIMgr.Update('BrowseOrgMissionsByOrgMiss:KMission',QuickWindow) ! Save window data to non-volatile store
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
    UpdateOrgMissions
    ReturnValue = GlobalResponse
  END
  RETURN ReturnValue


BRW1.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END
  SELF.ViewControl = ?View:2                               ! Setup the control used to initiate view only mode


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Form MilMissions
!!! </summary>
U_Missions PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(type_MilOps)
                       PROJECT(tpyMilOp:Name)
                       PROJECT(tpyMilOp:ID)
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?tpyMilOp:Name
tpyMilOp:Name          LIKE(tpyMilOp:Name)            !List box control field - type derived from field
tpyMilOp:ID            LIKE(tpyMilOp:ID)              !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::Miss:Record LIKE(Miss:RECORD),THREAD
QuickWindow          WINDOW('Form MilMissions'),AT(,,417,271),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_Missions'),SYSTEM
                       PROMPT('ID:'),AT(8,20),USE(?Miss:ID:Prompt),TRN
                       PROMPT('Name:'),AT(8,34),USE(?Miss:Name:Prompt),TRN
                       ENTRY(@s100),AT(61,34,289,10),USE(Miss:Name)
                       ENTRY(@n-10.0),AT(61,20,48,10),USE(Miss:ID),DECIMAL(12)
                       PROMPT('Code:'),AT(8,48),USE(?Miss:Code:Prompt),TRN
                       ENTRY(@s20),AT(61,48,84,10),USE(Miss:Code)
                       BUTTON('&OK'),AT(259,255,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(312,255,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(365,255,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       PROMPT('Start Date:'),AT(11,63),USE(?Miss:StartDate:Prompt)
                       ENTRY(@D10),AT(61,63,60,10),USE(Miss:StartDate),DECIMAL(12)
                       PROMPT('Start Time:'),AT(137,64),USE(?Miss:StartTime:Prompt)
                       ENTRY(@T4),AT(187,63,60,10),USE(Miss:StartTime)
                       PROMPT('End Date:'),AT(12,78),USE(?Miss:EndDate:Prompt)
                       ENTRY(@D10),AT(61,78,60,10),USE(Miss:EndDate)
                       PROMPT('End Time:'),AT(137,79),USE(?Miss:EndTime:Prompt)
                       ENTRY(@T4),AT(187,78,60,10),USE(Miss:EndTime)
                       PROMPT('Military Operation type:'),AT(8,93,49,32),USE(?Miss:MilOpType:Prompt)
                       ENTRY(@n-10.0),AT(61,92,60,10),USE(Miss:MilOpType),DECIMAL(12),HIDE
                       COMBO(@s100),AT(61,92,289,10),USE(tpyMilOp:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@'), |
  FROM(Queue:FileDropCombo),IMM
                       TEXT,AT(62,118,288,86),USE(Miss:freeText,,?Miss:freeText:2),RTF(TEXT:Field)
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
    ActionMessage = 'View Mission'
  OF InsertRecord
    ActionMessage = 'Define New Mission'
  OF ChangeRecord
    ActionMessage = 'Modify Mission'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_Missions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Miss:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(Miss:Record,History::Miss:Record)
  SELF.AddHistoryField(?Miss:Name,2)
  SELF.AddHistoryField(?Miss:ID,1)
  SELF.AddHistoryField(?Miss:Code,3)
  SELF.AddHistoryField(?Miss:StartDate,4)
  SELF.AddHistoryField(?Miss:StartTime,5)
  SELF.AddHistoryField(?Miss:EndDate,6)
  SELF.AddHistoryField(?Miss:EndTime,7)
  SELF.AddHistoryField(?Miss:MilOpType,8)
  SELF.AddHistoryField(?Miss:freeText:2,9)
  SELF.AddUpdateFile(Access:MilMissions)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:MilMissions.Open                                  ! File MilMissions used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:MilMissions
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
    ?Miss:Name{PROP:ReadOnly} = True
    ?Miss:ID{PROP:ReadOnly} = True
    ?Miss:Code{PROP:ReadOnly} = True
    ?Miss:StartDate{PROP:ReadOnly} = True
    ?Miss:StartTime{PROP:ReadOnly} = True
    ?Miss:EndDate{PROP:ReadOnly} = True
    ?Miss:EndTime{PROP:ReadOnly} = True
    ?Miss:MilOpType{PROP:ReadOnly} = True
    DISABLE(?tpyMilOp:Name)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_Missions',QuickWindow)                   ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(tpyMilOp:Name,?tpyMilOp:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:type_MilOps,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder()
  FDCB8.AddField(tpyMilOp:Name,FDCB8.Q.tpyMilOp:Name) !List box control field - type derived from field
  FDCB8.AddField(tpyMilOp:ID,FDCB8.Q.tpyMilOp:ID) !Primary key field - type derived from field
  FDCB8.AddUpdateField(tpyMilOp:ID,Miss:MilOpType)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:MilMissions.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_Missions',QuickWindow)                ! Save window data to non-volatile store
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
!!! Form OrgMissions
!!! </summary>
UpdateOrgMissions PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
History::OrgMiss:Record LIKE(OrgMiss:RECORD),THREAD
QuickWindow          WINDOW('Form OrgMissions'),AT(,,163,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('UpdateOrgMissions'),SYSTEM
                       SHEET,AT(4,4,155,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?OrgMiss:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(64,20,48,10),USE(OrgMiss:ID),DECIMAL(12)
                           PROMPT('Organization:'),AT(8,34),USE(?OrgMiss:Organization:Prompt),TRN
                           ENTRY(@n-10.0),AT(64,34,48,10),USE(OrgMiss:Organization),DECIMAL(12)
                           PROMPT('Mission:'),AT(8,48),USE(?OrgMiss:Mission:Prompt),TRN
                           ENTRY(@n-10.0),AT(64,48,48,10),USE(OrgMiss:Mission),DECIMAL(12)
                         END
                       END
                       BUTTON('&OK'),AT(4,66,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(57,66,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(110,66,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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
  GlobalErrors.SetProcedureName('UpdateOrgMissions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OrgMiss:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(OrgMiss:Record,History::OrgMiss:Record)
  SELF.AddHistoryField(?OrgMiss:ID,1)
  SELF.AddHistoryField(?OrgMiss:Organization,2)
  SELF.AddHistoryField(?OrgMiss:Mission,3)
  SELF.AddUpdateFile(Access:OrgMissions)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:OrgMissions.Open                                  ! File OrgMissions used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:OrgMissions
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
    ?OrgMiss:ID{PROP:ReadOnly} = True
    ?OrgMiss:Organization{PROP:ReadOnly} = True
    ?OrgMiss:Mission{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('UpdateOrgMissions',QuickWindow)            ! Restore window settings from non-volatile store
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
    Relate:OrgMissions.Close
  END
  IF SELF.Opened
    INIMgr.Update('UpdateOrgMissions',QuickWindow)         ! Save window data to non-volatile store
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
!!! Browse the C2IPExplorer file
!!! </summary>
B_C2IPExplorer PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(C2IPExplorer)
                       PROJECT(C2IPExp:ID)
                       PROJECT(C2IPExp:Organization)
                       PROJECT(C2IPExp:C2IP)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
C2IPExp:ID             LIKE(C2IPExp:ID)               !List box control field - type derived from field
C2IPExp:Organization   LIKE(C2IPExp:Organization)     !List box control field - type derived from field
C2IPExp:C2IP           LIKE(C2IPExp:C2IP)             !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the C2IPExplorer file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_C2IPExplorer'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~' & |
  'ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the' & |
  ' C2IPExplorer file')
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
  GlobalErrors.SetProcedureName('B_C2IPExplorer')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:C2IPExplorer,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon C2IPExp:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,C2IPExp:PKID)    ! Add the sort order for C2IPExp:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,C2IPExp:ID,1,BRW1)             ! Initialize the browse locator using  using key: C2IPExp:PKID , C2IPExp:ID
  BRW1.AddField(C2IPExp:ID,BRW1.Q.C2IPExp:ID)              ! Field C2IPExp:ID is a hot field or requires assignment from browse
  BRW1.AddField(C2IPExp:Organization,BRW1.Q.C2IPExp:Organization) ! Field C2IPExp:Organization is a hot field or requires assignment from browse
  BRW1.AddField(C2IPExp:C2IP,BRW1.Q.C2IPExp:C2IP)          ! Field C2IPExp:C2IP is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_C2IPExplorer',QuickWindow)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_C2IPExplorer
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
    Relate:C2IPExplorer.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_C2IPExplorer',QuickWindow)            ! Save window data to non-volatile store
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
    U_C2IPExplorer
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
!!! Form C2IPExplorer
!!! </summary>
U_C2IPExplorer PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(myOrganization)
                       PROJECT(myOrg:Name)
                       PROJECT(myOrg:ID)
                     END
FDCB9::View:FileDropCombo VIEW(C2IPs)
                       PROJECT(C2IP:Name)
                       PROJECT(C2IP:ID)
                       PROJECT(C2IP:Type)
                       JOIN(tpyC2IP:PKID,C2IP:Type)
                         PROJECT(tpyC2IP:Code)
                         PROJECT(tpyC2IP:ID)
                       END
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?myOrg:Name
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
myOrg:ID               LIKE(myOrg:ID)                 !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?C2IP:Name
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Primary key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::C2IPExp:Record LIKE(C2IPExp:RECORD),THREAD
QuickWindow          WINDOW('Form C2IPExplorer'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_C2IPExplorer'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?C2IPExp:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(C2IPExp:ID),DECIMAL(12)
                           PROMPT('Organization:'),AT(8,34),USE(?C2IPExp:Organization:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,34,48,10),USE(C2IPExp:Organization),DECIMAL(12)
                           PROMPT('C2IP:'),AT(8,48),USE(?C2IPExp:C2IP:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,48,48,10),USE(C2IPExp:C2IP),DECIMAL(12)
                           COMBO(@s100),AT(134,34,273,10),USE(myOrg:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@'), |
  FROM(Queue:FileDropCombo),IMM
                           COMBO(@s100),AT(134,46,273,12),USE(C2IP:Name),DROP(5),FORMAT('100L(2)|M~C2IP Name~C(0)@' & |
  's100@40L(2)|M~C2IP Type~C(0)@s20@'),FROM(Queue:FileDropCombo:1),IMM
                         END
                       END
                       BUTTON('&OK'),AT(260,68,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(313,68,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(366,68,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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
    ActionMessage = 'View C2IP Explorer'
  OF InsertRecord
    ActionMessage = 'New C2IP in C2IP Explorer'
  OF ChangeRecord
    ActionMessage = 'Modify C2IP in C2IP Explorer'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_C2IPExplorer')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?C2IPExp:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(C2IPExp:Record,History::C2IPExp:Record)
  SELF.AddHistoryField(?C2IPExp:ID,1)
  SELF.AddHistoryField(?C2IPExp:Organization,2)
  SELF.AddHistoryField(?C2IPExp:C2IP,3)
  SELF.AddUpdateFile(Access:C2IPExplorer)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IPExplorer.SetOpenRelated()
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:C2IPExplorer
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
    ?C2IPExp:ID{PROP:ReadOnly} = True
    ?C2IPExp:Organization{PROP:ReadOnly} = True
    ?C2IPExp:C2IP{PROP:ReadOnly} = True
    DISABLE(?myOrg:Name)
    DISABLE(?C2IP:Name)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_C2IPExplorer',QuickWindow)               ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(myOrg:Name,?myOrg:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:myOrganization,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(myOrg:PKID)
  FDCB8.AddField(myOrg:Name,FDCB8.Q.myOrg:Name) !List box control field - type derived from field
  FDCB8.AddField(myOrg:ID,FDCB8.Q.myOrg:ID) !Primary key field - type derived from field
  FDCB8.AddUpdateField(myOrg:ID,C2IPExp:Organization)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  FDCB9.Init(C2IP:Name,?C2IP:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:C2IPs,ThisWindow,GlobalErrors,0,1,0)
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(C2IP:PKID)
  FDCB9.AddField(C2IP:Name,FDCB9.Q.C2IP:Name) !List box control field - type derived from field
  FDCB9.AddField(tpyC2IP:Code,FDCB9.Q.tpyC2IP:Code) !List box control field - type derived from field
  FDCB9.AddField(C2IP:ID,FDCB9.Q.C2IP:ID) !Primary key field - type derived from field
  FDCB9.AddField(tpyC2IP:ID,FDCB9.Q.tpyC2IP:ID) !Related join file key field - type derived from field
  FDCB9.AddUpdateField(C2IP:ID,C2IPExp:C2IP)
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
    INIMgr.Update('U_C2IPExplorer',QuickWindow)            ! Save window data to non-volatile store
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
!!! Browse the myOrgORBAT file
!!! </summary>
B_myOrgORBAT PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(myOrgORBAT)
                       PROJECT(myOrgORB:ID)
                       PROJECT(myOrgORB:Organization)
                       PROJECT(myOrgORB:ORBATC2IP)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
myOrgORB:ID            LIKE(myOrgORB:ID)              !List box control field - type derived from field
myOrgORB:Organization  LIKE(myOrgORB:Organization)    !List box control field - type derived from field
myOrgORB:ORBATC2IP     LIKE(myOrgORB:ORBATC2IP)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the myOrgORBAT file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_myOrgORBAT'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~' & |
  'ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the' & |
  ' myOrgORBAT file')
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
  GlobalErrors.SetProcedureName('B_myOrgORBAT')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:myOrgORBAT.Open                                   ! File myOrgORBAT used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:myOrgORBAT,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon myOrgORB:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,myOrgORB:PKID)   ! Add the sort order for myOrgORB:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,myOrgORB:ID,1,BRW1)            ! Initialize the browse locator using  using key: myOrgORB:PKID , myOrgORB:ID
  BRW1.AddField(myOrgORB:ID,BRW1.Q.myOrgORB:ID)            ! Field myOrgORB:ID is a hot field or requires assignment from browse
  BRW1.AddField(myOrgORB:Organization,BRW1.Q.myOrgORB:Organization) ! Field myOrgORB:Organization is a hot field or requires assignment from browse
  BRW1.AddField(myOrgORB:ORBATC2IP,BRW1.Q.myOrgORB:ORBATC2IP) ! Field myOrgORB:ORBATC2IP is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_myOrgORBAT',QuickWindow)                 ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_myOrgORBAT
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
    Relate:myOrgORBAT.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_myOrgORBAT',QuickWindow)              ! Save window data to non-volatile store
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
    U_myOrgORBAT
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
!!! Form myOrgORBAT
!!! </summary>
U_myOrgORBAT PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB9::View:FileDropCombo VIEW(C2IPExplorer)
                       PROJECT(C2IPExp:Organization)
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
FDCB10::View:FileDropCombo VIEW(myOrganization)
                       PROJECT(myOrg:Name)
                       PROJECT(myOrg:ID)
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?C2IP:Name
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
myOrgORB:Organization  LIKE(myOrgORB:Organization)    !Browse hot field - type derived from field
C2IPExp:Organization   LIKE(C2IPExp:Organization)     !Browse hot field - type derived from field
C2IPExp:ID             LIKE(C2IPExp:ID)               !Primary key field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Related join file key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:2 QUEUE                           !Queue declaration for browse/combo box using ?myOrg:Name:2
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
myOrg:ID               LIKE(myOrg:ID)                 !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::myOrgORB:Record LIKE(myOrgORB:RECORD),THREAD
QuickWindow          WINDOW('Form myOrgORBAT'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_myORGORBAT'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?myOrgORB:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(myOrgORB:ID),DECIMAL(12)
                           PROMPT('Organization:'),AT(8,34),USE(?myOrgORB:Organization:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,34,48,10),USE(myOrgORB:Organization),DECIMAL(12)
                           PROMPT('ORBAT C2IP:'),AT(8,48),USE(?myOrgORB:ORBATC2IP:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,48,48,10),USE(myOrgORB:ORBATC2IP),DECIMAL(12)
                           COMBO(@s100),AT(126,48,278,9),USE(C2IP:Name),DROP(5),FORMAT('100L(2)|M~C2IP Name~C(0)@s' & |
  '100@40L(2)|M~C2IP Type~L(0)@s20@'),FROM(Queue:FileDropCombo:1),IMM
                           COMBO(@s100),AT(127,34,277,10),USE(myOrg:Name,,?myOrg:Name:2),DROP(5),FORMAT('100L(2)|M~' & |
  'Organization~C(0)@s100@'),FROM(Queue:FileDropCombo:2),IMM
                         END
                       END
                       BUTTON('&OK'),AT(260,68,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(313,68,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(366,68,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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

FDCB9                CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:1         !Reference to browse queue type
                     END

FDCB10               CLASS(FileDropComboClass)             ! File drop combo manager
Q                      &Queue:FileDropCombo:2         !Reference to browse queue type
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
    ActionMessage = 'View Organization''s ORBAT'
  OF InsertRecord
    ActionMessage = 'Define New ORBAT'
  OF ChangeRecord
    ActionMessage = 'Change ORBAT'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_myOrgORBAT')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?myOrgORB:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(myOrgORB:Record,History::myOrgORB:Record)
  SELF.AddHistoryField(?myOrgORB:ID,1)
  SELF.AddHistoryField(?myOrgORB:Organization,2)
  SELF.AddHistoryField(?myOrgORB:ORBATC2IP,3)
  SELF.AddUpdateFile(Access:myOrgORBAT)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IPExplorer.SetOpenRelated()
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:myOrgORBAT
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
    ?myOrgORB:ID{PROP:ReadOnly} = True
    ?myOrgORB:Organization{PROP:ReadOnly} = True
    ?myOrgORB:ORBATC2IP{PROP:ReadOnly} = True
    DISABLE(?C2IP:Name)
    DISABLE(?myOrg:Name:2)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_myOrgORBAT',QuickWindow)                 ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB9.Init(C2IP:Name,?C2IP:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:C2IPExplorer,ThisWindow,GlobalErrors,0,1,0)
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(C2IPExp:KOrganization)
  FDCB9.AddField(C2IP:Name,FDCB9.Q.C2IP:Name) !List box control field - type derived from field
  FDCB9.AddField(tpyC2IP:Code,FDCB9.Q.tpyC2IP:Code) !List box control field - type derived from field
  FDCB9.AddField(myOrgORB:Organization,FDCB9.Q.myOrgORB:Organization) !Browse hot field - type derived from field
  FDCB9.AddField(C2IPExp:Organization,FDCB9.Q.C2IPExp:Organization) !Browse hot field - type derived from field
  FDCB9.AddField(C2IPExp:ID,FDCB9.Q.C2IPExp:ID) !Primary key field - type derived from field
  FDCB9.AddField(C2IP:ID,FDCB9.Q.C2IP:ID) !Related join file key field - type derived from field
  FDCB9.AddField(tpyC2IP:ID,FDCB9.Q.tpyC2IP:ID) !Related join file key field - type derived from field
  FDCB9.AddUpdateField(C2IPExp:C2IP,myOrgORB:ORBATC2IP)
  ThisWindow.AddItem(FDCB9.WindowComponent)
  FDCB9.DefaultFill = 0
  FDCB10.Init(myOrg:Name,?myOrg:Name:2,Queue:FileDropCombo:2.ViewPosition,FDCB10::View:FileDropCombo,Queue:FileDropCombo:2,Relate:myOrganization,ThisWindow,GlobalErrors,0,1,0)
  FDCB10.Q &= Queue:FileDropCombo:2
  FDCB10.AddSortOrder(myOrg:PKID)
  FDCB10.AddField(myOrg:Name,FDCB10.Q.myOrg:Name) !List box control field - type derived from field
  FDCB10.AddField(myOrg:ID,FDCB10.Q.myOrg:ID) !Primary key field - type derived from field
  FDCB10.AddUpdateField(myOrg:ID,myOrgORB:Organization)
  ThisWindow.AddItem(FDCB10.WindowComponent)
  FDCB10.DefaultFill = 0
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
    INIMgr.Update('U_myOrgORBAT',QuickWindow)              ! Save window data to non-volatile store
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
!!! Browse the MissionTASKORG file
!!! </summary>
B_MissionTASKORG PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(MissionTASKORG)
                       PROJECT(MissTSK:ID)
                       PROJECT(MissTSK:Mission)
                       PROJECT(MissTSK:TASKORGC2IP)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
MissTSK:ID             LIKE(MissTSK:ID)               !List box control field - type derived from field
MissTSK:Mission        LIKE(MissTSK:Mission)          !List box control field - type derived from field
MissTSK:TASKORGC2IP    LIKE(MissTSK:TASKORGC2IP)      !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the MissionTASKORG file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_MissionTASKORG'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~' & |
  'ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the' & |
  ' MissionTASKORG file')
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
  GlobalErrors.SetProcedureName('B_MissionTASKORG')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Browse:1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  Relate:MissionTASKORG.Open                               ! File MissionTASKORG used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:MissionTASKORG,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon MissTSK:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,MissTSK:PKID)    ! Add the sort order for MissTSK:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,MissTSK:ID,1,BRW1)             ! Initialize the browse locator using  using key: MissTSK:PKID , MissTSK:ID
  BRW1.AddField(MissTSK:ID,BRW1.Q.MissTSK:ID)              ! Field MissTSK:ID is a hot field or requires assignment from browse
  BRW1.AddField(MissTSK:Mission,BRW1.Q.MissTSK:Mission)    ! Field MissTSK:Mission is a hot field or requires assignment from browse
  BRW1.AddField(MissTSK:TASKORGC2IP,BRW1.Q.MissTSK:TASKORGC2IP) ! Field MissTSK:TASKORGC2IP is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_MissionTASKORG',QuickWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_MissionTASKORG
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
    Relate:MissionTASKORG.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_MissionTASKORG',QuickWindow)          ! Save window data to non-volatile store
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
    U_MissionTASKORG
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

