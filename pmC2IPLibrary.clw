    MEMBER('learnMil')

    MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('pmC2IPLibrary.INC'),ONCE

! Local objects

! JSON objects
json                JSONClass
collection          &JSONClass

! string theory objects
sst                 stringtheory
        
BSO.Construct       PROCEDURE()
    CODE
        
BSO.Destruct        PROCEDURE()
    CODE
        
UnitsCollection.Construct     PROCEDURE()
    CODE
        SELF.ul     &= NEW(UnitsList)
        SELF.tmpul  &=NEW(UnitsList)
        
UnitsCollection.Destruct      PROCEDURE()
    CODE         
        DISPOSE(SELF.tmpul)
        DISPOSE(SELF.ul)   
        
    
UnitsCollection.prepRndName   PROCEDURE
tmpUnitName     STRING(100)
    CODE
        LOOP 10 TIMES
            tmpUnitName = CLIP(tmpUnitName) & CHR(RANDOM(97, 122))    
        END
        
        RETURN tmpUnitName
        
UnitsCollection.insertFirstNode PROCEDURE
    CODE
        sst.Trace('START:UnitsCollection.insertFirstNode')
        SELF.ul.UnitName        = SELF.prepRndName()
        !SELF.ul.UnitType        = uTpy:notDefined
        SELF.ul.UnitTypeCode    = ''
        SELF.ul.Echelon         = echTpy:notDefined        
        SELF.ul.Hostility       = hTpy:Unknown
        SELF.ul.IsHQ            = FALSE
        SELF.ul.xPos            = 1
        SELF.ul.yPos            = 1
        SELF.ul.TreePos         = 1
        SELF.ul.markForDel      = FALSE
        SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)
        IF NOT ERRORCODE() THEN
            SELF.selTreePos     = 1     
            SELF.maxTreePos     = 1
            SELF.selQueuePos    = POINTER(SELF.ul)
            sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
            sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
            sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        ELSE
            sst.Trace('ADD(SELF.ul) error')
        END
        sst.Trace('END:UnitsCollection.insertFirstNode')
        
        
        
        
        
UnitsCollection.prepNewNode   PROCEDURE(LONG nNewRecPosition)
    CODE
        sst.Trace('START:UnitsCollection.prepNewNode')        
        CLEAR(SELF.urec)
        SELF.urec.TreePos       = SELF.selTreePos
        SELF.urec.UnitName      = SELF.prepRndName()
        ! Unit Type, Echelon and  IsHQ are similare as the current ones
        SELF.urec.UnitType      = SELF.ul.UnitType
        SELF.urec.UnitTypeCode  = SELF.ul.UnitTypeCode
        SELF.urec.Echelon       = SELF.ul.Echelon
        SELF.ul.Hostility       = SELF.ul.Hostility
        SELF.urec.IsHQ          = SELF.ul.IsHQ
        SELF.urec.xPos          = (SELF.urec.TreePos-1)*50 + 1
        SELF.urec.yPos          = (nNewRecPosition - 1)*30 + 1
        sst.Trace('END:UnitsCollection.prepNewNode')        
        
UnitsCollection.moveNodesToTmp        PROCEDURE(LONG nStartPos, LONG nEndPos)
    CODE
        sst.Trace('START:UnitsCollection.moveNodesToTmp')        
        FREE(SELF.tmpul)       
        LOOP i# = nStartPos TO nEndPos
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                SELF.tmpul.TreePos      = SELF.ul.TreePos
                SELF.tmpul.UnitName     = SELF.ul.UnitName
                SELF.tmpul.UnitType     = SELF.ul.UnitType
                SELF.tmpul.UnitTypeCode = SELF.ul.UnitTypeCode
                SELF.tmpul.Echelon      = SELF.ul.Echelon
                SELF.tmpul.Hostility    = SELF.ul.Hostility
                SELF.tmpul.xPos         = SELF.ul.xPos
                SELF.tmpul.yPos         = SELF.ul.yPos + 30
                ADD(SELF.tmpul)
            END            
        END
        sst.Trace('END:UnitsCollection.moveNodesToTmp')        
        
UnitsCollection.addEmptyNode       PROCEDURE
    CODE
        sst.Trace('START:UnitsCollection.insertEmptyNode')        
        ADD(SELF.ul)
        IF NOT ERRORCODE() THEN
        END        
        sst.Trace('END:UnitsCollection.insertEmptyNode')        
        
UnitsCollection.insertCurrentPrepNode     PROCEDURE(LONG nPosition)
    CODE
        sst.Trace('START:UnitsCollection.insertCurrentNode')        
        GET(SELF.ul, nPosition)
        IF NOT ERRORCODE() THEN
            SELF.ul.TreePos     = SELF.urec.TreePos
            SELF.ul.UnitName    = SELF.urec.UnitName
            SELF.ul.UnitType    = SELF.urec.UnitType
            SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
            SELF.ul.Echelon     = SELF.urec.Echelon
            SELF.ul.Hostility   = SELF.urec.Hostility
            SELF.ul.xPos        = SELF.urec.xPos
            SELF.ul.yPos        = SELF.urec.yPos
            SELF.ul.markForDel  = FALSE
            SELF.ul.markForDisbl    = FALSE
            PUT(SELF.ul)
        END
        sst.Trace('END:UnitsCollection.insertCurrentNode')        
        
UnitsCollection.moveNodesBackFromTmp  PROCEDURE(LONG nStartPos)        
    CODE
        sst.Trace('START:UnitsCollection.moveNodesBackFromTmp')        
        j# = 0
        LOOP i# = nStartPos TO RECORDS(SELF.ul)
            j# = j# + 1
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                GET(SELF.tmpul, j#)
                IF NOT ERRORCODE() THEN
                    SELF.ul.TreePos     = SELF.tmpul.TreePos
                    SELF.ul.UnitName    = SELF.tmpul.UnitName
                    SELF.ul.UnitType    = SELF.tmpul.UnitType
                    SELF.ul.UnitTypeCode    = SELF.tmpul.UnitTypeCode
                    SELF.ul.Echelon     = SELF.tmpul.Echelon
                    SELF.ul.Hostility   = SELF.tmpul.Hostility
                    SELF.ul.xPos        = SELF.tmpul.xPos
                    SELF.ul.yPos        = SELF.tmpul.yPos
                    SELF.ul.markForDel  = FALSE
                    SELF.ul.markForDisbl    = FALSE
                    PUT(SELF.ul)
                END                    
            END            
        END        
        sst.Trace('END:UnitsCollection.moveNodesBackFromTmp')        
        
UnitsCollection.insertLastNode        PROCEDURE()
    CODE
        sst.Trace('START:UnitsCollection.insertLastNode')        
        SELF.ul.TreePos         = SELF.urec.TreePos
        SELF.ul.UnitName        = SELF.urec.UnitName
        SELF.ul.UnitType        = SELF.urec.UnitType
        SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
        SELF.ul.Echelon         = SELF.urec.Echelon
        SELF.ul.Hostility       = SELF.urec.Hostility
        SELF.ul.xPos            = SELF.urec.xPos
        SELF.ul.yPos            = SELF.urec.yPos
        SELF.ul.markForDel      = FALSE
        SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)   
        IF NOT ERRORCODE() THEN
            SELF.selQueuePos    = POINTER(SELF.ul)
            SELF.selTreePos     = SELF.ul.TreePos
            sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
            sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
            sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        ELSE
            sst.Trace('ADD(SELF.ul) error')
        END        
        sst.Trace('END:UnitsCollection.insertLastNode')        
        
        
        
UnitsCollection.InsertNode    PROCEDURE
tmpUnitName     STRING(100)
CODE
    ! insert a new node to the current collection
    sst.Trace('START:UnitsCollection.InsertNode')
        
    tmpUnitName    = SELF.prepRndName()
    
    IF RECORDS(SELF.ul) = 0 THEN
        ! 1st records
        sst.Trace('1st queue record')        
        sst.Trace('CALL:SELF.insertFirstNode()')
        SELF.insertFirstNode()                   
    ELSE
        ! inside the queue
        sst.Trace('inside the queue')
        
        ! increment Tree Position
        sst.Trace('increment Tree Position')
        SELF.selTreePos  = SELF.ul.TreePos + 1
        IF SELF.selTreePos > SELF.maxTreePos THEN
            SELF.maxTreePos = SELF.selTreePos
        END
        
        ! preserve current position and all records number
        sst.Trace('preserve current position and all records number')
        allPos# = RECORDS(SELF.ul)
                
        ! prepare the new record
        sst.Trace('prepare the new record')
        sst.Trace('CALL:SELF.prepNewNode()')
        SELF.prepNewNode(SELF.selQueuePos + 1)               
        
        ! check the position inside the queue
        ! move to the temporary queue
        ! change yPos values
        sst.Trace('check the position inside the queue')
        IF (SELF.selQueuePos + 1) < (allPos# + 1) THEN            
            ! in the middle of queue
            sst.Trace('in the middle of queue')           
            sst.Trace('CALL:SELF.moveNodesToTmp(SELF.selQueuePos + 1, allPos#)')           
            SELF.moveNodesToTmp(SELF.selQueuePos + 1, allPos#)
                                    
            ! add empty record
            sst.Trace('add empty record')
            sst.Trace('CALL:SELF.addEmptyNode()')           
            SELF.addEmptyNode()            
            
            
            ! insert current record
            sst.Trace('insert current record')
            sst.Trace('CALL:SELF.insertCurrentNode(SELF.selQueuePos + 1)')           
            SELF.insertCurrentPrepNode(SELF.selQueuePos + 1)        
                        
            ! copy back records
            sst.Trace('copy back records')
            IF POINTER(SELF.tmpul) > 0 THEN
                sst.Trace('CALL:SELF.moveNodesBackFromTmp(SELF.selQueuePos + 2)')                                           
                SELF.moveNodesBackFromTmp(SELF.selQueuePos + 2)
                
            END    
            
            ! get new current Position            
            sst.Trace('get new current Position')
            SELF.selQueuePos    = SELF.selQueuePos + 1
            GET(SELF.ul, SELF.selQueuePos + 1)
            IF NOT ERRORCODE() THEN
                SELF.selTreePos = SELF.ul.TreePos
            END                        
        ELSE
            ! last on queue
            sst.Trace('last on queue')
            sst.Trace('CALL:SELF.insertLastNode()')             
            SELF.insertLastNode()            
        END                              
    END
    sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
    sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
    sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
    sst.Trace('END:UnitsCollection.InsertNode')
    
    
UnitsCollection.InsertNode    PROCEDURE(*UnitBasicRecord pURec)
tmpUnitName         STRING(100)
CODE
    ! do something
    
    tmpUnitName    = ''
    LOOP 10 TIMES
        tmpUnitName = CLIP(tmpUnitName) & CHR(RANDOM(97, 122))    
    END
    
    IF RECORDS(SELF.ul) = 0 THEN
        ! 1st records
        SELF.ul.UnitName        = pUrec.UnitName
        SELF.ul.UnitType        = pURec.UnitType
        SELF.ul.UnitTypeCode    = pURec.UnitTypeCode
        SELF.ul.Echelon         = pUrec.Echelon
        SELF.ul.Hostility       = pUrec.Hostility
        SELF.ul.IsHQ            = pUrec.IsHQ
        SELF.ul.xPos            = 1
        SELF.ul.yPos            = 1
        SELF.ul.TreePos         = 1
        SELF.ul.markForDel      = FALSE
        SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)
        
        SELF.selTreePos = 1     
        SELF.maxTreePos = 1
        SELF.selQueuePos    = 1               
    ELSE                
        
        ! inside the queue
        
        ! increment Tree Position
        SELF.selTreePos  = SELF.ul.TreePos + 1
        IF SELF.selTreePos > SELF.maxTreePos THEN
            SELF.maxTreePos = SELF.selTreePos
        END
        curentPos# = POINTER(SELF.ul)
        allPos# = RECORDS(SELF.ul)
        SELF.selQueuePos    = curentPos#
        
        ! prepare the new record
        CLEAR(SELF.urec)
        SELF.urec.TreePos       = SELF.selTreePos
        SELF.urec.UnitName      = pUrec.UnitName
        ! Unit Type, Echelon and  IsHQ are similare as the current ones
        SELF.urec.UnitType      = pUrec.UnitType
        SELF.urec.UnitTypeCode  = pUrec.UnitTypeCode
        SELF.urec.Echelon       = pUrec.Echelon
        SELF.urec.Hostility     = pUrec.Hostility
        SELF.urec.IsHQ          = pUrec.IsHQ
        SELF.urec.xPos          = (SELF.urec.TreePos-1)*50 + 1
        SELF.urec.yPos          = curentPos#*30 + 1
        
        ! move to temporary queue
        ! move yPos
        IF curentPos# < allPos# THEN
            ! in the middle of queue
            FREE(SELF.tmpul)       
            LOOP i# = (curentPos#+1) TO allPos#
                GET(SELF.ul, i#)
                IF NOT ERRORCODE() THEN
                    SELF.tmpul.TreePos      = SELF.ul.TreePos
                    SELF.tmpul.UnitName     = SELF.ul.UnitName
                    SELF.tmpul.UnitType     = SELF.ul.UnitType
                    SELF.tmpul.UnitTypeCode = SELF.ul.UnitTypeCode
                    SELF.tmpul.Echelon      = SELF.ul.Echelon
                    SELF.tmpul.Hostility    = SELF.ul.Hostility
                    SELF.tmpul.IsHQ         = SELF.ul.IsHQ
                    SELF.tmpul.xPos         = SELF.ul.xPos
                    SELF.tmpul.yPos         = SELF.ul.yPos + 30
                    ADD(SELF.tmpul)
                END            
            END
            
            ! add empty record
            ADD(SELF.ul)        
            
            ! insert current record
            GET(SELF.ul, curentPos#+1)
            IF NOT ERRORCODE() THEN
                SELF.ul.TreePos     = SELF.urec.TreePos
                SELF.ul.UnitName    = SELF.urec.UnitName
                SELF.ul.UnitType    = SELF.urec.UnitType
                SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
                SELF.ul.Echelon     = SELF.urec.Echelon
                SELF.ul.Hostility   = SELF.urec.Hostility
                SELF.ul.xPos        = SELF.urec.xPos
                SELF.ul.yPos        = SELF.urec.yPos
                SELF.ul.markForDel  = FALSE
                SELF.ul.markForDisbl    = FALSE
                PUT(SELF.ul)
            END
            
            ! copy back records
            IF POINTER(SELF.tmpul)>0 THEN
                j# = 0
                LOOP i# = (curentPos#+2) TO RECORDS(SELF.ul)
                    j# = j# + 1
                    GET(SELF.ul, i#)
                    IF NOT ERRORCODE() THEN
                        GET(SELF.tmpul, j#)
                        IF NOT ERRORCODE() THEN
                            SELF.ul.TreePos     = SELF.tmpul.TreePos
                            SELF.ul.UnitName    = SELF.tmpul.UnitName
                            SELF.ul.UnitType    = SELF.tmpul.UnitType
                            SELF.ul.UnitTypeCode    = SELF.tmpul.UnitTypeCode
                            SELF.ul.Echelon     = SELF.tmpul.Echelon
                            SELF.ul.Hostility   = SELF.tmpul.Hostility
                            SELF.ul.xPos        = SELF.tmpul.xPos
                            SELF.ul.yPos        = SELF.tmpul.yPos
                            SELF.ul.markForDel  = FALSE
                            SELF.ul.markForDisbl    = FALSE
                            PUT(SELF.ul)
                        END                    
                    END            
                END
            END    
            
            ! current Position
            GET(SELF.ul, curentPos# + 1)
            IF NOT ERRORCODE() THEN
                SELF.selTreePos = SELF.ul.TreePos
            END
            
        ELSE
            ! last on queue
            SELF.ul.TreePos     = SELF.urec.TreePos
            SELF.ul.UnitName    = SELF.urec.UnitName
            SELF.ul.UnitType    = SELF.urec.UnitType
            SELF.ul.UnitTypeCode    = SELF.urec.UnitTypeCode
            SELF.ul.Echelon     = SELF.urec.Echelon
            SELF.ul.Hostility   = SELF.urec.Hostility
            SELF.ul.xPos        = SELF.urec.xPos
            SELF.ul.yPos        = SELF.urec.yPos
            SELF.ul.markForDel  = FALSE
            SELF.ul.markForDisbl    = FALSE
            ADD(SELF.ul)                        
        END                
        
        SELF.selQueuePos = POINTER(SELF.ul)      
        SELF.selTreePos = SELF.ul.TreePos        
              
    END        
    
    RETURN TRUE        
    
UnitsCollection.AddNode       PROCEDURE(*UnitBasicRecord pUrec)
    CODE
        SELF.ul.UnitName        = pUrec.UnitName
        SELF.ul.UnitType        = pURec.UnitType
        SELF.ul.UnitTypeCode    = pURec.UnitTypeCode
        SELF.ul.Echelon         = pUrec.Echelon
        SELF.ul.Hostility       = pUrec.Hostility
        SELF.ul.IsHQ            = pUrec.IsHQ
        SELF.ul.xPos            = pUrec.xPos
        SELF.ul.yPos            = pUrec.yPos
        
        !SELF.ul.TreePos         = 1
        !SELF.ul.markForDel      = FALSE
        !SELF.ul.markForDisbl    = FALSE
        ADD(SELF.ul)
        
        SELF.selQueuePos    = POINTER(SELF.ul)
        RETURN TRUE
        
UnitsCollection.GetNode       PROCEDURE(*UnitBasicRecord pURec)
    CODE
        ! get current node
    
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            pUrec.UnitName          = SELF.ul.UnitName
            pUrec.UnitType          = SELF.ul.UnitType
            pUrec.UnitTypeCode      = SELF.ul.UnitTypeCode
            pUrec.Echelon           = SELF.ul.Echelon
            pURec.Hostility         = SELF.ul.Hostility
            pUrec.IsHQ              = SELF.ul.IsHQ
            pUrec.xPos              = SELF.ul.xPos
            pUrec.yPos              = SELF.ul.yPos
            pUrec.TreePos           = SELF.ul.TreePos
            RETURN TRUE
        ELSE
            RETURN FALSE
        END    
        
UnitsCollection.GetNode       PROCEDURE()
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        
        
        
UnitsCollection.DeleteNode     PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for deletion current record
        currentTreePos# = SELF.ul.TreePos
        SELF.ul.markForDel  = TRUE
        PUT(SELF.ul)
        !DELETE(SELF.ul)
        
        ! Mark for deletion all below records in deeper tree postions        
        LOOP i# = POINTER(SELF.ul)+1 TO RECORDS(SELF.ul)
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                IF SELF.ul.TreePos > currentTreePos# THEN
                    SELF.ul.markForDel  = TRUE
                    PUT(SELF.ul)                    
                ELSE
                    BREAK
                END                
            END            
        END
        
    END

    ! Remove all marked for deletion records
    i# = 1
    LOOP
        GET(SELF.ul, i#)
        IF NOT ERRORCODE() THEN
            IF SELF.ul.markForDel = TRUE THEN
                DELETE(SELF.ul)
                IF ERRORCODE() THEN
                    BREAK
                END
                i# = 1
            ELSE
                SELF.ul.yPos = (POINTER(SELF.ul)-1)*30 + 1
                PUT(SELF.ul)
                i# = i# + 1
            END            
        ELSE
            BREAK
        END
        
    END                
    
UnitsCollection.DisableNode    PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for disableling for new drag&drop selection
        SELF.ul.markForDisbl  = TRUE
        PUT(SELF.ul)
    END   
    
UnitsCollection.SelUp     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos>1 THEN        
        SELF.selQueuePos = SELF.selQueuePos-1
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
    
UnitsCollection.SelDown     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos<RECORDS(SELF.ul) THEN        
        SELF.selQueuePos = SELF.selQueuePos+1
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
    
UnitsCollection.SelLeft     PROCEDURE
CODE
    ! do something
    RETURN TRUE
        
    
UnitsCollection.SelRight     PROCEDURE
CODE
    ! do something    
    RETURN TRUE
                   
UnitsCollection.Records       PROCEDURE()        
    CODE
        sst.Trace('BEGIN:UnitsCollection.Records')
        sst.Trace('RECORDS(SELF.ul) = ' & RECORDS(SELF.ul))
        sst.Trace('END:UnitsCollection.Records')
        RETURN RECORDS(SELF.ul)
        
UnitsCollection.Pointer       PROCEDURE()
    CODE
        sst.Trace('BEGIN:UnitsCollection.Pointer')
        sst.Trace('POINTER(SELF.ul) = ' & POINTER(SELF.ul))
        sst.Trace('END:UnitsCollection.Pointer')
        RETURN POINTER(SELF.ul)
        
UnitsCollection.GetCurrentSelPos      PROCEDURE()
    CODE
        sst.Trace('BEGIN:UnitsCollection.GetCurrentSelPos')
        sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        sst.Trace('END:UnitsCollection.GetCurrentSelPos')
        RETURN SELF.selQueuePos
        
                                

UnitsCollection.Get        PROCEDURE()
    CODE
        sst.Trace('BEGIN:UnitsCollection.Get()')
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            succes# = TRUE
        ELSE
            success# = FALSE
        END
        sst.Trace('END:UnitsCollection.Get')
        RETURN success#

UnitsCollection.UnitTypeCode  PROCEDURE()
    CODE
        sst.Trace('BEGIN:UnitsCollection.UnitTypeCode')
        sst.Trace('SELF.ul.UnitTypeCode = ' & SELF.ul.UnitTypeCode)
        sst.Trace('END:UnitsCollection.UnitTypeCode')
        RETURN SELF.ul.UnitTypeCode
        
UnitsCollection.SetUnitTypeCode       PROCEDURE(STRING sUnitTypeCode)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN       
            SELF.ul.UnitTypeCode    = sUnitTypeCode
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN TRUE            
            ELSE
                RETURN FALSE            
            END            
        ELSE
            RETURN FALSE
        END    
        
UnitsCollection.Echelon      PROCEDURE()        
    CODE
        sst.Trace('BEGIN:UnitsCollection.Echelon')
        sst.Trace('SELF.ul.Echelon = ' & SELF.ul.Echelon)
        sst.Trace('END:UnitsCollection.Echelon')
        RETURN SELF.ul.Echelon                

UnitsCollection.SetEchelon    PROCEDURE(LONG nEchelon)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.Echelon    = nEchelon
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN TRUE            
            ELSE
                RETURN FALSE            
            END
            
        ELSE
            RETURN FALSE
        END    
        
UnitsCollection.xPos  PROCEDURE()
    CODE
        RETURN SELF.ul.xPos
                                
        
UnitsCollection.yPos  PROCEDURE()
    CODE
        RETURN SELF.ul.yPos
        
UnitsCollection.Hostility     PROCEDURE()
    CODE
        sst.Trace('BEGIN:UnitsCollection.Hostility')
        sst.Trace('SELF.ul.Hostility = ' & SELF.ul.Hostility)
        sst.Trace('END:UnitsCollection.Hostility')
        RETURN SELF.ul.Hostility
        
UnitsCollection.SetHostility  PROCEDURE(LONG nHostility)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.Hostility    = nHostility
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN TRUE            
            ELSE
                RETURN FALSE            
            END
            
        ELSE
            RETURN FALSE
        END    
                               
        
UnitsCollection.markForDisbl  PROCEDURE()
    CODE
        RETURN SELF.ul.markForDel
        
UnitsCollection.IsHQ  PROCEDURE()
    CODE
        ! do something
        RETURN SELF.ul.IsHQ

UnitsCollection.SetHQ PROCEDURE(BOOL bIsHQ)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.IsHQ    = bIsHQ
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN SELF.ul.IsHQ            
            ELSE
                RETURN FALSE            
            END
            
        ELSE
            RETURN FALSE
        END    
        
UnitsCollection.UnitName      PROCEDURE
    CODE
        RETURN SELF.ul.UnitName
        
UnitsCollection.SetUnitName   PROCEDURE(STRING sUnitName)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.UnitName    = sUnitName
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN TRUE
            ELSE
                RETURN FALSE                
            END
        ELSE
            RETURN FALSE
        END
               
                
UnitsCollection.TreePos       PROCEDURE
    CODE
        RETURN SELF.ul.TreePos
        
        
UnitsCollection.SelectByMouse PROCEDURE(LONG nXPos, LONG nYPos)        
    CODE
        LOOP i# = 1 TO RECORDS(SELF.ul)
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                IF (SELF.ul.xPos < nXPos) AND (nXPos < SELF.ul.xPos + 50) THEN
                    IF (SELF.ul.yPos < nYPos) AND (nYPos < SELF.ul.yPos + 30) THEN
                        ! found Unit selection
                        SELF.selTreePos     = SELF.ul.TreePos
                        SELF.selQueuePos    = i#
                        RETURN i#
                    END                
                END            
            END
        END
        
        RETURN 0
        
        
UnitsCollection.ChangeNodePos PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.xPos    = nXPos
            SELF.ul.yPos    = nYPos
            PUT(SELF.ul)
        END 
            
        RETURN 0
        
     

        


    