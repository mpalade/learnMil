

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
        IF PARENT.SelectByMouse(nXPos, nYPos) = TRUE THEN
            ! BSO found
        END
        
            
        !MESSAGE('verify the Actions')
        
        ! verify the Actions
        actionFoundPos# = SELF.al.CheckByMouse(nXPos, nYPos)
        !MESSAGE('actionFoundPos# = ' & actionFoundPos#)
        IF actionFoundPos# > 0 THEN
            !MESSAGE('found Action = ' & actionFoundPos#)
            SELF.DisplaySelection(actionFoundPos#)
        END
                    
        IF actionFoundPos# > 0 THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END            

OverlayC2IP.SelectDrawingByMouse    PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        actionFoundPos# = SELF.al.CheckByMouse(nXPos, nYPos)
        !MESSAGE('actionFoundPos# = ' & actionFoundPos#)
        IF actionFoundPos# > 0 THEN
            !MESSAGE('found Action = ' & actionFoundPos#)
            SELF.DisplaySelection(actionFoundPos#)
        END
        
        
OverlayC2IP.CheckByMouse   PROCEDURE(LONG nXPos, LONG nYPos)    
    CODE        
        RETURN PARENT.CheckByMouse(nXPos, nYPos)
        
OverlayC2IP.CheckDrawingByMouse     PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        RETURN SELF.al.CheckByMouse(nXPos, nYPos)
        
    
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
        
        SELF.isDrawingSelection = FALSE
                   
        
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
    
    


OverlayC2IP.SetGeometry     PROCEDURE(LONG nGeometry)
    CODE
        SELF.geometry   = nGeometry
        
        RETURN TRUE

OverlayC2IP.SetActionTypeCode       PROCEDURE(STRING sActionTypeCode)
    CODE
        SELF.actionTypeCode = CLIP(sActionTypeCode)
        
    RETURN TRUE

OverlayC2IP.SetAction       PROCEDURE(STRING sActionTypeCode, LONG nGeometry)
    CODE
        SELF.actionTypeCode = CLIP(sActionTypeCode)
        SELF.geometry       = nGeometry
        
        SELF.isDrawingSelection = TRUE
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
        
    RETURN TRUE

                                        
        
        
OverlayC2IP.TakeNodeAction   PROCEDURE(LONG nOption)
startPos                            GROUP(PosRecord)
                                    END

endPos                              GROUP(PosRecord)
                                    END
CODE
    ! do something
    
    SELF.isDrawingSelection     = FALSE
    
    CASE nOption
    OF 1
        ! Advance to contact
        SELF.actionTypeCode     = aTpy:AdvanceToContact
             
        SELF.geometry           = g:AxisAdvance
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE        
    OF 2
        ! Ambush
        SELF.actionTypeCode     = aTpy:Ambush
        SELF.geometry           = g:Ambush
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 3
        ! Arrest
        SELF.actionTypeCode     = aTpy:CAI_Arrest
        SELF.geometry           = g:Circle
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 4
        ! Attack
        SELF.actionTypeCode     = aTpy:AxisOfAdvance_SupportingAttack
        SELF.geometry           = g:AxisAdvance
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 5        
        ! Attack By Fire
        SELF.actionTypeCode     = aTpy:AttackByFirePosition
        SELF.geometry           = g:LineWithBase
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 6
        ! Block
        SELF.actionTypeCode     = aTpy:Block
        SELF.geometry           = g:LineWithHeader
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
    OF 7
        ! Breach
        SELF.actionTypeCode     = aTpy:Breach
        SELF.geometry           = g:Breach
        SELF.isPointsCollection = TRUE
        SELF.isMouseDown        = FALSE
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


OverlayC2IP.DA_Ambush       PROCEDURE(PosRecord startPos, PosRecord endPos)        
    CODE
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        
        ! median line
        SELF.drwImg.Line(startPos.xPos, startPos.yPos, dx#, dy#)
        
        ! arrow cup
        
        ! base arc
        SELF.drwImg.Arc(startPos.xPos - 10, startPos.yPos - 10, 10, 10, 0, 90)
        SELF.drwImg.Arc(startPos.xPos, startPos.yPos, 10, 10, 0, 90)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()     

OverlayC2IP.DA_Arrest       PROCEDURE(PosRecord startPos, PosRecord endPos)        
    CODE        
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        
        ! circle
        SELF.drwImg.Arc(startPos.xPos -dx#/2, startPos.yPos -dy#/2, dx#, dy#, 0, 3599)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()     
        
                                

OverlayC2IP.DA_Block        PROCEDURE(PosRecord startPos, PosRecord endPos)        
    CODE
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        L#  = SQRT(dx#*dx# + dy#*dy#)
        wdth#  = 20
        
        lx# = dy#*wdth#/L#
        ly# = dx#*wdth#/L#
        
        ! median line
        SELF.drwImg.Line(startPos.xPos, startPos.yPos, dx#, dy#)
        
        ! small header line
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, -lx#, -ly#)
        SELF.drwImg.Line(endPos.xPos, endPos.yPos, lx#, ly#)      
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()
        
OverlayC2IP.DA_Breach   PROCEDURE(PosRecord startPos, PosRecord endPos)
    CODE        
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        L#  = SQRT(dx#*dx# + dy#*dy#)
        wdth#  = 20
        
        lx# = dy#*wdth#/L#
        ly# = dx#*wdth#/L#        
        
        ! main symbol
        ! corridor lines
        SELF.drwImg.Line(startPos.xPos - lx#, startPos.yPos + ly#, dx#, dy#)
        SELF.drwImg.Line(startPos.xPos + lx#, startPos.yPos - ly#, dx#, dy#)    
        ! base line
        SELF.drwImg.Line(startPos.xPos - lx#, startPos.yPos + ly#, ABS(2*lx#), ABS(2*ly#))
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()
        
    
OverlayC2IP.TakePoints      PROCEDURE(PosRecord startPos, PosRecord endPos)    
    CODE
        startPos.xPos   = SELF.ul.xPos()
        startPos.yPos   = SELF.ul.yPos()
        endPos.xPos     = startPos.xPos + 50
        endPos.yPos     = startPos.yPos - 30



OverlayC2IP.InsertAction    PROCEDURE()
actionRec                       GROUP(ActionBasicRecord)
                                END

selBSO                                  GROUP(UnitBasicRecord)
                                        END

    CODE   
        ASSERT(SELF.ul.GetNode(selBSO), 'UnitsCollection.GetNode() error')
        !MESSAGE('Unit Name = ' & selBSO.UnitName)
        
        CASE CLIP(SELF.actionTypeCode)
            OF aTpy:notDefined
                ! not Defined
                actionRec.ActionName    = 'aTpy:notDefined'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:notDefined
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
            
            OF aTpy:AdvanceToContact
                ! Advance to contact
                
            OF aTpy:Ambush
                ! Ambush
                actionRec.ActionName    = 'aTpy:Ambush'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:Ambush
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
                !SELF.al.InsertAction(actionRec)
                
            OF aTpy:CAI_Arrest
                ! Arrest
                actionRec.ActionName    = 'aTpy:CAI_Arrest'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:CAI_Arrest
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
                !SELF.al.InsertAction(actionRec)
                
            OF aTpy:AxisOfAdvance_SupportingAttack
                ! Attack
                actionRec.ActionName    = 'aTpy:AxisOfAdvance_SupportingAttack'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:AxisOfAdvance_SupportingAttack
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
                !SELF.al.InsertAction(actionRec)

            OF aTpy:AttackByFirePosition        
                ! Attack By Fire
                
            OF aTpy:Block
                ! Block
                actionRec.ActionName    = 'aTpy:Block'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:Block
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
                !SELF.al.InsertAction(actionRec)
                
            OF aTpy:Breach
                ! Breach
                actionRec.ActionName    = 'aTpy:Breach'
                actionRec.ActionType    = 0
                actionRec.ActionTypeCode        = aTpy:Breach
                actionRec.ActionPointsNumber    = 2
                actionRec.xPos[1]               = SELF.p1x
                actionRec.yPos[1]               = SELF.p1y
                actionRec.xPos[2]               = SELF.drwImg.MouseX()
                actionRec.yPos[2]               = SELF.drwImg.MouseY()           
                !SELF.al.InsertAction(actionRec)
        END     
        SELF.al.InsertAction(actionRec, selBSO)
        
        SELF.Redraw()
                

OverlayC2IP.TakeMouseDown   PROCEDURE()
    CODE
        ! Check the status of BSO selection
        IF SELF.isSelection = FALSE THEN
            ! check if it is a new BSO selection on the Overlay                
            IF SELF.CheckByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY()) = TRUE THEN
                SELF.SelectByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                SELF.isSelection    = TRUE
            END
        END
        
        ! Check the status of Generic Drawings selection
        IF SELF.isDrawingSelection = FALSE THEN
            IF SELF.CheckDrawingByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY()) = TRUE THEN
                SELF.SelectDrawingByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                SELF.isDrawingSelection = TRUE
            ELSE
                ! check if is a generic drawing
                IF SELF.geometry <> g:NotDefined THEN
                    SELF.isPointsCollection     = TRUE
                ELSE
                END
            END
            
        END       
        
        sst.Trace('isBSOSelection = ' & SELF.isSelection)
        sst.Trace('isDrawingSelection = ' & SELF.isDrawingSelection)
     
        
        ! Check the status of Actions selection
                                
        ! check if it is about to collect points for Action drawing / generic drawing
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
        
OverlayC2IP.TakeMouseMove   PROCEDURE()
    CODE
        IF SELF.isPointsCollection = TRUE THEN
            IF SELF.isMouseDown = TRUE THEN
                ! previewing = TRUE
                CASE SELF.geometry
                OF g:Point
                    ! Point                    
                OF g:Line
                    ! Line
                    SELF.Draw_Line(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)
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
                OF g:LineWithHeader
                    ! Line With Header style
                    SELF.Draw_LineWithHeader(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)                            
                OF g:Breach
                    ! Breach style
                    SELF.Draw_Breach(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), TRUE)
                END
            ELSE
                ! nothing
            END                                                                
            ELSE
                ! nothing
        END                                                                                    
        
OverlayC2IP.TakeMouseUp     PROCEDURE
    CODE
        IF SELF.isPointsCollection = TRUE THEN
            IF SELF.isMouseDown = TRUE THEN                    
                ! points collected
                ! draw final version; previewing = FALSE
                CASE SELF.geometry
                OF g:Point
                    ! finalize point
                OF g:Line
                    ! final line
                    SELF.Draw_Line(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)
                OF g:FreeLine                    
                    ! final dree line
                OF g:AxisAdvance
                    ! Axis of Advance
                    SELF.Draw_AxisAdvance(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)                        
                OF g:Ambush
                    ! Ambush style
                    SELF.Draw_Ambush(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)                        
                OF g:Circle
                    ! Circle style
                    SELF.Draw_Circle(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)     
                OF g:LineWithBase
                    ! Line With Base style
                    SELF.Draw_LineWithBase(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)
                OF g:LineWithHeader
                    ! Line With Header style
                    SELF.Draw_LineWithHeader(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)    
                OF g:Breach
                    ! Breach style
                    SELF.Draw_Breach(SELF.drwImg.MouseX(), SELF.drwImg.MouseY(), FALSE)
                END
                
                ! check if another BSO is targeted
                ! only if there is the Action mode
                IF SELF.isDrawingSelection = TRUE THEN
                    foundTarget#    = SELF.CheckByMouse(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                    IF foundTarget# > 0 THEN
                        MESSAGE('found a target pos#' & foundTarget#)
                    END
                END                                                           
                
                SELF.InsertAction()
                SELF.isPointsCollection = FALSE      
                SELF.geometry           = g:NotDefined
                SELF.isMouseDown        = FALSE
            ELSE
                ! noting
            END
        ELSE
            ! nothing
        END   
        
        SELF.isSelection        = FALSE
        SELF.isDrawingSelection = FALSE
        SELF.isPointsCollection = FALSE
        
        
OverlayC2IP.TakeEvent       PROCEDURE()
    CODE
        !! check BSO 
        !PARENT.TakeEvent()
                
        CASE EVENT()            
        OF EVENT:MouseDown            
            ! mouse down                
            SELF.TakeMouseDown()
                            
        OF EVENT:MouseMove
            ! mouse move
            SELF.TakeMouseMove()                
            
        OF EVENT:MouseUp
            ! mouse up     
            SELF.TakeMouseUp()                        
            
        OF EVENT:Drop
            ! DROP
        END        
        
OverlayC2IP.TakePoints     PROCEDURE(LONG nGeometry)
    CODE
        SELF.geometry           = nGeometry                   
        
OverlayC2IP.Draw_Line    PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)
    CODE
        SELF.drwImg.Blank(COLOR:White)
        IF bPreview = TRUE THEN            
            SELF.drwImg.SetPenStyle(PEN:dash)
        ELSE
            SELF.drwImg.SetPenStyle(PEN:solid)            
        END 
            
        ! Draw line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, (nXPos - SELF.p1x), (nYPos - SELF.p1y))
        
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()
        
OverlayC2IP.Draw_Line       PROCEDURE(PosRecord startPos, PosRecord endPos)        
    CODE
        dx# = endPos.xPos - startPos.xPos
        dy# = endPos.yPos - startPos.yPos
        
        ! Draw line
        SELF.drwImg.Line(startPos.xPos, startPos.yPos, dx#, dy#)

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
        
        ! median line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, dx#, dy#)
        
        ! small base line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, -lx#, -ly#)
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, lx#, ly#)
        
        ! small lateral wings
        SELF.drwImg.Line(SELF.p1x - lx#, SELF.p1y - ly#, -wdth#, -wdth#/2)
        SELF.drwImg.Line(SELF.p1x + lx#, SELF.p1y + ly#, wdth#, wdth#/2)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()             
        
        
OverlayC2IP.Draw_LineWithHeader     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
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
        
        ! median line
        SELF.drwImg.Line(SELF.p1x, SELF.p1y, dx#, dy#)
        
        ! small header line
        SELF.drwImg.Line(nXPos, nYPos, -lx#, -ly#)
        SELF.drwImg.Line(nXPos, nYPos, lx#, ly#)       
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()                     
        
OverlayC2IP.Draw_Breach     PROCEDURE(LONG nXPos, LONG nYPos, BOOL bPreview)        
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
        
        ! main symbol
        ! corridor lines
        SELF.drwImg.Line(SELF.p1x - lx#, SELF.p1y + ly#, dx#, dy#)
        SELF.drwImg.Line(SELF.p1x + lx#, SELF.p1y - ly#, dx#, dy#)
        
        ! display preview
        SELF.drwImg.SetPenStyle(PEN:solid)
        SELF.drwImg.Display()                             
        
OverlayC2IP.DrawAction      PROCEDURE()
startPos                        GROUP(PosRecord)
                                END
endPos                          GROUP(PosRecord)
                                END

    CODE
        
        OMIT('_noCompile')
        CASE CLIP(SELF.al.al.ActionTypeCode)
        !OF '151404'
        OF aTpy:AxisOfAdvance_SupportingAttack
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
        _noCompile        
        
        CASE CLIP(SELF.al.al.ActionTypeCode)
        OF aTpy:notDefined
            ! not Defined
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.Draw_Line(startPos, endPos)
            
        OF aTpy:AdvanceToContact
            ! Advance to contact
            
        OF aTpy:Ambush
            ! Ambush
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.DA_Ambush(startPos, endPos)
            
        OF aTpy:CAI_Arrest
            ! Arrest
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.DA_Arrest(startPos, endPos)
            
        OF aTpy:AxisOfAdvance_SupportingAttack
            ! Attack
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.DA_AxisOfAdvance(startPos, endPos)

        OF aTpy:AttackByFirePosition        
            ! Attack By Fire
            
        OF aTpy:Block
            ! Block
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.DA_Block(startPos, endPos)
            
        OF aTpy:Breach
        !OF '340200'
            ! Breach
            startPos.xPos   = SELF.al.al.xPos[1]
            startPos.yPos   = SELF.al.al.yPos[1]
            endPos.xPos     = SELF.al.al.xPos[2]
            endPos.yPos     = SELF.al.al.yPos[2]       
            SELF.DA_Breach(startPos, endPos)
            
            
            OMIT('_noCompile')
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
            
            _noCompile
                        
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
    
OverlayC2IP.DisplaySelection        PROCEDURE(LONG nAPointer)    
aRec                                    GROUP(ActionBasicRecord)
                                        END
selAction   Action
    CODE
        SELF.al.GetAction(nAPointer, aRec)
        selAction.Init(aRec)
        dx# = aRec.xPos[2] - aRec.xPos[1]
        dy# = aRec.yPos[2] - aRec.yPos[1]
        
        SELF.drwImg.Setpencolor(COLOR:Red)
        SELF.drwImg.SetPenWidth(3)
        
        ! display line
        SELF.drwImg.Line(aRec.xPos[1], aRec.yPos[1], dx#, dy#)
        ! display anchors
        SELF.drwImg.Box(aRec.xPos[1] - 2, aRec.yPos[1] - 2, 5, 5)
        SELF.drwImg.Box(aRec.xPos[2] - 2, aRec.yPos[2] - 2, 5, 5)
        
        SELF.drwImg.SetPenWidth(1)
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.Display()
        