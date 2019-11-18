

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 14.01.2019
 * Time: 17:26
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

                    MAP

    END

!aCollection     &BSOCollection    
aCollection     &UnitsCollection    

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_BSOCollection.INC'),ONCE

! string theory objects
log                 stringtheory

UT_BSOCollection.InitContext        PROCEDURE
    CODE
        !aCollection &= NEW(BSOCollection)
        aCollection &= NEW(UnitsCollection)
        
UT_BSOCollection.DestroyContext     PROCEDURE
    CODE
        DISPOSE(aCollection)


UT_BSOCollection.Construct  PROCEDURE
    CODE
        
        
UT_BSOCollection.Destruct   PROCEDURE
    CODE
        

UT_BSOCollection.InsertNode    PROCEDURE
    CODE
        aCollection.InsertNode()
        ASSERT(aCollection.isHQ()=FALSE, 'UT_BSOCollection.InsertNode:aCollection.isHQ=FALSE')
        ASSERT(aCollection.Hostility()=hTpy:Unknown, 'UT_BSOCollection.InsertNode:aCollection.Hostility=hTpy:Unknown')
        ASSERT(aCollection.Echelon()=echTpy:notDefined,'UT_BSOCollection.InsertNode:aCollection.Echelon=echTpy:notDefined')
        ASSERT(aCollection.UnitTypeCode()='','UT_BSOCollection.InsertNode:aCollection.Echelon=')
        ASSERT(aCollection.UnitTypeCode()=uTpy:notDefined,'UT_BSOCollection.InsertNode:aCollection.Echelon=uTpy:notDefined')        
        RETURN TRUE
        
UT_BSOCollection.InsertAndVerifyABSO        PROCEDURE
myBSO       BSO
rcvBSO      BSO
    CODE
        myBSO.urec.Echelon      = echTpy:Army
        myBSO.urec.Hostility    = hTpy:Friend
        myBSO.urec.IsHQ         = FALSE
        myBSO.urec.TreePos      = 1
        myBSO.urec.UnitName     = 'myUnit'
        myBSO.urec.UnitType     = uTpy:Amphibious
        myBSO.urec.UnitTypeCode = 'uTpy:Amphibious'
        myBSO.urec.xPos         = 100
        myBSO.urec.yPos         = 100
        
        
        aCollection.InsertNode(myBSO)
        
UT_BSOCollection.InsertAndFind      PROCEDURE
loc:BSOColl                             UnitsCollection
loc:BSO1                                BSO
loc:BSO2                                BSO
loc:BSO3                                BSO
loc:nFoundID                            LONG

    CODE
        log.Trace('UT_BSOCollection.InsertAndFind PROCEDURE BEGIN')       
        
        loc:BSO1.urec.UnitName   = 'BSO1'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO1)
        
        loc:BSO2.urec.UnitName   = 'BSO2'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO2)
        
        loc:BSO3.urec.UnitName  = 'BSO3'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO3)
        
        retCode#    = loc:BSOColl.BSOCollOpr.Find(loc:BSO3, loc:nFoundID)
        log.Trace('     retCode#(loc:BSOColl.BSOCollOpr.Find) = ' & retCode#)
        log.Trace('     loc:nFoundID = ' & loc:nFoundID)        
        ASSERT(retCode# = TRUE, 'BSOColl.BSOCollOpr.Find() exception')
        ASSERT(loc:nFoundID <> 0, 'BSOColl.BSOCollOpr.Find() error')
        
        log.Trace('UT_BSOCollection.InsertAndFind PROCEDURE END')       
        RETURN TRUE
        
UT_BSOCollection.InsertAndFindAndGet        PROCEDURE        
loc:BSOColl                             UnitsCollection
loc:BSO1                                BSO
loc:BSO2                                BSO
loc:BSO3                                BSO
loc:nFoundID                                    LONG
loc:pFoundBSO                                   BSO

    CODE
        log.Trace('UT_BSOCollection.InsertAndFindAndGet PROCEDURE BEGIN')     
        
        loc:BSO1.urec.UnitName   = 'BSO1'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO1)
        
        loc:BSO2.urec.UnitName   = 'BSO2'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO2)
        
        loc:BSO3.urec.UnitName  = 'BSO3'
        loc:BSOColl.BSOCollOpr.Add(loc:BSO3)
        
        ! Find
        retCode#    = loc:BSOColl.BSOCollOpr.Find(loc:BSO3, loc:nFoundID)
        log.Trace('     retCode#(loc:BSOColl.BSOCollOpr.Find) = ' & retCode#)
        log.Trace('     loc:nFoundID = ' & loc:nFoundID)        
        ASSERT(retCode# = TRUE, 'BSOColl.BSOCollOpr.Find() exception')
        ASSERT(loc:nFoundID <> 0, 'BSOColl.BSOCollOpr.Find() error')
        
        ! Get
        retCode#    = loc:BSOColl.BSOCollOpr.Get(loc:nFoundID, loc:pFoundBSO)
        log.Trace('     retCode#(loc:BSOColl.BSOCollOpr.Get) = ' & retCode#)
        log.Trace('     loc:pFoundBSO.UnitName = ' & loc:pFoundBSO.urec.UnitName)
        ASSERT(retCode# = TRUE, 'BSOColl.BSOCollOpr.Get() exception')
        ASSERT(loc:pFoundBSO.urec.UnitName = loc:BSO3.urec.UnitName, 'BSOColl.BSOCollOpr.Get() error')
        
        log.Trace('UT_BSOCollection.InsertAndFindAndGet PROCEDURE END')     
        
        RETURN TRUE
        
        
        
UT_BSOCollection.InsertNodeOnEmptyCollection        PROCEDURE
    CODE

        
        aCollection.InsertNode()
        ASSERT(aCollection.Records() = 1, 'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.Records()=1')
        ASSERT(aCollection.Pointer() = 1, 'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.Pointer()=1')
        ASSERT(aCollection.GetCurrentSelPos() = 1,'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
        ASSERT(aCollection.isHQ()=FALSE, 'UT_BSOCollection.InsertNodeOnEmptyCollection:isHQ=FALSE')
        ASSERT(aCollection.Hostility()=hTpy:Unknown, 'UT_BSOCollection.InsertNodeOnEmptyCollection:Hostility=hTpy:Unknown')
        ASSERT(aCollection.Echelon()=echTpy:notDefined,'UT_BSOCollection.InsertNodeOnEmptyCollection:Echelon=echTpy:notDefined')
        ASSERT(aCollection.UnitTypeCode()='','UT_BSOCollection.InsertNodeOnEmptyCollection:Echelon=')
        ASSERT(aCollection.UnitTypeCode()=uTpy:notDefined,'UT_BSOCollection.InsertNodeOnEmptyCollection:Echelon=uTpy:notDefined')
        
        RETURN TRUE
        
UT_BSOCollection.InsertTwoNodes     PROCEDURE
    CODE
        
        aCollection.InsertNode()
        aCollection.InsertNode()
        ASSERT(aCollection.Records() = 2, 'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.Records()=2')
        ASSERT(aCollection.Pointer() = 2, 'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.Pointer()=2')
        ASSERT(aCollection.GetCurrentSelPos() = 2,'UT_BSOCollection.InsertNodeOnEmptyCollection:aCollection.GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
                
        RETURN TRUE
        
UT_BSOCollection.InsertTwoNodesSelectUp     PROCEDURE
    CODE
        
        SELF.InsertTwoNodes()
        aCollection.SelUp()
        !ASSERT(aCollection.Pointer() = 1, 'UT_BSOCollection.InsertTwoNodesSelectUp:Pointer()=' & aCollection.Pointer())
        ASSERT(aCollection.GetCurrentSelPos() = 1, 'UT_BSOCollection.InsertTwoNodesSelectUp:GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
        
        RETURN TRUE
        
        
UT_BSOCollection.InsertTwoNodesSelectUpUp   PROCEDURE        
    CODE
        
        SELF.InsertTwoNodesSelectUp()
        aCollection.SelUp()
        !ASSERT(aCollection.Pointer() = 1, 'UT_BSOCollection.InsertTwoNodesSelectUpUp:Pointer()=' & aCollection.Pointer())
        ASSERT(aCollection.GetCurrentSelPos() = 1, 'UT_BSOCollection.InsertTwoNodesSelectUpUp:GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
        RETURN TRUE
        
UT_BSOCollection.InsertTwoNodesSelectDown    PROCEDURE
    CODE
        SELF.InsertTwoNodes()
        aCollection.SelDown()
        ASSERT(aCollection.GetCurrentSelPos() = 2, 'UT_BSOCollection.InsertTwoNodesSelectUpUp:GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
        RETURN TRUE
        
UT_BSOCollection.InsertTwoNodesSelectDownDown   PROCEDURE
    CODE
        SELF.InsertTwoNodes()
        aCollection.SelDown()
        aCollection.SelDown()
        ASSERT(aCollection.GetCurrentSelPos() = 2, 'UT_BSOCollection.InsertTwoNodesSelectUpUp:GetCurrentSelPos() = ' & aCollection.GetCurrentSelPos())
        RETURN TRUE
        
        
UT_BSOCollection.InsertSpecificNode PROCEDURE(*UnitBasicRecord pURec)
    CODE
        aCollection.InsertNode(pURec)
        ASSERT(aCollection.UnitName() = pURec.UnitName, 'UT_BSOCollection.InsertSpecificNode:aCollection.UnitName() = ' & aCollection.UnitName())
        ASSERT(aCollection.UnitTypeCode() = pURec.UnitTypeCode, 'UT_BSOCollection.InsertSpecificNode:aCollection.UnitTypeCode() = ' & aCollection.UnitTypeCode())
        ASSERT(aCollection.Echelon() = pURec.Echelon, 'UT_BSOCollection.InsertSpecificNode:aCollection.Echelon() = ' & aCollection.Echelon())
        ASSERT(aCollection.Hostility() = pURec.Hostility, 'UT_BSOCollection.InsertSpecificNode:aCollection.Hostility() = ' & aCollection.Hostility())
        ASSERT(aCollection.isHQ() = pURec.IsHQ, 'UT_BSOCollection.InsertSpecificNode:aCollection.isHQ() = ' & aCollection.isHQ())
        RETURN TRUE
        
UT_BSOCollection.AddSpecificNode    PROCEDURE(*UnitBasicRecord pURec)        
    CODE
        aCollection.AddNode(pURec)
        ASSERT(aCollection.xPos() = pURec.xPos, 'UT_BSOCollection.AddSpecificNode:aCollection.xPos() = ' & pURec.xPos)
        ASSERT(aCollection.yPos() = pURec.yPos, 'UT_BSOCollection.AddSpecificNode:aCollection.yPos() = ' & pURec.yPos)
        RETURN TRUE
        
        
UT_BSOCollection.AddGet     PROCEDURE()
myBSO                           BSO
myColl                          UnitsCollection
receivedBSO                     BSO

    CODE
        myBSO.urec.UnitName = 'myName'
        myColl.BSOCollOpr.Add(myBSO)
        myColl.BSOCollOpr.Get(1, receivedBSO)
        ASSERT(myBSO.urec.UnitName = receivedBSO.urec.UnitName, 'myColl.BSOCollOpr.Get(1, receivedBSO) ERROR')
        ASSERT(myBSO.urec.UnitName = 'myName', 'myColl.BSOCollOpr.Get(1, receivedBSO) ERROR')
        
        myBSO.urec.UnitName = 'Zuzu'
        myColl.BSOCollOpr.Add(myBSO)
        myColl.BSOCollOpr.Get(2, receivedBSO)
        ASSERT(myBSO.urec.UnitName = receivedBSO.urec.UnitName, 'myColl.BSOCollOpr.Get(2, receivedBSO) ERROR')
        ASSERT(myBSO.urec.UnitName = 'Zuzu', 'myColl.BSOCollOpr.Get(1, receivedBSO) ERROR')
        
        
UT_BSOCollection.Replace     PROCEDURE()
myBSO                           BSO
secBSO                          BSO
myColl                          UnitsCollection
receivedBSO                     BSO

    CODE
        myBSO.urec.UnitName = 'ana'
        myColl.BSOCollOpr.Add(myBSO)
        
        secBSO.urec.UnitName    = 'dana'
        
        myColl.BSOCollOpr.Rpl(1, secBSO)
        
        myColl.BSOCollOpr.Get(1, receivedBSO)
        ASSERT(receivedBSO.urec.UnitName = secBSO.urec.UnitName, 'myColl.BSOCollOpr.Rpl(1, secBSO) ERROR')
        ASSERT(receivedBSO.urec.UnitName = 'dana', 'myColl.BSOCollOpr.Rpl(1, secBSO) ERROR')
        



