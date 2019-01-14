

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

    

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_BSOCollection.INC'),ONCE


UT_BSOCollection.Construct  PROCEDURE
    CODE
        SELF.collection &= NEW(BSOCollection)
        
UT_BSOCollection.Destruct   PROCEDURE
    CODE
        DISPOSE(SELF.collection)
        

UT_BSOCollection.InsertNode    PROCEDURE
    CODE
        SELF.collection.InsertNode()
        ASSERT(SELF.collection.Records() = 1, 'UT_BSOCollection.InsertNode:Records()=1')
        !ASSERT(SELF.collection.UnitName()= '', 'UT_BSOCollection.InsetNode:UnitName=')
        ASSERT(SELF.collection.isHQ()=FALSE, 'UT_BSOCollection.InsertNode:isHQ=FALSE')
        ASSERT(SELF.collection.Hostility()=hTpy:Unknown, 'UT_BSOCollection.InsertNode:Hostility=hTpy:Unknown')
        RETURN TRUE
        



