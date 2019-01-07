    MEMBER('learnMil.clw')

    MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

aClass.aProcedure   PROCEDURE()
localV                  LONG
    CODE
        localV  = 5
        SELF.aValue =localV
        MESSAGE('value = ' & SELF.aValue)
        
        
aClass.bProcedure    PROCEDURE(LONG nPrm)
    CODE
        SELF.aValue = nPrm
     
                  
OrgChartC2IP.Construct     PROCEDURE
CODE
    ! do something
    
    SELF.ul     &= NEW(UnitsList)
    SELF.tmpul  &= NEW(UnitsList)
    
    ! default C2IP Name
    SELF.Name   = ''
    LOOP 10 TIMES
        SELF.Name = CLIP(SELF.Name) & CHR(RANDOM(97, 122))    
    END       
    
    ! referenced C2IPs list
    SELF.refC2IPs   &= NEW(C2IPsList)
    
    SELF.labelEditMode  = FALSE

OrgChartC2IP.InitDraw     PROCEDURE(Draw pDraw)
CODE
    ! do something
    
    SELF.drwImg     &= pDraw

OrgChartC2IP.Redraw PROCEDURE
nCurrentUnitType    LONG
CODE
    ! do something
    
    SELF.drwImg.Blank(COLOR:White)
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    LOOP i# = 1 TO RECORDS(SELF.ul)
        GET(SELF.ul, i#)
        IF NOT ERRORCODE() THEN    
            
            OMIT('__unitType')
            ! Unit Type
            CASE SELF.ul.UnitType
            OF uTpy:infantry
                ! Infantry
                IF SELF.DrawNode_Infantry(FALSE) = TRUE THEN
                END
                
                
                !SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos, 50, 30, COLOR:Aqua) 
                !SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos, 50, 30)
                !SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos + 30, 50, -30)
                !SELF.drwImg.Show(SELF.ul.xPos + 5, SELF.ul.yPos + 11, SELF.ul.UnitName)                
            ELSE
                ! Default
                IF SELF.DrawNode_Default(FALSE) = TRUE THEN
                END
                
                !SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos, 50, 30, COLOR:Aqua) 
                !SELF.drwImg.Show(SELF.ul.xPos + 5, SELF.ul.yPos + 11, SELF.ul.UnitName)                
            END    
            __unitType
            
            ! Unit Type Code
            CASE CLIP(SELF.ul.UnitTypeCode)
            OF '121100'
                ! Infantry
                IF SELF.DrawNode_Infantry(FALSE) = TRUE THEN
                END
            OF '121101'
                ! Infantry Amphibious
                IF SELF.DrawNode_Infantry_Amphibious(FALSE) = TRUE THEN
                END
            OF '121102'
                ! Infantry Armored/Mechanized/Tracked
                IF SELF.DrawNode_Infantry_Armored(FALSE) = TRUE THEN
                END
            OF '121103'
                ! Infantry Main Gun System
                IF SELF.DrawNode_Infantry_MainGunSystem(FALSE) = TRUE THEN
                END
            OF '121104'
                ! Infantry Motorized
                IF SELF.DrawNode_Infantry_Motorized(FALSE) = TRUE THEN
                END
            OF '121105'
                ! Infantry Infantry Fighting Vehicle
                IF SELF.DrawNode_Infantry_FightingVehicle(FALSE) = TRUE THEN
                END
            OF '121200'
                ! Observer
                IF SELF.DrawNode_Observer(FALSE) = TRUE THEN
                END
            ELSE
                IF SELF.DrawNode_Default(FALSE) = TRUE THEN
                END
            END                                    
            
            ! Echelon
            CASE SELF.ul.Echelon
            OF echTpy:Team
                ! Team
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
            OF echTpy:Squad
                ! Squad
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
            OF echTpy:Section
                ! Section
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
            OF echTpy:Platoon
                ! Platoon
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 7, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
            OF echTpy:Company
                ! Company
                SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 0, 4)
            OF echTpy:Battalion
                ! Battalion
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 1, SELF.ul.yPos - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 0, 4)
            OF echTpy:Regiment
                ! Regiment
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 2, SELF.ul.yPos - 6, 0, 4)
            OF echTpy:Brigade
                ! Brigade
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:Division
                ! Divion
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:Corps
                ! Corps
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:Army
                ! Army
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:ArmyGroup
                ! Army Group
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 10, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 10, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 8, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 8, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:Theater
                ! Theater
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 15, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 15, SELF.ul.yPos - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 11, SELF.ul.yPos - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 11, SELF.ul.yPos - 3, 4, -4)
            OF echTpy:Command
                ! Command
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 3, SELF.ul.yPos - 6, 0, 5)
                SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 4, 5, 0)
                
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 0, 5)
                SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 4, 5, 0)
            END
        END
        
    END
    
    SELF.drwImg.Display()
    

OrgChartC2IP.DrawNode       PROCEDURE(LONG nUnitType=0)
err1                            BOOL
err2                            BOOL
err3                            BOOL

CODE
    ! do something
    
    ! Unit Type
    CASE nUnitType
    OF uTpy:infantry
        err1 = SELF.DrawNode_Infantry()
    ELSE
        ! Default Node
        err1 = SELF.DrawNode_Default()                       
    END
    
    err2 = SELF.DrawNode_Echelon()           
    
    RETURN TRUE
    
    
    

!OrgChartC2IP.DrawNode_*.*
OrgChartC2IP.DrawNode_Default       PROCEDURE(BOOL bAutoDisplay)
nFillColor      LONG
CODE
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    ! Fill color depending on Hostility
    CASE SELF.ul.Hostility
    OF hTpy:Unknown
        ! yellow
        nFillColor  = COLOR:Unknown
    OF hTpy:AssumedFriend
        ! blue
        nFillColor  = COLOR:AssumedFriend
    OF hTpy:Friend
        ! blue
        nFillColor  = COLOR:Friend
    OF hTpY:Neutral
        ! green
        nFillColor  = COLOR:Neutral
    OF hTpy:Suspect
        ! red
        nFillColor  = COLOR:Suspect
    OF hTpy:Hostile
        ! red
        nFillColor  = COLOR:Hostile        
    ELSE
        nFillColor  = COLOR:Unknown
    END            
    
    ! Fill color depeding on Enable/Disable status for new drag&drop selections
    IF SELF.ul.markForDisbl = TRUE THEN
        ! Display as unable for newer selections
        nFillColor  = COLOR:NodeDisabled    
    END    
    SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos, 50, 30, nFillColor)
    SELF.drwImg.Show(SELF.ul.xPos + 5 + 50, SELF.ul.yPos + 11, SELF.ul.UnitName)   
    
    IF SELF.ul.IsHQ THEN
        ! Is HQ
        SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos + 30, 0, 10)
    END
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry      PROCEDURE(BOOL bAutoDisplay)
nFillColor          LONG
CODE

    SELF.DrawNode_Default(bAutoDisplay)
    SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos, 50, 30)
    SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos + 30, 50, -30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
    
OrgChartC2IP.DrawNode_Infantry_Amphibious        PROCEDURE(BOOL bAutoDisplay)
CODE
    SELF.DrawNode_Infantry(bAutoDisplay)
    
    ! inner sine function
    SELF.drwImg.Arc(SELF.ul.xPos - 5, SELF.ul.yPos + 15 + 5, 10, -10, 2700, 3599)
    SELF.drwImg.Arc(SELF.ul.xPos + 5, SELF.ul.yPos + 15 + 5, 10, -10, 0, 1800)
    SELF.drwImg.Arc(SELF.ul.xPos + 5 + 10, SELF.ul.yPos + 10, 10, 10, 1800, 3599)
    SELF.drwImg.Arc(SELF.ul.xPos + 25, SELF.ul.yPos + 15 + 5, 10, -10, 0, 1800)
    SELF.drwImg.Arc(SELF.ul.xPos + 25 + 10, SELF.ul.yPos + 10, 10, 10, 1800, 3599)
    SELF.drwImg.Arc(SELF.ul.xPos + 50 - 5, SELF.ul.yPos + 20, 10, -10, 900, 1800)
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_Armored   PROCEDURE(BOOL bAutoDisplay)    
CODE
    SELF.DrawNode_Infantry(bAutoDisplay)
    
    ! inner ellipse
    SELF.drwImg.Line(SELF.ul.xPos + 15, SELF.ul.yPos + 10, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos + 15 + 20 - 5, SELF.ul.yPos + 10, 10, 10, 2700, 900)
    SELF.drwImg.Line(SELF.ul.xPos + 15, SELF.ul.yPos + 20, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos + 5 + 5, SELF.ul.yPos + 10, 10, 10, 900, 2700)
            
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_MainGunSystem   PROCEDURE(BOOL bAutoDisplay)    
CODE
    SELF.DrawNode_Infantry(bAutoDisplay)    

    ! Left line
    SELF.drwImg.Line(SELF.ul.xPos + 8, SELF.ul.yPos, 0, 30)
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_Motorized   PROCEDURE(BOOL bAutoDisplay)    
CODE
    SELF.DrawNode_Infantry(bAutoDisplay)    
    
    ! Midle line
    SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos, 0, 30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE    
    
OrgChartC2IP.DrawNode_Infantry_FightingVehicle   PROCEDURE(BOOL bAutoDisplay)    
CODE
    SELF.DrawNode_Infantry(bAutoDisplay)    
    
    ! inner ellipse
    SELF.drwImg.Line(SELF.ul.xPos + 15, SELF.ul.yPos + 10, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos + 15 + 20 - 5, SELF.ul.yPos + 10, 10, 10, 2700, 900)
    SELF.drwImg.Line(SELF.ul.xPos + 15, SELF.ul.yPos + 20, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos + 5 + 5, SELF.ul.yPos + 10, 10, 10, 900, 2700)
    ! Left line
    SELF.drwImg.Line(SELF.ul.xPos + 8, SELF.ul.yPos, 0, 30)
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE    

    
        
!OrgChartC2IP.DrawNode_Observer
OrgChartC2IP.DrawNode_Observer      PROCEDURE(BOOL bAutoDisplay)    
nFillColor      LONG
CODE
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    ! Fill color depending on Hostility
    CASE SELF.ul.Hostility
    OF hTpy:Unknown
        ! yellow
        nFillColor  = COLOR:Unknown
    OF hTpy:AssumedFriend
        ! blue
        nFillColor  = COLOR:AssumedFriend
    OF hTpy:Friend
        ! blue
        nFillColor  = COLOR:Friend
    OF hTpY:Neutral
        ! green
        nFillColor  = COLOR:Neutral
    OF hTpy:Suspect
        ! red
        nFillColor  = COLOR:Suspect
    OF hTpy:Hostile
        ! red
        nFillColor  = COLOR:Hostile        
    ELSE
        nFillColor  = COLOR:Unknown
    END            
    
    ! Fill color depeding on Enable/Disable status for new drag&drop selections
    IF SELF.ul.markForDisbl = TRUE THEN
        ! Display as unable for newer selections
        nFillColor  = COLOR:NodeDisabled    
    END    
    SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos, 50, 30, nFillColor)
        
    SELF.drwImg.Show(SELF.ul.xPos + 5 + 50, SELF.ul.yPos + 11, SELF.ul.UnitName)
    ! inner triangle
    SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos + 15 + 2, 5, -5)
    SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos + 15 - 3, 5, 5)      
    SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos + 15 + 2, 10, 0)
    
    IF SELF.ul.IsHQ THEN
        SELF.drwImg.Line(SELF.ul.xPos, SELF.ul.yPos + 30, 0, 10)
    END
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
OrgChartC2IP.DrawNode_Echelon       PROCEDURE(BOOL bAutoDisplay)
CODE
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)        
    
    CASE SELF.ul.Echelon
    OF echTpy:Team
        ! Team
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
    OF echTpy:Squad
        ! Squad
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
    OF echTpy:Section
        ! Section
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
    OF echTpy:Platoon
        ! Platoon
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 7, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4, COLOR:Black)
    OF echTpy:Company
        ! Company
        SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 0, 4)
    OF echTpy:Battalion
        ! Battalion
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 1, SELF.ul.yPos - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 0, 4)
    OF echTpy:Regiment
        ! Regiment
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25, SELF.ul.yPos - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 2, SELF.ul.yPos - 6, 0, 4)
    OF echTpy:Brigade
        ! Brigade
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:Division
        ! Division
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:Corps
        ! Corps
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4)        
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:Army
        ! Army
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:ArmyGroup
        ! Army Group
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 10, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 10, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2 - 5, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 2, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 8, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 8, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:Theater
        !Theater
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 15, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 15, SELF.ul.yPos - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 10, SELF.ul.yPos - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 6, SELF.ul.yPos - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 11, SELF.ul.yPos - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 11, SELF.ul.yPos - 3, 4, -4)
    OF echTpy:Command
        ! Command
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 3, SELF.ul.yPos - 6, 0, 5)
        SELF.drwImg.Line(SELF.ul.xPos + 25 - 5, SELF.ul.yPos - 4, 5, 0)
                
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 3, SELF.ul.yPos - 6, 0, 5)
        SELF.drwImg.Line(SELF.ul.xPos + 25 + 1, SELF.ul.yPos - 4, 5, 0)
    END
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    
    RETURN TRUE
    
OrgChartC2IP.InsertNode     PROCEDURE
CODE
    ! do something
    
    SELF.DisplayUnselection()    
    !SELF.Redraw()
    
    SELF.tmpUnitName    = ''
    LOOP 10 TIMES
        SELF.tmpUnitName = CLIP(SELF.tmpUnitName) & CHR(RANDOM(97, 122))    
    END
    
    IF RECORDS(SELF.ul) = 0 THEN
        ! 1st records
        SELF.ul.UnitName = SELF.tmpUnitName
        SELF.ul.UnitType        = uTpy:notDefined
        SELF.ul.UnitTypeCode    = ''
        SELF.ul.Echelon     = echTpy:notDefined        
        SELF.ul.IsHQ        = FALSE
        SELF.ul.xPos = 1
        SELF.ul.yPos = 1
        SELF.ul.TreePos = 1
        SELF.ul.markForDel      = FALSE
        SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)
        
        SELF.selTreePos = 1     
        SELF.maxTreePos = 1
        SELF.selQueuePos    = 1
        
        ASSERT(SELF.DrawNode(), 'OrgChartC2IP.InsertNode()->SELF.DrawNode()')        
    ELSE
        ! inside the queue
        
        ! increment Tree Position
        SELF.selTreePos  = SELF.ul.TreePos + 1
        IF SELF.selTreePos > SELF.maxTreePos THEN
            SELF.maxTreePos = SELF.selTreePos
        END
        curentPos# = POINTER(SELF.ul)
        allPos# = RECORDS(SELF.ul)
        SELF.selQueuePos    = curentPos#
        
        ! prepare the new record
        CLEAR(SELF.urec)
        SELF.urec.TreePos   = SELF.selTreePos
        SELF.urec.UnitName  = SELF.tmpUnitName
        ! Unit Type, Echelon and  IsHQ are similare as the current ones
        SELF.urec.UnitType  = SELF.ul.UnitType
        SELF.urec.UnitTypeCode  = SELF.ul.UnitTypeCode
        SELF.urec.Echelon   = SELF.ul.Echelon
        SELF.urec.IsHQ      = SELF.ul.IsHQ
        SELF.urec.xPos      = (SELF.urec.TreePos-1)*50 + 1
        SELF.urec.yPos      = curentPos#*30 + 1
        
        ! move to temporary queue
        ! move yPos
        IF curentPos# < allPos# THEN
            ! in the middle of queue
            FREE(SELF.tmpul)       
            LOOP i# = (curentPos#+1) TO allPos#
                GET(SELF.ul, i#)
                IF NOT ERRORCODE() THEN
                    SELF.tmpul.TreePos = SELF.ul.TreePos
                    SELF.tmpul.UnitName = SELF.ul.UnitName
                    SELF.tmpul.UnitType = SELF.ul.UnitType
                    SELF.tmpul.UnitTypeCode = SELF.ul.UnitTypeCode
                    SELF.tmpul.Echelon  = SELF.ul.Echelon
                    SELF.tmpul.xPos = SELF.ul.xPos
                    SELF.tmpul.yPos = SELF.ul.yPos + 30
                    ADD(SELF.tmpul)
                END            
            END
            
            ! add empty record
            ADD(SELF.ul)        
            
            ! insert current record
            GET(SELF.ul, curentPos#+1)
            IF NOT ERRORCODE() THEN
                SELF.ul.TreePos     = SELF.urec.TreePos
                SELF.ul.UnitName    = SELF.urec.UnitName
                SELF.ul.UnitType    = SELF.urec.UnitType
                SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
                SELF.ul.Echelon     = SELF.urec.Echelon
                SELF.ul.xPos        = SELF.urec.xPos
                SELF.ul.yPos        = SELF.urec.yPos
                SELF.ul.markForDel  = FALSE
                SELF.ul.markForDisbl    = FALSE
                PUT(SELF.ul)
            END
            
            ! copy back records
            IF POINTER(SELF.tmpul)>0 THEN
                j# = 0
                LOOP i# = (curentPos#+2) TO RECORDS(SELF.ul)
                    j# = j# + 1
                    GET(SELF.ul, i#)
                    IF NOT ERRORCODE() THEN
                        GET(SELF.tmpul, j#)
                        IF NOT ERRORCODE() THEN
                            SELF.ul.TreePos     = SELF.tmpul.TreePos
                            SELF.ul.UnitName    = SELF.tmpul.UnitName
                            SELF.ul.UnitType    = SELF.tmpul.UnitType
                            SELF.ul.UnitTypeCode    = SELF.tmpul.UnitTypeCode
                            SELF.ul.Echelon     = SELF.tmpul.Echelon
                            SELF.ul.xPos        = SELF.tmpul.xPos
                            SELF.ul.yPos        = SELF.tmpul.yPos
                            SELF.ul.markForDel  = FALSE
                            SELF.ul.markForDisbl    = FALSE
                            PUT(SELF.ul)
                        END                    
                    END            
                END
            END    
            
            ! current Position
            GET(SELF.ul, curentPos# + 1)
            IF NOT ERRORCODE() THEN
                SELF.selTreePos = SELF.ul.TreePos
            END
            
        ELSE
            ! last on queue
            SELF.ul.TreePos     = SELF.urec.TreePos
            SELF.ul.UnitName    = SELF.urec.UnitName
            SELF.ul.UnitType    = SELF.urec.UnitType
            SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
            SELF.ul.Echelon     = SELF.urec.Echelon
            SELF.ul.xPos        = SELF.urec.xPos
            SELF.ul.yPos        = SELF.urec.yPos
            SELF.ul.markForDel  = FALSE
            SELF.ul.markForDisbl    = FALSE
            ADD(SELF.ul)                        
        END                

        ASSERT(SELF.DrawNode(), 'SELF.DrawNode()')        
        
        SELF.selQueuePos = POINTER(SELF.ul)      
        SELF.selTreePos = SELF.ul.TreePos
              
    END
    
    SELF.Redraw()
    
    SELF.DisplaySelection()
    
    !SELF.Redraw()
    
    
    
OrgChartC2IP.InsertNode     PROCEDURE(*UnitBasicRecord pURec)
CODE
    ! do something
    
    SELF.DisplayUnselection()        
    
    SELF.tmpUnitName    = ''
    LOOP 10 TIMES
        SELF.tmpUnitName = CLIP(SELF.tmpUnitName) & CHR(RANDOM(97, 122))    
    END
    
    IF RECORDS(SELF.ul) = 0 THEN
        ! 1st records
        SELF.ul.UnitName        = pUrec.UnitName
        SELF.ul.UnitType        = pURec.UnitType
        SELF.ul.UnitTypeCode    = pURec.UnitTypeCode
        SELF.ul.Echelon         = pUrec.Echelon
        SELF.ul.Hostility       = pUrec.Hostility
        SELF.ul.IsHQ            = pUrec.IsHQ
        SELF.ul.xPos            = 1
        SELF.ul.yPos            = 1
        SELF.ul.TreePos         = 1
        SELF.ul.markForDel      = FALSE
        SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)
        
        SELF.selTreePos = 1     
        SELF.maxTreePos = 1
        SELF.selQueuePos    = 1
        
        ASSERT(SELF.DrawNode(), 'OrgChartC2IP.InsertNode()->SELF.DrawNode()')        
    ELSE                
        
        ! inside the queue
        
        ! increment Tree Position
        SELF.selTreePos  = SELF.ul.TreePos + 1
        IF SELF.selTreePos > SELF.maxTreePos THEN
            SELF.maxTreePos = SELF.selTreePos
        END
        curentPos# = POINTER(SELF.ul)
        allPos# = RECORDS(SELF.ul)
        SELF.selQueuePos    = curentPos#
        
        ! prepare the new record
        CLEAR(SELF.urec)
        SELF.urec.TreePos       = SELF.selTreePos
        SELF.urec.UnitName      = pUrec.UnitName
        ! Unit Type, Echelon and  IsHQ are similare as the current ones
        SELF.urec.UnitType      = pUrec.UnitType
        SELF.urec.UnitTypeCode  = pUrec.UnitTypeCode
        SELF.urec.Echelon       = pUrec.Echelon
        SELF.urec.Hostility     = pUrec.Hostility
        SELF.urec.IsHQ          = pUrec.IsHQ
        SELF.urec.xPos          = (SELF.urec.TreePos-1)*50 + 1
        SELF.urec.yPos          = curentPos#*30 + 1
        
        ! move to temporary queue
        ! move yPos
        IF curentPos# < allPos# THEN
            ! in the middle of queue
            FREE(SELF.tmpul)       
            LOOP i# = (curentPos#+1) TO allPos#
                GET(SELF.ul, i#)
                IF NOT ERRORCODE() THEN
                    SELF.tmpul.TreePos      = SELF.ul.TreePos
                    SELF.tmpul.UnitName     = SELF.ul.UnitName
                    SELF.tmpul.UnitType     = SELF.ul.UnitType
                    SELF.tmpul.UnitTypeCode = SELF.ul.UnitTypeCode
                    SELF.tmpul.Echelon      = SELF.ul.Echelon
                    SELF.tmpul.Hostility    = SELF.ul.Hostility
                    SELF.tmpul.IsHQ         = SELF.ul.IsHQ
                    SELF.tmpul.xPos         = SELF.ul.xPos
                    SELF.tmpul.yPos         = SELF.ul.yPos + 30
                    ADD(SELF.tmpul)
                END            
            END
            
            ! add empty record
            ADD(SELF.ul)        
            
            ! insert current record
            GET(SELF.ul, curentPos#+1)
            IF NOT ERRORCODE() THEN
                SELF.ul.TreePos     = SELF.urec.TreePos
                SELF.ul.UnitName    = SELF.urec.UnitName
                SELF.ul.UnitType    = SELF.urec.UnitType
                SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
                SELF.ul.Echelon     = SELF.urec.Echelon
                SELF.ul.Hostility   = SELF.urec.Hostility
                SELF.ul.xPos        = SELF.urec.xPos
                SELF.ul.yPos        = SELF.urec.yPos
                SELF.ul.markForDel  = FALSE
                SELF.ul.markForDisbl    = FALSE
                PUT(SELF.ul)
            END
            
            ! copy back records
            IF POINTER(SELF.tmpul)>0 THEN
                j# = 0
                LOOP i# = (curentPos#+2) TO RECORDS(SELF.ul)
                    j# = j# + 1
                    GET(SELF.ul, i#)
                    IF NOT ERRORCODE() THEN
                        GET(SELF.tmpul, j#)
                        IF NOT ERRORCODE() THEN
                            SELF.ul.TreePos     = SELF.tmpul.TreePos
                            SELF.ul.UnitName    = SELF.tmpul.UnitName
                            SELF.ul.UnitType    = SELF.tmpul.UnitType
                            SELF.ul.UnitTypeCode    = SELF.tmpul.UnitTypeCode
                            SELF.ul.Echelon     = SELF.tmpul.Echelon
                            SELF.ul.Hostility   = SELF.tmpul.Hostility
                            SELF.ul.xPos        = SELF.tmpul.xPos
                            SELF.ul.yPos        = SELF.tmpul.yPos
                            SELF.ul.markForDel  = FALSE
                            SELF.ul.markForDisbl    = FALSE
                            PUT(SELF.ul)
                        END                    
                    END            
                END
            END    
            
            ! current Position
            GET(SELF.ul, curentPos# + 1)
            IF NOT ERRORCODE() THEN
                SELF.selTreePos = SELF.ul.TreePos
            END
            
        ELSE
            ! last on queue
            SELF.ul.TreePos     = SELF.urec.TreePos
            SELF.ul.UnitName    = SELF.urec.UnitName
            SELF.ul.UnitType    = SELF.urec.UnitType
            SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
            SELF.ul.Echelon     = SELF.urec.Echelon
            SELF.ul.Hostility   = SELF.urec.Hostility
            SELF.ul.xPos        = SELF.urec.xPos
            SELF.ul.yPos        = SELF.urec.yPos
            SELF.ul.markForDel  = FALSE
            SELF.ul.markForDisbl    = FALSE
            ADD(SELF.ul)                        
        END                

        ASSERT(SELF.DrawNode(), 'SELF.DrawNode()')        
        
        SELF.selQueuePos = POINTER(SELF.ul)      
        SELF.selTreePos = SELF.ul.TreePos        
              
    END
    
    SELF.Redraw()
    
    SELF.DisplaySelection()
    
    !SELF.Redraw()
    
    RETURN TRUE
    
    
    
OrgChartC2IP.GetNode     PROCEDURE(*UnitBasicRecord pURec)
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        pUrec.UnitName          = SELF.ul.UnitName
        pUrec.UnitType          = SELF.ul.UnitType
        pUrec.UnitTypeCode      = SELF.ul.UnitTypeCode
        pUrec.Echelon           = SELF.ul.Echelon
        pURec.Hostility         = SELF.ul.Hostility
        pUrec.IsHQ              = SELF.ul.IsHQ
        pUrec.xPos              = SELF.ul.xPos
        pUrec.yPos              = SELF.ul.yPos
        pUrec.TreePos           = SELF.ul.TreePos
        RETURN TRUE
    ELSE
        RETURN FALSE
    END    
OrgChartC2IP.DeleteNode     PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for deletion current record
        currentTreePos# = SELF.ul.TreePos
        SELF.ul.markForDel  = TRUE
        PUT(SELF.ul)
        !DELETE(SELF.ul)
        
        ! Mark for deletion all below records in deeper tree postions        
        LOOP i# = POINTER(SELF.ul)+1 TO RECORDS(SELF.ul)
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                IF SELF.ul.TreePos > currentTreePos# THEN
                    SELF.ul.markForDel  = TRUE
                    PUT(SELF.ul)                    
                ELSE
                    BREAK
                END                
            END            
        END
        
    END

    ! Remove all marked for deletion records
    i# = 1
    LOOP
        GET(SELF.ul, i#)
        IF NOT ERRORCODE() THEN
            IF SELF.ul.markForDel = TRUE THEN
                DELETE(SELF.ul)
                IF ERRORCODE() THEN
                    BREAK
                END
                i# = 1
            ELSE
                SELF.ul.yPos    = (POINTER(SELF.ul)-1)*30 + 1
                PUT(SELF.ul)
                i# = i# + 1
            END            
        ELSE
            BREAK
        END
        
    END
    
    
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    
    
OrgChartC2IP.DisableNode    PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for disableling for new drag&drop selection
        SELF.ul.markForDisbl  = TRUE
        PUT(SELF.ul)
    END
    
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    
    
OrgChartC2IP.DisplaySelection     PROCEDURE
CODE
    ! do something
    
    !SELF.Redraw()
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        !SELF.DrawNode()
        SELF.drwImg.Setpencolor(COLOR:Red)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos,50,30)
        SELF.drwImg.Show(SELF.ul.xPos + 5 + 50, SELF.ul.yPos + 11, SELF.ul.UnitName)
        SELF.drwImg.Display()
    END
    
OrgChartC2IP.DisplayUnselection     PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.drwImg.Setpencolor(COLOR:White)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos,50,30)
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        SELF.drwImg.Box(SELF.ul.xPos, SELF.ul.yPos,50,30)
        SELF.drwImg.Display()
    END
    
OrgChartC2IP.SelUp     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos>1 THEN
        SELF.DisplayUnselection()
        !SELF.Redraw()
        SELF.selQueuePos = SELF.selQueuePos-1
        SELF.DisplaySelection()
    END
    
    
OrgChartC2IP.SelDown     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos<RECORDS(SELF.ul) THEN
        SELF.DisplayUnselection()
        !SELF.Redraw()
        SELF.selQueuePos = SELF.selQueuePos+1
        SELF.DisplaySelection()
    END
    
    
OrgChartC2IP.SelLeft     PROCEDURE
CODE
    ! do something
    
    
    
    
OrgChartC2IP.SelRight     PROCEDURE
CODE
    ! do something
    
    
    
    
OrgChartC2IP.SelectByMouse     PROCEDURE(LONG nXPos, LONG nYPos)
CODE
    ! do something
    
    unitFound# = FALSE
    LOOP i# = 1 TO RECORDS(SELF.ul)
        GET(SELF.ul, i#)
        IF NOT ERRORCODE() THEN
            IF (SELF.ul.xPos < nXPos) AND (nXPos < SELF.ul.xPos + 50) THEN
                IF (SELF.ul.yPos < nYPos) AND (nYPos < SELF.ul.yPos + 30) THEN
                    ! found Unit selection
                    unitFound# = TRUE
                    SELF.DisplayUnselection()
                    SELF.selTreePos     = SELF.ul.TreePos
                    SELF.selQueuePos    = i#
                    SELF.DisplaySelection()
                    BREAK
                END                
            END            
        END
    END
    
    RETURN unitFound#
    
    
    
    
    
OrgChartC2IP.Unselect     PROCEDURE()
CODE
    ! do something
    
    SELF.DisplayUnselection()
    
    RETURN TRUE
    
    
    
    
    
OrgChartC2IP.Destruct     PROCEDURE
CODE
    ! do something
    
    DISPOSE(SELF.refC2IPs)
    
    DISPOSE(SELF.tmpul)
    DISPOSE(SELF.ul)
    
OrgChartC2IP.GetUnitName     PROCEDURE
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        RETURN SELF.ul.UnitName
    ELSE
        RETURN ''
    END    
    
OrgChartC2IP.SetUnitName     PROCEDURE(STRING sUnitName)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.ul.UnitName    = sUnitName
        PUT(SELF.ul)
            SELF.Redraw()
            SELF.DisplaySelection()          
        IF NOT ERRORCODE() THEN
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.GetUnitType     PROCEDURE
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        RETURN SELF.ul.UnitType
    ELSE
        RETURN ''
    END    
    
OrgChartC2IP.SetUnitType     PROCEDURE(LONG nUnitType)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.ul.UnitType    = nUnitType        
        PUT(SELF.ul)
            SELF.Redraw()
            SELF.DisplaySelection()
        IF NOT ERRORCODE() THEN
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.SetUnitTypeCode     PROCEDURE(STRING sUnitTypeCode)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        !SELF.ul.UnitType    = nUnitType  
        SELF.ul.UnitTypeCode    = sUnitTypeCode
        PUT(SELF.ul)
            SELF.Redraw()
            SELF.DisplaySelection()
        IF NOT ERRORCODE() THEN
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.GetEchelon     PROCEDURE
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        RETURN SELF.ul.Echelon
    ELSE
        RETURN 0
    END    
    
OrgChartC2IP.SetEchelon     PROCEDURE(LONG nEchelon)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.ul.Echelon    = nEchelon
        PUT(SELF.ul)
        SELF.Redraw()
        SELF.DisplaySelection()
        IF NOT ERRORCODE() THEN
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.GetHostility     PROCEDURE
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        RETURN SELF.ul.Hostility
    ELSE
        RETURN 0
    END    
    
OrgChartC2IP.SetHostility     PROCEDURE(LONG nHostility)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.ul.Hostility    = nHostility
        PUT(SELF.ul)
        SELF.Redraw()
        SELF.DisplaySelection()
        IF NOT ERRORCODE() THEN
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.GetHQ     PROCEDURE
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        RETURN SELF.ul.IsHQ
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.SetHQ     PROCEDURE(BOOL bIsHQ)
CODE
    ! do something
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        SELF.ul.IsHQ    = bIsHQ
        PUT(SELF.ul)
        SELF.Redraw()
        SELF.DisplaySelection()
        IF NOT ERRORCODE() THEN
            RETURN SELF.ul.IsHQ            
        ELSE
            RETURN FALSE            
        END
        
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.Save     PROCEDURE()
CODE
    ! do something
    json.Start()
    !collection &= json.CreateCollection('Collection')
    !collection.Append(
    !json.Add('C2IPName', SELF.Name)
    collection &= json.CreateCollection('TaskOrg')
    collection.Append('C2IPName', SELF.Name, json:String)
    collection.Append(SELF.ul, 'Units')
    
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
    collection.Append(SELF.ul, 'Units')
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
    json.SaveFile(sFileName, TRUE)
    
    RETURN TRUE
    
OrgChartC2IP.Load   PROCEDURE(STRING sFileName)
jsonItem  &JSONClass
CODE
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
        FREE(SELF.ul)
        jsonItem.Load(SELF.ul)
    END  
    
    ! refrenced C2IPs
    jsonItem &= json.GetByName('refC2IPs')
    IF NOT jsonItem &= NULL THEN
        FREE(SELF.refC2IPs)
        jsonItem.Load(SELF.refC2IPs)
    END
    
    
    SELF.Redraw()
    
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
    
    CASE nKeyCode
    OF MouseLeft2
        !SELF.checkLabelEditMode()
        !SELF.SelectByMouse(DrwTaskOrg.MouseX, DrwTaskOrg.MouseY)
    END
    
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
        CREATE(?uNameEntry, CREATE:entry)
        SELF.uNameEntry = ''
        ?uNameEntry{PROP:use} = SELF.uNameEntry
        ?uNameEntry{PROP:text} = '@s100'
        ?uNameEntry{PROP:Xpos} = 30
        ?uNameEntry{PROP:Ypos} = 200
        !?uNameEntry{PROP:
        UNHIDE(?uNameEntry)
        SELECT(?uNameEntry)
    OF 2
        ! Unit Type        
        UNHIDE(?ListSymbology)
        SELECT(?ListSymbology)
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
        CREATE(?uHQ, CREATE:check)
        ?uHQ{PROP:Use} = SELF.bIsHQEntry
        ?uHQ{PROP:TrueValue} = TRUE
        ?uHQ{PROP:FalseValue} = FALSE
        ?uHQ{PROP:XPos} = 30
        ?uHQ{PROP:Ypos} = 200
        UNHIDE(?uHQ)
        SELECT(?uHQ)
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
    
    
    
    
        


