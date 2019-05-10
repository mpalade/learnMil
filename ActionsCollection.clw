

  MEMBER('learnMil')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 21.01.2019
 * Time: 22:48
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

ActionsCollection.Construct   PROCEDURE
    CODE
        SELF.al &= NEW(ActResTargets)
        
ActionsCollection.Destruct   PROCEDURE
    CODE
        ! Resources
        LOOP WHILE RECORDS(SELF.al.Resources)
            GET(SELF.al.Resources, 1)
            FREE(SELF.al.Resources)
            DISPOSE(SELF.al.Resources)
            DELETE(SELF.al)
        END
        ! BSO Targets
        LOOP WHILE RECORDS(SELF.al.BSOTargets)
            GET(SELF.al.BSOTargets, 1)
            FREE(SELF.al.BSOTargets)
            DISPOSE(SELF.al.BSOTargets)
            DELETE(SELF.al)
        END
        
        ! Action Targets
        LOOP WHILE RECORDS(SELF.al.ActTargets)
            GET(SELF.al.ActTargets, 1)
            FREE(SELF.al.ActTargets)
            DISPOSE(SELF.al.ActTargets)
            DELETE(SELF.al)
        END
        
        DISPOSE(SELF.al)
        
ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec)
    CODE
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        
        ! Action Points
        !SELF.al.xPos            = pARec.xPos
        !SELF.al.yPos            = pARec.yPos     
        !!!
        OMIT('_noCompile')
        SELF.al.ActionPoints    &= NEW(PosList)
        LOOP i# = 1 TO RECORDS(parec.ActionPoints)
            GET(parec.ActionPoints, i#)
            IF NOT ERRORCODE() THEN
                SELF.al.ActionPoints.xPos   = parec.ActionPoints.xPos
                SELF.al.ActionPoints.yPos   = parec.ActionPoints.yPos
                ADD(SELF.al.ActionPoints)
            END                
        END
        _noCompile
        SELF.al.ActionPoints    &= NEW(PosList)
        retVal# = SELF.C2IPOperators.Eql(SELF.al.ActionPoints, parec.ActionPoints)

        ! APoints is a CLASS
        ! all ActionPoints references whould be changed with APoints references
        SELF.al.APoints     &= NEW(PointsCollection)
        
        
        !SELF.al.ActionPoints
        
        SELF.al.Resources       &= NEW(UnitsQueue)
        ! Resource1
        SELF.al.Resources.Echelon   = 1
        SELF.al.Resources.Hostility = 1
        SELF.al.Resources.IsHQ      = 1
        SELF.al.Resources.markForDel    = 0
        SELF.al.Resources.markForDisbl  = 0
        SELF.al.Resources.TreePos       = 1
        SELF.al.Resources.UnitName      = 'TEST1'
        SELF.al.Resources.UnitType      = 1
        SELF.al.Resources.UnitTypeCode  = 'TEST1'
        SELF.al.Resources.xPos          = 100
        SELF.al.Resources.yPos          = 100
        ADD(SELF.al.Resources)
        
        ! Resource2
        SELF.al.Resources.Echelon   = 2
        SELF.al.Resources.Hostility = 2
        SELF.al.Resources.IsHQ      = 2
        SELF.al.Resources.markForDel    = 0
        SELF.al.Resources.markForDisbl  = 0
        SELF.al.Resources.TreePos       = 1
        SELF.al.Resources.UnitName      = 'TEST2'
        SELF.al.Resources.UnitType      = 1
        SELF.al.Resources.UnitTypeCode  = 'TEST2'
        SELF.al.Resources.xPos          = 100
        SELF.al.Resources.yPos          = 100
        ADD(SELF.al.Resources)
        
        ADD(SELF.al)   
        !MESSAGE('action added to the queue')
        
        
ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec, UnitBasicRecord  pURec)
    CODE
        sst.Trace('ActionsCollection.InsertAction(action, resource) BEGIN')
        
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        !SELF.al.xPos            = pARec.xPos
        !SELF.al.yPos            = pARec.yPos
        
        ! Action Points
        SELF.al.ActionPoints    &= NEW(PosList)
        retVal# = SELF.C2IPOperators.Eql(SELF.al.ActionPoints, parec.ActionPoints)        
                
        ! Resources
        SELF.al.Resources       &= NEW(UnitsQueue)
        
        SELF.al.Resources.Echelon   = purec.Echelon
        SELF.al.Resources.Hostility = purec.Hostility
        SELF.al.Resources.IsHQ      = purec.IsHQ
        SELF.al.Resources.markForDel    = 0
        SELF.al.Resources.markForDisbl  = 0
        SELF.al.Resources.TreePos       = purec.TreePos
        SELF.al.Resources.UnitName      = purec.UnitName
        SELF.al.Resources.UnitType      = purec.UnitType
        SELF.al.Resources.UnitTypeCode  = purec.UnitTypeCode
        SELF.al.Resources.xPos          = purec.xPos
        SELF.al.Resources.yPos          = purec.yPos
        
        ADD(SELF.al.Resources)
        
        ADD(SELF.al)   
        
        sst.Trace('ActionsCollection.InsertAction(action, resource) END')
        
ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec, UnitBasicRecord  pURec, UnitBasicRecord pTarget_urec)        
    CODE
        sst.Trace('ActionsCollection.InsertAction(action, resource, target-unit) BEGIN')
        
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        !SELF.al.xPos            = pARec.xPos
        !SELF.al.yPos            = pARec.yPos
        
        ! Action Points
        SELF.al.ActionPoints    &= NEW(PosList)
        retVal# = SELF.C2IPOperators.Eql(SELF.al.ActionPoints, parec.ActionPoints)
        
        ! Resources
        SELF.al.Resources       &= NEW(UnitsQueue)
        
        SELF.al.Resources.Echelon   = purec.Echelon
        SELF.al.Resources.Hostility = purec.Hostility
        SELF.al.Resources.IsHQ      = purec.IsHQ
        SELF.al.Resources.markForDel    = 0
        SELF.al.Resources.markForDisbl  = 0
        SELF.al.Resources.TreePos       = purec.TreePos
        SELF.al.Resources.UnitName      = purec.UnitName
        SELF.al.Resources.UnitType      = purec.UnitType
        SELF.al.Resources.UnitTypeCode  = purec.UnitTypeCode
        SELF.al.Resources.xPos          = purec.xPos
        SELF.al.Resources.yPos          = purec.yPos
        
        ADD(SELF.al.Resources)
        
        ! BSO Targets
        SELF.al.BSOTargets  &= NEW(UnitsQueue)
        SELF.al.BSOTargets.Echelon      = pTarget_urec.Echelon
        SELF.al.BSOTargets.Hostility    = pTarget_urec.Hostility
        SELF.al.BSOTargets.IsHQ         = pTarget_urec.IsHQ
        SELF.al.BSOTargets.markForDel   = 0
        SELF.al.BSOTargets.markForDisbl = 0
        SELF.al.BSOTargets.TreePos      = pTarget_urec.TreePos
        SELF.al.BSOTargets.UnitName     = pTarget_urec.UnitName
        SELF.al.BSOTargets.UnitType     = pTarget_urec.UnitType
        SELF.al.BSOTargets.UnitTypeCode = pTarget_urec.UnitTypeCode
        SELF.al.BSOTargets.xPos         = pTarget_urec.xPos
        SELF.al.BSOTargets.yPos         = pTarget_urec.yPos
        ADD(SELF.al.BSOTargets)
        
        ADD(SELF.al)
        
        sst.Trace('ActionsCollection.InsertAction(action, resource, target-unit) END')

ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec, UnitBasicRecord  pURec, ActionBasicRecord pTarget_arec)                
    CODE
        sst.Trace('ActionsCollection.InsertAction(action, resource, target-action) BEGIN')
        
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        !SELF.al.xPos            = pARec.xPos
        !SELF.al.yPos            = pARec.yPos
        
        ! Action Points
        SELF.al.ActionPoints    &= NEW(PosList)
        retVal# = SELF.C2IPOperators.Eql(SELF.al.ActionPoints, parec.ActionPoints)
        
        ! Resources
        SELF.al.Resources       &= NEW(UnitsQueue)
        
        SELF.al.Resources.Echelon   = purec.Echelon
        SELF.al.Resources.Hostility = purec.Hostility
        SELF.al.Resources.IsHQ      = purec.IsHQ
        SELF.al.Resources.markForDel    = 0
        SELF.al.Resources.markForDisbl  = 0
        SELF.al.Resources.TreePos       = purec.TreePos
        SELF.al.Resources.UnitName      = purec.UnitName
        SELF.al.Resources.UnitType      = purec.UnitType
        SELF.al.Resources.UnitTypeCode  = purec.UnitTypeCode
        SELF.al.Resources.xPos          = purec.xPos
        SELF.al.Resources.yPos          = purec.yPos
        
        ADD(SELF.al.Resources)
        
        !Action Targets
        SELF.al.ActTargets      &= NEW(ActionsQueue)
        SELF.al.ActTargets.ActionName               = pTarget_arec.ActionName
        SELF.al.ActTargets.ActionPointsNumber       = pTarget_arec.ActionPointsNumber
        SELF.al.ActTargets.ActionType               = pTarget_arec.ActionType
        SELF.al.ActTargets.ActionPoints     &= NEW(PosList)
        retVal# = SELF.C2IPOperators.Eql(SELF.al.ActTargets.ActionPoints, pTarget_arec.ActionPoints)        
        !LOOP i# = 1 TO MAXIMUM(pTarget_arec.xPos, 1)
        !    SELF.al.ActTargets.xPos[i#]                    = pTarget_arec.xPos[i#]
        !    SELF.al.ActTargets.yPos[i#]                    = pTarget_arec.yPos[i#]
        !END                
        ADD(SELF.al.ActTargets)
        
        ADD(SELF.al)
        
        sst.Trace('ActionsCollection.InsertAction(action, resource, target-action) END')
        

ActionsCollection.SelectByMouse     PROCEDURE(LONG nXPos, LONG nYPos)     
aRec                                    GROUP(ActionBasicRecord)
                                        END
foundAction                             Action
    CODE                
        sst.Trace('ActionsCollection.CheckByMouse Actions# = ' & RECORDS(SELF.al))
        LOOP i# = 1 TO RECORDS(SELF.al)
            GET(SELF.al, i#)
            IF NOT ERRORCODE() THEN
                ! found Action
                sst.Trace('Action' & i# & 'code =' & CLIP(SELF.al.ActionTypeCode))                
                CASE CLIP(SELF.al.ActionTypeCode)
                OF aTpy:notDefined
                    ! not defined                    
                    sst.Trace('verify aTpy:notDefined')
                    
                    ! verify Line                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckLineByMouse(nXPos, nYPos) THEN
                        ! found Line
                        RETURN TRUE
                    END                        
                OF aTpy:notDef_Line
                    ! generic Line
                    sst.Trace('verify aTpy:notDef_Line')
                    
                    ! verify Line                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckLineByMouse(nXPos, nYPos) THEN
                        ! found Line
                        RETURN TRUE
                    END                   
                OF aTpy:notDef_Rectangle
                    ! generic Rectangle
                    sst.Trace('verify aTpy:notDef_Rectangle')
                    
                    ! verify Rectangle                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckRectangleByMouse(nXPos, nYPos) THEN
                        ! found Line
                        RETURN TRUE
                    END                   
                END
            END
            
        END
        
        
        OMIT('_noCompile')
        LOOP i# = 1 TO RECORDS(SELF.ul)
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                IF (SELF.ul.xPos < nXPos) AND (nXPos < SELF.ul.xPos + 50) THEN
                    IF (SELF.ul.yPos < nYPos) AND (nYPos < SELF.ul.yPos + 30) THEN
                        ! found Unit selection
                        SELF.selTreePos     = SELF.ul.TreePos
                        SELF.selQueuePos    = i#
                        RETURN i#
                    END                
                END            
            END
        END
        _noCompile
        
        RETURN FALSE
        
ActionsCollection.CheckByMouse     PROCEDURE(LONG nXPos, LONG nYPos)     
aRec                                    GROUP(ActionBasicRecord)
                                        END
foundAction                             Action
    CODE
        sst.Trace('ActionsCollection.CheckByMouse BEGIN')
        
        sst.Trace('     ActionsCollection.CheckByMouse : Actions# = ' & RECORDS(SELF.al))
        ret#    = 0
        LOOP i# = 1 TO RECORDS(SELF.al)
            GET(SELF.al, i#)
            IF NOT ERRORCODE() THEN
                ! found Action
                sst.Trace('     ActionsCollection.CheckByMouse : Action' & i# & ' code =' & CLIP(SELF.al.ActionTypeCode))                
                CASE CLIP(SELF.al.ActionTypeCode)
                OF aTpy:notDefined
                    ! not defined                    
                    sst.Trace('     ActionsCollection.CheckByMouse : verify aTpy:notDefined')
                    
                    ! verify Line                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckLineByMouse(nXPos, nYPos) THEN
                        ! found Line
                        ret#    = i#                        
                        BREAK
                    END                        
                OF aTpy:notDef_Line
                    ! generic Line
                    sst.Trace('     ActionsCollection.CheckByMouse : verify aTpy:notDef_Line')
                    
                    ! verify Line                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckLineByMouse(nXPos, nYPos) THEN
                        ! found Line
                        ret#    = i#
                        BREAK
                    END                   
                OF aTpy:notDef_Rectangle
                    ! generic Rectangle
                    sst.Trace('     ActionsCollection.CheckByMouse : verify aTpy:notDef_Rectangle')
                    
                    ! verify Rectangle                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckRectangleByMouse(nXPos, nYPos) THEN
                        ! found Rectangle
                        ret#    = i#
                        BREAK
                    END                   
                OF aTpy:notDef_FreeHand
                    ! generic Free Hand
                    sst.Trace('     ActionsCollection.CheckByMouse : verify aTpy:notDef_FreeHand')
                    
                    ! verify Free Hand                   
                    SELF.GetAction(i#, aRec)
                    foundAction.Init(aRec)
                    IF foundAction.CheckFreeHandByMouse(nXPos, nYPos) THEN
                        ! found Free Hand
                        ret#    = i#
                        BREAK
                    END                       
                END
            END
            
        END
        
        sst.Trace('     ActionsCollection.CheckByMouse : ret# = ' & ret#)
        sst.Trace('ActionsCollection.CheckByMouse END')
        RETURN ret#

ActionsCollection.CheckLineByMouse  PROCEDURE(LONG nXPos, LONG nYPos)                
    CODE
        RETURN 0
        
        
ActionsCollection.GetAction PROCEDURE(LONG nPointer, *ActionBasicRecord pARec)
    CODE
        ! get current node
    
        GET(SELF.al, nPointer)
        IF NOT ERRORCODE() THEN
            pARec.ActionName            = SELF.al.ActionName
            pARec.ActionPointsNumber    = SELF.al.ActionPointsNumber
            pARec.ActionType            = SELF.al.ActionType
            pARec.ActionTypeCode        = SELF.al.ActionTypeCode
            pARec.ActionPoints          &= NEW(PosList)
            LOOP i# = 1 TO RECORDS(SELF.al.ActionPoints)
                GET(SELF.al.ActionPoints, i#)
                IF NOT ERRORCODE() THEN
                    pARec.ActionPoints.xPos = SELF.al.ActionPoints.xPos
                    pARec.ActionPoints.yPos = SELF.al.ActionPoints.yPos
                    ADD(pARec.ActionPoints)
                END               
            END
            
            !LOOP i# = 1 TO MAXIMUM(SELF.al.xPos, 1)
            !    pARec.xPos[i#]  = SELF.al.xPos[i#]
            !    pARec.yPos[i#]  = SELF.al.yPos[i#]
            !END
            
            RETURN TRUE
        ELSE
            RETURN FALSE
        END      
        
ActionsCollection.ChangeActionPos  PROCEDURE(LONG nPos, LONG nDX, LONG nDY)        
    CODE
        !sst.Trace('ActionsCollection.ChangeActionPos BEGIN')
        
        GET(SELF.al, nPos)
        IF NOT ERRORCODE() THEN
            ! move all the Action points            
            
            LOOP i# = 1 TO RECORDS(SELF.al.ActionPoints)
                GET(SELF.al.ActionPoints, i#)
                IF NOT ERRORCODE() THEN
                    SELF.al.ActionPoints.xPos   = SELF.al.ActionPoints.xPos + nDX
                    SELF.al.ActionPoints.yPos   = SELF.al.ActionPoints.yPos + nDY
                    PUT(SELF.al.ActionPoints)
                END
                
            END
            
        END
        
        !sst.Trace('ActionsCollection.ChangeActionPos END')
        RETURN TRUE
        
        
ActionsCollection.C2IPOperators.Eql      PROCEDURE(PosList l1, PosList l2)
    CODE
        LOOP i# = 1 TO RECORDS(l2)
            GET(l2, i#)
            IF NOT ERRORCODE() THEN
                l1.xPos = l2.xPos
                l1.yPos = l2.yPos
            ADD(l1)
            END                        
        END
        
        RETURN TRUE        
        
      