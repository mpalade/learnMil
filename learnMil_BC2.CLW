  MEMBER('learnMil.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
learnMil_BC2:DctInit    PROCEDURE()
learnMil_BC2:DctKill    PROCEDURE()
learnMil_BC2:FilesInit  PROCEDURE()
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

Hide:Access:_c2ieBSO_Resources CLASS(FileManager),TYPE     ! FileManager for _c2ieBSO_Resources
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieBSO_Resources CLASS(RelationManager),TYPE ! RelationManager for _c2ieBSO_Resources
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieBSO_Objectives CLASS(FileManager),TYPE    ! FileManager for _c2ieBSO_Objectives
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieBSO_Objectives CLASS(RelationManager),TYPE ! RelationManager for _c2ieBSO_Objectives
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_Units_Resources CLASS(FileManager),TYPE       ! FileManager for _Units_Resources
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_Units_Resources CLASS(RelationManager),TYPE   ! RelationManager for _Units_Resources
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_Units_Objectives CLASS(FileManager),TYPE      ! FileManager for _Units_Objectives
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_Units_Objectives CLASS(RelationManager),TYPE  ! RelationManager for _Units_Objectives
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IPs   CLASS(FileManager),TYPE               ! FileManager for _C2IPs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IPs   CLASS(RelationManager),TYPE           ! RelationManager for _C2IPs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IP_TaskOrgs CLASS(FileManager),TYPE         ! FileManager for _C2IP_TaskOrgs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IP_TaskOrgs CLASS(RelationManager),TYPE     ! RelationManager for _C2IP_TaskOrgs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IP_ORBATs CLASS(FileManager),TYPE           ! FileManager for _C2IP_ORBATs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IP_ORBATs CLASS(RelationManager),TYPE       ! RelationManager for _C2IP_ORBATs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IE_ORBATs CLASS(FileManager),TYPE           ! FileManager for _C2IE_ORBATs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IE_ORBATs CLASS(RelationManager),TYPE       ! RelationManager for _C2IE_ORBATs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IE_TASKORGs CLASS(FileManager),TYPE         ! FileManager for _C2IE_TASKORGs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IE_TASKORGs CLASS(RelationManager),TYPE     ! RelationManager for _C2IE_TASKORGs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieBSO_ORBATs CLASS(FileManager),TYPE        ! FileManager for _c2ieBSO_ORBATs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieBSO_ORBATs CLASS(RelationManager),TYPE    ! RelationManager for _c2ieBSO_ORBATs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_c2ieBSO_TASKORGs CLASS(FileManager),TYPE      ! FileManager for _c2ieBSO_TASKORGs
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_c2ieBSO_TASKORGs CLASS(RelationManager),TYPE  ! RelationManager for _c2ieBSO_TASKORGs
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END

Hide:Access:_C2IEsFromTransfers CLASS(FileManager),TYPE    ! FileManager for _C2IEsFromTransfers
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:_C2IEsFromTransfers CLASS(RelationManager),TYPE ! RelationManager for _C2IEsFromTransfers
Init                   PROCEDURE
DeferedAddRelations    PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
                     END


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
_Hide:Access:_c2ieBSO_Resources &Hide:Access:_c2ieBSO_Resources,AUTO,THREAD
_Hide:Relate:_c2ieBSO_Resources &Hide:Relate:_c2ieBSO_Resources,AUTO,THREAD
_Hide:Access:_c2ieBSO_Objectives &Hide:Access:_c2ieBSO_Objectives,AUTO,THREAD
_Hide:Relate:_c2ieBSO_Objectives &Hide:Relate:_c2ieBSO_Objectives,AUTO,THREAD
_Hide:Access:_Units_Resources &Hide:Access:_Units_Resources,AUTO,THREAD
_Hide:Relate:_Units_Resources &Hide:Relate:_Units_Resources,AUTO,THREAD
_Hide:Access:_Units_Objectives &Hide:Access:_Units_Objectives,AUTO,THREAD
_Hide:Relate:_Units_Objectives &Hide:Relate:_Units_Objectives,AUTO,THREAD
_Hide:Access:_C2IPs  &Hide:Access:_C2IPs,AUTO,THREAD
_Hide:Relate:_C2IPs  &Hide:Relate:_C2IPs,AUTO,THREAD
_Hide:Access:_C2IP_TaskOrgs &Hide:Access:_C2IP_TaskOrgs,AUTO,THREAD
_Hide:Relate:_C2IP_TaskOrgs &Hide:Relate:_C2IP_TaskOrgs,AUTO,THREAD
_Hide:Access:_C2IP_ORBATs &Hide:Access:_C2IP_ORBATs,AUTO,THREAD
_Hide:Relate:_C2IP_ORBATs &Hide:Relate:_C2IP_ORBATs,AUTO,THREAD
_Hide:Access:_C2IE_ORBATs &Hide:Access:_C2IE_ORBATs,AUTO,THREAD
_Hide:Relate:_C2IE_ORBATs &Hide:Relate:_C2IE_ORBATs,AUTO,THREAD
_Hide:Access:_C2IE_TASKORGs &Hide:Access:_C2IE_TASKORGs,AUTO,THREAD
_Hide:Relate:_C2IE_TASKORGs &Hide:Relate:_C2IE_TASKORGs,AUTO,THREAD
_Hide:Access:_c2ieBSO_ORBATs &Hide:Access:_c2ieBSO_ORBATs,AUTO,THREAD
_Hide:Relate:_c2ieBSO_ORBATs &Hide:Relate:_c2ieBSO_ORBATs,AUTO,THREAD
_Hide:Access:_c2ieBSO_TASKORGs &Hide:Access:_c2ieBSO_TASKORGs,AUTO,THREAD
_Hide:Relate:_c2ieBSO_TASKORGs &Hide:Relate:_c2ieBSO_TASKORGs,AUTO,THREAD
_Hide:Access:_C2IEsFromTransfers &Hide:Access:_C2IEsFromTransfers,AUTO,THREAD
_Hide:Relate:_C2IEsFromTransfers &Hide:Relate:_C2IEsFromTransfers,AUTO,THREAD


learnMil_BC2:DctInit PROCEDURE()
  CODE
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
  _Hide:Access:_c2ieBSO_Resources &= NEW(Hide:Access:_c2ieBSO_Resources)
  _Hide:Relate:_c2ieBSO_Resources &= NEW(Hide:Relate:_c2ieBSO_Resources)
  _Hide:Access:_c2ieBSO_Objectives &= NEW(Hide:Access:_c2ieBSO_Objectives)
  _Hide:Relate:_c2ieBSO_Objectives &= NEW(Hide:Relate:_c2ieBSO_Objectives)
  _Hide:Access:_Units_Resources &= NEW(Hide:Access:_Units_Resources)
  _Hide:Relate:_Units_Resources &= NEW(Hide:Relate:_Units_Resources)
  _Hide:Access:_Units_Objectives &= NEW(Hide:Access:_Units_Objectives)
  _Hide:Relate:_Units_Objectives &= NEW(Hide:Relate:_Units_Objectives)
  _Hide:Access:_C2IPs &= NEW(Hide:Access:_C2IPs)
  _Hide:Relate:_C2IPs &= NEW(Hide:Relate:_C2IPs)
  _Hide:Access:_C2IP_TaskOrgs &= NEW(Hide:Access:_C2IP_TaskOrgs)
  _Hide:Relate:_C2IP_TaskOrgs &= NEW(Hide:Relate:_C2IP_TaskOrgs)
  _Hide:Access:_C2IP_ORBATs &= NEW(Hide:Access:_C2IP_ORBATs)
  _Hide:Relate:_C2IP_ORBATs &= NEW(Hide:Relate:_C2IP_ORBATs)
  _Hide:Access:_C2IE_ORBATs &= NEW(Hide:Access:_C2IE_ORBATs)
  _Hide:Relate:_C2IE_ORBATs &= NEW(Hide:Relate:_C2IE_ORBATs)
  _Hide:Access:_C2IE_TASKORGs &= NEW(Hide:Access:_C2IE_TASKORGs)
  _Hide:Relate:_C2IE_TASKORGs &= NEW(Hide:Relate:_C2IE_TASKORGs)
  _Hide:Access:_c2ieBSO_ORBATs &= NEW(Hide:Access:_c2ieBSO_ORBATs)
  _Hide:Relate:_c2ieBSO_ORBATs &= NEW(Hide:Relate:_c2ieBSO_ORBATs)
  _Hide:Access:_c2ieBSO_TASKORGs &= NEW(Hide:Access:_c2ieBSO_TASKORGs)
  _Hide:Relate:_c2ieBSO_TASKORGs &= NEW(Hide:Relate:_c2ieBSO_TASKORGs)
  _Hide:Access:_C2IEsFromTransfers &= NEW(Hide:Access:_C2IEsFromTransfers)
  _Hide:Relate:_C2IEsFromTransfers &= NEW(Hide:Relate:_C2IEsFromTransfers)
  Relate:Adm &= _Hide:Relate:Adm
  Relate:_Units &= _Hide:Relate:_Units
  Relate:_UnitsPositions &= _Hide:Relate:_UnitsPositions
  Relate:_c2ieUnitsPositions &= _Hide:Relate:_c2ieUnitsPositions
  Relate:_c2ieUnits &= _Hide:Relate:_c2ieUnits
  Relate:_C2IPContent &= _Hide:Relate:_C2IPContent
  Relate:_c2ieTaskOrg &= _Hide:Relate:_c2ieTaskOrg
  Relate:_C2IEs &= _Hide:Relate:_C2IEs
  Relate:_c2ieBSO_Resources &= _Hide:Relate:_c2ieBSO_Resources
  Relate:_c2ieBSO_Objectives &= _Hide:Relate:_c2ieBSO_Objectives
  Relate:_Units_Resources &= _Hide:Relate:_Units_Resources
  Relate:_Units_Objectives &= _Hide:Relate:_Units_Objectives
  Relate:_C2IPs &= _Hide:Relate:_C2IPs
  Relate:_C2IP_TaskOrgs &= _Hide:Relate:_C2IP_TaskOrgs
  Relate:_C2IP_ORBATs &= _Hide:Relate:_C2IP_ORBATs
  Relate:_C2IE_ORBATs &= _Hide:Relate:_C2IE_ORBATs
  Relate:_C2IE_TASKORGs &= _Hide:Relate:_C2IE_TASKORGs
  Relate:_c2ieBSO_ORBATs &= _Hide:Relate:_c2ieBSO_ORBATs
  Relate:_c2ieBSO_TASKORGs &= _Hide:Relate:_c2ieBSO_TASKORGs
  Relate:_C2IEsFromTransfers &= _Hide:Relate:_C2IEsFromTransfers


learnMil_BC2:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:Adm.Init
  _Hide:Relate:_Units.Init
  _Hide:Relate:_UnitsPositions.Init
  _Hide:Relate:_c2ieUnitsPositions.Init
  _Hide:Relate:_c2ieUnits.Init
  _Hide:Relate:_C2IPContent.Init
  _Hide:Relate:_c2ieTaskOrg.Init
  _Hide:Relate:_C2IEs.Init
  _Hide:Relate:_c2ieBSO_Resources.Init
  _Hide:Relate:_c2ieBSO_Objectives.Init
  _Hide:Relate:_Units_Resources.Init
  _Hide:Relate:_Units_Objectives.Init
  _Hide:Relate:_C2IPs.Init
  _Hide:Relate:_C2IP_TaskOrgs.Init
  _Hide:Relate:_C2IP_ORBATs.Init
  _Hide:Relate:_C2IE_ORBATs.Init
  _Hide:Relate:_C2IE_TASKORGs.Init
  _Hide:Relate:_c2ieBSO_ORBATs.Init
  _Hide:Relate:_c2ieBSO_TASKORGs.Init
  _Hide:Relate:_C2IEsFromTransfers.Init


learnMil_BC2:DctKill PROCEDURE()
  CODE
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
  _Hide:Relate:_c2ieBSO_Resources.Kill
  DISPOSE(_Hide:Relate:_c2ieBSO_Resources)
  _Hide:Relate:_c2ieBSO_Objectives.Kill
  DISPOSE(_Hide:Relate:_c2ieBSO_Objectives)
  _Hide:Relate:_Units_Resources.Kill
  DISPOSE(_Hide:Relate:_Units_Resources)
  _Hide:Relate:_Units_Objectives.Kill
  DISPOSE(_Hide:Relate:_Units_Objectives)
  _Hide:Relate:_C2IPs.Kill
  DISPOSE(_Hide:Relate:_C2IPs)
  _Hide:Relate:_C2IP_TaskOrgs.Kill
  DISPOSE(_Hide:Relate:_C2IP_TaskOrgs)
  _Hide:Relate:_C2IP_ORBATs.Kill
  DISPOSE(_Hide:Relate:_C2IP_ORBATs)
  _Hide:Relate:_C2IE_ORBATs.Kill
  DISPOSE(_Hide:Relate:_C2IE_ORBATs)
  _Hide:Relate:_C2IE_TASKORGs.Kill
  DISPOSE(_Hide:Relate:_C2IE_TASKORGs)
  _Hide:Relate:_c2ieBSO_ORBATs.Kill
  DISPOSE(_Hide:Relate:_c2ieBSO_ORBATs)
  _Hide:Relate:_c2ieBSO_TASKORGs.Kill
  DISPOSE(_Hide:Relate:_c2ieBSO_TASKORGs)
  _Hide:Relate:_C2IEsFromTransfers.Kill
  DISPOSE(_Hide:Relate:_C2IEsFromTransfers)


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


Hide:Relate:_c2ieBSO_Resources.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieBSO_Resources.Init
  SELF.Init(Access:_c2ieBSO_Resources,1)
  SELF.SetAlias(Relate:c2ieUnits)


Hide:Access:_c2ieBSO_Resources.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieBSORes:Record
  SELF.AliasedFile &= Access:c2ieUnits                     !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieBSO_Resources'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieBSO_Resources
  PARENT.Init
  Access:_c2ieBSO_Resources &= SELF


Hide:Access:_c2ieBSO_Resources.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieBSO_Resources &= NULL                        ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieBSO_Resources.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieBSO_Resources,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieBSORes:PKID,'_c2ieBSORes:PKID',1)
    SELF.AddKey(_c2ieBSORes:KC2IEUnit,'_c2ieBSORes:KC2IEUnit',0)
    SELF.AddKey(_c2ieBSORes:KC2IE,'_c2ieBSORes:KC2IE',0)
    SELF.AddKey(_c2ieBSORes:KUnit,'_c2ieBSORes:KUnit',0)
    SELF.AddKey(_c2ieBSORes:KHostility,'_c2ieBSORes:KHostility',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieBSO_Resources.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Units)

  SELF.AddRelation(Relate:c2ieActionResources,RI:None,RI:None,c2ieActRes:Kc2ieBSO)
  SELF.AddRelationLink(_c2ieBSORes:ID,c2ieActRes:c2ieBSO)

  SELF.AddRelation(Relate:_Units_Resources)


Hide:Relate:_c2ieBSO_Resources.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieBSO_Resources.Kill                     ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieBSO_Resources &= NULL                        ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieBSO_Resources)                 ! destroy the file manager


Hide:Relate:_c2ieBSO_Objectives.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieBSO_Objectives.Init
  SELF.Init(Access:_c2ieBSO_Objectives,1)
  SELF.SetAlias(Relate:c2ieUnits)


Hide:Access:_c2ieBSO_Objectives.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieBSOObj:Record
  SELF.AliasedFile &= Access:c2ieUnits                     !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieBSO_Objectives'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieBSO_Objectives
  PARENT.Init
  Access:_c2ieBSO_Objectives &= SELF


Hide:Access:_c2ieBSO_Objectives.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieBSO_Objectives &= NULL                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieBSO_Objectives.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieBSO_Objectives,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieBSOObj:PKID,'_c2ieBSOObj:PKID',1)
    SELF.AddKey(_c2ieBSOObj:KC2IEUnit,'_c2ieBSOObj:KC2IEUnit',0)
    SELF.AddKey(_c2ieBSOObj:KC2IE,'_c2ieBSOObj:KC2IE',0)
    SELF.AddKey(_c2ieBSOObj:KUnit,'_c2ieBSOObj:KUnit',0)
    SELF.AddKey(_c2ieBSOObj:KHostility,'_c2ieBSOObj:KHostility',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieBSO_Objectives.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:Units)

  SELF.AddRelation(Relate:c2ieActionObjectives,RI:None,RI:None,c2ieActObj:Kc2ieBSO)
  SELF.AddRelationLink(_c2ieBSOObj:ID,c2ieActObj:c2ieBSO)

  SELF.AddRelation(Relate:_Units_Objectives)


Hide:Relate:_c2ieBSO_Objectives.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieBSO_Objectives.Kill                    ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieBSO_Objectives &= NULL                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieBSO_Objectives)                ! destroy the file manager


Hide:Relate:_Units_Resources.Init PROCEDURE()
  CODE
  _Hide:Access:_Units_Resources.Init
  SELF.Init(Access:_Units_Resources,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:_Units_Resources.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _UniRes:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_Units_Resources'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _Units_Resources
  PARENT.Init
  Access:_Units_Resources &= SELF


Hide:Access:_Units_Resources.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_Units_Resources &= NULL                          ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_Units_Resources.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_Units_Resources,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_UniRes:PKID,'_UniRes:PKID',1)
    SELF.AddKey(_UniRes:KName,'_UniRes:KName',0)
    SELF.AddKey(_UniRes:KCode,'_UniRes:KCode',0)
    SELF.AddKey(_UniRes:KBSOType,'_UniRes:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_Units_Resources.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_c2ieBSO_Resources,RI:None,RI:None,_c2ieBSORes:KUnit)
  SELF.AddRelationLink(_UniRes:ID,_c2ieBSORes:Unit)


Hide:Relate:_Units_Resources.Kill PROCEDURE

  CODE
  _Hide:Access:_Units_Resources.Kill                       ! Kill the file manager
  PARENT.Kill
  Relate:_Units_Resources &= NULL                          ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_Units_Resources)                   ! destroy the file manager


Hide:Relate:_Units_Objectives.Init PROCEDURE()
  CODE
  _Hide:Access:_Units_Objectives.Init
  SELF.Init(Access:_Units_Objectives,1)
  SELF.SetAlias(Relate:Units)


Hide:Access:_Units_Objectives.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _UniObj:Record
  SELF.AliasedFile &= Access:Units                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_Units_Objectives'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _Units_Objectives
  PARENT.Init
  Access:_Units_Objectives &= SELF


Hide:Access:_Units_Objectives.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_Units_Objectives &= NULL                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_Units_Objectives.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_Units_Objectives,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_UniObj:PKID,'_UniObj:PKID',1)
    SELF.AddKey(_UniObj:KName,'_UniObj:KName',0)
    SELF.AddKey(_UniObj:KCode,'_UniObj:KCode',0)
    SELF.AddKey(_UniObj:KBSOType,'_UniObj:KBSOType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_Units_Objectives.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_c2ieBSO_Objectives,RI:None,RI:None,_c2ieBSOObj:KUnit)
  SELF.AddRelationLink(_UniObj:ID,_c2ieBSOObj:Unit)


Hide:Relate:_Units_Objectives.Kill PROCEDURE

  CODE
  _Hide:Access:_Units_Objectives.Kill                      ! Kill the file manager
  PARENT.Kill
  Relate:_Units_Objectives &= NULL                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_Units_Objectives)                  ! destroy the file manager


Hide:Relate:_C2IPs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IPs.Init
  SELF.Init(Access:_C2IPs,1)
  SELF.SetAlias(Relate:C2IPs)


Hide:Access:_C2IPs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IP:Record
  SELF.AliasedFile &= Access:C2IPs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IPs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IPs
  PARENT.Init
  Access:_C2IPs &= SELF


Hide:Access:_C2IPs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IPs &= NULL                                    ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IPs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IPs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IP:PKID,'_C2IP:PKID',1)
    SELF.AddKey(_C2IP:KType,'_C2IP:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IPs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_C2IPContent,RI:CASCADE,RI:CASCADE,_C2IPCt:KC2IP)
  SELF.AddRelationLink(_C2IP:ID,_C2IPCt:C2IPPackage)


Hide:Relate:_C2IPs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IPs.Kill                                 ! Kill the file manager
  PARENT.Kill
  Relate:_C2IPs &= NULL                                    ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IPs)                             ! destroy the file manager


Hide:Relate:_C2IP_TaskOrgs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IP_TaskOrgs.Init
  SELF.Init(Access:_C2IP_TaskOrgs,1)
  SELF.SetAlias(Relate:C2IPs)


Hide:Access:_C2IP_TaskOrgs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IPTsk:Record
  SELF.AliasedFile &= Access:C2IPs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IP_TaskOrgs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IP_TaskOrgs
  PARENT.Init
  Access:_C2IP_TaskOrgs &= SELF


Hide:Access:_C2IP_TaskOrgs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IP_TaskOrgs &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IP_TaskOrgs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IP_TaskOrgs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IPTsk:PKID,'_C2IPTsk:PKID',1)
    SELF.AddKey(_C2IPTsk:KType,'_C2IPTsk:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IP_TaskOrgs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:MissionTASKORG,RI:CASCADE,RI:CASCADE,MissTSK:KC2IP)
  SELF.AddRelationLink(_C2IPTsk:ID,MissTSK:TASKORGC2IP)

  SELF.AddRelation(Relate:_C2IPContent,RI:None,RI:None,_C2IPCt:KC2IP)
  SELF.AddRelationLink(_C2IPTsk:ID,_C2IPCt:C2IPPackage)


Hide:Relate:_C2IP_TaskOrgs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IP_TaskOrgs.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:_C2IP_TaskOrgs &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IP_TaskOrgs)                     ! destroy the file manager


Hide:Relate:_C2IP_ORBATs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IP_ORBATs.Init
  SELF.Init(Access:_C2IP_ORBATs,1)
  SELF.SetAlias(Relate:C2IPs)


Hide:Access:_C2IP_ORBATs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IP_Orbats:Record
  SELF.AliasedFile &= Access:C2IPs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IP_ORBATs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IP_ORBATs
  PARENT.Init
  Access:_C2IP_ORBATs &= SELF


Hide:Access:_C2IP_ORBATs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IP_ORBATs &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IP_ORBATs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IP_ORBATs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IP_Orbats:PKID,'_C2IP_Orbats:PKID',1)
    SELF.AddKey(_C2IP_Orbats:KType,'_C2IP_Orbats:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IP_ORBATs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:myOrgORBAT,RI:CASCADE,RI:CASCADE,myOrgORB:KC2IP)
  SELF.AddRelationLink(_C2IP_Orbats:ID,myOrgORB:ORBATC2IP)

  SELF.AddRelation(Relate:C2IPContent,RI:None,RI:None,C2IPCt:KC2IP)
  SELF.AddRelationLink(_C2IP_Orbats:ID,C2IPCt:C2IPPackage)


Hide:Relate:_C2IP_ORBATs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IP_ORBATs.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:_C2IP_ORBATs &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IP_ORBATs)                       ! destroy the file manager


Hide:Relate:_C2IE_ORBATs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IE_ORBATs.Init
  SELF.Init(Access:_C2IE_ORBATs,1)
  SELF.SetAlias(Relate:C2IEs)


Hide:Access:_C2IE_ORBATs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IEORB:Record
  SELF.AliasedFile &= Access:C2IEs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IE_ORBATs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IE_ORBATs
  PARENT.Init
  Access:_C2IE_ORBATs &= SELF


Hide:Access:_C2IE_ORBATs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IE_ORBATs &= NULL                              ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IE_ORBATs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IE_ORBATs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IEORB:PKID,'_C2IEORB:PKID',1)
    SELF.AddKey(_C2IEORB:KType,'_C2IEORB:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IE_ORBATs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:C2IPContent,RI:None,RI:None,C2IPCt:KC2IE)
  SELF.AddRelationLink(_C2IEORB:ID,C2IPCt:C2IEInstance)

  SELF.AddRelation(Relate:_c2ieBSO_ORBATs,RI:None,RI:None,_c2ieBSOORB:KC2IE)
  SELF.AddRelationLink(_C2IEORB:ID,_c2ieBSOORB:C2IE)


Hide:Relate:_C2IE_ORBATs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IE_ORBATs.Kill                           ! Kill the file manager
  PARENT.Kill
  Relate:_C2IE_ORBATs &= NULL                              ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IE_ORBATs)                       ! destroy the file manager


Hide:Relate:_C2IE_TASKORGs.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IE_TASKORGs.Init
  SELF.Init(Access:_C2IE_TASKORGs,1)
  SELF.SetAlias(Relate:C2IEs)


Hide:Access:_C2IE_TASKORGs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IETSK:Record
  SELF.AliasedFile &= Access:C2IEs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IE_TASKORGs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IE_TASKORGs
  PARENT.Init
  Access:_C2IE_TASKORGs &= SELF


Hide:Access:_C2IE_TASKORGs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IE_TASKORGs &= NULL                            ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IE_TASKORGs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IE_TASKORGs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IETSK:PKID,'_C2IETSK:PKID',1)
    SELF.AddKey(_C2IETSK:KType,'_C2IETSK:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IE_TASKORGs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:C2IPContent,RI:None,RI:None,C2IPCt:KC2IE)
  SELF.AddRelationLink(_C2IETSK:ID,C2IPCt:C2IEInstance)

  SELF.AddRelation(Relate:_c2ieBSO_TASKORGs,RI:None,RI:None,_c2ieBSOTSK:KC2IE)
  SELF.AddRelationLink(_C2IETSK:ID,_c2ieBSOTSK:C2IE)


Hide:Relate:_C2IE_TASKORGs.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IE_TASKORGs.Kill                         ! Kill the file manager
  PARENT.Kill
  Relate:_C2IE_TASKORGs &= NULL                            ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IE_TASKORGs)                     ! destroy the file manager


Hide:Relate:_c2ieBSO_ORBATs.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieBSO_ORBATs.Init
  SELF.Init(Access:_c2ieBSO_ORBATs,1)
  SELF.SetAlias(Relate:c2ieUnits)


Hide:Access:_c2ieBSO_ORBATs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieBSOORB:Record
  SELF.AliasedFile &= Access:c2ieUnits                     !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieBSO_ORBATs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieBSO_ORBATs
  PARENT.Init
  Access:_c2ieBSO_ORBATs &= SELF


Hide:Access:_c2ieBSO_ORBATs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieBSO_ORBATs &= NULL                           ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieBSO_ORBATs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieBSO_ORBATs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieBSOORB:PKID,'_c2ieBSOORB:PKID',1)
    SELF.AddKey(_c2ieBSOORB:KC2IEUnit,'_c2ieBSOORB:KC2IEUnit',0)
    SELF.AddKey(_c2ieBSOORB:KC2IE,'_c2ieBSOORB:KC2IE',0)
    SELF.AddKey(_c2ieBSOORB:KUnit,'_c2ieBSOORB:KUnit',0)
    SELF.AddKey(_c2ieBSOORB:KHostility,'_c2ieBSOORB:KHostility',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieBSO_ORBATs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_C2IE_ORBATs)

  SELF.AddRelation(Relate:Units)


Hide:Relate:_c2ieBSO_ORBATs.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieBSO_ORBATs.Kill                        ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieBSO_ORBATs &= NULL                           ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieBSO_ORBATs)                    ! destroy the file manager


Hide:Relate:_c2ieBSO_TASKORGs.Init PROCEDURE()
  CODE
  _Hide:Access:_c2ieBSO_TASKORGs.Init
  SELF.Init(Access:_c2ieBSO_TASKORGs,1)
  SELF.SetAlias(Relate:c2ieUnits)


Hide:Access:_c2ieBSO_TASKORGs.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _c2ieBSOTSK:Record
  SELF.AliasedFile &= Access:c2ieUnits                     !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_c2ieBSO_TASKORGs'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _c2ieBSO_TASKORGs
  PARENT.Init
  Access:_c2ieBSO_TASKORGs &= SELF


Hide:Access:_c2ieBSO_TASKORGs.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_c2ieBSO_TASKORGs &= NULL                         ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_c2ieBSO_TASKORGs.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_c2ieBSO_TASKORGs,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_c2ieBSOTSK:PKID,'_c2ieBSOTSK:PKID',1)
    SELF.AddKey(_c2ieBSOTSK:KC2IEUnit,'_c2ieBSOTSK:KC2IEUnit',0)
    SELF.AddKey(_c2ieBSOTSK:KC2IE,'_c2ieBSOTSK:KC2IE',0)
    SELF.AddKey(_c2ieBSOTSK:KUnit,'_c2ieBSOTSK:KUnit',0)
    SELF.AddKey(_c2ieBSOTSK:KHostility,'_c2ieBSOTSK:KHostility',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_c2ieBSO_TASKORGs.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:_C2IE_TASKORGs)

  SELF.AddRelation(Relate:_Units)

  SELF.AddRelation(Relate:c2ieUnitTransfer,RI:None,RI:None,c2iUniTrf:Kc2ieUnit)
  SELF.AddRelationLink(_c2ieBSOTSK:ID,c2iUniTrf:c2ieUnit)


Hide:Relate:_c2ieBSO_TASKORGs.Kill PROCEDURE

  CODE
  _Hide:Access:_c2ieBSO_TASKORGs.Kill                      ! Kill the file manager
  PARENT.Kill
  Relate:_c2ieBSO_TASKORGs &= NULL                         ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_c2ieBSO_TASKORGs)                  ! destroy the file manager


Hide:Relate:_C2IEsFromTransfers.Init PROCEDURE()
  CODE
  _Hide:Access:_C2IEsFromTransfers.Init
  SELF.Init(Access:_C2IEsFromTransfers,1)
  SELF.SetAlias(Relate:C2IEs)


Hide:Access:_C2IEsFromTransfers.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= _C2IEFromTrf:Record
  SELF.AliasedFile &= Access:C2IEs                         !This is a File Alias, so assign aliased file manager
  SELF.FileNameValue = '_C2IEsFromTransfers'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= _C2IEsFromTransfers
  PARENT.Init
  Access:_C2IEsFromTransfers &= SELF


Hide:Access:_C2IEsFromTransfers.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:_C2IEsFromTransfers &= NULL                       ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:_C2IEsFromTransfers.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(_C2IEsFromTransfers,GlobalErrors)
    SELF.Create = 1
    SELF.LockRecover = 10
    SELF.AddKey(_C2IEFromTrf:PKID,'_C2IEFromTrf:PKID',1)
    SELF.AddKey(_C2IEFromTrf:KType,'_C2IEFromTrf:KType',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:_C2IEsFromTransfers.DeferedAddRelations PROCEDURE

  CODE
  DO AddRelations_1
  
  PARENT.DeferedAddRelations

AddRelations_1 ROUTINE
  SELF.AddRelation(Relate:c2ieUnitTransfer,RI:None,RI:None,c2iUniTrf:KC2IE_From)
  SELF.AddRelationLink(_C2IEFromTrf:ID,c2iUniTrf:C2IE_From)


Hide:Relate:_C2IEsFromTransfers.Kill PROCEDURE

  CODE
  _Hide:Access:_C2IEsFromTransfers.Kill                    ! Kill the file manager
  PARENT.Kill
  Relate:_C2IEsFromTransfers &= NULL                       ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:_C2IEsFromTransfers)                ! destroy the file manager

