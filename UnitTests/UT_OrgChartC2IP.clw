

  MEMBER('UnitTests')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 15.01.2019
 * Time: 1:11
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

  MAP
    END

anOrgChart          &OrgChartC2IP
aDraw               &Draw

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

    INCLUDE('UT_OrgChartC2IP.INC'),ONCE

UT_OrgChartC2IP.InitContext PROCEDURE
    CODE
        aDraw       &= NEW(Draw)
        anOrgChart  &= NEW(OrgChartC2IP)
        
        anOrgChart.InitDraw(aDraw)
        
UT_OrgChartC2IP.DestroyContext      PROCEDURE
    CODE
        DISPOSE(anOrgChart)
        DISPOSE(aDraw)        
        
UT_OrgChartC2IP.Construct  PROCEDURE
    CODE                        
        
        
UT_OrgChartC2IP.Destruct   PROCEDURE
    CODE                


UT_OrgChartC2IP.InsertNode  PROCEDURE
    CODE
        !aDraw.Box(10, 10, 10, 10)
        !aDraw.Show(5, 5, 'mama')       
        !aDraw.Display()
        !aDraw.Blank()
        
        !anOrgChart.InsertNode()
        !ASSERT(anOrgChart.Name = 'mama', 'UT_OrgChartC2IP.InsertNode:anOrgChart.Name = ' & anOrgChart.Name )
        RETURN TRUE
        


