

  MEMBER('learnMil')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 16.01.2019
 * Time: 19:57
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

! Local objects

! JSON objects
json                CLASS(JSONClass)
reference           &UnitsList
!AddByReference          PROCEDURE (StringTheory pName,JSONClass pJson),VIRTUAL
AddByReference          PROCEDURE (StringTheory pName,JSONClass pJson)

Construct               PROCEDURE()
Destruct                PROCEDURE(), VIRTUAL
                    END
        
collection          &JSONClass
subItem             &JSONClass

ActionsJSON             CLASS(JSONClass)
!AssignValue     PROCEDURE (JSONClass pJson,StringTheory pName,|
!                            *Group pGroup,*Long pIndex,Long pColumnOffset),VIRTUAL
                        END

! string theory objects
sst                 stringtheory


json.Construct      PROCEDURE
    CODE
        PARENT.Construct
        self.reference  &= NEW(UnitsList)
        
        
json.Destruct       PROCEDURE
    CODE
        DISPOSE(self.reference)
        PARENT.Destruct()               
                                

OverlayC2IP.SelectByMouse   PROCEDURE(LONG nXPos, LONG nYPos)    
    CODE
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
            
            !SELF.selTreePos     = SELF.ul.TreePos()
            !SELF.selQueuePos    = SELF.ul.Pointer()
            SELF.DisplaySelection()
        ELSE
            SELF.DisplaySelection()
        END
                    
        IF nodeFoundPos# > 0 THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END            
        
    
OverlayC2IP.MoveTo  PROCEDURE(LONG nXPos, LONG nYPos)            
    CODE
        PARENT.MoveTo(nXPos, nYPos)
        SELF.Redraw()
        RETURN TRUE


OverlayC2IP.Construct       PROCEDURE()
    CODE
        PARENT.Construct()  
        SELF.PolyPoints = 0    
        SELF.pp     &= NEW(PosList)
        SELF.al &= NEW(ActionsCollection)
                   
        
OverlayC2IP.Destruct        PROCEDURE()
    CODE        
        DISPOSE(SELF.pp)
        DISPOSE(SELF.al)
        PARENT.Destruct()
        
        
OverlayC2IP.Redraw  PROCEDURE()
    CODE
        
        PARENT.Redraw()
                
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        
        
        
        ! background map
        IF LEN(CLIP(SELF.map)) > 0 THEN
            SELF.drwImg.Image(1, 1, , , SELF.map)
        END
        
        
        ! draw Units
        !MESSAGE('units = ' & RECORDS(SELF.ul.ul))
        LOOP i# = 1 TO RECORDS(SELF.ul.ul)
            GET(SELF.ul.ul, i#)
            IF NOT ERRORCODE() THEN
                ! Draw Main Symbol
                SELF.DrawNode_MainSymbol()
                ! Draw Echelon
                SELF.DrawNode_Echelon()
                ! Draw HQ
                SELF.DrawNode_HQ()
            END
        END
        
        ! draw actions
        !MESSAGE('actions = ' & RECORDS(SELF.al.al))
        LOOP i# = 1 TO RECORDS(SELF.al.al)
            GET(SELF.al.al, i#)
            IF NOT ERRORCODE() THEN
                ! draw action
                SELF.DrawAction()
            END
            
        END
        
 
        SELF.drwImg.Display()
        
        !MESSAGE('Finish Overlay Redraw')

        
        
OverlayC2IP.DeployBSO       PROCEDURE(*UnitBasicRecord pUrec, LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OverlayC2IP.DeployBSO')
        sst.Trace('nXPos = ' & nXPos & ', nYPos = ' & nYPos)
        pUrec.xPos  = nXPos
        pUrec.yPos  = nYPos
        
        errCode#    = SELF.ul.AddNode(pUrec)
        IF errCode# = TRUE THEN
            SELF.Redraw()
            SELF.DisplaySelection()
        END
        
        sst.Trace('END:OverlayC2IP.DeployBSO')
        RETURN TRUE
        
OverlayC2IP.AttachC2IP      PROCEDURE(STRING sFileName)
jsonItem        &JSONClass
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
    
    
OverlayC2IP.AttachMap       PROCEDURE(STRING sFileName)
    CODE
        SELF.map    = sFileName
        !SELF.drwImg.Image(1, 1, , , sFileName)
        SELF.Redraw()        
        RETURN TRUE
    
    

        
        
OverlayC2IP.TakeNodeAction   PROCEDURE(LONG nOption)
startPos                            GROUP(PosRecord)
                                    END

endPos                              GROUP(PosRecord)
                                    END
CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Advance to contact
        SELF.geometry           = g:AxisAdvance
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE        
    OF 2
        ! Ambush
        SELF.geometry           = g:Ambush
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 3
        ! Arrest
        SELF.geometry           = g:Circle
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 4
        ! Attack
        SELF.geometry           = g:AxisAdvance
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 5        
        ! Attack By Fire
        SELF.geometry           = g:LineWithBase
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 6
        ! Block
    OF 7
        ! Breach
    OF 8
        ! Bypass
    OF 9
        ! Canalize
    OF 10
        ! Capture
    OF 11
        ! Clear
    OF 12
        ! Contain
    OF 13
        ! Control
    OF 14
        ! Counterattack
    OF 15
        ! Counterattack By Fire
    OF 16
        ! Cover
    OF 17
        ! Conduct Deception
    OF 18
        ! Delay
    OF 19
        ! Demonstrate
    OF 20
        ! Deny
    OF 21
        ! Disengage
    OF 22
        ! Disrupt
    OF 23
        ! Envelop
    OF 24
        ! Escort
    OF 25
        ! Exfiltrate
    OF 26
        ! Conduct Exploitation
    OF 27
        ! Feint
    OF 28
        ! Fix
    OF 29
        ! Follow and Assume
    OF 30
        ! Follow and Support
    OF 31
        ! Guard
    OF 32
        ! Infiltrate
    OF 33
        ! Interdict
    OF 34
        ! Isolate
    OF 35
        ! Locate
    OF 36
        ! Neutralize
    OF 37
        ! Occupy
    OF 38
        ! Penetrate
    OF 39
        ! Pursue
    OF 40
        ! Recover
    OF 41
        ! Relief In Place
    OF 42
        ! Retain
    OF 43
        ! Retire
    OF 44
        ! Screen
    OF 45
        ! Secure
    OF 46
        ! Seize
    OF 47
        ! Support By Fire
    OF 48
        ! Suppress
    OF 49
        ! Turn
    OF 50
        ! Withdraw
    OF 51
        ! Withdraw Under Pressure
                        
    END
    
    RETURN TRUE        
    
OverlayC2IP.NodeActionsMenuOptions  PROCEDURE()
actMenuOpt          STRING(1000)
CODE
    ! do something  
    actMenuOpt  = 'Advance To Contact'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Ambush'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Arrest'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Attack'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Attack By Fire'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Block'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Breach'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Bypass'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Canalize'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Capture'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Clear'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Contain'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Control'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Counterattack'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Counterattack By Fire'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Cover'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Conduct Deception'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Delay'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Demonstrate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Deny'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Disengage'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Disrupt'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Envelop'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Escort'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Exfiltrate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Conduct Exploitation'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Feint'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Fix'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Follow and Assume'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Follow and Support'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Guard'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Infiltrate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Interdict'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Isolate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Locate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Neutralize'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Occupy'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Penetrate'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Pursue'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Recover'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Relief In Place'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Retain'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Retire'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Screen'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Secure'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Seize'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Support By Fire'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Suppress'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Turn'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Withdraw'
    actMenuOpt  = CLIP(actMenuOpt) & '| ' & 'Withdraw Under Pressure'
                
    RETURN actMenuOpt
    
OverlayC2IP.DA_SupportingAttack     PROCEDURE(PosRecord startPos, PosRecord endPos)
    CODE
        dX#   = endPos.xPos - startPos.xPos
        dY#    = endPos.yPos - startPos.yPos
        i#     = SQRT(dX#*dX# + dY#*dY#)
        
        SELF.drwImg.Line(startPos.xPos, startPos.yPos, dX#, dY#)
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, -(0.15*i#), -(0.15*i#))
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, -(0.15*i#), +(0.15*i#))
        !SELF.drwImg.Display()
        !MESSAGE('DA_SupportingAttack')
        
OverlayC2IP.DA_AxisOfAdvance        PROCEDURE(PosRecord startPos, PosRecord endPos)
    CODE
        SELF.drwImg.Line(startPos.xPos, startPos.yPos, endPos.xPos - startPos.xPos, endPos.yPos - startPos.yPos)
                
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        L#  = SQRT(dx#*dx# + dy#*dy#)
        wdth#  = 20
        
        lx# = dy#*wdth#/L#
        ly# = dx#*wdth#/L#
        
        SELF.drwImg.Line(startPos.xPos - lx#, startPos.yPos + ly#, dx#, dy#)
        SELF.drwImg.Line(startPos.xPos + lx#, startPos.yPos - ly#, dx#, dy#)
        
        llx#    = dy#*2*wdth#/L#
        lly#    = dx#*2*wdth#/L#
        
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, -llx#, lly#)
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, llx#, -lly#)
        
        hght#   = 20
        
        hx#     = hght#*dx#/L#
        hy#     = hght#*dy#/L#
        
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, hx#, hy#)
                        
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()             
        
        
!OverlayC2IP.DA_AxisOfAdvance        PROCEDURE(PosRecord startPos, PostRecord endPos)
!    CODE        
!        SELF.drwImg.Line(startPos.xPos, startPos.yPos, endPos.xPos - startPos.xPos, endPos.yPos - startPos.yPos)
!        
!        
!        dx# = endPos.xPos - startPos.xPos
!        dy# = endPos.yPos - startPos.yPos
!        L#  = SQRT(dx#*dx# + dy#*dy#)
!        wdth#  = 20
!        
!        lx# = dy#*wdth#/L#
!        ly# = dx#*wdth#/L#
!        
!        SELF.drwImg.Line(startPos.xPos - lx#, startPos.yPos + ly#, dx#, dy#)
!        SELF.drwImg.Line(startPos.xPos + lx#, startPos.yPos - ly#, dx#, dy#)
!        
!        llx#    = dy#*2*wdth#/L#
!        lly#    = dx#*2*wdth#/L#
!        
!        SELF.drwImg.Line(endPos.xPos, endPos.yPos, -llx#, lly#)
!        SELF.drwImg.Line(endPos.xPos, endPos.yPos, llx#, -lly#)
!        
!        hght#   = 20
!        
!        hx#     = hght#*dx#/L#
!        hy#     = hght#*dy#/L#
!        
!        SELF.drwImg.Line(endPos.xPos, endPos.yPos, hx#, hy#)
!                        
!        SELF.drwImg.SetPenStyle(PEN:solid)
!        SELF.drwImg.Display()     
        
    
OverlayC2IP.TakePoints      PROCEDURE(PosRecord startPos, PosRecord endPos)    
    CODE
        startPos.xPos   = SELF.ul.xPos()
        startPos.yPos   = SELF.ul.yPos()
        endPos.xPos     = startPos.xPos + 50
        endPos.yPos     = startPos.yPos - 30



OverlayC2IP.InsertAction    PROCEDURE()
actionRec                       GROUP(ActionBasicRecord)
                                END

    CODE
        !actionRec   &= NEW(ActionBasicRecord)
        CASE SELF.geometry
        OF g:Point
        OF g:Line
        OF g:FreeLine
        OF g:AxisAdvance
            actionRec.ActionName    = 'bla bla bla'
            actionRec.ActionType    = 0
            actionRec.ActionTypeCode        = aTpy:AxisOfAdvance_SupportingAttack
            actionRec.ActionPointsNumber    = 2
            actionRec.xPos[1]               = SELF.p1x
            actionRec.yPos[1]               = SELF.p1y
            actionRec.xPos[2]               = SELF.drwImg.MouseX()
            actionRec.yPos[2]               = SELF.drwImg.MouseY()
            !MESSAGE('inainte de call')
            SELF.al.InsertAction(actionRec)
        END        
        SELF.Redraw()
        !DISPOSE(actionRec)
        
OverlayC2IP.TakeEvent       PROCEDURE()
    CODE
        !PARENT.TakeEvent()
        
        CASE EVENT()
        OF EVENT:MouseDown
            ! mouse down
            
            ! check if it is a new selection on the Overlay                
            IF SELF.SelectByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY()) = TRUE THEN
                SELF.isSelection    = TRUE
            END
            
            ! check if it is about to collect points for Action drawing
            IF SELF.isPointsCollection = TRUE THEN
                IF SELF.isMouseDown = FALSE THEN
                    ! collect points
                    SELF.p1x    = SELF.drwImg.MouseX()
                    SELF.p1y    = SELF.drwImg.MouseY()            
                    
                    SELF.isMouseDown    = TRUE
                ELSE
                    ! nothing
                END
                
                
            END                                                

        OF EVENT:MouseMove
            ! mouse move
            IF SELF.isPointsCollection = TRUE THEN
                IF SELF.isMouseDown = TRUE THEN
                    ! previewing = TRUE
                    CASE SELF.geometry
                    OF g:Point
                        ! Point                    
                    OF g:Line
                        ! Line
                        SELF.Preview_Line(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                        !SELF.PreviewArrow(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                    OF g:FreeLine                    
                        SELF.Preview_FreeLine(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                    OF g:AxisAdvance
                        ! Axis of Advance
                        SELF.Draw_AxisAdvance(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)                    
                    OF g:Ambush
                        ! Ambush style
                        SELF.Draw_Ambush(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)
                    OF g:Circle
                        ! Circle style
                        SELF.Draw_Circle(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)                        
                    OF g:LineWithBase
                        ! Line With Base style
                        SELF.Draw_LineWithBase(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)
                    END
                ELSE
                    ! nothing
                END                                                
            ELSE
                ! nothing
            END                                                                                    
        OF EVENT:MouseUp
            ! mouse up     
            IF SELF.isPointsCollection = TRUE THEN
                IF SELF.isMouseDown = TRUE THEN                    
                    ! points collected
                    ! draw final version; previewing = FALSE
                    CASE SELF.geometry
                    OF g:Point
                        ! finalize point
                    OF g:Line
                        ! final line
                    OF g:FreeLine                    
                        ! final dree line
                    OF g:AxisAdvance
                        ! Axis of Advance
                        SELF.Draw_AxisAdvance(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)
                        SELF.InsertAction()
                    OF g:Ambush
                        ! Ambush style
                        SELF.Draw_Ambush(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)                        
                    OF g:Circle
                        ! Circle style
                        SELF.Draw_Circle(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)     
                    OF g:LineWithBase
                        ! Line With Base style
                        SELF.Draw_LineWithBase(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)
                    END
                    SELF.isPointsCollection = FALSE                
                ELSE
                    ! noting
                END
            ELSE
                ! nothing
            END                    
            
        OF EVENT:Drop
            ! DROP
        END
        
OverlayC2IP.TakePoints     PROCEDURE(LONG nGeometry)
    CODE
        SELF.geometry           = nGeometry                   
        
OverlayC2IP.Preview_Line    PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        SELF.drwImg.Blank(COLOR:White)
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, (nXPos - SELF.p1x), (nYPos - SELF.p1y))
        SELF.drwImg.Display()
        
OverlayC2IP.Preview_Arrow   PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        SELF.drwImg.Blank(COLOR:White)
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, (nXPos - SELF.p1x), (nYPos - SELF.p1y))
        dX# = nXPos - SELF.p1x
        dY# = nYPos - SELF.p1y
        i#  = SQRT(dX#*dX# + dY#*dY#)
        SELF.drwImg.Line(nXPos, nYPos, -0.2*i#, -0.2*i#)
        SELF.drwImg.Line(nXPos, nYPos, 0.2*i#, 0.2*i#)
        SELF.drwImg.Display()
        
OverlayC2IP.Preview_FreeLine        PROCEDURE(LONG nXPos, LONG nYPos)
    CODE                
        IF SELF.PolyPoints = 0 THEN
            SELF.pp.xPos    = SELF.p1x
            SELF.pp.yPos    = SELF.p1y
            ADD(SELF.pp)
            SELF.PolyPoints +=  1            
        END        
        
        dx# = nXPos - SELF.pp.xPos
        dy# = nYPos - SELF.pp.yPos
        SELF.drwImg.Line(SELF.pp.xPos, SELF.pp.yPos, dx#, dy#)
                
        SELF.pp.xPos    = nXPos
        SELF.pp.yPos    = nYPos
        ADD(SELF.pp)      
        SELF.PolyPoints +=  1
        
        SELF.drwImg.Display()
        
OverlayC2IP.Draw_AxisAdvance   PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
    CODE
        SELF.drwImg.Blank(COLOR:White)
        IF bPreview = TRUE THEN            
            SELF.drwImg.SetPenStyle(PEN:dash)
        ELSE
            SELF.drwImg.SetPenStyle(PEN:solid)            
        END        
        
        ! median line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, (nXPos - SELF.p1x), (nYPos - SELF.p1y))
        
        
        dx# = nXPos - SELF.p1x
        dy# = nYPos - SELF.p1y
        L#  = SQRT(dx#*dx# + dy#*dy#)
        wdth#  = 20
        
        lx# = dy#*wdth#/L#
        ly# = dx#*wdth#/L#
        
        ! corridor lines
        SELF.drwImg.Line(SELF.p1x - lx#, SELF.p1y + ly#, dx#, dy#)
        SELF.drwImg.Line(SELF.p1x + lx#, SELF.p1y - ly#, dx#, dy#)
        
        llx#    = dy#*2*wdth#/L#
        lly#    = dx#*2*wdth#/L#
        
        ! small arrow lateral lines
        SELF.drwImg.Line(nXPos, nYPos, -llx#, lly#)
        SELF.drwImg.Line(nXPos, nYPos, llx#, -lly#)
        
        hght#   = 20
        
        hx#     = hght#*dx#/L#
        hy#     = hght#*dy#/L#
        
        ! arrow line
        SELF.drwImg.Line(nXPos, nYPos, hx#, hy#)
        
        ! arrow lines
        !SELF.drwImg.Line(SELF.p1x - lx# + dx#, SELF.p1y + ly# + dy#, ABS(llx# + hx#), ABS(lly# - hy#))
        SELF.drwImg.Line(nXPos - ABS(llx#), nYPos - ABS(lly#), ABS(llx#) + ABS(hx#), ABS(ABS(lly#) - ABS(hy#)))
        !SELF.drwImg.Line(nXPos + llx#, nYPos + lly#, -ABS(llx# - hx#), -ABS(lly# - hy#)) 
        
        
        
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()     
        !MESSAGE('am desenat Draw_AxisAdvance')
        
OverlayC2IP.Draw_Ambush     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
    CODE
        SELF.drwImg.Blank(COLOR:White)
        IF bPreview = TRUE THEN            
            SELF.drwImg.SetPenStyle(PEN:dash)
        ELSE
            SELF.drwImg.SetPenStyle(PEN:solid)            
        END        
        
        ! median line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, (nXPos - SELF.p1x), (nYPos - SELF.p1y))
        
        ! arrow cup
        
        ! base arc
        SELF.drwImg.Arc(SELF.p1x - 10, SELF.p1y - 10, 10, 10, 0, 90)
        SELF.drwImg.Arc(SELF.p1x, SELF.p1y, 10, 10, 0, 90)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
    SELF.drwImg.Display()     


OverlayC2IP.Draw_Circle     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
    CODE
        SELF.drwImg.Blank(COLOR:White)
        IF bPreview = TRUE THEN            
            SELF.drwImg.SetPenStyle(PEN:dash)
        ELSE
            SELF.drwImg.SetPenStyle(PEN:solid)            
        END      
        
        dx# = nXPos - SELF.p1x
        dy# = nYPos - SELF.p1y
        
        ! circle
        SELF.drwImg.Arc(SELF.p1x -dx#/2, SELF.p1y -dy#/2, dx#, dy#, 0, 3599)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()     
        
OverlayC2IP.Draw_LineWithBase     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
    CODE
        SELF.drwImg.Blank(COLOR:White)
        IF bPreview = TRUE THEN            
            SELF.drwImg.SetPenStyle(PEN:dash)
        ELSE
            SELF.drwImg.SetPenStyle(PEN:solid)            
        END      
        
        dx# = nXPos - SELF.p1x
        dy# = nYPos - SELF.p1y
        L#  = SQRT(dx#*dx# + dy#*dy#)
        wdth#  = 20
        
        lx# = dy#*wdth#/L#
        ly# = dx#*wdth#/L#
        
        ! circle
        SELF.drwImg.Line(SELF.p1x - lx#, SELF.p1y - ly#, 2*lx#, 2*ly#)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()             
        
OverlayC2IP.DrawAction      PROCEDURE()
startPos                        GROUP(PosRecord)
                                END
endPos                          GROUP(PosRecord)
                                END

    CODE
        CASE CLIP(SELF.al.al.ActionTypeCode)
        OF '151404'
            ! Axis Of Advance / Supporting Attack
            !MESSAGE('Axis Of Advance / Supporting Attack')
            !SELF.DrawAction_SupportingAttack()
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]
            !SELF.DA_SupportingAttack(startPos, endPos)
            SELF.DA_AxisOfAdvance(startPos, endPos)
        END
        
OverlayC2IP.Save    PROCEDURE(STRING sFileName)
arec                    GROUP(ActionBasicRecord)
                        END

CODE
    ! do something
    json.Start()
    collection &= json.CreateCollection('Overlay')
    
    ! C2IP Name
    collection.Append('C2IPName', SELF.Name, json:String)
    
    ! Units
    collection.Append(SELF.ul.ul, 'Units')
    
    ! Actions
    collection.Append(SELF.al.al, 'Actions')
    !json.reference  = SELF.al.al.Resources
    !json.SetColumnType('Resources',jf:Reference)
    
    subItem &= collection.Append('Resources')
    subItem.Append(SELF.al.al.Resources)
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
    json.SaveFile(sFileName, TRUE)
    
    RETURN TRUE        
    
json.AddByReference PROCEDURE (StringTheory pName,JSONClass pJson)
  CODE
  case pName.GetValue()
  of 'Resources'
    pJson.Add(self.reference)
  end
  !PARENT.AddByReference (pName,pJson)    
    
    
OverlayC2IP.Load   PROCEDURE(STRING sFileName)
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
        !IF SELF.ul.Free() = TRUE THEN
        !END
        
        FREE(SELF.ul.ul)
        jsonItem.Load(SELF.ul.ul)
    END  
    
    ! Actions
    jsonItem &= json.GetByName('Actions')
    IF NOT jsonItem &= NULL THEN
        FREE(SELF.al.al)
        jsonItem.Load(SELF.al.al)
    END  
    
    ! refrenced C2IPs
    jsonItem &= json.GetByName('refC2IPs')
    IF NOT jsonItem &= NULL THEN
        FREE(SELF.refC2IPs)
        jsonItem.Load(SELF.refC2IPs)
    END
    
    
    SELF.Redraw()
    
    RETURN TRUE    