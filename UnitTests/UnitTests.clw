
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

  END


testBSOCollection   UT_BSOCollection
    CODE
        HelloWorld()
        testBSOCollection.InsertNode()
        
        
HelloWorld          PROCEDURE
    CODE
        MESSAGE('Hello World')
