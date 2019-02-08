

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
json                JSONClass
collection          &JSONClass

! string theory objects
sst                 stringtheory

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
        ! Supporting Attack
        SELF.geometry           = g:AxisAdvance
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
        
        !SELF.TakePoints(startPos, endPos)       
        !startPos.xPos   = SELF.ul.xPos()
        !startPos.yPos   = SELF.ul.yPos()
        !endPos.xPos     = SELF.drwImg.MouseY()
        !endPos.yPos     = SELF.drwImg.MouseY()       
        !SELF.DA_SupportingAttack(startPos, endPos)        
        !SELF.TakePoints(g:AxisAdvance)
    END
    
    RETURN TRUE    
    
    
    
    
OverlayC2IP.NodeActionsMenuOptions   PROCEDURE()
CODE
    ! do something    
    RETURN 'Supporting Attack'        
    
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
        SELF.drwImg.Line(nXPos - llx#, nYPos - lly#, llx# + hx#, lly# - hy#)
        SELF.drwImg.Line(nXPos + llx#, nYPos + lly#, ABS(hx# - llx#), ABS(hy# - lly#)) 
        
        
        
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()     
        !MESSAGE('am desenat Draw_AxisAdvance')
        
        
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
        
        