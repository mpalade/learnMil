  MEMBER('learnMil.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
learnMil_BC2:DctInit    PROCEDURE()
learnMil_BC2:DctKill    PROCEDURE()
learnMil_BC2:FilesInit  PROCEDURE()
  END

Hide:Access:C2       CLASS(FileManager),TYPE               ! FileManager for C2
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:C2       CLASS(RelationManager),TYPE           ! RelationManager for C2
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:C3       CLASS(FileManager),TYPE               ! FileManager for C3
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:C3       CLASS(RelationManager),TYPE           ! RelationManager for C3
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:C4       CLASS(FileManager),TYPE               ! FileManager for C4
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:C4       CLASS(RelationManager),TYPE           ! RelationManager for C4
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:C5       CLASS(FileManager),TYPE               ! FileManager for C5
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:C5       CLASS(RelationManager),TYPE           ! RelationManager for C5
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:FC       CLASS(FileManager),TYPE               ! FileManager for FC
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:FC       CLASS(RelationManager),TYPE           ! RelationManager for FC
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:OpCom    CLASS(FileManager),TYPE               ! FileManager for OpCom
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:OpCom    CLASS(RelationManager),TYPE           ! RelationManager for OpCom
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:OpCon    CLASS(FileManager),TYPE               ! FileManager for OpCon
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:OpCon    CLASS(RelationManager),TYPE           ! RelationManager for OpCon
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:TaCom    CLASS(FileManager),TYPE               ! FileManager for TaCom
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:TaCom    CLASS(RelationManager),TYPE           ! RelationManager for TaCom
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:TaCon    CLASS(FileManager),TYPE               ! FileManager for TaCon
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:TaCon    CLASS(RelationManager),TYPE           ! RelationManager for TaCon
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Supported CLASS(FileManager),TYPE              ! FileManager for Supported
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Supported CLASS(RelationManager),TYPE          ! RelationManager for Supported
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Supporting CLASS(FileManager),TYPE             ! FileManager for Supporting
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Supporting CLASS(RelationManager),TYPE         ! RelationManager for Supporting
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:P        CLASS(FileManager),TYPE               ! FileManager for P
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:P        CLASS(RelationManager),TYPE           ! RelationManager for P
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:Adm      CLASS(FileManager),TYPE               ! FileManager for Adm
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:Adm      CLASS(RelationManager),TYPE           ! RelationManager for Adm
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_Units   CLASS(FileManager),TYPE               ! FileManager for _Units
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_Units   CLASS(RelationManager),TYPE           ! RelationManager for _Units
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_UnitsPositions CLASS(FileManager),TYPE        ! FileManager for _UnitsPositions
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_UnitsPositions CLASS(RelationManager),TYPE    ! RelationManager for _UnitsPositions
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieUnitsPositions CLASS(FileManager),TYPE    ! FileManager for _c2ieUnitsPositions
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieUnitsPositions CLASS(RelationManager),TYPE ! RelationManager for _c2ieUnitsPositions
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieUnits CLASS(FileManager),TYPE             ! FileManager for _c2ieUnits
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieUnits CLASS(RelationManager),TYPE         ! RelationManager for _c2ieUnits
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IPContent CLASS(FileManager),TYPE           ! FileManager for _C2IPContent
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IPContent CLASS(RelationManager),TYPE       ! RelationManager for _C2IPContent
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieTaskOrg CLASS(FileManager),TYPE           ! FileManager for _c2ieTaskOrg
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieTaskOrg CLASS(RelationManager),TYPE       ! RelationManager for _c2ieTaskOrg
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IEs   CLASS(FileManager),TYPE               ! FileManager for _C2IEs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IEs   CLASS(RelationManager),TYPE           ! RelationManager for _C2IEs
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:C2      &Hide:Access:C2,AUTO,THREAD
_Hide:Relate:C2      &Hide:Relate:C2,AUTO,THREAD
_Hide:Access:C3      &Hide:Access:C3,AUTO,THREAD
_Hide:Relate:C3      &Hide:Relate:C3,AUTO,THREAD
_Hide:Access:C4      &Hide:Access:C4,AUTO,THREAD
_Hide:Relate:C4      &Hide:Relate:C4,AUTO,THREAD
_Hide:Access:C5      &Hide:Access:C5,AUTO,THREAD
_Hide:Relate:C5      &Hide:Relate:C5,AUTO,THREAD
_Hide:Access:FC      &Hide:Access:FC,AUTO,THREAD
_Hide:Relate:FC      &Hide:Relate:FC,AUTO,THREAD
_Hide:Access:OpCom   &Hide:Access:OpCom,AUTO,THREAD
_Hide:Relate:OpCom   &Hide:Relate:OpCom,AUTO,THREAD
_Hide:Access:OpCon   &Hide:Access:OpCon,AUTO,THREAD
_Hide:Relate:OpCon   &Hide:Relate:OpCon,AUTO,THREAD
_Hide:Access:TaCom   &Hide:Access:TaCom,AUTO,THREAD
_Hide:Relate:TaCom   &Hide:Relate:TaCom,AUTO,THREAD
_Hide:Access:TaCon   &Hide:Access:TaCon,AUTO,THREAD
_Hide:Relate:TaCon   &Hide:Relate:TaCon,AUTO,THREAD
_Hide:Access:Supported &Hide:Access:Supported,AUTO,THREAD
_Hide:Relate:Supported &Hide:Relate:Supported,AUTO,THREAD
_Hide:Access:Supporting &Hide:Access:Supporting,AUTO,THREAD
_Hide:Relate:Supporting &Hide:Relate:Supporting,AUTO,THREAD
_Hide:Access:P       &Hide:Access:P,AUTO,THREAD
_Hide:Relate:P       &Hide:Relate:P,AUTO,THREAD
_Hide:Access:Adm     &Hide:Access:Adm,AUTO,THREAD
_Hide:Relate:Adm     &Hide:Relate:Adm,AUTO,THREAD
_Hide:Access:_Units  &Hide:Access:_Units,AUTO,THREAD
_Hide:Relate:_Units  &Hide:Relate:_Units,AUTO,THREAD
_Hide:Access:_UnitsPositions &Hide:Access:_UnitsPositions,AUTO,THREAD
_Hide:Relate:_UnitsPositions &Hide:Relate:_UnitsPositions,AUTO,THREAD
_Hide:Access:_c2ieUnitsPositions &Hide:Access:_c2ieUnitsPositions,AUTO,THREAD
_Hide:Relate:_c2ieUnitsPositions &Hide:Relate:_c2ieUnitsPositions,AUTO,THREAD
_Hide:Access:_c2ieUnits &Hide:Access:_c2ieUnits,AUTO,THREAD
_Hide:Relate:_c2ieUnits &Hide:Relate:_c2ieUnits,AUTO,THREAD
_Hide:Access:_C2IPContent &Hide:Access:_C2IPContent,AUTO,THREAD
_Hide:Relate:_C2IPContent &Hide:Relate:_C2IPContent,AUTO,THREAD
_Hide:Access:_c2ieTaskOrg &Hide:Access:_c2ieTaskOrg,AUTO,THREAD
_Hide:Relate:_c2ieTaskOrg &Hide:Relate:_c2ieTaskOrg,AUTO,THREAD
_Hide:Access:_C2IEs  &Hide:Access:_C2IEs,AUTO,THREAD
_Hide:Relate:_C2IEs  &Hide:Relate:_C2IEs,AUTO,THREAD


learnMil_BC2:DctInit PROCEDURE()
  CODE
  _Hide:Access:C2 &= NEW(Hide:Access:C2)
  _Hide:Relate:C2 &= NEW(Hide:Relate:C2)
  _Hide:Access:C3 &= NEW(Hide:Access:C3)
  _Hide:Relate:C3 &= NEW(Hide:Relate:C3)
  _Hide:Access:C4 &= NEW(Hide:Access:C4)
  _Hide:Relate:C4 &= NEW(Hide:Relate:C4)
  _Hide:Access:C5 &= NEW(Hide:Access:C5)
  _Hide:Relate:C5 &= NEW(Hide:Relate:C5)
  _Hide:Access:FC &= NEW(Hide:Access:FC)
  _Hide:Relate:FC &= NEW(Hide:Relate:FC)
  _Hide:Access:OpCom &= NEW(Hide:Access:OpCom)
  _Hide:Relate:OpCom &= NEW(Hide:Relate:OpCom)
  _Hide:Access:OpCon &= NEW(Hide:Access:OpCon)
  _Hide:Relate:OpCon &= NEW(Hide:Relate:OpCon)
  _Hide:Access:TaCom &= NEW(Hide:Access:TaCom)
  _Hide:Relate:TaCom &= NEW(Hide:Relate:TaCom)
  _Hide:Access:TaCon &= NEW(Hide:Access:TaCon)
  _Hide:Relate:TaCon &= NEW(Hide:Relate:TaCon)
  _Hide:Access:Supported &= NEW(Hide:Access:Supported)
  _Hide:Relate:Supported &= NEW(Hide:Relate:Supported)
  _Hide:Access:Supporting &= NEW(Hide:Access:Supporting)
  _Hide:Relate:Supporting &= NEW(Hide:Relate:Supporting)
  _Hide:Access:P &= NEW(Hide:Access:P)
  _Hide:Relate:P &= NEW(Hide:Relate:P)
  _Hide:Access:Adm &= NEW(Hide:Access:Adm)
  _Hide:Relate:Adm &= NEW(Hide:Relate:Adm)
  _Hide:Access:_Units &= NEW(Hide:Access:_Units)
  _Hide:Relate:_Units &= NEW(Hide:Relate:_Units)
  _Hide:Access:_UnitsPositions &= NEW(Hide:Access:_UnitsPositions)
  _Hide:Relate:_UnitsPositions &= NEW(Hide:Relate:_UnitsPositions)
  _Hide:Access:_c2ieUnitsPositions &= NEW(Hide:Access:_c2ieUnitsPositions)
  _Hide:Relate:_c2ieUnitsPositions &= NEW(Hide:Relate:_c2ieUnitsPositions)
  _Hide:Access:_c2ieUnits &= NEW(Hide:Access:_c2ieUnits)
  _Hide:Relate:_c2ieUnits &= NEW(Hide:Relate:_c2ieUnits)
  _Hide:Access:_C2IPContent &= NEW(Hide:Access:_C2IPContent)
  _Hide:Relate:_C2IPContent &= NEW(Hide:Relate:_C2IPContent)
  _Hide:Access:_c2ieTaskOrg &= NEW(Hide:Access:_c2ieTaskOrg)
  _Hide:Relate:_c2ieTaskOrg &= NEW(Hide:Relate:_c2ieTaskOrg)
  _Hide:Access:_C2IEs &= NEW(Hide:Access:_C2IEs)
  _Hide:Relate:_C2IEs &= NEW(Hide:Relate:_C2IEs)
  Relate:C2 &= _Hide:Relate:C2
  Relate:C3 &= _Hide:Relate:C3
  Relate:C4 &= _Hide:Relate:C4
  Relate:C5 &= _Hide:Relate:C5
  Relate:FC &= _Hide:Relate:FC
  Relate:OpCom &= _Hide:Relate:OpCom
  Relate:OpCon &= _Hide:Relate:OpCon
  Relate:TaCom &= _Hide:Relate:TaCom
  Relate:TaCon &= _Hide:Relate:TaCon
  Relate:Supported &= _Hide:Relate:Supported
  Relate:Supporting &= _Hide:Relate:Supporting
  Relate:P &= _Hide:Relate:P
  Relate:Adm &= _Hide:Relate:Adm
  Relate:_Units &= _Hide:Relate:_Units
  Relate:_UnitsPositions &= _Hide:Relate:_UnitsPositions
  Relate:_c2ieUnitsPositions &= _Hide:Relate:_c2ieUnitsPositions
  Relate:_c2ieUnits &= _Hide:Relate:_c2ieUnits
  Relate:_C2IPContent &= _Hide:Relate:_C2IPContent
  Relate:_c2ieTaskOrg &= _Hide:Relate:_c2ieTaskOrg
  Relate:_C2IEs &= _Hide:Relate:_C2IEs


learnMil_BC2:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:C2.Init
  _Hide:Relate:C3.Init
  _Hide:Relate:C4.Init
  _Hide:Relate:C5.Init
  _Hide:Relate:FC.Init
  _Hide:Relate:OpCom.Init
  _Hide:Relate:OpCon.Init
  _Hide:Relate:TaCom.Init
  _Hide:Relate:TaCon.Init
  _Hide:Relate:Supported.Init
  _Hide:Relate:Supporting.Init
  _Hide:Relate:P.Init
  _Hide:Relate:Adm.Init
  _Hide:Relate:_Units.Init
  _Hide:Relate:_UnitsPositions.Init
  _Hide:Relate:_c2ieUnitsPositions.Init
  _Hide:Relate:_c2ieUnits.Init
  _Hide:Relate:_C2IPContent.Init
  _Hide:Relate:_c2ieTaskOrg.Init
  _Hide:Relate:_C2IEs.Init


learnMil_BC2:DctKill PROCEDURE()
  CODE
  _Hide:Relate:C2.Kill
  DISPOSE(_Hide:Relate:C2)
  _Hide:Relate:C3.Kill
  DISPOSE(_Hide:Relate:C3)
  _Hide:Relate:C4.Kill
  DISPOSE(_Hide:Relate:C4)
  _Hide:Relate:C5.Kill
  DISPOSE(_Hide:Relate:C5)
  _Hide:Relate:FC.Kill
  DISPOSE(_Hide:Relate:FC)
  _Hide:Relate:OpCom.Kill
  DISPOSE(_Hide:Relate:OpCom)
  _Hide:Relate:OpCon.Kill
  DISPOSE(_Hide:Relate:OpCon)
  _Hide:Relate:TaCom.Kill
  DISPOSE(_Hide:Relate:TaCom)
  _Hide:Relate:TaCon.Kill
  DISPOSE(_Hide:Relate:TaCon)
  _Hide:Relate:Supported.Kill
  DISPOSE(_Hide:Relate:Supported)
  _Hide:Relate:Supporting.Kill
  DISPOSE(_Hide:Relate:Supporting)
  _Hide:Relate:P.Kill
  DISPOSE(_Hide:Relate:P)
  _Hide:Relate:Adm.Kill
  DISPOSE(_Hide:Relate:Adm)
  _Hide:Relate:_Units.Kill
  DISPOSE(_Hide:Relate:_Units)
  _Hide:Relate:_UnitsPositions.Kill
  DISPOSE(_Hide:Relate:_UnitsPositions)
  _Hide:Relate:_c2ieUnitsPositions.Kill
  DISPOSE(_Hide:Relate:_c2ieUnitsPositions)
  _Hide:Relate:_c2ieUnits.Kill
  DISPOSE(_Hide:Relate:_c2ieUnits)
  _Hide:Relate:_C2IPContent.Kill
  DISPOSE(_Hide:Relate:_C2IPContent)
  _Hide:Relate:_c2ieTaskOrg.Kill
  DISPOSE(_Hide:Relate:_c2ieTaskOrg)
  _Hide:Relate:_C2IEs.Kill
  DISPOSE(_Hide:Relate:_C2IEs)


Hide:Relate:C2.Init PROCEDURE()
  CODE
  _Hide:Access:C2.Init
  SELF.Init(Access:C2,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:C2.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniC2:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'C2'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= C2
  PARENT.Init
  Access:C2 &= SELF


Hide:Access:C2.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:C2 &= NULL                                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:C2.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(C2,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniC2:PKID,'UniC2:PKID',1)
    SELF.AddKey(UniC2:KName,'UniC2:KName',0)
    SELF.AddKey(UniC2:KCode,'UniC2:KCode',0)
    SELF.AddKey(UniC2:KBSOType,'UniC2:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:C2.Kill PROCEDURE

  CODE
  _Hide:Access:C2.Kill                                     ! Kill the file manager
  PARENT.Kill
  Relate:C2 &= NULL                                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:C2)                                 ! destroy the file manager


Hide:Relate:C3.Init PROCEDURE()
  CODE
  _Hide:Access:C3.Init
  SELF.Init(Access:C3,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:C3.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniC3:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'C3'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= C3
  PARENT.Init
  Access:C3 &= SELF


Hide:Access:C3.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:C3 &= NULL                                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:C3.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(C3,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniC3:PKID,'UniC3:PKID',1)
    SELF.AddKey(UniC3:KName,'UniC3:KName',0)
    SELF.AddKey(UniC3:KCode,'UniC3:KCode',0)
    SELF.AddKey(UniC3:KBSOType,'UniC3:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:C3.Kill PROCEDURE

  CODE
  _Hide:Access:C3.Kill                                     ! Kill the file manager
  PARENT.Kill
  Relate:C3 &= NULL                                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:C3)                                 ! destroy the file manager


Hide:Relate:C4.Init PROCEDURE()
  CODE
  _Hide:Access:C4.Init
  SELF.Init(Access:C4,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:C4.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniC4:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'C4'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= C4
  PARENT.Init
  Access:C4 &= SELF


Hide:Access:C4.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:C4 &= NULL                                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:C4.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(C4,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniC4:PKID,'UniC4:PKID',1)
    SELF.AddKey(UniC4:KName,'UniC4:KName',0)
    SELF.AddKey(UniC4:KCode,'UniC4:KCode',0)
    SELF.AddKey(UniC4:KBSOType,'UniC4:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:C4.Kill PROCEDURE

  CODE
  _Hide:Access:C4.Kill                                     ! Kill the file manager
  PARENT.Kill
  Relate:C4 &= NULL                                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:C4)                                 ! destroy the file manager


Hide:Relate:C5.Init PROCEDURE()
  CODE
  _Hide:Access:C5.Init
  SELF.Init(Access:C5,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:C5.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniC5:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'C5'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= C5
  PARENT.Init
  Access:C5 &= SELF


Hide:Access:C5.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:C5 &= NULL                                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:C5.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(C5,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniC5:PKID,'UniC5:PKID',1)
    SELF.AddKey(UniC5:KName,'UniC5:KName',0)
    SELF.AddKey(UniC5:KCode,'UniC5:KCode',0)
    SELF.AddKey(UniC5:KBSOType,'UniC5:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:C5.Kill PROCEDURE

  CODE
  _Hide:Access:C5.Kill                                     ! Kill the file manager
  PARENT.Kill
  Relate:C5 &= NULL                                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:C5)                                 ! destroy the file manager


Hide:Relate:FC.Init PROCEDURE()
  CODE
  _Hide:Access:FC.Init
  SELF.Init(Access:FC,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:FC.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniFC:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'FC'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= FC
  PARENT.Init
  Access:FC &= SELF


Hide:Access:FC.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:FC &= NULL                                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:FC.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(FC,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniFC:PKID,'UniFC:PKID',1)
    SELF.AddKey(UniFC:KName,'UniFC:KName',0)
    SELF.AddKey(UniFC:KCode,'UniFC:KCode',0)
    SELF.AddKey(UniFC:KBSOType,'UniFC:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:FC.Kill PROCEDURE

  CODE
  _Hide:Access:FC.Kill                                     ! Kill the file manager
  PARENT.Kill
  Relate:FC &= NULL                                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:FC)                                 ! destroy the file manager


Hide:Relate:OpCom.Init PROCEDURE()
  CODE
  _Hide:Access:OpCom.Init
  SELF.Init(Access:OpCom,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:OpCom.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniOpCom:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'OpCom'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= OpCom
  PARENT.Init
  Access:OpCom &= SELF


Hide:Access:OpCom.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:OpCom &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:OpCom.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(OpCom,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniOpCom:PKID,'UniOpCom:PKID',1)
    SELF.AddKey(UniOpCom:KName,'UniOpCom:KName',0)
    SELF.AddKey(UniOpCom:KCode,'UniOpCom:KCode',0)
    SELF.AddKey(UniOpCom:KBSOType,'UniOpCom:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:OpCom.Kill PROCEDURE

  CODE
  _Hide:Access:OpCom.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:OpCom &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:OpCom)                              ! destroy the file manager


Hide:Relate:OpCon.Init PROCEDURE()
  CODE
  _Hide:Access:OpCon.Init
  SELF.Init(Access:OpCon,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:OpCon.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniOpCon:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'OpCon'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= OpCon
  PARENT.Init
  Access:OpCon &= SELF


Hide:Access:OpCon.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:OpCon &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:OpCon.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(OpCon,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniOpCon:PKID,'UniOpCon:PKID',1)
    SELF.AddKey(UniOpCon:KName,'UniOpCon:KName',0)
    SELF.AddKey(UniOpCon:KCode,'UniOpCon:KCode',0)
    SELF.AddKey(UniOpCon:KBSOType,'UniOpCon:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:OpCon.Kill PROCEDURE

  CODE
  _Hide:Access:OpCon.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:OpCon &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:OpCon)                              ! destroy the file manager


Hide:Relate:TaCom.Init PROCEDURE()
  CODE
  _Hide:Access:TaCom.Init
  SELF.Init(Access:TaCom,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:TaCom.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniTaCom:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'TaCom'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TaCom
  PARENT.Init
  Access:TaCom &= SELF


Hide:Access:TaCom.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TaCom &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TaCom.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TaCom,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniTaCom:PKID,'UniTaCom:PKID',1)
    SELF.AddKey(UniTaCom:KName,'UniTaCom:KName',0)
    SELF.AddKey(UniTaCom:KCode,'UniTaCom:KCode',0)
    SELF.AddKey(UniTaCom:KBSOType,'UniTaCom:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TaCom.Kill PROCEDURE

  CODE
  _Hide:Access:TaCom.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:TaCom &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TaCom)                              ! destroy the file manager


Hide:Relate:TaCon.Init PROCEDURE()
  CODE
  _Hide:Access:TaCon.Init
  SELF.Init(Access:TaCon,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:TaCon.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniTaCon:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'TaCon'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= TaCon
  PARENT.Init
  Access:TaCon &= SELF


Hide:Access:TaCon.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:TaCon &= NULL                                     ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:TaCon.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(TaCon,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniTaCon:PKID,'UniTaCon:PKID',1)
    SELF.AddKey(UniTaCon:KName,'UniTaCon:KName',0)
    SELF.AddKey(UniTaCon:KCode,'UniTaCon:KCode',0)
    SELF.AddKey(UniTaCon:KBSOType,'UniTaCon:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:TaCon.Kill PROCEDURE

  CODE
  _Hide:Access:TaCon.Kill                                  ! Kill the file manager
  PARENT.Kill
  Relate:TaCon &= NULL                                     ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:TaCon)                              ! destroy the file manager


Hide:Relate:Supported.Init PROCEDURE()
  CODE
  _Hide:Access:Supported.Init
  SELF.Init(Access:Supported,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:Supported.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniSpted:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'Supported'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Supported
  PARENT.Init
  Access:Supported &= SELF


Hide:Access:Supported.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Supported &= NULL                                 ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Supported.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Supported,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniSpted:PKID,'UniSpted:PKID',1)
    SELF.AddKey(UniSpted:KName,'UniSpted:KName',0)
    SELF.AddKey(UniSpted:KCode,'UniSpted:KCode',0)
    SELF.AddKey(UniSpted:KBSOType,'UniSpted:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Supported.Kill PROCEDURE

  CODE
  _Hide:Access:Supported.Kill                              ! Kill the file manager
  PARENT.Kill
  Relate:Supported &= NULL                                 ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Supported)                          ! destroy the file manager


Hide:Relate:Supporting.Init PROCEDURE()
  CODE
  _Hide:Access:Supporting.Init
  SELF.Init(Access:Supporting,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:Supporting.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniSping:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'Supporting'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Supporting
  PARENT.Init
  Access:Supporting &= SELF


Hide:Access:Supporting.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Supporting &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Supporting.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Supporting,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniSping:PKID,'UniSping:PKID',1)
    SELF.AddKey(UniSping:KName,'UniSping:KName',0)
    SELF.AddKey(UniSping:KCode,'UniSping:KCode',0)
    SELF.AddKey(UniSping:KBSOType,'UniSping:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Supporting.Kill PROCEDURE

  CODE
  _Hide:Access:Supporting.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:Supporting &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Supporting)                         ! destroy the file manager


Hide:Relate:P.Init PROCEDURE()
  CODE
  _Hide:Access:P.Init
  SELF.Init(Access:P,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:P.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniP:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'P'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= P
  PARENT.Init
  Access:P &= SELF


Hide:Access:P.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:P &= NULL                                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:P.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(P,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniP:PKID,'UniP:PKID',1)
    SELF.AddKey(UniP:KName,'UniP:KName',0)
    SELF.AddKey(UniP:KCode,'UniP:KCode',0)
    SELF.AddKey(UniP:KBSOType,'UniP:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:P.Kill PROCEDURE

  CODE
  _Hide:Access:P.Kill                                      ! Kill the file manager
  PARENT.Kill
  Relate:P &= NULL                                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:P)                                  ! destroy the file manager


Hide:Relate:Adm.Init PROCEDURE()
  CODE
  _Hide:Access:Adm.Init
  SELF.Init(Access:Adm,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:Adm.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= UniAdm:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = 'Adm'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= Adm
  PARENT.Init
  Access:Adm &= SELF


Hide:Access:Adm.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:Adm &= NULL                                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:Adm.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(Adm,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(UniAdm:PKID,'UniAdm:PKID',1)
    SELF.AddKey(UniAdm:KName,'UniAdm:KName',0)
    SELF.AddKey(UniAdm:KCode,'UniAdm:KCode',0)
    SELF.AddKey(UniAdm:KBSOType,'UniAdm:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:Adm.Kill PROCEDURE

  CODE
  _Hide:Access:Adm.Kill                                    ! Kill the file manager
  PARENT.Kill
  Relate:Adm &= NULL                                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:Adm)                                ! destroy the file manager


Hide:Relate:_Units.Init PROCEDURE()
  CODE
  _Hide:Access:_Units.Init
  SELF.Init(Access:_Units,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:_Units.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _Uni:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_Units'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _Units
  PARENT.Init
  Access:_Units &= SELF


Hide:Access:_Units.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_Units &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_Units.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_Units,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_Uni:PKID,'_Uni:PKID',1)
    SELF.AddKey(_Uni:KName,'_Uni:KName',0)
    SELF.AddKey(_Uni:KCode,'_Uni:KCode',0)
    SELF.AddKey(_Uni:KBSOType,'_Uni:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_Units.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_c2ieBSO_TASKORGs,RI:None,RI:None,_c2ieBSOTSK:KUnit)
  SELF.AddRelationLink(_Uni:ID,_c2ieBSOTSK:Unit)


Hide:Relate:_Units.Kill PROCEDURE

  CODE
  _Hide:Access:_Units.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:_Units &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_Units)                             ! destroy the file manager


Hide:Relate:_UnitsPositions.Init PROCEDURE()
  CODE
  _Hide:Access:_UnitsPositions.Init
  SELF.Init(Access:_UnitsPositions,1)
  SELF.SetAlias(Relate:UnitsPositions)


Hide:Access:_UnitsPositions.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _UniPos:Record
  SELF.AliasedFile &= Access:UnitsPositions                !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_UnitsPositions'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _UnitsPositions
  PARENT.Init
  Access:_UnitsPositions &= SELF


Hide:Access:_UnitsPositions.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_UnitsPositions &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_UnitsPositions.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_UnitsPositions,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_UniPos:PKID,'_UniPos:PKID',1)
    SELF.AddKey(_UniPos:KUnit,'_UniPos:KUnit',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_UnitsPositions.Kill PROCEDURE

  CODE
  _Hide:Access:_UnitsPositions.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:_UnitsPositions &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_UnitsPositions)                    ! destroy the file manager


Hide:Relate:_c2ieUnitsPositions.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieUnitsPositions.Init
  SELF.Init(Access:_c2ieUnitsPositions,1)
  SELF.SetAlias(Relate:c2ieUnitsPositions)


Hide:Access:_c2ieUnitsPositions.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieUniPos:Record
  SELF.AliasedFile &= Access:c2ieUnitsPositions            !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieUnitsPositions'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieUnitsPositions
  PARENT.Init
  Access:_c2ieUnitsPositions &= SELF


Hide:Access:_c2ieUnitsPositions.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieUnitsPositions &= NULL                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieUnitsPositions.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieUnitsPositions,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieUniPos:PKID,'_c2ieUniPos:PKID',1)
    SELF.AddKey(_c2ieUniPos:Kc2ieUnit,'_c2ieUniPos:Kc2ieUnit',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieUnitsPositions.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieUnitsPositions.Kill                    ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieUnitsPositions &= NULL                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieUnitsPositions)                ! destroy the file manager


Hide:Relate:_c2ieUnits.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieUnits.Init
  SELF.Init(Access:_c2ieUnits,1)
  SELF.SetAlias(Relate:c2ieUnits)


Hide:Access:_c2ieUnits.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieUni:Record
  SELF.AliasedFile &= Access:c2ieUnits                     !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieUnits'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieUnits
  PARENT.Init
  Access:_c2ieUnits &= SELF


Hide:Access:_c2ieUnits.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieUnits &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieUnits.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieUnits,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieUni:PKID,'_c2ieUni:PKID',1)
    SELF.AddKey(_c2ieUni:KC2IEUnit,'_c2ieUni:KC2IEUnit',0)
    SELF.AddKey(_c2ieUni:KC2IE,'_c2ieUni:KC2IE',0)
    SELF.AddKey(_c2ieUni:KUnit,'_c2ieUni:KUnit',0)
    SELF.AddKey(_c2ieUni:KHostility,'_c2ieUni:KHostility',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieUnits.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieUnits.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieUnits &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieUnits)                         ! destroy the file manager


Hide:Relate:_C2IPContent.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IPContent.Init
  SELF.Init(Access:_C2IPContent,1)
  SELF.SetAlias(Relate:C2IPContent)


Hide:Access:_C2IPContent.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IPCt:Record
  SELF.AliasedFile &= Access:C2IPContent                   !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IPContent'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IPContent
  PARENT.Init
  Access:_C2IPContent &= SELF


Hide:Access:_C2IPContent.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IPContent &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IPContent.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IPContent,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IPCt:PKID,'_C2IPCt:PKID',1)
    SELF.AddKey(_C2IPCt:KC2IP,'_C2IPCt:KC2IP',0)
    SELF.AddKey(_C2IPCt:KC2IE,'_C2IPCt:KC2IE',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IPContent.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_C2IPs)

  SELF.AddRelation(Relate:_C2IP_TaskOrgs)


Hide:Relate:_C2IPContent.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IPContent.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:_C2IPContent &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IPContent)                       ! destroy the file manager


Hide:Relate:_c2ieTaskOrg.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieTaskOrg.Init
  SELF.Init(Access:_c2ieTaskOrg,1)
  SELF.SetAlias(Relate:c2ieTaskOrg)


Hide:Access:_c2ieTaskOrg.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieTO:Record
  SELF.AliasedFile &= Access:c2ieTaskOrg                   !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieTaskOrg'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieTaskOrg
  PARENT.Init
  Access:_c2ieTaskOrg &= SELF


Hide:Access:_c2ieTaskOrg.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieTaskOrg &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieTaskOrg.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieTaskOrg,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieTO:PKID,'_c2ieTO:PKID',1)
    SELF.AddKey(_c2ieTO:KC2IE,'_c2ieTO:KC2IE',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieTaskOrg.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieTaskOrg.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieTaskOrg &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieTaskOrg)                       ! destroy the file manager


Hide:Relate:_C2IEs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IEs.Init
  SELF.Init(Access:_C2IEs,1)
  SELF.SetAlias(Relate:C2IEs)


Hide:Access:_C2IEs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IE:Record
  SELF.AliasedFile &= Access:C2IEs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IEs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IEs
  PARENT.Init
  Access:_C2IEs &= SELF


Hide:Access:_C2IEs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IEs &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IEs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IEs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IE:PKID,'_C2IE:PKID',1)
    SELF.AddKey(_C2IE:KType,'_C2IE:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IEs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IEs.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:_C2IEs &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IEs)                             ! destroy the file manager

