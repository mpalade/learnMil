UT_C2IPv2    CLASS, MODULE('UT_C2IPv2.clw'), LINK('UT_C2IPv2.clw'), TYPE

Construct               PROCEDURE
Destruct                PROCEDURE

InitContext             PROCEDURE
DestroyContext          PROCEDURE

    ! test C2IP set/get Name
SetGetName          PROCEDURE
    ! test Add BSO
AddBSO              PROCEDURE
FoundBSO            PROCEDURE
AddTwoBSO           PROCEDURE
    

    ! tess C2IP load BSOs contet
LoadBSOContent          PROCEDURE
    END