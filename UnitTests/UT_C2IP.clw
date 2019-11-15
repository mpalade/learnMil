

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 15.11.2019
 * Time: 18:15
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_C2IP.INC'),ONCE

! string theory objects
log                 stringtheory

aC2IP               C2IP


UT_C2IP.Construct    PROCEDURE
    CODE
        
UT_C2IP.Destruct     PROCEDURE
    CODE

UT_C2IP.InitContext  PROCEDURE
    CODE
        
UT_C2IP.DestroyContext       PROCEDURE
    CODE
        
UT_C2IP.SetGetName  PROCEDURE
    CODE
        log.Trace('UT_C2IP.SetGetName   PROCEDURE BEGIN')
        
        aC2IP.Name  = 'Nume1'
        ASSERT(aC2IP.Name = 'Nume1', 'set(Name) error')
        
        log.Trace('UT_C2IP.SetGetName   PROCEDURE BEGIN')

UT_C2IP.LoadBSOContent      PROCEDURE
    CODE
        log.Trace('UT_C2IP.LoadBSOContent   PROCEDURE BEGIN')       
        
        log.Trace('UT_C2IP.LoadBSOContent   PROCEDURE BEGIN')
        
