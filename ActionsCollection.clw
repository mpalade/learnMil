

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
        DISPOSE(SELF.al)
        
ActionsCollection.InsertAction      PROCEDURE(ActionBasicRecord pARec)
    CODE
        SELF.al.ActionName      = pARec.ActionName
        SELF.al.ActionType      = pARec.ActionType
        SELF.al.ActionTypeCode  = pARec.ActionTypeCode
        SELF.al.xPos            = pARec.xPos
        SELF.al.yPos            = pARec.yPos
        ADD(SELF.al)   
        MESSAGE('action added to the queue')
        
        



