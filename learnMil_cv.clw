

   MEMBER('learnMil.clw')                                  ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('LEARNMIL_CV.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! convert C2IP to tables data structures
!!! </summary>
cvC2IP_tables        PROCEDURE  (STRING sC2IPPath)         ! Declare Procedure
! local objects



refOrgChart         OrgChartC2IP
refOverlay          OverlayC2IP

  CODE
! convert C2IP to table data structures

IF (LEN(sC2IPPath) > 0 ) THEN
    IF refOrgChart.Load(sC2IPPath) = TRUE THEN
        
        C2IE:Type   = 0 !TASKORG
        C2IE:Name   = refOrgChart.Name
        
        C2IP:Type   = 0 !TASKORG
        C2IP:Name   = refOrgChart.Name
        
        ! Prepare C2IE table
        Access:C2IEs.PrimeAutoInc()
        C2IPCt:C2IEInstance = C2IE:ID
        
        Access:C2IEs.TryInsert()
        
        ! Prepare C2IP table
        Access:C2IPs.PrimeAutoInc()        
        C2IPCt:C2IPPackage  = C2IP:ID
        Access:C2IPs.TryInsert()
        
        ! Prepare C2IPContent table
        Access:C2IPContent.PrimeAutoInc()
        Access:C2IPContent.TryInsert()
        
    END    
END

!!! <summary>
!!! Generated from procedure template - Window
!!! conversion Background Window
!!! </summary>
cvBkgWnd PROCEDURE (STRING sC2IPPath)

QuickWindow          WINDOW('conversion background window'),AT(,,260,160),FONT('Microsoft Sans Serif',8,,FONT:regular, |
  CHARSET:DEFAULT),RESIZE,CENTER,GRAY,IMM,HLP('cvBkgWnd'),SYSTEM
                       BUTTON('&OK'),AT(101,142,49,14),USE(?Ok),LEFT,ICON('WAOK.ICO'),FLAT,MSG('Accept operation'), |
  TIP('Accept Operation')
                       BUTTON('&Cancel'),AT(154,142,49,14),USE(?Cancel),LEFT,ICON('WACANCEL.ICO'),FLAT,MSG('Cancel Operation'), |
  TIP('Cancel Operation')
                       BUTTON('&Help'),AT(207,142,49,14),USE(?Help),LEFT,ICON('WAHELP.ICO'),FLAT,MSG('See Help Window'), |
  STD(STD:Help),TIP('See Help Window')
                       IMAGE,AT(2,2,254,137),USE(?Draw)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END

! ----- cnvDrawer --------------------------------------------------------------------------
cnvDrawer            Class(Draw)
    ! derived method declarations
                     End  ! cnvDrawer
! ----- end cnvDrawer -----------------------------------------------------------------------
! local objects



refOrgChart         OrgChartC2IP
refOverlay          OverlayC2IP

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
  GlobalErrors.SetProcedureName('cvBkgWnd')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Ok
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Ok,RequestCancelled)                    ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Ok,RequestCompleted)                    ! Add the close control to the window manger
  END
  SELF.AddItem(?Cancel,RequestCancelled)                   ! Add the cancel control to the window manager
  Relate:C2IEs.SetOpenRelated()
  Relate:C2IEs.Open                                        ! File C2IEs used by this procedure, so make sure it's RelationManager is open
  Relate:c2ieUnits.SetOpenRelated()
  Relate:c2ieUnits.Open                                    ! File c2ieUnits used by this procedure, so make sure it's RelationManager is open
  Access:type_C2IE.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_C2IP.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:C2IPContent.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:C2IPs.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  SELF.FilesOpened = True
  SELF.Open(QuickWindow)                                   ! Open window
    QuickWindow{PROP:Buffer} = 1 ! Remove flicker when animating.
    cnvDrawer.Init(?Draw)
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  INIMgr.Fetch('cvBkgWnd',QuickWindow)                     ! Restore window settings from non-volatile store
  Resizer.Resize                                           ! Reset required after window size altered by INI manager
  SELF.SetAlerts()
  ! convert C2IP to table data structures
  
  IF (LEN(sC2IPPath) > 0 ) THEN
      IF refOrgChart.InitDraw(cnvDrawer) = TRUE THEN   
          IF refOrgChart.Load(sC2IPPath) = TRUE THEN
          
              tpyC2IE:Code    = 'TASKORG'
              IF Access:type_C2IE.Fetch(tpyC2IE:KCode) = Level:Benign THEN
                  C2IE:Type   = tpyC2IE:ID !TASKORG
                  C2IE:Name   = refOrgChart.Name
              END
              
              tpyC2IP:Code    = 'TASKORG'
              IF Access:type_C2IP.Fetch(tpyC2IP:KCode) = Level:Benign THEN
                  C2IP:Type   = tpyC2IP:ID !TASKORG
                  C2IP:Name   = refOrgChart.Name
              END                                    
      
              ! Prepare C2IE table
              Access:C2IEs.PrimeAutoInc()
              C2IPCt:C2IEInstance = C2IE:ID
              
              Access:C2IEs.TryInsert()
              
              ! Prepare C2IP table
              Access:C2IPs.PrimeAutoInc()        
              C2IPCt:C2IPPackage  = C2IP:ID
              Access:C2IPs.TryInsert()
              
              ! Prepare C2IPContent table
              Access:C2IPContent.PrimeAutoInc()
              Access:C2IPContent.TryInsert()   
              
              ! LOOP through Units
              MESSAGE('rec = ' & RECORDS(refOrgChart.ul.collection))
              LOOP i# = 1 TO RECORDS(refOrgChart.ul.collection)
                  GET(refOrgChart.ul.collection, i#)
                  IF NOT ERRORCODE() THEN
                      MESSAGE(refOrgChart.ul.collection.unit.urec.UnitName)
                  END
                  
              END
              
              
          END
      END    
  END
  
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
          cnvDrawer.Kill()
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:C2IEs.Close
    Relate:c2ieUnits.Close
  END
  IF SELF.Opened
    INIMgr.Update('cvBkgWnd',QuickWindow)                  ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

