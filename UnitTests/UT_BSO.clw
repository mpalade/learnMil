

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 15.05.2019
 * Time: 22:11
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_BSO.INC'),ONCE

! string theory objects
sst                 stringtheory

myBSO       BSO


UT_BSO.Construct    PROCEDURE
    CODE
        
UT_BSO.Destruct     PROCEDURE
    CODE
        

UT_BSO.InitContext  PROCEDURE
    CODE
        myBSO.urec.UnitName ='helloWorld'
        
UT_BSO.DestroyContext       PROCEDURE
    CODE
        
UT_BSO.Eql          PROCEDURE
bso1                BSO
bso2                BSO
    CODE
        sst.Trace('UT_BSO.Eql          PROCEDURE BEGIN')
        
        bso1.urec.UnitName  = 'bso1'
        bso2.urec.UnitName  = 'bso2'
        sst.Trace('bso1.urec.UnitName  = ' & bso1.urec.UnitName)
        sst.Trace('bso2.urec.UnitName  = ' & bso2.urec.UnitName)
        bso1.BSOOpr.Eql(bso2)
        sst.Trace('bso1.urec.UnitName  = ' & bso1.urec.UnitName)
        ASSERT(CLIP(bso1.urec.UnitName) = CLIP(bso2.urec.UnitName), 'bso1.BSOOpr.Eql(bso2) ERROR')
        ASSERT(bso1.urec.UnitName = 'bso2', 'bso1.BSOOpr.Eql(bso2) ERROR')
        
        sst.Trace('UT_BSO.Eql          PROCEDURE END')
        
        


