

  MEMBER('webLMil')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 16.01.2019
 * Time: 19:54
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

! Local objects

! JSON objects
json                JSONClass
collection          &JSONClass

! string theory objects
sst                 stringtheory


OrgChartC2IP.Construct      PROCEDURE()
    CODE
        PARENT.Construct()    

OrgChartC2IP.Redraw PROCEDURE()
nCurrentUnitType    LONG
CODE
    ! redraw OrgChar C2IP content
    sst.Trace('BEGIN:OrgChartC2IP.Redraw')
   
    PARENT.Redraw()
    
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    sst.Trace('RECORDS(SELF.ul.ul) = ' & RECORDS(SELF.ul.ul))
    IF RECORDS(SELF.ul.ul) > 0 THEN
        LOOP i# = 1 TO RECORDS(SELF.ul.ul)
            GET(SELF.ul.ul, i#)
            sst.Trace('i# = ' & i#)
            IF NOT ERRORCODE() THEN
                ! Main Symbol
                SELF.DrawNode_MainSymbol()                                                                                    
                ! Echelon
                SELF.DrawNode_Echelon()            
            END            
        END
    END
    
    sst.Trace('OrgChartC2IP.Redraw -> before Display')
    IF RECORDS(SELF.ul.ul) > 0 THEN
        SELF.drwImg.Display()
    END
    sst.Trace('OrgChartC2IP.Redraw -> after Display')
    sst.Trace('END:OrgChartC2IP.Redraw')
    
    

    
    
    
    
OrgChartC2IP.InsertNode     PROCEDURE
    CODE
        SELF.DisplayUnselection()
        SELF.ul.InsertNode()
        SELF.Redraw()
        SELF.DisplaySelection()
        
OrgChartC2IP.InsertNode     PROCEDURE(*UnitBasicRecord pURec)
    CODE
        errCode#    = SELF.ul.InsertNode(pUrec)
        IF errCode# = TRUE THEN
            SELF.Redraw()
            SELF.DisplaySelection()
        END
        
        
    
OrgChartC2IP.GetNode     PROCEDURE(*UnitBasicRecord pURec)
CODE
    ! get current node
    
    GET(SELF.ul.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        pUrec.UnitName          = SELF.ul.UnitName()
        !pUrec.UnitType          = SELF.ul.UnitType()
        pUrec.UnitTypeCode      = SELF.ul.UnitTypeCode()
        pUrec.Echelon           = SELF.ul.Echelon()
        pURec.Hostility         = SELF.ul.Hostility()
        pUrec.IsHQ              = SELF.ul.IsHQ()
        pUrec.xPos              = SELF.ul.xPos()
        pUrec.yPos              = SELF.ul.yPos()
        pUrec.TreePos           = SELF.ul.TreePos()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.DeleteNode     PROCEDURE
CODE
    ! do something
    SELF.ul.DeleteNode()
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    
    
OrgChartC2IP.DisableNode    PROCEDURE
CODE
    ! do something
    SELF.ul.DisableNode()
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    
    
    
    
        
    
OrgChartC2IP.SelectByMouse     PROCEDURE(LONG nXPos, LONG nYPos)
CODE
    ! do something
    sst.Trace('BEGIN:OrgChartC2IP.SelectByMouse')
    
    curSel#     = SELF.ul.Pointer()
    curXPos#    = SELF.ul.xPos()
    curYPos#    = SELF.ul.yPos()
        
    nodeFoundPos#   = PARENT.SelectByMouse(nXPos, nYPos)
    IF nodeFoundPos# > 0 THEN
        sst.Trace('node found')
        sst.Trace('curSel# = ' & curSel#)
        sst.Trace('curXPos# = ' & curXPos#)
        sst.Trace('curYPos# = ' & curYPos#)
        SELF.DisplayUnselection(curXPos#, curYPos#)
        
        SELF.selTreePos     = SELF.ul.TreePos()
        SELF.selQueuePos    = SELF.ul.Pointer()
        SELF.DisplaySelection()
    ELSE
        SELF.DisplaySelection()
    END
                
    sst.Trace('END:OrgChartC2IP.SelectByMouse')
    IF nodeFoundPos# > 0 THEN
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
    
OrgChartC2IP.Destruct     PROCEDURE
CODE        
    PARENT.Destruct()
    

    
       
    
OrgChartC2IP.Save     PROCEDURE()
CODE
    ! do something
    json.Start()
    !collection &= json.CreateCollection('Collection')
    !collection.Append(
    !json.Add('C2IPName', SELF.Name)
    collection &= json.CreateCollection('TaskOrg')
    collection.Append('C2IPName', SELF.Name, json:String)
    
    ! changed from queue to class
    !collection.Append(SELF.ul, 'Units')
    collection.Append(SELF.ul.ul, 'Units')
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
!    LOOP i# = 1 TO RECORDS(SELF.refC2IPs)
!        GET(SELF.refC2IPs, i#)
!        IF ERROCODE() THEN
!            SELF.
!        END
!    END    
            
    json.SaveFile(CLIP(SELF.Name)&'.c2ip', TRUE)
    
    RETURN TRUE
    
OrgChartC2IP.Save     PROCEDURE(STRING sFileName)
CODE
    ! do something
    json.Start()
    !collection &= json.CreateCollection('Collection')
    !collection.Append(
    !json.Add('C2IPName', SELF.Name)
    collection &= json.CreateCollection('TaskOrg')
    collection.Append('C2IPName', SELF.Name, json:String)
    
    ! changed from queue to class
    !collection.Append(SELF.ul, 'Units')
    collection.Append(SELF.ul.ul, 'Units')
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
    json.SaveFile(sFileName, TRUE)
    
    RETURN TRUE
    
OrgChartC2IP.Load   PROCEDURE(STRING sFileName)
jsonItem  &JSONClass
    CODE
        sst.Trace('BEGIN:OrgChartC2IP.Load')
        
    ! do something
    
    json.LoadFile(sFileName)
    
    i# = json.Records()
    !MESSAGE('found = ' & i#)
    
    ! C2IP Name
    jsonItem &= json.GetByName('C2IPName')
    IF NOT jsonItem &= Null THEN
        SELF.Name   = json.GetValueByName('C2IPName')
    END
    
    ! Units
    jsonItem &= json.GetByName('Units')
    IF NOT jsonItem &= NULL THEN
        !IF SELF.ul.Free() = TRUE THEN
        !END
        
        FREE(SELF.ul.ul)
        jsonItem.Load(SELF.ul.ul)
        sst.Trace('     OrgChartC2IP.Load->Units found = ' & RECORDS(SELF.ul.ul))
    END  
    
    ! refrenced C2IPs
    jsonItem &= json.GetByName('refC2IPs')
    IF NOT jsonItem &= NULL THEN
        FREE(SELF.refC2IPs)
        jsonItem.Load(SELF.refC2IPs)
    END
    
    
        SELF.Redraw()
        
        sst.Trace('END:OrgChartC2IP.Load')
    
    RETURN TRUE
    
    
    
! attach/detach C2IPs
OrgChartC2IP.AttachC2IP     PROCEDURE(STRING sFileName)
jsonItem                        &JSONClass
sC2IPName       STRING(100)
CODE
    ! do something
    
    json.LoadFile(sFileName)    
    i# = json.Records()
    
    ! C2IP Name
    jsonItem &= json.GetByName('C2IPName')
    IF NOT jsonItem &= Null THEN
        sC2IPName   = json.GetValueByName('C2IPName')
        
        SELF.refC2IPs.C2IPPath  = sFileName
        SELF.refC2IPs.C2IPName  = sC2IPName
        ADD(SELF.refC2IPs)
                
        RETURN TRUE
    ELSE
        RETURN FALSE
    END        
    
    
OrgChartC2IP.DetachC2IP     PROCEDURE(LONG nOPtion)
CODE
    ! do something
    
    
    RETURN TRUE    
    
    
    
OrgChartC2IP.TakeEvent   PROCEDURE(UNSIGNED nKeyCode)

CODE
    ! do something        
    
    RETURN TRUE
    
    
    
OrgChartC2IP.checkLabelEditMode   PROCEDURE()

CODE
    ! do something
    
    
    
    
OrgChartC2IP.TakeNodeAction   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Unit Name
!        CREATE(?uNameEntry, CREATE:entry)
!        SELF.uNameEntry = ''
!        ?uNameEntry{PROP:use} = SELF.uNameEntry
!        ?uNameEntry{PROP:text} = '@s100'
!        ?uNameEntry{PROP:Ypos} = 200
!        !?uNameEntry{PROP:
!        UNHIDE(?uNameEntry)
!        SELECT(?uNameEntry)
    OF 2
!        ! Unit Type        
!        UNHIDE(?ListSymbology)
!        SELECT(?ListSymbology)
    OF 3
        ! Echelon
        IF SELF.TakeEchelon(POPUP(SELF.EchelonMenuOptions())) = TRUE THEN
        END        
    OF 4
        ! Hostility
        IF SELF.TakeHostility(POPUP(SELF.HostilityMenuOptions())) = TRUE THEN
        END        
    OF 5
        ! HQ
!        CREATE(?uHQ, CREATE:check)
!        ?uHQ{PROP:Use} = SELF.bIsHQEntry
!        ?uHQ{PROP:TrueValue} = TRUE
!        ?uHQ{PROP:FalseValue} = FALSE
!        ?uHQ{PROP:XPos} = 30
!        ?uHQ{PROP:Ypos} = 200
!        UNHIDE(?uHQ)
!        SELECT(?uHQ)
    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.NodeActionsMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Change label | Change Unit type | Change Echelon | Change Hostility | Is HQ'
    
    
    
    
OrgChartC2IP.TakeEchelon   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Team
        ASSERT(SELF.SetEchelon(echTpy:Team), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Team)')
    OF 2
        ! Squad
        ASSERT(SELF.SetEchelon(echTpy:Squad), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Squad)')
    OF 3
        ! Section
        ASSERT(SELF.SetEchelon(echTpy:Section), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Section)')
    OF 4
        ! Platoon
        ASSERT(SELF.SetEchelon(echTpy:Platoon), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Platoon)')
    OF 5
        ! Company
        ASSERT(SELF.SetEchelon(echTpy:Company), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Company)')
    OF 6
        ! Battalion
        ASSERT(SELF.SetEchelon(echTpy:Battalion), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Battalion)')
    OF 7
        ! Regiment
        ASSERT(SELF.SetEchelon(echTpy:Regiment), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Regiment)')
    OF 8
        ! Brigade
        ASSERT(SELF.SetEchelon(echTpy:Brigade), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Brigade)')
    OF 9
        ! Division
        ASSERT(SELF.SetEchelon(echTpy:Division), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Division)')
    OF 10
        ! Corps
        ASSERT(SELF.SetEchelon(echTpy:Corps), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Corps)')
    OF 11
        ! Army
        ASSERT(SELF.SetEchelon(echTpy:Army), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Army)')
    OF 12
        ! Army Group
        ASSERT(SELF.SetEchelon(echTpy:ArmyGroup), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:ArmyGroup)')
    OF 13
        ! Theater
        ASSERT(SELF.SetEchelon(echTpy:Theater), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Theater)')
    OF 14
        ! Command
        ASSERT(SELF.SetEchelon(echTpy:Command), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Command)')

    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.EchelonMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Team o| Squad * | Section **| Platoon ***| Company :| Battalion ::| Regiment :::| Brigade x| Division xx| Corps xxx| Army xxxx| Army Group xxxxx| Theater xxxxxx| Command ++'
    
    
    
    
OrgChartC2IP.TakeHostility   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Unknown
        ASSERT(SELF.SetHostility(hTpy:Unknown), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Unknown)')
    OF 2
        ! Assumed Friend
        ASSERT(SELF.SetHostility(hTpy:AssumedFriend), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:AssumedFriend)')
    OF 3
        ! Friend
        ASSERT(SELF.SetHostility(hTpy:Friend), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Friend)')
    OF 4
        ! Neutral
        ASSERT(SELF.SetHostility(hTpy:Neutral), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Neutral)')
    OF 5
        ! Suspect/Joker
        ASSERT(SELF.SetHostility(hTpy:Suspect), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Suspect)')
    OF 6
        ! Hostile/Faker
        ASSERT(SELF.SetHostility(hTpy:Hostile), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Hostile)')
    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.HostilityMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Unknown | Assumed Friend | Friend | Neutral | Suspect/Jokjer | Hostile/Faker'

    
OrgChartC2IP.SelUp     PROCEDURE()
CODE
    ! do something        
    SELF.DisplayUnselection()
    IF SELF.ul.SelUp() = TRUE THEN        
        ! do something
    END
    SELF.DisplaySelection()
     
    
OrgChartC2IP.SelDown     PROCEDURE()
CODE
    ! do something
    SELF.DisplayUnselection()
    IF SELF.ul.SelDown() = TRUE THEN
        ! do something
    END
    SELF.DisplaySelection()        


OrgChartC2IP.TakeEvent     PROCEDURE()
    CODE
        PARENT.TakeEvent()
        
          
        
        