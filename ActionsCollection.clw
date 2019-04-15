

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
        


