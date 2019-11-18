

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
loc:BSO                 BSO
loc:foundBSO            BSO
loc:foundBSOPosition    LONG
    CODE
        log.Trace('UT_C2IPv2.FoundBSO PROCEDURE BEGIN')       
        
        loc:BSO.urec.UnitName  = 'masina'
        loc:C2IP.AddBSO(loc:BSO)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 1, 'AddBSO error')
        
        retCode#    = loc:C2IP.FoundBSO(loc:BSO, loc:foundBSO, loc:foundBSOPosition)
        log.Trace('loc:foundBSO = ' & loc:foundBSO.urec.UnitName)
        ASSERT(loc:foundBSO.urec.UnitName = loc:BSO.urec.UnitName, 'loc:C2IP.FoundBSO error')
        
        log.Trace('UT_C2IPv2.FoundBSO PROCEDURE END')       
        
UT_C2IPv2.AddSeveralBSOFoundBSO     PROCEDURE
loc:C2IP    nvC2IP
loc:BSO1                                BSO
loc:BSO2                                BSO
loc:BSO3                                BSO
loc:foundBSO            BSO
loc:foundBSOPosition    LONG
    CODE
        log.Trace('UT_C2IPv2.AddSeveralBSOFoundBSO PROCEDURE BEGIN')     
        
        loc:BSO1.urec.UnitName  = 'BSO1'
        loc:C2IP.AddBSO(loc:BSO1)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 1, 'AddBSO error')
        
        loc:BSO2.urec.UnitName  = 'BSO2'
        loc:C2IP.AddBSO(loc:BSO2)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 2, 'AddBSO error')
        
        loc:BSO3.urec.UnitName  = 'BSO3'
        loc:C2IP.AddBSO(loc:BSO3)
        count# = loc:C2IP.GetContentCount()
        log.Trace('loc:C2IP.GetContentCount() = ' & count#)
        ASSERT(count# = 3, 'AddBSO error')
        
        retCode#    = loc:C2IP.FoundBSO(loc:BSO2, loc:foundBSO, loc:foundBSOPosition)
        log.Trace('loc:foundBSO = ' & loc:foundBSO.urec.UnitName)
        ASSERT(loc:foundBSO.urec.UnitName = loc:BSO2.urec.UnitName, 'loc:C2IP.FoundBSO error')
        
        log.Trace('UT_C2IPv2.AddSeveralBSOFoundBSO PROCEDURE END')       
        
        
        
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
        
UT_C2IPv2.AddBSOCollection  PROCEDURE
loc:C2IP                        nvC2IP
loc:BSOColl                     UnitsCollection
loc:BSO1                        BSO
loc:BSO2                        BSO
loc:BSO3                        BSO
    CODE
        log.Trace('UT_C2IPv2.AddBSOCollection PROCEDURE BEGIN')   
        
        loc:BSO1.urec.UnitName = 'BSO1'
        loc:BSO2.urec.UnitName = 'BSO2'
        loc:BSO3.urec.UnitName = 'BSO3'
        
        loc:BSOColl.AddNode(loc:BSO1)        
        loc:BSOColl.AddNode(loc:BSO2)        
        loc:BSOColl.AddNode(loc:BSO3)        
        
        loc:C2IP.AddBSOColl(loc:BSOColl)
        ASSERT(loc:C2IP.GetContentCount() = 3, 'nvC2IP.AddBSOColl() error')
        
        log.Trace('UT_C2IPv2.AddBSOCollection PROCEDURE END')   
        
        
UT_C2IPv2.LoadBSOContent    PROCEDURE
    CODE
        log.Trace('UT_C2IPv2.LoadBSOContent   PROCEDURE BEGIN')                  
        
        log.Trace('UT_C2IPv2.LoadBSOContent   PROCEDURE END')




