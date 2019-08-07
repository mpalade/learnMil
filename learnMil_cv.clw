

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

sFoundUnitName       STRING(100)                           ! 
sFoundUnitCode       STRING(20)                            ! 
nFoundUnitID         DECIMAL(7)                            ! 
nFoundBSOTypeID      DECIMAL(7)                            ! 
nFoundC2IEID         DECIMAL(7)                            ! 
nFoundC2IPID         DECIMAL(7)                            ! 
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
  Relate:Units.SetOpenRelated()
  Relate:Units.Open                                        ! File Units used by this procedure, so make sure it's RelationManager is open
  Relate:_Units.Open                                       ! File _Units used by this procedure, so make sure it's RelationManager is open
  Access:c2ieTaskOrg.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_BSO.UseFile                                  ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_C2IE.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:type_C2IP.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:C2IPContent.UseFile                               ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:C2IPs.UseFile                                     ! File referenced in 'Other Files' so need to inform it's FileManager
  Access:c2ieUnits.UseFile                                 ! File referenced in 'Other Files' so need to inform it's FileManager
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
              nFoundC2IEID        = C2IE:ID            
              C2IPCt:C2IEInstance = C2IE:ID            
              Access:C2IEs.TryInsert()
              
              ! Prepare C2IP table
              Access:C2IPs.PrimeAutoInc()   
              nFoundC2IPID        = C2IP:ID
              C2IPCt:C2IPPackage  = C2IP:ID
              Access:C2IPs.TryInsert()
              
              ! Prepare C2IPContent table
              Access:C2IPContent.PrimeAutoInc()
              Access:C2IPContent.TryInsert()   
              
              
              
              OMIT('__noCompile')
              ! LOOP through Units
                  ! should be correct
              !MESSAGE('rec = ' & RECORDS(refOrgChart.ul.collection))
              LOOP i# = 1 TO RECORDS(refOrgChart.ul.collection)
                  GET(refOrgChart.ul.collection, i#)
                  IF NOT ERRORCODE() THEN
                      MESSAGE(refOrgChart.ul.collection.unit.urec.UnitName)
                  END
                  
              END
              __noCompile
              
              log.Trace('RECORDS(SELF.ul.ul) = ' & RECORDS(refOrgChart.ul.ul))
              IF RECORDS(refOrgChart.ul.ul) > 0 THEN
                  LOOP i# = 1 TO RECORDS(refOrgChart.ul.ul)
                      GET(refOrgChart.ul.ul, i#)
                      log.Trace('i# = ' & i#)
                      IF NOT ERRORCODE() THEN
                          sFoundUnitName  = refOrgChart.ul.ul.UnitName
                          sFoundUnitCode  = refOrgChart.ul.ul.UnitName
                          !MESSAGE(refOrgChart.ul.ul.UnitName)
                          
                          _Uni:Name   = sFoundUnitName
                          IF Access:_Units.Fetch(_Uni:KName) = Level:Benign THEN
                              ! keep current Object ID
                              nFoundUnitID    = _Uni:ID
                          ELSE
                              ! determine BSO Type
                              tpyBSO:Code = 'Units'
                              IF Access:type_BSO.Fetch(tpyBSO:KCode) = Level:Benign THEN
                                  nFoundBSOTypeID = tpyBSO:ID
                              END
                                                          
                              ! insert new Object
                              Uni:Name       = sFoundUnitName
                              Uni:Code       = sFoundUnitCode
                              Uni:BSOType    = nFoundBSOTypeID
                              Access:Units.PrimeAutoInc()
                              Access:Units.TryInsert()
                              nFoundUnitID    = Uni:ID
                          END
                          
                          ! Update c2ieUnits table
                          c2ieUni:C2IE    = nFoundC2IEID
                          c2ieUni:Unit    = nFoundUnitID
                          c2ieUni:Hostility   = 1
                          Access:c2ieUnits.PrimeAutoInc()
                          Access:c2ieUnits.TryInsert()
                          
                          ! Update c2ieTaskOrg table
                          Access:c2ieTaskOrg.PrimeRecord()
                          Access:c2ieTaskOrg.PrimeAutoInc()
                          c2ieTO:C2IE     = nFoundC2IEID
                          CASE refOrgChart.ul.ul.TreePos
                          OF 1
                              ! Parent
                              c2ieTO:Parent   = nFoundUnitID
                          OF 2
                              ! Child1
                              c2ieTO:Child1   = nFoundUnitID
                          OF 3
                              ! Child2
                              c2ieTO:Child2   = nFoundUnitID
                          OF 4
                              ! Child3
                              c2ieTO:Child3   = nFoundUnitID
                          OF 5
                              ! Child4
                              c2ieTO:Child4   = nFoundUnitID
                          OF 6
                              ! Child5
                              c2ieTO:Child5   = nFoundUnitID                            
                          END
                          Access:c2ieTaskOrg.TryInsert()                        
                          
                      END            
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
    Relate:Units.Close
    Relate:_Units.Close
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

