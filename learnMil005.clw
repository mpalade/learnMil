

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL005.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('LEARNMIL006.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('LEARNMIL007.INC'),ONCE        !Req'd for module callout resolution
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
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
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
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
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
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
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

!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the myOrganization file
!!! </summary>
View_myOrganization PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(myOrganization)
                       PROJECT(myOrg:ID)
                       PROJECT(myOrg:Name)
                       PROJECT(myOrg:Code)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
myOrg:ID               LIKE(myOrg:ID)                 !List box control field - type derived from field
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
myOrg:Code             LIKE(myOrg:Code)               !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW8::View:Browse    VIEW(OrgTOO)
                       PROJECT(OrgTOO:ID)
                       PROJECT(OrgTOO:Organization)
                       PROJECT(OrgTOO:TheaterOfOperations)
                       JOIN(TOO:PKID,OrgTOO:TheaterOfOperations)
                         PROJECT(TOO:Name)
                         PROJECT(TOO:Code)
                         PROJECT(TOO:ID)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
TOO:Name               LIKE(TOO:Name)                 !List box control field - type derived from field
TOO:Code               LIKE(TOO:Code)                 !List box control field - type derived from field
OrgTOO:ID              LIKE(OrgTOO:ID)                !Primary key field - type derived from field
OrgTOO:Organization    LIKE(OrgTOO:Organization)      !Browse key field - type derived from field
TOO:ID                 LIKE(TOO:ID)                   !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW9::View:Browse    VIEW(OrgMissions)
                       PROJECT(OrgMiss:ID)
                       PROJECT(OrgMiss:Organization)
                       PROJECT(OrgMiss:Mission)
                       JOIN(Miss:PKID,OrgMiss:Mission)
                         PROJECT(Miss:Name)
                         PROJECT(Miss:Code)
                         PROJECT(Miss:ID)
                         PROJECT(Miss:MilOpType)
                         JOIN(tpyMilOp:PKID,Miss:MilOpType)
                           PROJECT(tpyMilOp:Name)
                           PROJECT(tpyMilOp:Code)
                           PROJECT(tpyMilOp:ID)
                         END
                       END
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:2
Miss:Name              LIKE(Miss:Name)                !List box control field - type derived from field
Miss:Code              LIKE(Miss:Code)                !List box control field - type derived from field
tpyMilOp:Name          LIKE(tpyMilOp:Name)            !List box control field - type derived from field
tpyMilOp:Code          LIKE(tpyMilOp:Code)            !List box control field - type derived from field
OrgMiss:ID             LIKE(OrgMiss:ID)               !Primary key field - type derived from field
OrgMiss:Organization   LIKE(OrgMiss:Organization)     !Browse key field - type derived from field
Miss:ID                LIKE(Miss:ID)                  !Related join file key field - type derived from field
tpyMilOp:ID            LIKE(tpyMilOp:ID)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW12::View:Browse   VIEW(C2IPExplorer)
                       PROJECT(C2IPExp:ID)
                       PROJECT(C2IPExp:Organization)
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
Queue:Browse:3       QUEUE                            !Queue declaration for browse/combo box using ?List:3
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
C2IPExp:ID             LIKE(C2IPExp:ID)               !Primary key field - type derived from field
C2IPExp:Organization   LIKE(C2IPExp:Organization)     !Browse key field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Related join file key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW14::View:Browse   VIEW(myOrgORBAT)
                       PROJECT(myOrgORB:ID)
                       PROJECT(myOrgORB:Organization)
                       PROJECT(myOrgORB:ORBATC2IP)
                       JOIN(C2IP:PKID,myOrgORB:ORBATC2IP)
                         PROJECT(C2IP:Name)
                         PROJECT(C2IP:ID)
                         PROJECT(C2IP:Type)
                         JOIN(tpyC2IP:PKID,C2IP:Type)
                           PROJECT(tpyC2IP:Code)
                           PROJECT(tpyC2IP:ID)
                         END
                       END
                     END
Queue:Browse:4       QUEUE                            !Queue declaration for browse/combo box using ?List:4
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
myOrgORB:ID            LIKE(myOrgORB:ID)              !Primary key field - type derived from field
myOrgORB:Organization  LIKE(myOrgORB:Organization)    !Browse key field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Related join file key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('My Organization'),AT(,,524,347),FONT('Microsoft Sans Serif',8,,FONT:regular+FONT:underline, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_myOrganization'),SYSTEM
                       LIST,AT(3,2,261,54),USE(?Browse:1),HVSCROLL,FORMAT('0R(2)|M~ID~C(0)@n-10.0@100L(2)|M~Or' & |
  'ganization Name~C(2)@s100@40L(2)|M~Code~C(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he myOrganization file')
                       BUTTON('&Select'),AT(3,60,49,14),USE(?Select:2),LEFT,ICON('WASELECT.ICO'),FLAT,MSG('Select the Record'), |
  TIP('Select the Record')
                       BUTTON('&View'),AT(57,60,49,14),USE(?View:3),LEFT,ICON('WAVIEW.ICO'),FLAT,MSG('View Record'), |
  TIP('View Record')
                       BUTTON('&Insert'),AT(110,60,49,14),USE(?Insert:4),LEFT,ICON('WAINSERT.ICO'),FLAT,MSG('Insert a Record'), |
  TIP('Insert a Record')
                       BUTTON('&Change'),AT(162,60,49,14),USE(?Change:4),LEFT,ICON('WACHANGE.ICO'),DEFAULT,FLAT,MSG('Change the Record'), |
  TIP('Change the Record')
                       BUTTON('&Delete'),AT(215,60,49,14),USE(?Delete:4),LEFT,ICON('WADELETE.ICO'),FLAT,MSG('Delete the Record'), |
  TIP('Delete the Record')
                       BUTTON('&Close'),AT(419,331,49,14),USE(?Close),LEFT,ICON('WACLOSE.ICO'),FLAT,MSG('Close Window'), |
  TIP('Close Window')
                       BUTTON('&Help'),AT(473,331,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       LIST,AT(3,154,261,60),USE(?List),FORMAT('[100L(2)|M~Name~C(0)@s100@40L(2)|M~Code~C(0)@s' & |
  '20@]|~Theaters of Operations~'),FROM(Queue:Browse),IMM
                       LIST,AT(269,154,252,60),USE(?List:2),FORMAT('[100L(2)|M~Name~C(0)@s100@40L(2)|M~Code~C(' & |
  '0)@s20@]|~Missions~[100L(2)|M~Name~C(0)@s100@40L(2)|M~Code~C(0)@s20@]|~Operation Type~'), |
  FROM(Queue:Browse:2),IMM
                       BUTTON('&Insert'),AT(1,218,42,12),USE(?Insert)
                       BUTTON('&Change'),AT(43,218,42,12),USE(?Change)
                       BUTTON('&Delete'),AT(85,218,42,12),USE(?Delete)
                       BUTTON('&Insert'),AT(269,218,42,12),USE(?Insert:2)
                       BUTTON('&Change'),AT(311,218,42,12),USE(?Change:2)
                       BUTTON('&Delete'),AT(353,218,42,12),USE(?Delete:2)
                       LIST,AT(269,2,253,111),USE(?List:3),DECIMAL(12),FORMAT('[40L(2)|M~C2IP Type~C(0)@s20@10' & |
  '0L(2)|M~C2IP Name~C(0)@s100@]|~C2IP Explorer~'),FROM(Queue:Browse:3),IMM
                       BUTTON('&Insert'),AT(269,118,42,12),USE(?Insert:3)
                       BUTTON('&Change'),AT(311,118,42,12),USE(?Change:3)
                       BUTTON('&Delete'),AT(353,118,42,12),USE(?Delete:3)
                       LIST,AT(3,79,261,36),USE(?List:4),FORMAT('[100L(2)|M~ORBAT C2IP Name~C(0)@s100@40L(2)|M' & |
  '~ORBAT C2IP Type~C(0)@s20@]|~ORBAT~'),FROM(Queue:Browse:4),IMM
                       BUTTON('&Insert'),AT(2,119,42,12),USE(?Insert:5)
                       BUTTON('&Change'),AT(43,119,42,12),USE(?Change:5)
                       BUTTON('&Delete'),AT(86,119,42,12),USE(?Delete:5)
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
BRW8                 CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW8::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW9                 CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:2                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW9::Sort0:Locator  StepLocatorClass                      ! Default Locator
BRW12                CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:3                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW12::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW14                CLASS(BrowseClass)                    ! Browse using ?List:4
Q                      &Queue:Browse:4                !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
                     END

BRW14::Sort0:Locator StepLocatorClass                      ! Default Locator
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
  GlobalErrors.SetProcedureName('View_myOrganization')
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
  Relate:C2IPExplorer.SetOpenRelated()
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:myOrganization,SELF) ! Initialize the browse manager
  BRW8.Init(?List,Queue:Browse.ViewPosition,BRW8::View:Browse,Queue:Browse,Relate:OrgTOO,SELF) ! Initialize the browse manager
  BRW9.Init(?List:2,Queue:Browse:2.ViewPosition,BRW9::View:Browse,Queue:Browse:2,Relate:OrgMissions,SELF) ! Initialize the browse manager
  BRW12.Init(?List:3,Queue:Browse:3.ViewPosition,BRW12::View:Browse,Queue:Browse:3,Relate:C2IPExplorer,SELF) ! Initialize the browse manager
  BRW14.Init(?List:4,Queue:Browse:4.ViewPosition,BRW14::View:Browse,Queue:Browse:4,Relate:myOrgORBAT,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon myOrg:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,myOrg:PKID)      ! Add the sort order for myOrg:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,myOrg:ID,1,BRW1)               ! Initialize the browse locator using  using key: myOrg:PKID , myOrg:ID
  BRW1.AddField(myOrg:ID,BRW1.Q.myOrg:ID)                  ! Field myOrg:ID is a hot field or requires assignment from browse
  BRW1.AddField(myOrg:Name,BRW1.Q.myOrg:Name)              ! Field myOrg:Name is a hot field or requires assignment from browse
  BRW1.AddField(myOrg:Code,BRW1.Q.myOrg:Code)              ! Field myOrg:Code is a hot field or requires assignment from browse
  BRW8.Q &= Queue:Browse
  BRW8.AddSortOrder(,OrgTOO:KOrganization)                 ! Add the sort order for OrgTOO:KOrganization for sort order 1
  BRW8.AddRange(OrgTOO:Organization,Relate:OrgTOO,Relate:myOrganization) ! Add file relationship range limit for sort order 1
  BRW8.AddLocator(BRW8::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW8::Sort0:Locator.Init(,OrgTOO:Organization,1,BRW8)    ! Initialize the browse locator using  using key: OrgTOO:KOrganization , OrgTOO:Organization
  BRW8.AddField(TOO:Name,BRW8.Q.TOO:Name)                  ! Field TOO:Name is a hot field or requires assignment from browse
  BRW8.AddField(TOO:Code,BRW8.Q.TOO:Code)                  ! Field TOO:Code is a hot field or requires assignment from browse
  BRW8.AddField(OrgTOO:ID,BRW8.Q.OrgTOO:ID)                ! Field OrgTOO:ID is a hot field or requires assignment from browse
  BRW8.AddField(OrgTOO:Organization,BRW8.Q.OrgTOO:Organization) ! Field OrgTOO:Organization is a hot field or requires assignment from browse
  BRW8.AddField(TOO:ID,BRW8.Q.TOO:ID)                      ! Field TOO:ID is a hot field or requires assignment from browse
  BRW9.Q &= Queue:Browse:2
  BRW9.AddSortOrder(,OrgMiss:KOrganization)                ! Add the sort order for OrgMiss:KOrganization for sort order 1
  BRW9.AddRange(OrgMiss:Organization,Relate:OrgMissions,Relate:myOrganization) ! Add file relationship range limit for sort order 1
  BRW9.AddLocator(BRW9::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW9::Sort0:Locator.Init(,OrgMiss:Organization,1,BRW9)   ! Initialize the browse locator using  using key: OrgMiss:KOrganization , OrgMiss:Organization
  BRW9.AddField(Miss:Name,BRW9.Q.Miss:Name)                ! Field Miss:Name is a hot field or requires assignment from browse
  BRW9.AddField(Miss:Code,BRW9.Q.Miss:Code)                ! Field Miss:Code is a hot field or requires assignment from browse
  BRW9.AddField(tpyMilOp:Name,BRW9.Q.tpyMilOp:Name)        ! Field tpyMilOp:Name is a hot field or requires assignment from browse
  BRW9.AddField(tpyMilOp:Code,BRW9.Q.tpyMilOp:Code)        ! Field tpyMilOp:Code is a hot field or requires assignment from browse
  BRW9.AddField(OrgMiss:ID,BRW9.Q.OrgMiss:ID)              ! Field OrgMiss:ID is a hot field or requires assignment from browse
  BRW9.AddField(OrgMiss:Organization,BRW9.Q.OrgMiss:Organization) ! Field OrgMiss:Organization is a hot field or requires assignment from browse
  BRW9.AddField(Miss:ID,BRW9.Q.Miss:ID)                    ! Field Miss:ID is a hot field or requires assignment from browse
  BRW9.AddField(tpyMilOp:ID,BRW9.Q.tpyMilOp:ID)            ! Field tpyMilOp:ID is a hot field or requires assignment from browse
  BRW12.Q &= Queue:Browse:3
  BRW12.AddSortOrder(,C2IPExp:KOrganization)               ! Add the sort order for C2IPExp:KOrganization for sort order 1
  BRW12.AddRange(C2IPExp:Organization,Relate:C2IPExplorer,Relate:myOrganization) ! Add file relationship range limit for sort order 1
  BRW12.AddLocator(BRW12::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW12::Sort0:Locator.Init(,C2IPExp:Organization,1,BRW12) ! Initialize the browse locator using  using key: C2IPExp:KOrganization , C2IPExp:Organization
  BRW12.AddField(tpyC2IP:Code,BRW12.Q.tpyC2IP:Code)        ! Field tpyC2IP:Code is a hot field or requires assignment from browse
  BRW12.AddField(C2IP:Name,BRW12.Q.C2IP:Name)              ! Field C2IP:Name is a hot field or requires assignment from browse
  BRW12.AddField(C2IPExp:ID,BRW12.Q.C2IPExp:ID)            ! Field C2IPExp:ID is a hot field or requires assignment from browse
  BRW12.AddField(C2IPExp:Organization,BRW12.Q.C2IPExp:Organization) ! Field C2IPExp:Organization is a hot field or requires assignment from browse
  BRW12.AddField(C2IP:ID,BRW12.Q.C2IP:ID)                  ! Field C2IP:ID is a hot field or requires assignment from browse
  BRW12.AddField(tpyC2IP:ID,BRW12.Q.tpyC2IP:ID)            ! Field tpyC2IP:ID is a hot field or requires assignment from browse
  BRW14.Q &= Queue:Browse:4
  BRW14.AddSortOrder(,myOrgORB:KOrganization)              ! Add the sort order for myOrgORB:KOrganization for sort order 1
  BRW14.AddRange(myOrgORB:Organization,Relate:myOrgORBAT,Relate:myOrganization) ! Add file relationship range limit for sort order 1
  BRW14.AddLocator(BRW14::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW14::Sort0:Locator.Init(,myOrgORB:Organization,1,BRW14) ! Initialize the browse locator using  using key: myOrgORB:KOrganization , myOrgORB:Organization
  BRW14.AddField(C2IP:Name,BRW14.Q.C2IP:Name)              ! Field C2IP:Name is a hot field or requires assignment from browse
  BRW14.AddField(tpyC2IP:Code,BRW14.Q.tpyC2IP:Code)        ! Field tpyC2IP:Code is a hot field or requires assignment from browse
  BRW14.AddField(myOrgORB:ID,BRW14.Q.myOrgORB:ID)          ! Field myOrgORB:ID is a hot field or requires assignment from browse
  BRW14.AddField(myOrgORB:Organization,BRW14.Q.myOrgORB:Organization) ! Field myOrgORB:Organization is a hot field or requires assignment from browse
  BRW14.AddField(C2IP:ID,BRW14.Q.C2IP:ID)                  ! Field C2IP:ID is a hot field or requires assignment from browse
  BRW14.AddField(tpyC2IP:ID,BRW14.Q.tpyC2IP:ID)            ! Field tpyC2IP:ID is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('View_myOrganization',QuickWindow)          ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_myOrganization
  BRW8.AskProcedure = 2                                    ! Will call: U_OrgTOO
  BRW9.AskProcedure = 3                                    ! Will call: View_OrgMissions
  BRW12.AskProcedure = 4                                   ! Will call: U_C2IPExplorer
  BRW14.AskProcedure = 5                                   ! Will call: U_myOrgORBAT
  BRW1.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW1.ToolbarItem.HelpButton = ?Help
  BRW8.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW8.ToolbarItem.HelpButton = ?Help
  BRW9.AddToolbarTarget(Toolbar)                           ! Browse accepts toolbar control
  BRW9.ToolbarItem.HelpButton = ?Help
  BRW12.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  BRW12.ToolbarItem.HelpButton = ?Help
  BRW14.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  BRW14.ToolbarItem.HelpButton = ?Help
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
    INIMgr.Update('View_myOrganization',QuickWindow)       ! Save window data to non-volatile store
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
      U_myOrganization
      U_OrgTOO
      View_OrgMissions
      U_C2IPExplorer
      U_myOrgORBAT
    END
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


BRW8.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW9.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:2
    SELF.ChangeControl=?Change:2
    SELF.DeleteControl=?Delete:2
  END


BRW12.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:3
    SELF.ChangeControl=?Change:3
    SELF.DeleteControl=?Delete:3
  END


BRW14.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert:5
    SELF.ChangeControl=?Change:5
    SELF.DeleteControl=?Delete:5
  END


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

!!! <summary>
!!! Generated from procedure template - Window
!!! Form myOrganization
!!! </summary>
U_myOrganization PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
History::myOrg:Record LIKE(myOrg:RECORD),THREAD
QuickWindow          WINDOW('Form myOrganization'),AT(,,358,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_myOrganization'),SYSTEM
                       SHEET,AT(4,4,350,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?myOrg:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(61,20,48,10),USE(myOrg:ID),DECIMAL(12)
                           PROMPT('Name:'),AT(8,34),USE(?myOrg:Name:Prompt),TRN
                           ENTRY(@s100),AT(61,34,289,10),USE(myOrg:Name)
                           PROMPT('Code:'),AT(8,48),USE(?myOrg:Code:Prompt),TRN
                           ENTRY(@s20),AT(61,48,84,10),USE(myOrg:Code)
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
    ActionMessage = 'View Organization'
  OF InsertRecord
    ActionMessage = 'Define New Organization'
  OF ChangeRecord
    ActionMessage = 'Modify Organization'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_myOrganization')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?myOrg:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(myOrg:Record,History::myOrg:Record)
  SELF.AddHistoryField(?myOrg:ID,1)
  SELF.AddHistoryField(?myOrg:Name,2)
  SELF.AddHistoryField(?myOrg:Code,3)
  SELF.AddUpdateFile(Access:myOrganization)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:myOrganization.SetOpenRelated()
  Relate:myOrganization.Open                               ! File myOrganization used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:myOrganization
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
    ?myOrg:ID{PROP:ReadOnly} = True
    ?myOrg:Name{PROP:ReadOnly} = True
    ?myOrg:Code{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_myOrganization',QuickWindow)             ! Restore window settings from non-volatile store
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
    Relate:myOrganization.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_myOrganization',QuickWindow)          ! Save window data to non-volatile store
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
!!! Browse the OrgTOO file
!!! </summary>
B_OrgTOO PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(OrgTOO)
                       PROJECT(OrgTOO:ID)
                       PROJECT(OrgTOO:Organization)
                       PROJECT(OrgTOO:TheaterOfOperations)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
OrgTOO:ID              LIKE(OrgTOO:ID)                !List box control field - type derived from field
OrgTOO:Organization    LIKE(OrgTOO:Organization)      !List box control field - type derived from field
OrgTOO:TheaterOfOperations LIKE(OrgTOO:TheaterOfOperations) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the OrgTOO file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_OrgTOO'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@52R(2)|M~' & |
  'Organization~C(0)@n-10.0@80R(6)|M~Theater of Operations~C(0)@n-10.0@'),FROM(Queue:Browse:1), |
  IMM,MSG('Browsing the OrgTOO file')
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
  GlobalErrors.SetProcedureName('B_OrgTOO')
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
  Relate:OrgTOO.SetOpenRelated()
  Relate:OrgTOO.Open                                       ! File OrgTOO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:OrgTOO,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon OrgTOO:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,OrgTOO:PKID)     ! Add the sort order for OrgTOO:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,OrgTOO:ID,1,BRW1)              ! Initialize the browse locator using  using key: OrgTOO:PKID , OrgTOO:ID
  BRW1.AddField(OrgTOO:ID,BRW1.Q.OrgTOO:ID)                ! Field OrgTOO:ID is a hot field or requires assignment from browse
  BRW1.AddField(OrgTOO:Organization,BRW1.Q.OrgTOO:Organization) ! Field OrgTOO:Organization is a hot field or requires assignment from browse
  BRW1.AddField(OrgTOO:TheaterOfOperations,BRW1.Q.OrgTOO:TheaterOfOperations) ! Field OrgTOO:TheaterOfOperations is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_OrgTOO',QuickWindow)                     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_OrgTOO
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
    Relate:OrgTOO.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_OrgTOO',QuickWindow)                  ! Save window data to non-volatile store
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
    U_OrgTOO
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
!!! Form OrgTOO
!!! </summary>
U_OrgTOO PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(myOrganization)
                       PROJECT(myOrg:Name)
                       PROJECT(myOrg:ID)
                     END
FDCB9::View:FileDropCombo VIEW(TheaterOfOps)
                       PROJECT(TOO:Code)
                       PROJECT(TOO:ID)
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?myOrg:Name
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
myOrg:ID               LIKE(myOrg:ID)                 !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?TOO:Name
TOO:Code               LIKE(TOO:Code)                 !List box control field - type derived from field
TOO:ID                 LIKE(TOO:ID)                   !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::OrgTOO:Record LIKE(OrgTOO:RECORD),THREAD
QuickWindow          WINDOW('Form OrgTOO'),AT(,,417,84),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_OrgTOO'),SYSTEM
                       SHEET,AT(4,4,411,58),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?OrgTOO:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(100,20,48,10),USE(OrgTOO:ID),DECIMAL(12)
                           PROMPT('Organization:'),AT(8,34),USE(?OrgTOO:Organization:Prompt),TRN
                           ENTRY(@n-10.0),AT(100,34,48,10),USE(OrgTOO:Organization),DECIMAL(12)
                           PROMPT('Theater of Operations:'),AT(8,48),USE(?OrgTOO:TheaterOfOperations:Prompt),TRN
                           ENTRY(@n-10.0),AT(100,48,48,10),USE(OrgTOO:TheaterOfOperations),DECIMAL(12)
                           COMBO(@s100),AT(153,33,251,10),USE(myOrg:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@'), |
  FROM(Queue:FileDropCombo),IMM
                           COMBO(@s20),AT(153,48,251,9),USE(TOO:Name),DROP(5),FORMAT('80L(2)|M~Code~L(0)@s20@'),FROM(Queue:FileDropCombo:1), |
  IMM
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
    ActionMessage = 'View Theater Of Operations (TOO)'
  OF InsertRecord
    ActionMessage = 'Define New Theater Of Operations (TOO)'
  OF ChangeRecord
    ActionMessage = 'Modify Theater Of Operations (TOO)'
  END
  QuickWindow{PROP:Text} = ActionMessage                   ! Display status message in title bar
  PARENT.Ask


ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('U_OrgTOO')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OrgTOO:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(OrgTOO:Record,History::OrgTOO:Record)
  SELF.AddHistoryField(?OrgTOO:ID,1)
  SELF.AddHistoryField(?OrgTOO:Organization,2)
  SELF.AddHistoryField(?OrgTOO:TheaterOfOperations,3)
  SELF.AddUpdateFile(Access:OrgTOO)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:OrgTOO.SetOpenRelated()
  Relate:OrgTOO.Open                                       ! File OrgTOO used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:OrgTOO
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
    ?OrgTOO:ID{PROP:ReadOnly} = True
    ?OrgTOO:Organization{PROP:ReadOnly} = True
    ?OrgTOO:TheaterOfOperations{PROP:ReadOnly} = True
    DISABLE(?myOrg:Name)
    DISABLE(?TOO:Name)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_OrgTOO',QuickWindow)                     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(myOrg:Name,?myOrg:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:myOrganization,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(myOrg:PKID)
  FDCB8.AddField(myOrg:Name,FDCB8.Q.myOrg:Name) !List box control field - type derived from field
  FDCB8.AddField(myOrg:ID,FDCB8.Q.myOrg:ID) !Primary key field - type derived from field
  FDCB8.AddUpdateField(myOrg:ID,OrgTOO:Organization)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  FDCB9.Init(TOO:Name,?TOO:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:TheaterOfOps,ThisWindow,GlobalErrors,0,1,0)
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(TOO:PKID)
  FDCB9.AddField(TOO:Code,FDCB9.Q.TOO:Code) !List box control field - type derived from field
  FDCB9.AddField(TOO:ID,FDCB9.Q.TOO:ID) !Primary key field - type derived from field
  FDCB9.AddUpdateField(TOO:ID,OrgTOO:TheaterOfOperations)
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
    Relate:OrgTOO.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_OrgTOO',QuickWindow)                  ! Save window data to non-volatile store
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
!!! Browse the OrgMissions file
!!! </summary>
B_OrgMissions PROCEDURE 

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
QuickWindow          WINDOW('Browse the OrgMissions file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_OrgMissions'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@52R(2)|M~' & |
  'Organization~C(0)@n-10.0@48R(2)|M~Mission~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing t' & |
  'he OrgMissions file')
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
  GlobalErrors.SetProcedureName('B_OrgMissions')
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
  Relate:OrgMissions.Open                                  ! File OrgMissions used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:OrgMissions,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon OrgMiss:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,OrgMiss:PKID)    ! Add the sort order for OrgMiss:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,OrgMiss:ID,1,BRW1)             ! Initialize the browse locator using  using key: OrgMiss:PKID , OrgMiss:ID
  BRW1.AddField(OrgMiss:ID,BRW1.Q.OrgMiss:ID)              ! Field OrgMiss:ID is a hot field or requires assignment from browse
  BRW1.AddField(OrgMiss:Organization,BRW1.Q.OrgMiss:Organization) ! Field OrgMiss:Organization is a hot field or requires assignment from browse
  BRW1.AddField(OrgMiss:Mission,BRW1.Q.OrgMiss:Mission)    ! Field OrgMiss:Mission is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_OrgMissions',QuickWindow)                ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: View_OrgMissions
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
    Relate:OrgMissions.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_OrgMissions',QuickWindow)             ! Save window data to non-volatile store
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
    View_OrgMissions
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
!!! Form OrgMissions
!!! </summary>
View_OrgMissions PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
nMissTaskOrgRef      DECIMAL(7)                            ! 
nTASKORGC2IPRef      DECIMAL(7)                            ! 
sMilMissFreeText     STRING(1000)                          ! 
FDCB8::View:FileDropCombo VIEW(myOrganization)
                       PROJECT(myOrg:Name)
                       PROJECT(myOrg:ID)
                     END
FDCB9::View:FileDropCombo VIEW(MilMissions)
                       PROJECT(Miss:Name)
                       PROJECT(Miss:ID)
                       PROJECT(Miss:MilOpType)
                       JOIN(tpyMilOp:PKID,Miss:MilOpType)
                         PROJECT(tpyMilOp:Name)
                         PROJECT(tpyMilOp:Code)
                         PROJECT(tpyMilOp:ID)
                       END
                     END
BRW10::View:Browse   VIEW(MissionTASKORG)
                       PROJECT(MissTSK:ID)
                       PROJECT(MissTSK:TASKORGC2IP)
                       PROJECT(MissTSK:Mission)
                       JOIN(_C2IPTsk:PKID,MissTSK:TASKORGC2IP)
                         PROJECT(_C2IPTsk:Name)
                         PROJECT(_C2IPTsk:ID)
                       END
                     END
Queue:Browse         QUEUE                            !Queue declaration for browse/combo box using ?List
MissTSK:ID             LIKE(MissTSK:ID)               !List box control field - type derived from field
MissTSK:TASKORGC2IP    LIKE(MissTSK:TASKORGC2IP)      !List box control field - type derived from field
_C2IPTsk:Name          LIKE(_C2IPTsk:Name)            !List box control field - type derived from field
MissTSK:Mission        LIKE(MissTSK:Mission)          !Browse key field - type derived from field
_C2IPTsk:ID            LIKE(_C2IPTsk:ID)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW12::View:Browse   VIEW(C2IPExplorer)
                       PROJECT(C2IPExp:Mission)
                       PROJECT(C2IPExp:ID)
                       PROJECT(C2IPExp:Organization)
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
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?List:2
C2IPExp:Mission        LIKE(C2IPExp:Mission)          !List box control field - type derived from field
C2IP:Name              LIKE(C2IP:Name)                !List box control field - type derived from field
tpyC2IP:Code           LIKE(tpyC2IP:Code)             !List box control field - type derived from field
C2IPExp:ID             LIKE(C2IPExp:ID)               !Primary key field - type derived from field
C2IPExp:Organization   LIKE(C2IPExp:Organization)     !Browse key field - type derived from field
C2IP:ID                LIKE(C2IP:ID)                  !Related join file key field - type derived from field
tpyC2IP:ID             LIKE(tpyC2IP:ID)               !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
BRW13::View:Browse   VIEW(MissionToDo)
                       PROJECT(MissToDo:TaskName)
                       PROJECT(MissToDo:ID)
                       PROJECT(MissToDo:Mission)
                     END
Queue:Browse:2       QUEUE                            !Queue declaration for browse/combo box using ?List:3
MissToDo:TaskName      LIKE(MissToDo:TaskName)        !List box control field - type derived from field
MissToDo:ID            LIKE(MissToDo:ID)              !Primary key field - type derived from field
MissToDo:Mission       LIKE(MissToDo:Mission)         !Browse key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?myOrg:Name
myOrg:Name             LIKE(myOrg:Name)               !List box control field - type derived from field
myOrg:ID               LIKE(myOrg:ID)                 !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?Miss:Name
Miss:Name              LIKE(Miss:Name)                !List box control field - type derived from field
tpyMilOp:Name          LIKE(tpyMilOp:Name)            !List box control field - type derived from field
tpyMilOp:Code          LIKE(tpyMilOp:Code)            !List box control field - type derived from field
Miss:ID                LIKE(Miss:ID)                  !Primary key field - type derived from field
tpyMilOp:ID            LIKE(tpyMilOp:ID)              !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::OrgMiss:Record LIKE(OrgMiss:RECORD),THREAD
QuickWindow          WINDOW('View Mission'),AT(,,523,345),FONT('Microsoft Sans Serif',8,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_OrgMissions'),SYSTEM
                       PROMPT('Organization:'),AT(11,2),USE(?OrgMiss:Organization:Prompt),TRN
                       PROMPT('Mission:'),AT(11,17),USE(?OrgMiss:Mission:Prompt),TRN
                       ENTRY(@n-10.0),AT(67,2,48,10),USE(OrgMiss:Organization),DECIMAL(12),HIDE
                       COMBO(@s100),AT(121,17,291,9),USE(Miss:Name),DROP(5),FORMAT('100L(2)|M~Name~C(0)@s100@[' & |
  '100L(2)|M~Name~C(0)@s100@40L(2)|M~Code~C(0)@s20@]|~Mission Type~'),FROM(Queue:FileDropCombo:1), |
  IMM
                       COMBO(@s100),AT(121,2,291,10),USE(myOrg:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@'), |
  FROM(Queue:FileDropCombo),IMM
                       ENTRY(@n-10.0),AT(67,17,48,10),USE(OrgMiss:Mission),DECIMAL(12),HIDE
                       BUTTON('&OK'),AT(366,329,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(419,329,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(472,329,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       LIST,AT(5,125,173,87),USE(?List),FORMAT('0L(2)|M~ID~D(12)@n-10.0@0L(2)|M~ID~D(12)@n-10.' & |
  '0@[400L(2)|M~Name~C(0)@s100@]|~TASKORG~'),FROM(Queue:Browse),IMM
                       BUTTON('&Insert'),AT(2,217,42,12),USE(?Insert)
                       BUTTON('&Change'),AT(45,217,42,12),USE(?Change)
                       BUTTON('&Delete'),AT(86,217,42,12),USE(?Delete)
                       BUTTON('View TaskOrg'),AT(4,257),USE(?BUTTON_ViewTaskOrg)
                       BUTTON('View COP'),AT(68,257),USE(?BUTTON_ViewCOP)
                       BUTTON('View MilDocs'),AT(120,257),USE(?BUTTON_MilDoc)
                       LIST,AT(183,125,151,87),USE(?List:2),FORMAT('0L(2)|M~ID~D(12)@n-10.0@[100L(2)|M~C2IP Na' & |
  'me~C(0)@s100@40L(2)|M~C2IP Type~C(0)@s20@]|~C2IP Explorer~'),FROM(Queue:Browse:1),IMM
                       BUTTON('Create COP'),AT(183,215),USE(?BUTTON_CreateCOP)
                       PROMPT('Start Date:'),AT(121,33),USE(?Miss:StartDate:Prompt)
                       ENTRY(@D10),AT(170,31,60,10),USE(Miss:StartDate),DECIMAL(12)
                       PROMPT('Start Time:'),AT(302,33),USE(?Miss:StartTime:Prompt)
                       ENTRY(@T4),AT(351,31,60,10),USE(Miss:StartTime)
                       PROMPT('End Date:'),AT(119,47),USE(?Miss:EndDate:Prompt)
                       ENTRY(@D10),AT(170,46,60,10),USE(Miss:EndDate)
                       PROMPT('End Time:'),AT(301,47),USE(?Miss:EndTime:Prompt)
                       ENTRY(@T4),AT(351,46,60,10),USE(Miss:EndTime)
                       PROMPT('Mil Operation:'),AT(120,62),USE(?tpyMilOp:Name:Prompt)
                       ENTRY(@s100),AT(170,61,242,10),USE(tpyMilOp:Name)
                       TEXT,AT(5,78,515,42),USE(sMilMissFreeText),RTF(TEXT:Field)
                       LIST,AT(339,125,181,87),USE(?List:3),FORMAT('1020L(2)|M~Task Name~L(0)@s255@'),FROM(Queue:Browse:2), |
  IMM
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

BRW_MissTaskOrg      CLASS(BrowseClass)                    ! Browse using ?List
Q                      &Queue:Browse                  !Reference to browse queue
Init                   PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)
TakeNewSelection       PROCEDURE(),DERIVED
                     END

BRW10::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW_MissC2IPs        CLASS(BrowseClass)                    ! Browse using ?List:2
Q                      &Queue:Browse:1                !Reference to browse queue
                     END

BRW12::Sort0:Locator StepLocatorClass                      ! Default Locator
BRW13                CLASS(BrowseClass)                    ! Browse using ?List:3
Q                      &Queue:Browse:2                !Reference to browse queue
                     END

BRW13::Sort0:Locator StepLocatorClass                      ! Default Locator
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
    ActionMessage = 'View Organization''s Missions'
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
  GlobalErrors.SetProcedureName('View_OrgMissions')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?OrgMiss:Organization:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(OrgMiss:Record,History::OrgMiss:Record)
  SELF.AddHistoryField(?OrgMiss:Organization,2)
  SELF.AddHistoryField(?OrgMiss:Mission,3)
  SELF.AddUpdateFile(Access:OrgMissions)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IPExplorer.SetOpenRelated()
  Relate:C2IPExplorer.Open                                 ! File C2IPExplorer used by this procedure, so make sure it's RelationManager is open
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
  BRW_MissTaskOrg.Init(?List,Queue:Browse.ViewPosition,BRW10::View:Browse,Queue:Browse,Relate:MissionTASKORG,SELF) ! Initialize the browse manager
  BRW_MissC2IPs.Init(?List:2,Queue:Browse:1.ViewPosition,BRW12::View:Browse,Queue:Browse:1,Relate:C2IPExplorer,SELF) ! Initialize the browse manager
  BRW13.Init(?List:3,Queue:Browse:2.ViewPosition,BRW13::View:Browse,Queue:Browse:2,Relate:MissionToDo,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  IF SELF.Request = ViewRecord                             ! Configure controls for View Only mode
    ?OrgMiss:Organization{PROP:ReadOnly} = True
    DISABLE(?Miss:Name)
    DISABLE(?myOrg:Name)
    ?OrgMiss:Mission{PROP:ReadOnly} = True
    DISABLE(?Insert)
    DISABLE(?Change)
    DISABLE(?Delete)
    DISABLE(?BUTTON_ViewTaskOrg)
    DISABLE(?BUTTON_ViewCOP)
    DISABLE(?BUTTON_MilDoc)
    DISABLE(?BUTTON_CreateCOP)
    ?Miss:StartDate{PROP:ReadOnly} = True
    ?Miss:StartTime{PROP:ReadOnly} = True
    ?Miss:EndDate{PROP:ReadOnly} = True
    ?Miss:EndTime{PROP:ReadOnly} = True
    ?tpyMilOp:Name{PROP:ReadOnly} = True
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  BRW_MissTaskOrg.Q &= Queue:Browse
  BRW_MissTaskOrg.AddSortOrder(,MissTSK:KMission)          ! Add the sort order for MissTSK:KMission for sort order 1
  BRW_MissTaskOrg.AddRange(MissTSK:Mission,Relate:MissionTASKORG,Relate:OrgMissions) ! Add file relationship range limit for sort order 1
  BRW_MissTaskOrg.AddLocator(BRW10::Sort0:Locator)         ! Browse has a locator for sort order 1
  BRW10::Sort0:Locator.Init(,MissTSK:Mission,1,BRW_MissTaskOrg) ! Initialize the browse locator using  using key: MissTSK:KMission , MissTSK:Mission
  BRW_MissTaskOrg.AddField(MissTSK:ID,BRW_MissTaskOrg.Q.MissTSK:ID) ! Field MissTSK:ID is a hot field or requires assignment from browse
  BRW_MissTaskOrg.AddField(MissTSK:TASKORGC2IP,BRW_MissTaskOrg.Q.MissTSK:TASKORGC2IP) ! Field MissTSK:TASKORGC2IP is a hot field or requires assignment from browse
  BRW_MissTaskOrg.AddField(_C2IPTsk:Name,BRW_MissTaskOrg.Q._C2IPTsk:Name) ! Field _C2IPTsk:Name is a hot field or requires assignment from browse
  BRW_MissTaskOrg.AddField(MissTSK:Mission,BRW_MissTaskOrg.Q.MissTSK:Mission) ! Field MissTSK:Mission is a hot field or requires assignment from browse
  BRW_MissTaskOrg.AddField(_C2IPTsk:ID,BRW_MissTaskOrg.Q._C2IPTsk:ID) ! Field _C2IPTsk:ID is a hot field or requires assignment from browse
  BRW_MissC2IPs.Q &= Queue:Browse:1
  BRW_MissC2IPs.AddSortOrder(,C2IPExp:KOrganization)       ! Add the sort order for C2IPExp:KOrganization for sort order 1
  BRW_MissC2IPs.AddRange(C2IPExp:Organization,OrgMiss:Organization) ! Add single value range limit for sort order 1
  BRW_MissC2IPs.AddLocator(BRW12::Sort0:Locator)           ! Browse has a locator for sort order 1
  BRW12::Sort0:Locator.Init(,C2IPExp:Organization,1,BRW_MissC2IPs) ! Initialize the browse locator using  using key: C2IPExp:KOrganization , C2IPExp:Organization
  BRW_MissC2IPs.AddField(C2IPExp:Mission,BRW_MissC2IPs.Q.C2IPExp:Mission) ! Field C2IPExp:Mission is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(C2IP:Name,BRW_MissC2IPs.Q.C2IP:Name) ! Field C2IP:Name is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(tpyC2IP:Code,BRW_MissC2IPs.Q.tpyC2IP:Code) ! Field tpyC2IP:Code is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(C2IPExp:ID,BRW_MissC2IPs.Q.C2IPExp:ID) ! Field C2IPExp:ID is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(C2IPExp:Organization,BRW_MissC2IPs.Q.C2IPExp:Organization) ! Field C2IPExp:Organization is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(C2IP:ID,BRW_MissC2IPs.Q.C2IP:ID)  ! Field C2IP:ID is a hot field or requires assignment from browse
  BRW_MissC2IPs.AddField(tpyC2IP:ID,BRW_MissC2IPs.Q.tpyC2IP:ID) ! Field tpyC2IP:ID is a hot field or requires assignment from browse
  BRW13.Q &= Queue:Browse:2
  BRW13.AddSortOrder(,MissToDo:KMission)                   ! Add the sort order for MissToDo:KMission for sort order 1
  BRW13.AddRange(MissToDo:Mission,OrgMiss:Mission)         ! Add single value range limit for sort order 1
  BRW13.AddLocator(BRW13::Sort0:Locator)                   ! Browse has a locator for sort order 1
  BRW13::Sort0:Locator.Init(,MissToDo:Mission,1,BRW13)     ! Initialize the browse locator using  using key: MissToDo:KMission , MissToDo:Mission
  BRW13.AddField(MissToDo:TaskName,BRW13.Q.MissToDo:TaskName) ! Field MissToDo:TaskName is a hot field or requires assignment from browse
  BRW13.AddField(MissToDo:ID,BRW13.Q.MissToDo:ID)          ! Field MissToDo:ID is a hot field or requires assignment from browse
  BRW13.AddField(MissToDo:Mission,BRW13.Q.MissToDo:Mission) ! Field MissToDo:Mission is a hot field or requires assignment from browse
  INIMgr.Fetch('View_OrgMissions',QuickWindow)             ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(myOrg:Name,?myOrg:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:myOrganization,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(myOrg:PKID)
  FDCB8.AddField(myOrg:Name,FDCB8.Q.myOrg:Name) !List box control field - type derived from field
  FDCB8.AddField(myOrg:ID,FDCB8.Q.myOrg:ID) !Primary key field - type derived from field
  FDCB8.AddUpdateField(myOrg:ID,OrgMiss:Organization)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  FDCB9.Init(Miss:Name,?Miss:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:MilMissions,ThisWindow,GlobalErrors,1,1,0)
  FDCB9.AskProcedure = 1
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(Miss:PKID)
  FDCB9.AddField(Miss:Name,FDCB9.Q.Miss:Name) !List box control field - type derived from field
  FDCB9.AddField(tpyMilOp:Name,FDCB9.Q.tpyMilOp:Name) !List box control field - type derived from field
  FDCB9.AddField(tpyMilOp:Code,FDCB9.Q.tpyMilOp:Code) !List box control field - type derived from field
  FDCB9.AddField(Miss:ID,FDCB9.Q.Miss:ID) !Primary key field - type derived from field
  FDCB9.AddField(tpyMilOp:ID,FDCB9.Q.tpyMilOp:ID) !Related join file key field - type derived from field
  FDCB9.AddUpdateField(Miss:ID,OrgMiss:Mission)
  ThisWindow.AddItem(FDCB9.WindowComponent)
  FDCB9.DefaultFill = 0
  BRW_MissTaskOrg.AskProcedure = 2                         ! Will call: U_MissionTASKORG
  BRW_MissTaskOrg.AddToolbarTarget(Toolbar)                ! Browse accepts toolbar control
  BRW_MissTaskOrg.ToolbarItem.HelpButton = ?Help
  BRW_MissC2IPs.AddToolbarTarget(Toolbar)                  ! Browse accepts toolbar control
  BRW_MissC2IPs.ToolbarItem.HelpButton = ?Help
  BRW13.AddToolbarTarget(Toolbar)                          ! Browse accepts toolbar control
  BRW13.ToolbarItem.HelpButton = ?Help
  SELF.SetAlerts()
  ! Mission Free Text
  
  sMilMissFreeText    = Miss:freeText
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
    INIMgr.Update('View_OrgMissions',QuickWindow)          ! Save window data to non-volatile store
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
    EXECUTE Number
      U_Missions
      U_MissionTASKORG
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
    OF ?Miss:Name
      FDCB9.TakeAccepted()
    OF ?OK
      ThisWindow.Update()
      IF SELF.Request = ViewRecord AND NOT SELF.BatchProcessing THEN
         POST(EVENT:CloseWindow)
      END
    OF ?BUTTON_ViewCOP
      ThisWindow.Update()
      ! COPApp
      
      ! View current selected C2IP from C2IP Explorer
      !MESSAGE('C2IP = ' & BRW_MissC2IPs.q.C2IP:ID)
      COPApp(BRW_MissC2IPs.q.C2IP:ID, OrgMiss:Organization, nMissTaskOrgRef, nTASKORGC2IPRef)
    OF ?BUTTON_CreateCOP
      ThisWindow.Update()
      ! COPApp
      
      COPApp(0, OrgMiss:Organization, nMissTaskOrgRef, nTASKORGC2IPRef)
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window


BRW_MissTaskOrg.Init PROCEDURE(SIGNED ListBox,*STRING Posit,VIEW V,QUEUE Q,RelationManager RM,WindowManager WM)

  CODE
  PARENT.Init(ListBox,Posit,V,Q,RM,WM)
  IF WM.Request <> ViewRecord                              ! If called for anything other than ViewMode, make the insert, change & delete controls available
    SELF.InsertControl=?Insert
    SELF.ChangeControl=?Change
    SELF.DeleteControl=?Delete
  END


BRW_MissTaskOrg.TakeNewSelection PROCEDURE

  CODE
  PARENT.TakeNewSelection
  ! Mission TASKORG Reference
  
  nMissTaskOrgRef  = BRW_MissTaskOrg.q.MissTSK:ID
  nTASKORGC2IPRef  = BRW_MissTaskOrg.q.MissTSK:TASKORGC2IP

!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the TheaterOfOps file
!!! </summary>
B_TOOs PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(TheaterOfOps)
                       PROJECT(TOO:ID)
                       PROJECT(TOO:Name)
                       PROJECT(TOO:Code)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
TOO:ID                 LIKE(TOO:ID)                   !List box control field - type derived from field
TOO:Name               LIKE(TOO:Name)                 !List box control field - type derived from field
TOO:Code               LIKE(TOO:Code)                 !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the TheaterOfOps file'),AT(,,277,198),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_TOOs'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@80L(2)|M~' & |
  'Name~L(2)@s100@80L(2)|M~Code~L(2)@s20@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the ' & |
  'TheaterOfOps file')
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
  GlobalErrors.SetProcedureName('B_TOOs')
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
  Relate:TheaterOfOps.Open                                 ! File TheaterOfOps used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:TheaterOfOps,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon TOO:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,TOO:PKID)        ! Add the sort order for TOO:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,TOO:ID,1,BRW1)                 ! Initialize the browse locator using  using key: TOO:PKID , TOO:ID
  BRW1.AddField(TOO:ID,BRW1.Q.TOO:ID)                      ! Field TOO:ID is a hot field or requires assignment from browse
  BRW1.AddField(TOO:Name,BRW1.Q.TOO:Name)                  ! Field TOO:Name is a hot field or requires assignment from browse
  BRW1.AddField(TOO:Code,BRW1.Q.TOO:Code)                  ! Field TOO:Code is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_TOOs',QuickWindow)                       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_TOOs
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
    Relate:TheaterOfOps.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_TOOs',QuickWindow)                    ! Save window data to non-volatile store
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
    U_TOOs
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

