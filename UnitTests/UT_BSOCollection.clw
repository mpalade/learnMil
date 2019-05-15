

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
        
        
        
        
        



