

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL005.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Form c2ieActionResources
!!! </summary>
U_c2ieActionResources PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(_c2ieBSO_Resources)
                       PROJECT(_c2ieBSORes:ID)
                       PROJECT(_c2ieBSORes:Unit)
                       JOIN(_UniRes:PKID,_c2ieBSORes:Unit)
                         PROJECT(_UniRes:Code)
                         PROJECT(_UniRes:ID)
                       END
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?_UniRes:Code
_UniRes:Code           LIKE(_UniRes:Code)             !List box control field - type derived from field
_c2ieBSORes:ID         LIKE(_c2ieBSORes:ID)           !Primary key field - type derived from field
_UniRes:ID             LIKE(_UniRes:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::c2ieActRes:Record LIKE(c2ieActRes:RECORD),THREAD
QuickWindow          WINDOW('Form c2ieActionResources'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_c2ieActionResources'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?c2ieActRes:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(c2ieActRes:ID),DECIMAL(12)
                           PROMPT('ID:'),AT(8,34),USE(?c2ieActRes:c2ieActionDetail:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,34,48,10),USE(c2ieActRes:c2ieActionDetail),DECIMAL(12)
                           PROMPT('ID:'),AT(8,48),USE(?c2ieActRes:c2ieBSO:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,48,48,10),USE(c2ieActRes:c2ieBSO),DECIMAL(12)
                           COMBO(@s20),AT(115,48,291,10),USE(_UniRes:Code),DROP(5),FORMAT('80L(2)|M~Code~L(0)@s20@'), |
  FROM(Queue:FileDropCombo),IMM
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
  GlobalErrors.SetProcedureName('U_c2ieActionResources')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?c2ieActRes:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(c2ieActRes:Record,History::c2ieActRes:Record)
  SELF.AddHistoryField(?c2ieActRes:ID,1)
  SELF.AddHistoryField(?c2ieActRes:c2ieActionDetail,2)
  SELF.AddHistoryField(?c2ieActRes:c2ieBSO,3)
  SELF.AddUpdateFile(Access:c2ieActionResources)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:_c2ieBSO_Resources.Open                           ! File _c2ieBSO_Resources used by this procedure, so make sure it's RelationManager is open
  Relate:c2ieActionResources.SetOpenRelated()
  Relate:c2ieActionResources.Open                          ! File c2ieActionResources used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:c2ieActionResources
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
    ?c2ieActRes:ID{PROP:ReadOnly} = True
    ?c2ieActRes:c2ieActionDetail{PROP:ReadOnly} = True
    ?c2ieActRes:c2ieBSO{PROP:ReadOnly} = True
    DISABLE(?_UniRes:Code)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_c2ieActionResources',QuickWindow)        ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(_UniRes:Code,?_UniRes:Code,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:_c2ieBSO_Resources,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(_c2ieBSORes:PKID)
  FDCB8.AddField(_UniRes:Code,FDCB8.Q._UniRes:Code) !List box control field - type derived from field
  FDCB8.AddField(_c2ieBSORes:ID,FDCB8.Q._c2ieBSORes:ID) !Primary key field - type derived from field
  FDCB8.AddField(_UniRes:ID,FDCB8.Q._UniRes:ID) !Related join file key field - type derived from field
  FDCB8.AddUpdateField(_c2ieBSORes:ID,c2ieActRes:c2ieBSO)
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
    Relate:_c2ieBSO_Resources.Close
    Relate:c2ieActionResources.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_c2ieActionResources',QuickWindow)     ! Save window data to non-volatile store
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
!!! Browse the c2ieActionObjectives file
!!! </summary>
B_c2ieActionObjectives PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(c2ieActionObjectives)
                       PROJECT(c2ieActObj:ID)
                       PROJECT(c2ieActObj:c2ieActionDetail)
                       PROJECT(c2ieActObj:c2ieBSO)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
c2ieActObj:ID          LIKE(c2ieActObj:ID)            !List box control field - type derived from field
c2ieActObj:c2ieActionDetail LIKE(c2ieActObj:c2ieActionDetail) !List box control field - type derived from field
c2ieActObj:c2ieBSO     LIKE(c2ieActObj:c2ieBSO)       !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the c2ieActionObjectives file'),AT(,,277,198),FONT('Microsoft Sans Serif',8, |
  ,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_c2ieActionObjectives'), |
  SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@80R(10)|M' & |
  '~Action Detail reference~C(0)@n-10.0@76R(2)|M~C2IE BSO reference~C(0)@n-10.0@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the c2ieActionObjectives file')
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
  GlobalErrors.SetProcedureName('B_c2ieActionObjectives')
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
  Relate:c2ieActionObjectives.Open                         ! File c2ieActionObjectives used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:c2ieActionObjectives,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon c2ieActObj:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,c2ieActObj:PKID) ! Add the sort order for c2ieActObj:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,c2ieActObj:ID,1,BRW1)          ! Initialize the browse locator using  using key: c2ieActObj:PKID , c2ieActObj:ID
  BRW1.AddField(c2ieActObj:ID,BRW1.Q.c2ieActObj:ID)        ! Field c2ieActObj:ID is a hot field or requires assignment from browse
  BRW1.AddField(c2ieActObj:c2ieActionDetail,BRW1.Q.c2ieActObj:c2ieActionDetail) ! Field c2ieActObj:c2ieActionDetail is a hot field or requires assignment from browse
  BRW1.AddField(c2ieActObj:c2ieBSO,BRW1.Q.c2ieActObj:c2ieBSO) ! Field c2ieActObj:c2ieBSO is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_c2ieActionObjectives',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_c2ieActionObjectives
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
    Relate:c2ieActionObjectives.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_c2ieActionObjectives',QuickWindow)    ! Save window data to non-volatile store
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
    U_c2ieActionObjectives
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
!!! Form c2ieActionObjectives
!!! </summary>
U_c2ieActionObjectives PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(_c2ieBSO_Objectives)
                       PROJECT(_c2ieBSOObj:ID)
                       PROJECT(_c2ieBSOObj:Unit)
                       JOIN(_UniObj:PKID,_c2ieBSOObj:Unit)
                         PROJECT(_UniObj:Code)
                         PROJECT(_UniObj:ID)
                       END
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?_UniObj:Code
_UniObj:Code           LIKE(_UniObj:Code)             !List box control field - type derived from field
_c2ieBSOObj:ID         LIKE(_c2ieBSOObj:ID)           !Primary key field - type derived from field
_UniObj:ID             LIKE(_UniObj:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::c2ieActObj:Record LIKE(c2ieActObj:RECORD),THREAD
QuickWindow          WINDOW('Form c2ieActionObjectives'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_c2ieActionObjectives'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?c2ieActObj:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(108,20,48,10),USE(c2ieActObj:ID),DECIMAL(12)
                           PROMPT('Action Detail reference:'),AT(8,34),USE(?c2ieActObj:c2ieActionDetail:Prompt),TRN
                           ENTRY(@n-10.0),AT(108,34,48,10),USE(c2ieActObj:c2ieActionDetail),DECIMAL(12)
                           PROMPT('C2IE BSO reference:'),AT(8,48),USE(?c2ieActObj:c2ieBSO:Prompt),TRN
                           ENTRY(@n-10.0),AT(108,48,48,10),USE(c2ieActObj:c2ieBSO),DECIMAL(12)
                           COMBO(@s20),AT(161,47,241,10),USE(_UniObj:Code),DROP(5),FORMAT('80L(2)|M~Code~L(0)@s20@'), |
  FROM(Queue:FileDropCombo),IMM
                         END
                       END
                       BUTTON('&OK'),AT(260,68,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
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
  GlobalErrors.SetProcedureName('U_c2ieActionObjectives')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?c2ieActObj:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  SELF.AddItem(Toolbar)
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(c2ieActObj:Record,History::c2ieActObj:Record)
  SELF.AddHistoryField(?c2ieActObj:ID,1)
  SELF.AddHistoryField(?c2ieActObj:c2ieActionDetail,2)
  SELF.AddHistoryField(?c2ieActObj:c2ieBSO,3)
  SELF.AddUpdateFile(Access:c2ieActionObjectives)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:_c2ieBSO_Objectives.Open                          ! File _c2ieBSO_Objectives used by this procedure, so make sure it's RelationManager is open
  Relate:c2ieActionObjectives.Open                         ! File c2ieActionObjectives used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:c2ieActionObjectives
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
    ?c2ieActObj:ID{PROP:ReadOnly} = True
    ?c2ieActObj:c2ieActionDetail{PROP:ReadOnly} = True
    ?c2ieActObj:c2ieBSO{PROP:ReadOnly} = True
    DISABLE(?_UniObj:Code)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_c2ieActionObjectives',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(_UniObj:Code,?_UniObj:Code,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:_c2ieBSO_Objectives,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(_c2ieBSOObj:PKID)
  FDCB8.AddField(_UniObj:Code,FDCB8.Q._UniObj:Code) !List box control field - type derived from field
  FDCB8.AddField(_c2ieBSOObj:ID,FDCB8.Q._c2ieBSOObj:ID) !Primary key field - type derived from field
  FDCB8.AddField(_UniObj:ID,FDCB8.Q._UniObj:ID) !Related join file key field - type derived from field
  FDCB8.AddUpdateField(_c2ieBSOObj:ID,c2ieActObj:c2ieBSO)
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
    Relate:_c2ieBSO_Objectives.Close
    Relate:c2ieActionObjectives.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_c2ieActionObjectives',QuickWindow)    ! Save window data to non-volatile store
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

