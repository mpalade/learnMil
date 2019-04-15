

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
        SELF.al &= NEW(ActionsQueue)
        
ActionsCollection.Destruct   PROCEDURE
    CODE
        LOOP WHILE RECORDS(SELF.al.Resources)
            GET(SELF.al.Resources, 1)
            FREE(SELF.al.Resources)
            DISPOSE(SELF.al.Resources)
            DELETE(SELF.al)
        END
        
        DISPOSE(SELF.al)
        
ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec)
    CODE
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        SELF.al.xPos            = pARec.xPos
        SELF.al.yPos            = pARec.yPos       
        
        SELF.al.Resources       &= NEW(UnitsList)
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
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        SELF.al.xPos            = pARec.xPos
        SELF.al.yPos            = pARec.yPos
        
        SELF.al.Resources       &= NEW(UnitsList)
        
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
        

ActionsCollection.SelectByMouse     PROCEDURE(LONG nXPos, LONG nYPos)     
aRec                                    GROUP(ActionBasicRecord)
                                        END
foundAction                             Action
    CODE
        
        LOOP i# = 1 TO RECORDS(SELF.al)
            GET(SELF.al, i#)
            IF NOT ERRORCODE() THEN
                CASE CLIP(SELF.al.ActionTypeCode)
                OF g:NotDefined
                    ! not defined
                    IF SELF.CheckLineByMouse(nXPos, nYPos) THEN
                        ! found Action
                        SELF.GetAction(i#, aRec)
                        foundAction.Init(aRec)
                        IF foundAction.CheckLineByMouse(nXPos, nYPos) THEN
                            ! found Line
                        END
                        
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
        
        RETURN 0

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
            pARec.xPos                  = SELF.al.xPos
            pARec.yPos                  = SELF.al.yPos
            
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        
