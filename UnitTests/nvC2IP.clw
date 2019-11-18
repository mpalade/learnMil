

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: Mihai
 * Date: 11/16/2019
 * Time: 11:07 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('C2IPLibv2.inc'), ONCE

! string theory objects
log                 stringtheory

nvC2IP.Construct    PROCEDURE
    CODE
        SELF.content &= NEW(UnitsCollection)
        
nvC2IP.Destruct     PROCEDURE
    CODE
        DISPOSE(SELF.content)
        
nvC2IP.AddBSO       PROCEDURE(BSO aBSO)
    CODE
        log.Trace('nvC2IP.AddBSO   PROCEDURE BEGIN')  
        
        !retCode#    = SELF.content.AddNode(aBSO)
        retCode#    = SELF.content.BSOCollOpr.Add(aBSO)
        
        IF retCode# = FALSE THEN
            log.Trace('nvC2IP.AddBSO error')
        END        
        
        log.Trace('nvC2IP.AddBSO   PROCEDURE END')     
        RETURN retCode#
        
nvC2IP.ReplaceBSO   PROCEDURE(BSO origBSO, BSO newBSO)
    CODE
        RETURN FALSE
        
nvC2IP.GetContentCount      PROCEDURE
    CODE
        log.Trace('nvC2IP.GetContentCount   PROCEDURE BEGIN')  
        
        rec# = RECORDS(SELF.content.collection)
        !MESSAGE('rec# = ' & rec#)
        !RECORDS(SELF.content.collection)
        
        log.Trace('nvC2IP.GetContentCount   PROCEDURE END')  
        RETURN rec#
        
        


