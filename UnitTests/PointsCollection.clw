

    MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 09.05.2019
 * Time: 20:19
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

    MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

PointsCollection.Construct   PROCEDURE()
    CODE
        SELF.pl     &= NEW(PosList)
        
PointsCollection.Destruct   PROCEDURE()
    CODE                 
        
PointsCollection.Init       PROCEDURE(LONG nXpos, LONG nYPos)
    CODE
        IF RECORDS(SELF.pl) = 0 THEN
            SELF.pl.xPos    = nXPos
            SELF.pl.yPos    = nYPos
            ADD(SELF.pl)
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        
PointsCollection.Init       PROCEDURE(*PosRecord pPRec)
    CODE
        IF RECORDS(SELF.pl) = 0 THEN
            SELF.pl.xPos    = pPRec.xPos
            SELF.pl.yPos    = pPRec.yPos
            ADD(SELF.pl)
            RETURN TRUE
        ELSE
            RETURN FALSE            
        END

        
PointsCollection.InsertPoint        PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        SELF.pl.xPos    = nXPos
        SELF.pl.yPos    = nYPos
        ADD(SELF.pl)
        IF ERRORCODE() THEN
            RETURN FALSE
        ELSE
            RETURN TRUE
        END
        
        
PointsCollection.InsertPoint        PROCEDURE(*PosRecord pPRec)        
    CODE
        SELF.pl.xPos    = pPRec.xPos
        SELF.pl.yPos    = pPRec.yPos
        ADD(SELF.pl)
        IF ERRORCODE() THEN
            RETURN FALSE
        ELSE
            RETURN TRUE
        END
        
        
        
        
        
