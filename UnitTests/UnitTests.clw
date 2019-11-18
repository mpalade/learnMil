
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
    INCLUDE('UT_BSO.inc'), ONCE
    INCLUDE('UT_BSOCollection.inc'), ONCE
    INCLUDE('UT_C2IP.inc'), ONCE
    INCLUDE('UT_OrgChartC2ip.inc'), ONCE

    ! C2IP Library v2
    INCLUDE('C2IPLibv2.inc'), ONCE
    INCLUDE('UT_C2IPv2.inc'), ONCE


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

C2IPInitContext         PROCEDURE
C2IPDestroyContext      PROCEDURE

OrgChartInitContext     PROCEDURE
OrgChartDestroyContext  PROCEDURE

C2IPv2_InitContext      PROCEDURE
C2IPv2_DestroyContext   PROCEDURE

  END

! string theory objects
sst                 stringtheory

testBSO             UT_BSO

testBSOCollection   UT_BSOCollection
aRecord             GROUP(UnitBasicRecord)
                    END

testC2IP            UT_C2IP
testOrgChart        UT_OrgChartC2IP

testC2IPv2          UT_C2IPv2


    CODE
        HelloWorld()
        
        !BSO Collection
        OMIT('_noCompile')
        
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
        
        _noCompile
        
        
        !C2IP        
        C2IPInitContext()
            testC2IP.SetGetName()
        C2IPDestroyContext()
        
        !C2IP v2
        C2IPv2_InitContext()
            testC2IPv2.SetGetName()
            testC2IPv2.AddBSO()
            testC2IPv2.AddTwoBSO()
        C2IPv2_DestroyContext()
        
        
        
        !OrgChart
        OMIT('_noCompile')
        OrgChartInitContext()
            testOrgChart.InsertNode()
        OrgChartDestroyContext()
        
        InitContext()
            aRecord.UnitName    = 'myName'
            aRecord.UnitTypeCode    = uTpy:Amphibious
            aRecord.Echelon         = echTpy:Brigade
            aRecord.Hostility       = hTpy:Hostile
            aRecord.IsHQ            = TRUE
            aRecord.xPos            = 100
            aRecord.yPos            = 100
            testBSOCollection.AddSpecificNode(aRecord)
        DestroyContext()
        _noCompile
        
        !BSO
        OMIT('_noCompile')
        ! BSO
        !testBSO.InitContext()
        testBSO.Eql()
        !testBSO.DestroyContext()
        
        ! BSO Collection
        !testBSOCollection.AddGet()
        testBSOCollection.Replace()
        _noCompile
        
        !BSO
        !OMIT('_noCompile')
        ! BSO Collection
        ! Units Collection
        
        testBSOCollection.InitContext()
        !testBSOCollection.InsertAndVerifyABSO()
        retCode#    = testBSOCollection.InsertAndFind()
        testBSOCollection.DestroyContext()
        !_noCompile
        
        
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

! C2IP Ccontrext        
C2IPInitContext PROCEDURE
    CODE
        testC2IP.InitContext()
        
C2IPDestroyContext      PROCEDURE
    CODE
        testC2IP.DestroyContext()        
        
! C2IPv2 Ccontrext        
C2IPv2_InitContext PROCEDURE
    CODE
        testC2IPv2.InitContext()
        
C2IPv2_DestroyContext      PROCEDURE
    CODE
        testC2IPv2.DestroyContext()                