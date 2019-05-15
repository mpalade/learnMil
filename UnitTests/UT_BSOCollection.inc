UT_BSOCollection    CLASS, MODULE('UT_BSOCollection.clw'), LINK('UT_BSOCollection.clw'), TYPE

Construct               PROCEDURE
Destruct                PROCEDURE

InitContext             PROCEDURE
DestroyContext          PROCEDURE

InsertNode                      PROCEDURE(), BOOL
InsertNodeOnEmptyCollection     PROCEDURE(), BOOL
InsertTwoNodes                  PROCEDURE(), BOOL
InsertTwoNodesSelectUp          PROCEDURE(), BOOL
InsertTwoNodesSelectUpUp        PROCEDURE(), BOOL
InsertTwoNodesSelectDown        PROCEDURE(), BOOL
InsertTwoNodesSelectDownDown    PROCEDURE(), BOOL

InsertSpecificNode      PROCEDURE(*UnitBasicRecord pURec), BOOL
AddSpecificNode         PROCEDURE(*UnitBasicRecord pURec), BOOL

InsertAndVerifyABSO     PROCEDURE()
    END
    