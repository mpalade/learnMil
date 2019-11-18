

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: Mihai
 * Date: 11/16/2019
 * Time: 11:20 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_C2IPv2.INC'),ONCE

! string theory objects
log                 stringtheory

aC2IP               nvC2IP

UT_C2IPv2.Construct PROCEDURE
    CODE
        
UT_C2IPv2.Destruct  PROCEDURE
    CODE
        
UT_C2IPv2.InitContext       PROCEDURE
    CODE
        log.Trace('UT_C2IPv2.InitContext PROCEDURE BEGIN')       
        
        ASSERT(aC2IP.GetContentCount() = 0, 'InitContext error')
        
        log.Trace('UT_C2IPv2.InitContext PROCEDURE END')       
        
UT_C2IPv2.DestroyContext    PROCEDURE
    CODE
        log.Trace('UT_C2IPv2.DestroyContext PROCEDURE BEGIN')       
        
        log.Trace('UT_C2IPv2.DestroyContext PROCEDURE END')       

UT_C2IPv2.SetGetName        PROCEDURE
    CODE
        log.Trace('UT_C2IPv2.SetGetName   PROCEDURE BEGIN')
        
        aC2IP.Name  = 'Nume1'
        ASSERT(aC2IP.Name = 'Nume1', 'set(Name) error')
        
        log.Trace('UT_C2IPv2.SetGetName   PROCEDURE END')
        
UT_C2IPv2.AddBSO    PROCEDURE
loc:C2IP    nvC2IP
loc:BSO     BSO
    CODE
        log.Trace('UT_C2IPv2.AddBSO PROCEDURE BEGIN')       
        
        loc:BSO.urec.UnitName  = 'masina'
        loc:C2IP.AddBSO(loc:BSO)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 1, 'AddBSO error')
        
        log.Trace('UT_C2IPv2.AddBSO PROCEDURE END')  
        
UT_C2IPv2.FoundBSO  PROCEDURE
loc:C2IP    nvC2IP
loc:BSO     BSO
    CODE
        log.Trace('UT_C2IPv2.FoundBSO PROCEDURE BEGIN')       
        
        loc:BSO.urec.UnitName  = 'masina'
        loc:C2IP.AddBSO(loc:BSO)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 1, 'AddBSO error')
        
        !!!
        
        log.Trace('UT_C2IPv2.FoundBSO PROCEDURE END')       
        
                        
        
        
UT_C2IPv2.AddTwoBSO PROCEDURE    
loc:C2IP    nvC2IP
loc:BSO     BSO
    CODE
        log.Trace('UT_C2IPv2.AddTwoBSO PROCEDURE BEGIN')   
        
        loc:BSO.urec.UnitName  = 'masina'
        loc:C2IP.AddBSO(loc:BSO)
        loc:C2IP.AddBSO(loc:BSO)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 2, 'AddTwoBSO error')
        
        log.Trace('UT_C2IPv2.AddTwoBSO PROCEDURE END')       
        
        
        
UT_C2IPv2.LoadBSOContent    PROCEDURE
    CODE
        log.Trace('UT_C2IPv2.LoadBSOContent   PROCEDURE BEGIN')                  
        
        log.Trace('UT_C2IPv2.LoadBSOContent   PROCEDURE END')




