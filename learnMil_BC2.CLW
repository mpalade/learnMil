  MEMBER('learnMil.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
learnMil_BC2:DctInit    PROCEDURE()
learnMil_BC2:DctKill    PROCEDURE()
learnMil_BC2:FilesInit  PROCEDURE()
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


_Hide:Access:_c2ieBSO_Objectives &Hide:Access:_c2ieBSO_Objectives,AUTO,THREAD
_Hide:Relate:_c2ieBSO_Objectives &Hide:Relate:_c2ieBSO_Objectives,AUTO,THREAD
_Hide:Access:_Units_Resources &Hide:Access:_Units_Resources,AUTO,THREAD
_Hide:Relate:_Units_Resources &Hide:Relate:_Units_Resources,AUTO,THREAD
_Hide:Access:_Units_Objectives &Hide:Access:_Units_Objectives,AUTO,THREAD
_Hide:Relate:_Units_Objectives &Hide:Relate:_Units_Objectives,AUTO,THREAD


learnMil_BC2:DctInit PROCEDURE()
  CODE
  _Hide:Access:_c2ieBSO_Objectives &= NEW(Hide:Access:_c2ieBSO_Objectives)
  _Hide:Relate:_c2ieBSO_Objectives &= NEW(Hide:Relate:_c2ieBSO_Objectives)
  _Hide:Access:_Units_Resources &= NEW(Hide:Access:_Units_Resources)
  _Hide:Relate:_Units_Resources &= NEW(Hide:Relate:_Units_Resources)
  _Hide:Access:_Units_Objectives &= NEW(Hide:Access:_Units_Objectives)
  _Hide:Relate:_Units_Objectives &= NEW(Hide:Relate:_Units_Objectives)
  Relate:_c2ieBSO_Objectives &= _Hide:Relate:_c2ieBSO_Objectives
  Relate:_Units_Resources &= _Hide:Relate:_Units_Resources
  Relate:_Units_Objectives &= _Hide:Relate:_Units_Objectives


learnMil_BC2:FilesInit PROCEDURE()
  CODE
  _Hide:Relate:_c2ieBSO_Objectives.Init
  _Hide:Relate:_Units_Resources.Init
  _Hide:Relate:_Units_Objectives.Init


learnMil_BC2:DctKill PROCEDURE()
  CODE
  _Hide:Relate:_c2ieBSO_Objectives.Kill
  DISPOSE(_Hide:Relate:_c2ieBSO_Objectives)
  _Hide:Relate:_Units_Resources.Kill
  DISPOSE(_Hide:Relate:_Units_Resources)
  _Hide:Relate:_Units_Objectives.Kill
  DISPOSE(_Hide:Relate:_Units_Objectives)


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

