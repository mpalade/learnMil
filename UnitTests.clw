
                    PROGRAM

Draw:TemplateVersion equate('3.57')
jFiles:TemplateVersion equate('1.41')
StringTheory:TemplateVersion        equate('2.58')


    include('draw.inc'),once
    include('drawheader.inc'),once
    include('drawpaint.inc'),once
    include('jFiles.inc'),ONCE
    include('StringTheory.Inc'),ONCE

    INCLUDE('pmC2IPLibrary.inc'), ONCE
    INCLUDE('UT_BSOCollection.inc'), ONCE
    INCLUDE('UT_OrgChartC2ip.inc'), ONCE


OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 10.01.2019
 * Time: 10:31
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

                    MAP

HelloWorld              PROCEDURE

InitContext             PROCEDURE
DestroyContext          PROCEDURE

OrgChartInitContext     PROCEDURE
OrgChartDestroyContext  PROCEDURE

  END


testBSOCollection   UT_BSOCollection
aRecord             GROUP(UnitBasicRecord)
                    END

testOrgChart        UT_OrgChartC2IP


    CODE
        HelloWorld()
        
        OMIT('__tests')
        
        InitContext()        
        testBSOCollection.InsertNode()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertNodeOnEmptyCollection()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertTwoNodes()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertTwoNodesSelectUp()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertTwoNodesSelectUpUp()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertTwoNodesSelectDown()
        DestroyContext()
        
        InitContext()        
        testBSOCollection.InsertTwoNodesSelectDownDown()
        DestroyContext()
        
        InitContext()        
        aRecord.UnitName    = 'myName'
        aRecord.UnitTypeCode    = uTpy:Amphibious
        aRecord.Echelon         = echTpy:Brigade
        aRecord.Hostility       = hTpy:Hostile
        aRecord.IsHQ            = TRUE
        testBSOCollection.InsertSpecificNode(aRecord)
        DestroyContext()
        
        __tests
        
        OrgChartInitContext()
            testOrgChart.InsertNode()
        OrgChartDestroyContext()
        
        
HelloWorld          PROCEDURE
    CODE
        MESSAGE('Hello World')

        
InitContext         PROCEDURE
    CODE
        testBSOCollection.InitContext()        
        
DestroyContext      PROCEDURE
    CODE
        testBSOCollection.DestroyContext()        
        
OrgChartInitContext PROCEDURE
    CODE
        testOrgChart.InitContext()
        
OrgChartDestroyContext      PROCEDURE
    CODE
        testOrgChart.DestroyContext()