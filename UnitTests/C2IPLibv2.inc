
! BSO

! BSO Collection

! non visual C2IP class
nvC2IP                              CLASS, |
                                        MODULE('nvC2IP.clw'), lINK('nvC2IP.clw'), TYPE
Name                                        STRING(100)
content                                     &UnitsCollection, PROTECTED

GetContentCount                             PROCEDURE(), LONG



Construct               PROCEDURE
Destruct                                    PROCEDURE

AddBSO                                      PROCEDURE(BSO aBSO), BOOL
FoundBSO                                    PROCEDURE(BSO aBSO, BSO foundBSO, *LONG pFoundPos), BOOL 
ReplaceBSO                                  PROCEDURE(BSO origBSO, BSO newBSO), BOOL

! Add several BSOs as BSO Collection
AddBSOColl                                  PROCEDURE(UnitsCollection BSOColl), BOOL

                                        END

