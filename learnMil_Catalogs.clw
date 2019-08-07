

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL_CATALOGS.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Browse the c2ieUnitsNormContent file
!!! </summary>
B_c2ieUnitsNormContent PROCEDURE 

CurrentTab           STRING(80)                            ! 
BRW1::View:Browse    VIEW(c2ieUnitsNormContent)
                       PROJECT(c2ieUniNrmCt:ID)
                       PROJECT(c2ieUniNrmCt:UnitNorm)
                       PROJECT(c2ieUniNrmCt:StdEq)
                       PROJECT(c2ieUniNrmCt:Quantity)
                       PROJECT(c2ieUniNrmCt:ActualQuantity)
                     END
Queue:Browse:1       QUEUE                            !Queue declaration for browse/combo box using ?Browse:1
c2ieUniNrmCt:ID        LIKE(c2ieUniNrmCt:ID)          !List box control field - type derived from field
c2ieUniNrmCt:UnitNorm  LIKE(c2ieUniNrmCt:UnitNorm)    !List box control field - type derived from field
c2ieUniNrmCt:StdEq     LIKE(c2ieUniNrmCt:StdEq)       !List box control field - type derived from field
c2ieUniNrmCt:Quantity  LIKE(c2ieUniNrmCt:Quantity)    !List box control field - type derived from field
c2ieUniNrmCt:ActualQuantity LIKE(c2ieUniNrmCt:ActualQuantity) !List box control field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
QuickWindow          WINDOW('Browse the c2ieUnitsNormContent file'),AT(,,277,198),FONT('Microsoft Sans Serif',8, |
  ,FONT:regular,CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('B_c2ieUnitNormContent'),SYSTEM
                       LIST,AT(8,30,261,124),USE(?Browse:1),HVSCROLL,FORMAT('48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~' & |
  'ID~C(0)@n-10.0@48R(2)|M~ID~C(0)@n-10.0@48R(2)|M~Quantity~C(0)@n-10.0@48R(2)|M~Quanti' & |
  'ty~C(0)@n-10.0@'),FROM(Queue:Browse:1),IMM,MSG('Browsing the c2ieUnitsNormContent file')
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
  GlobalErrors.SetProcedureName('B_c2ieUnitsNormContent')
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
  Relate:c2ieUnitsNormContent.SetOpenRelated()
  Relate:c2ieUnitsNormContent.Open                         ! File c2ieUnitsNormContent used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  BRW1.Init(?Browse:1,Queue:Browse:1.ViewPosition,BRW1::View:Browse,Queue:Browse:1,Relate:c2ieUnitsNormContent,SELF) ! Initialize the browse manager
  SELF.Open(QuickWindow)                                   ! Open window
  Do DefineListboxStyle
  BRW1.Q &= Queue:Browse:1
  BRW1::Sort0:StepClass.Init(+ScrollSort:AllowAlpha)       ! Moveable thumb based upon c2ieUniNrmCt:ID for sort order 1
  BRW1.AddSortOrder(BRW1::Sort0:StepClass,c2ieUniNrmCt:PKID) ! Add the sort order for c2ieUniNrmCt:PKID for sort order 1
  BRW1.AddLocator(BRW1::Sort0:Locator)                     ! Browse has a locator for sort order 1
  BRW1::Sort0:Locator.Init(,c2ieUniNrmCt:ID,1,BRW1)        ! Initialize the browse locator using  using key: c2ieUniNrmCt:PKID , c2ieUniNrmCt:ID
  BRW1.AddField(c2ieUniNrmCt:ID,BRW1.Q.c2ieUniNrmCt:ID)    ! Field c2ieUniNrmCt:ID is a hot field or requires assignment from browse
  BRW1.AddField(c2ieUniNrmCt:UnitNorm,BRW1.Q.c2ieUniNrmCt:UnitNorm) ! Field c2ieUniNrmCt:UnitNorm is a hot field or requires assignment from browse
  BRW1.AddField(c2ieUniNrmCt:StdEq,BRW1.Q.c2ieUniNrmCt:StdEq) ! Field c2ieUniNrmCt:StdEq is a hot field or requires assignment from browse
  BRW1.AddField(c2ieUniNrmCt:Quantity,BRW1.Q.c2ieUniNrmCt:Quantity) ! Field c2ieUniNrmCt:Quantity is a hot field or requires assignment from browse
  BRW1.AddField(c2ieUniNrmCt:ActualQuantity,BRW1.Q.c2ieUniNrmCt:ActualQuantity) ! Field c2ieUniNrmCt:ActualQuantity is a hot field or requires assignment from browse
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('B_c2ieUnitsNormContent',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  BRW1.AskProcedure = 1                                    ! Will call: U_c2ieUnitsNormContent
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
    Relate:c2ieUnitsNormContent.Close
  END
  IF SELF.Opened
    INIMgr.Update('B_c2ieUnitsNormContent',QuickWindow)    ! Save window data to non-volatile store
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
    U_c2ieUnitsNormContent
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
!!! Form c2ieUnitsNormContent
!!! </summary>
U_c2ieUnitsNormContent PROCEDURE 

CurrentTab           STRING(80)                            ! 
ActionMessage        CSTRING(40)                           ! 
FDCB8::View:FileDropCombo VIEW(type_StdEqp)
                       PROJECT(tpyStdEqp:Name)
                       PROJECT(tpyStdEqp:Code)
                       PROJECT(tpyStdEqp:ID)
                     END
FDCB9::View:FileDropCombo VIEW(c2ieUnitsNorm)
                       PROJECT(c2ieUniNrm:ID)
                       PROJECT(c2ieUniNrm:Norm)
                       JOIN(Nrm:PKID,c2ieUniNrm:Norm)
                         PROJECT(Nrm:Name)
                         PROJECT(Nrm:Code)
                         PROJECT(Nrm:ID)
                       END
                     END
Queue:FileDropCombo  QUEUE                            !Queue declaration for browse/combo box using ?tpyStdEqp:Name
tpyStdEqp:Name         LIKE(tpyStdEqp:Name)           !List box control field - type derived from field
tpyStdEqp:Code         LIKE(tpyStdEqp:Code)           !List box control field - type derived from field
tpyStdEqp:ID           LIKE(tpyStdEqp:ID)             !Primary key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
Queue:FileDropCombo:1 QUEUE                           !Queue declaration for browse/combo box using ?Nrm:Name
Nrm:Name               LIKE(Nrm:Name)                 !List box control field - type derived from field
Nrm:Code               LIKE(Nrm:Code)                 !List box control field - type derived from field
c2ieUniNrm:ID          LIKE(c2ieUniNrm:ID)            !Primary key field - type derived from field
Nrm:ID                 LIKE(Nrm:ID)                   !Related join file key field - type derived from field
Mark                   BYTE                           !Entry's marked status
ViewPosition           STRING(1024)                   !Entry's view position
                     END
History::c2ieUniNrmCt:Record LIKE(c2ieUniNrmCt:RECORD),THREAD
QuickWindow          WINDOW('Form c2ieUnitsNormContent'),AT(,,417,272),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,MDI,HLP('U_c2ieUnitsNormContent'),SYSTEM
                       SHEET,AT(4,4,411,249),USE(?CurrentTab)
                         TAB('&1) General'),USE(?Tab:1)
                           PROMPT('ID:'),AT(8,20),USE(?c2ieUniNrmCt:ID:Prompt),TRN
                           ENTRY(@n-10.0),AT(82,20,48,10),USE(c2ieUniNrmCt:ID),DECIMAL(12)
                           PROMPT('Norm:'),AT(8,34),USE(?c2ieUniNrmCt:UnitNorm:Prompt),TRN
                           ENTRY(@n-10.0),AT(82,34,48,10),USE(c2ieUniNrmCt:UnitNorm),DECIMAL(12)
                           PROMPT('Standard Equipment:'),AT(8,48),USE(?c2ieUniNrmCt:StdEq:Prompt),TRN
                           ENTRY(@n-10.0),AT(82,49,48,10),USE(c2ieUniNrmCt:StdEq),DECIMAL(12)
                           PROMPT('Planned Quantity:'),AT(8,62),USE(?c2ieUniNrmCt:Quantity:Prompt),TRN
                           ENTRY(@n-10.0),AT(147,62,137,10),USE(c2ieUniNrmCt:Quantity),DECIMAL(12)
                           PROMPT('Actual Quantity:'),AT(8,76),USE(?c2ieUniNrmCt:ActualQuantity:Prompt),TRN
                           ENTRY(@n-10.0),AT(147,76,137,10),USE(c2ieUniNrmCt:ActualQuantity),DECIMAL(12)
                           COMBO(@s100),AT(147,49,254,10),USE(tpyStdEqp:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@' & |
  's100@80L(2)|M~Code~L(0)@s20@'),FROM(Queue:FileDropCombo),IMM
                           COMBO(@s100),AT(147,34,254,10),USE(Nrm:Name),DROP(5),FORMAT('400L(2)|M~Name~L(0)@s100@8' & |
  '0L(2)|M~Code~L(0)@s20@'),FROM(Queue:FileDropCombo:1),IMM
                         END
                       END
                       BUTTON('&OK'),AT(259,256,49,14),USE(?OK),LEFT,ICON('WAOK.ICO'),DEFAULT,FLAT,MSG('Accept dat' & |
  'a and close the window'),TIP('Accept data and close the window')
                       BUTTON('&Cancel'),AT(313,256,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel operation'), |
  TIP('Cancel operation')
                       BUTTON('&Help'),AT(365,256,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
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
  GlobalErrors.SetProcedureName('U_c2ieUnitsNormContent')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?c2ieUniNrmCt:ID:Prompt
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.HistoryKey = CtrlH
  SELF.AddHistoryFile(c2ieUniNrmCt:Record,History::c2ieUniNrmCt:Record)
  SELF.AddHistoryField(?c2ieUniNrmCt:ID,1)
  SELF.AddHistoryField(?c2ieUniNrmCt:UnitNorm,2)
  SELF.AddHistoryField(?c2ieUniNrmCt:StdEq,3)
  SELF.AddHistoryField(?c2ieUniNrmCt:Quantity,4)
  SELF.AddHistoryField(?c2ieUniNrmCt:ActualQuantity,5)
  SELF.AddUpdateFile(Access:c2ieUnitsNormContent)
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:c2ieUnitsNorm.SetOpenRelated()
  Relate:c2ieUnitsNorm.Open                                ! File c2ieUnitsNorm used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Primary &= Relate:c2ieUnitsNormContent
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
    ?c2ieUniNrmCt:ID{PROP:ReadOnly} = True
    ?c2ieUniNrmCt:UnitNorm{PROP:ReadOnly} = True
    ?c2ieUniNrmCt:StdEq{PROP:ReadOnly} = True
    ?c2ieUniNrmCt:Quantity{PROP:ReadOnly} = True
    ?c2ieUniNrmCt:ActualQuantity{PROP:ReadOnly} = True
    DISABLE(?tpyStdEqp:Name)
    DISABLE(?Nrm:Name)
  END
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('U_c2ieUnitsNormContent',QuickWindow)       ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  ToolBarForm.HelpButton=?Help
  SELF.AddItem(ToolbarForm)
  FDCB8.Init(tpyStdEqp:Name,?tpyStdEqp:Name,Queue:FileDropCombo.ViewPosition,FDCB8::View:FileDropCombo,Queue:FileDropCombo,Relate:type_StdEqp,ThisWindow,GlobalErrors,0,1,0)
  FDCB8.Q &= Queue:FileDropCombo
  FDCB8.AddSortOrder(tpyStdEqp:PKID)
  FDCB8.AddField(tpyStdEqp:Name,FDCB8.Q.tpyStdEqp:Name) !List box control field - type derived from field
  FDCB8.AddField(tpyStdEqp:Code,FDCB8.Q.tpyStdEqp:Code) !List box control field - type derived from field
  FDCB8.AddField(tpyStdEqp:ID,FDCB8.Q.tpyStdEqp:ID) !Primary key field - type derived from field
  FDCB8.AddUpdateField(tpyStdEqp:ID,c2ieUniNrmCt:StdEq)
  ThisWindow.AddItem(FDCB8.WindowComponent)
  FDCB8.DefaultFill = 0
  FDCB9.Init(Nrm:Name,?Nrm:Name,Queue:FileDropCombo:1.ViewPosition,FDCB9::View:FileDropCombo,Queue:FileDropCombo:1,Relate:c2ieUnitsNorm,ThisWindow,GlobalErrors,0,1,0)
  FDCB9.Q &= Queue:FileDropCombo:1
  FDCB9.AddSortOrder(c2ieUniNrm:PKID)
  FDCB9.AddField(Nrm:Name,FDCB9.Q.Nrm:Name) !List box control field - type derived from field
  FDCB9.AddField(Nrm:Code,FDCB9.Q.Nrm:Code) !List box control field - type derived from field
  FDCB9.AddField(c2ieUniNrm:ID,FDCB9.Q.c2ieUniNrm:ID) !Primary key field - type derived from field
  FDCB9.AddField(Nrm:ID,FDCB9.Q.Nrm:ID) !Related join file key field - type derived from field
  FDCB9.AddUpdateField(c2ieUniNrm:ID,c2ieUniNrmCt:UnitNorm)
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
    Relate:c2ieUnitsNorm.Close
  END
  IF SELF.Opened
    INIMgr.Update('U_c2ieUnitsNormContent',QuickWindow)    ! Save window data to non-volatile store
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

