    MEMBER('UnitTests')

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
        
BSOCollection.Construct     PROCEDURE()
    CODE
        SELF.ul     &= NEW(UnitsList)
        SELF.tmpul  &=NEW(UnitsList)
        
BSOCollection.Destruct      PROCEDURE()
    CODE         
        DISPOSE(SELF.tmpul)
        DISPOSE(SELF.ul)   
        
    
BSOCollection.prepRndName   PROCEDURE
tmpUnitName     STRING(100)
    CODE
        LOOP 10 TIMES
            tmpUnitName = CLIP(tmpUnitName) & CHR(RANDOM(97, 122))    
        END
        
        RETURN tmpUnitName
        
BSOCollection.insertFirstNode PROCEDURE
    CODE
        sst.Trace('START:BSOCollection.insertFirstNode')
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
        sst.Trace('END:BSOCollection.insertFirstNode')
        
        
        
        
        
BSOCollection.prepNewNode   PROCEDURE(LONG nNewRecPosition)
    CODE
        sst.Trace('START:BSOCollection.prepNewNode')        
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
        sst.Trace('END:BSOCollection.prepNewNode')        
        
BSOCollection.moveNodesToTmp        PROCEDURE(LONG nStartPos, LONG nEndPos)
    CODE
        sst.Trace('START:BSOCollection.moveNodesToTmp')        
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
        sst.Trace('END:BSOCollection.moveNodesToTmp')        
        
BSOCollection.addEmptyNode       PROCEDURE
    CODE
        sst.Trace('START:BSOCollection.insertEmptyNode')        
        ADD(SELF.ul)
        IF NOT ERRORCODE() THEN
        END        
        sst.Trace('END:BSOCollection.insertEmptyNode')        
        
BSOCollection.insertCurrentPrepNode     PROCEDURE(LONG nPosition)
    CODE
        sst.Trace('START:BSOCollection.insertCurrentNode')        
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
        sst.Trace('END:BSOCollection.insertCurrentNode')        
        
BSOCollection.moveNodesBackFromTmp  PROCEDURE(LONG nStartPos)        
    CODE
        sst.Trace('START:BSOCollection.moveNodesBackFromTmp')        
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
        sst.Trace('END:BSOCollection.moveNodesBackFromTmp')        
        
BSOCollection.insertLastNode        PROCEDURE()
    CODE
        sst.Trace('START:BSOCollection.insertLastNode')        
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
        sst.Trace('END:BSOCollection.insertLastNode')        
        
        
        
BSOCollection.InsertNode    PROCEDURE
tmpUnitName     STRING(100)
CODE
    ! insert a new node to the current collection
    sst.Trace('START:BSOCollection.InsertNode')
        
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
    sst.Trace('END:BSOCollection.InsertNode')
    
    
BSOCollection.InsertNode    PROCEDURE(*UnitBasicRecord pURec)
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
    
BSOCOllection.AddNode       PROCEDURE(*UnitBasicRecord pUrec)
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
        
BSOCollection.GetNode       PROCEDURE(*UnitBasicRecord pURec)
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
        
BSOCollection.GetNode       PROCEDURE()
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        
        
        
BSOCollection.DeleteNode     PROCEDURE
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
    
BSOCollection.DisableNode    PROCEDURE
CODE
    ! do something
    
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for disableling for new drag&drop selection
        SELF.ul.markForDisbl  = TRUE
        PUT(SELF.ul)
    END   
    
BSOCollection.SelUp     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos>1 THEN        
        SELF.selQueuePos = SELF.selQueuePos-1
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
    
BSOCollection.SelDown     PROCEDURE
CODE
    ! do something
    
    IF SELF.selQueuePos<RECORDS(SELF.ul) THEN        
        SELF.selQueuePos = SELF.selQueuePos+1
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
    
BSOCollection.SelLeft     PROCEDURE
CODE
    ! do something
    RETURN TRUE
        
    
BSOCollection.SelRight     PROCEDURE
CODE
    ! do something    
    RETURN TRUE
                   
BSOCollection.Records       PROCEDURE()        
    CODE
        sst.Trace('BEGIN:BSOCollection.Records')
        sst.Trace('RECORDS(SELF.ul) = ' & RECORDS(SELF.ul))
        sst.Trace('END:BSOCollection.Records')
        RETURN RECORDS(SELF.ul)
        
BSOCollection.Pointer       PROCEDURE()
    CODE
        sst.Trace('BEGIN:BSOCollection.Pointer')
        sst.Trace('POINTER(SELF.ul) = ' & POINTER(SELF.ul))
        sst.Trace('END:BSOCollection.Pointer')
        RETURN POINTER(SELF.ul)
        
BSOCollection.GetCurrentSelPos      PROCEDURE()
    CODE
        sst.Trace('BEGIN:BSOCollection.GetCurrentSelPos')
        sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        sst.Trace('END:BSOCollection.GetCurrentSelPos')
        RETURN SELF.selQueuePos
        
                                

BSOCollection.Get        PROCEDURE()
    CODE
        sst.Trace('BEGIN:BSOCollection.Get()')
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            succes# = TRUE
        ELSE
            success# = FALSE
        END
        sst.Trace('END:BSOCollection.Get')
        RETURN success#

BSOCollection.UnitTypeCode  PROCEDURE()
    CODE
        sst.Trace('BEGIN:BSOCollection.UnitTypeCode')
        sst.Trace('SELF.ul.UnitTypeCode = ' & SELF.ul.UnitTypeCode)
        sst.Trace('END:BSOCollection.UnitTypeCode')
        RETURN SELF.ul.UnitTypeCode
        
BSOCOllection.SetUnitTypeCode       PROCEDURE(STRING sUnitTypeCode)
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
        
BSOCollection.Echelon      PROCEDURE()        
    CODE
        sst.Trace('BEGIN:BSOCollection.Echelon')
        sst.Trace('SELF.ul.Echelon = ' & SELF.ul.Echelon)
        sst.Trace('END:BSOCollection.Echelon')
        RETURN SELF.ul.Echelon                

BSOCollection.SetEchelon    PROCEDURE(LONG nEchelon)
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
        
BSOCollection.xPos  PROCEDURE()
    CODE
        RETURN SELF.ul.xPos
                                
        
BSOCollection.yPos  PROCEDURE()
    CODE
        RETURN SELF.ul.yPos
        
BSOCollection.Hostility     PROCEDURE()
    CODE
        sst.Trace('BEGIN:BSOCollection.Hostility')
        sst.Trace('SELF.ul.Hostility = ' & SELF.ul.Hostility)
        sst.Trace('END:BSOCollection.Hostility')
        RETURN SELF.ul.Hostility
        
BSOCollection.SetHostility  PROCEDURE(LONG nHostility)
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
                               
        
BSOCollection.markForDisbl  PROCEDURE()
    CODE
        RETURN SELF.ul.markForDel
        
BSOCollection.IsHQ  PROCEDURE()
    CODE
        ! do something
        RETURN SELF.ul.IsHQ

BSOCollection.SetHQ PROCEDURE(BOOL bIsHQ)
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
        
BSOCollection.UnitName      PROCEDURE
    CODE
        RETURN SELF.ul.UnitName
        
BSOCollection.SetUnitName   PROCEDURE(STRING sUnitName)
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
               
                
BSOCollection.TreePos       PROCEDURE
    CODE
        RETURN SELF.ul.TreePos
        
        
BSOCollection.SelectByMouse PROCEDURE(LONG nXPos, LONG nYPos)        
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
        
     
C2IP.Construct      PROCEDURE()
    CODE
        ! initialize default objects    
    !SELF.ul     &= NEW(UnitsList)
    !SELF.tmpul  &= NEW(UnitsList)
        SELF.ul     &= NEW(BSOCollection)
        SELF.tmpul  &= NEW(BSOCollection)
    
    ! default C2IP Name
    SELF.Name   = ''
    LOOP 10 TIMES
        SELF.Name = CLIP(SELF.Name) & CHR(RANDOM(97, 122))    
    END       
    
    ! referenced C2IPs list
    SELF.refC2IPs   &= NEW(C2IPsList)
    
    SELF.labelEditMode  = FALSE
        
C2IP.Destruct       PROCEDURE()
    CODE    
        ! destroy default objects    
        DISPOSE(SELF.refC2IPs)        
        DISPOSE(SELF.tmpul)
        DISPOSE(SELF.ul)
        
C2IP.InitDraw     PROCEDURE(Draw pDraw)
CODE
    ! Init Drawing Object    
    SELF.drwImg     &= pDraw        
                  
OrgChartC2IP.Construct     PROCEDURE()
    CODE
        PARENT.Construct()    

OrgChartC2IP.Redraw PROCEDURE()
nCurrentUnitType    LONG
CODE
    ! redraw OrgChar C2IP content
    sst.Trace('BEGIN:OrgChartC2IP.Redraw')
    
    SELF.drwImg.Blank(COLOR:White)
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    sst.Trace('RECORDS(SELF.ul) = ' & RECORDS(SELF.ul))
    LOOP i# = 1 TO RECORDS(SELF.ul)
        GET(SELF.ul.ul, i#)
        sst.Trace('i# = ' & i#)
        IF NOT ERRORCODE() THEN
            ! Unit Type Code
            sst.Trace('! Unit Type Code = ' & CLIP(SELF.ul.UnitTypeCode()) )
            CASE CLIP(SELF.ul.UnitTypeCode())
            OF '120300'
                ! Amphibious
                IF SELF.DrawNode_Amphibious(FALSE) = TRUE THEN
                END
            OF '120400'
                ! Antitank/Antiarmor
                IF SELF.DrawNode_Antiarmor(FALSE) = TRUE THEN
                END
            OF '120401'
                ! Antitank/Antiarmor->Armored
                IF SELF.DrawNode_Antiarmor_Armored(FALSE) = TRUE THEN
                END
            OF '120402'
                ! Antitank/Antiarmor->Motorized
                IF SELF.DrawNode_Antiarmor_Motorized(FALSE) = TRUE THEN
                END
            OF '120500'
                ! Armor/Armored/Mechanized/Self-Propelled/Tracked
                IF SELF.DrawNode_Armor(FALSE) = TRUE THEN
                END
            OF '120501'
                !Armor/Armored/Mechanized/Self-Propelled/Tracked->Reconnaissance/Cavalry/Scout
                IF SELF.DrawNode_Armor_Recon(FALSE) = TRUE THEN
                END
            OF '120502'
                ! Armor/Armored/Mechanized/Self-Propelled/Tracked->Amphibious
                IF SELF.DrawNode_Armor_Amphibious(FALSE) = TRUE THEN
                END
            OF '120600'
                ! Army Aviation/Aviation Rotary Wing
                IF SELF.DrawNode_ArmyAviation(FALSE) = TRUE THEN
                END
            OF '120601'
                ! Army Aviation/Aviation Rotary Wing->Reconnaissance
                IF SELF.DrawNode_ArmyAviation_Recon(FALSE) = TRUE THEN
                END
            OF '120700'
                ! Aviation Composite
                IF SELF.DrawNode_AviationComposite(FALSE) = TRUE THEN
                END
            OF '120800'
                ! Aviation Fixed Wing
                IF SELF.DrawNode_AviationFixedWing(FALSE) = TRUE THEN
                END
            OF '120801'
                ! Aviation Fixed Wing->Reconnaissance
                IF SELF.DrawNode_AviationFixedWing_Recon(FALSE) = TRUE THEN
                END
            OF '120900'
                ! Combat
                IF SELF.DrawNode_Combat(FALSE) = TRUE THEN
                END
            OF '121000'
                ! Combined Arms
                IF SELF.DrawNode_CombinedArms(FALSE) = TRUE THEN
                END
            OF '121100'
                ! Infantry
                IF SELF.DrawNode_Infantry(FALSE) = TRUE THEN
                END
            OF '121101'
                ! Infantry Amphibious
                IF SELF.DrawNode_Infantry_Amphibious(FALSE) = TRUE THEN
                END
            OF '121102'
                ! Infantry Armored/Mechanized/Tracked
                IF SELF.DrawNode_Infantry_Armored(FALSE) = TRUE THEN
                END
            OF '121103'
                ! Infantry Main Gun System
                IF SELF.DrawNode_Infantry_MainGunSystem(FALSE) = TRUE THEN
                END
            OF '121104'
                ! Infantry Motorized
                IF SELF.DrawNode_Infantry_Motorized(FALSE) = TRUE THEN
                END
            OF '121105'
                ! Infantry Infantry Fighting Vehicle
                IF SELF.DrawNode_Infantry_FightingVehicle(FALSE) = TRUE THEN
                END
            OF '121200'
                ! Observer
                IF SELF.DrawNode_Observer(FALSE) = TRUE THEN
                END
            OF '121300'
                ! Reconnaissance/Cavalry/Scout
                IF SELF.DrawNode_Reconnaissance(FALSE) = TRUE THEN
                END
            OF '121301'
                ! Reconnaissance/Cavalry/Scout -> Reconnaissance and Surveillance
                IF SELF.DrawNode_Reconnaissance_Recon(FALSE) = TRUE THEN
                END
            OF '121302'
                ! Reconnaissance/Cavalry/Scout -> Marine
                IF SELF.DrawNode_Reconnaissance_Marine(FALSE) = TRUE THEN
                END
            OF '121303'
                ! Reconnaissance/Cavalry/Scout -> Motorized
                IF SELF.DrawNode_Reconnaissance_Motorized(FALSE) = TRUE THEN
                END
            OF '121400'
                ! Sea Air Land (SEAL)
            OF '121500'
                ! Snipper
            OF '121600'
                ! Surveillance
            OF '121700'
                ! Special Forces
            OF '121800'
                ! Special Operations Forces (SOF)
            OF '121801'
                ! Special Operations Forces (SOF) -> 	Fixed Wing MISO
            OF '121802'
                ! Special Operations Forces (SOF) -> 	Ground
            OF '121803'
                ! Special Operations Forces (SOF) -> 	Special Boat
            OF '121804'
                ! Special Operations Forces (SOF) -> 	Special SSNR
            OF '121805'
                ! Special Operations Forces (SOF) -> 	Underwater Demolition Team
            OF '121900'
                ! Unmanned Aerial Systems
            OF '130000'
                ! Fires
            OF '130100'
                ! Air Defense
            OF '130101'
                ! Air Defense -> Main Gun System
            OF '130102'
                ! Air Defense -> Missile
            OF '130200'
                ! Air/Land Naval Gunfire Liaison
            OF '130300'
                ! Field Artillery
            OF '130301'
                ! Field Artillery -> Self-propelled
            OF '130302'
                ! Field Artillery -> Target Acquisition
            OF '130400'
                ! Field Artillery Observer
            OF '130500'
                ! Joint Fire Support
            OF '130600'
                ! Meteorological
            OF '130700'
                ! Missile
            OF '130800'
                ! Mortar
            OF '130801'
                ! Mortar -> Armored/Mechanized/Tracked
            OF '130802'
                ! Mortar ->	Self-Propelled Wheeled
            OF '130803'
                ! Mortar -> Towed
            OF '130900'
                ! Survey
            OF '140000'
                ! Protection
            OF '140100'
                ! Chemical Biological Radiological Nuclear Defense
            OF '140101'
                ! Chemical Biological Radiological Nuclear Defense -> Mechanized
            OF '140102'
                ! Chemical Biological Radiological Nuclear Defense -> Motorized
            OF '140103'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance
            OF '140104'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance Armored
            OF '140105'
                ! Chemical Biological Radiological Nuclear Defense -> Reconnaissance Equipped
            OF '140200'
                ! Combat Support (Maneuver Enhancement)
            OF '140300'
                ! Criminal Investigation Division
            OF '140400'
                ! Diving
            OF '140500'
                ! Dog
            OF '140600'
                ! Drilling
            OF '140700'
                ! Engineer
                IF SELF.DrawNode_Engineer(FALSE) = TRUE THEN
                END
            OF '140701'
                ! Engineer -> Mechanized
                IF SELF.DrawNode_Engineer_Mechanized(FALSE) = TRUE THEN
                END
            OF '140702'
                ! Engineer -> Motorized
                IF SELF.DrawNode_Engineer_Motorized(FALSE) = TRUE THEN
                END
            OF '140703'
                ! Engineer -> Reconnaissance
                IF SELF.DrawNode_Engineer_Recon(FALSE) = TRUE THEN
                END
            ELSE
                IF SELF.DrawNode_Default(FALSE) = TRUE THEN
                END
            END                                    
            
            ! Echelon
            CASE SELF.ul.Echelon()
            OF echTpy:Team
                ! Team
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
            OF echTpy:Squad
                ! Squad
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
            OF echTpy:Section
                ! Section
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
            OF echTpy:Platoon
                ! Platoon
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 7, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
                SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
            OF echTpy:Company
                ! Company
                SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 0, 4)
            OF echTpy:Battalion
                ! Battalion
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 1, SELF.ul.yPos() - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 0, 4)
            OF echTpy:Regiment
                ! Regiment
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 0, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 2, SELF.ul.yPos() - 6, 0, 4)
            OF echTpy:Brigade
                ! Brigade
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:Division
                ! Divion
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:Corps
                ! Corps
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:Army
                ! Army
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:ArmyGroup
                ! Army Group
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 10, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 10, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 8, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 8, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:Theater
                ! Theater
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 15, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 15, SELF.ul.yPos() - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 3, 4, -4) 
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 3, 4, -4)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 11, SELF.ul.yPos() - 6, 4, 4)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 11, SELF.ul.yPos() - 3, 4, -4)
            OF echTpy:Command
                ! Command
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 3, SELF.ul.yPos() - 6, 0, 5)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 4, 5, 0)
                
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 0, 5)
                SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 4, 5, 0)
            END
        END
        
    END
    
    SELF.drwImg.Display()
    sst.Trace('END:OrgChartC2IP.Redraw')
    

OrgChartC2IP.DrawNode       PROCEDURE(LONG nUnitType=0)
err1                            BOOL
err2                            BOOL
err3                            BOOL

CODE
    ! do something
    
    ! Unit Type
    CASE nUnitType
    OF uTpy:infantry
        err1 = SELF.DrawNode_Infantry()
    ELSE
        ! Default Node
        err1 = SELF.DrawNode_Default()                       
    END
    
    err2 = SELF.DrawNode_Echelon()           
    
    RETURN TRUE
    
    
    

!OrgChartC2IP.DrawNode_*.*
OrgChartC2IP.DrawNode_Default       PROCEDURE(BOOL bAutoDisplay)
nFillColor      LONG
    CODE
        sst.Trace('BEGIN:OrgChartC2IP.DrawNode_Default')
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        
        ! Fill color depending on Hostility
        sst.Trace('SELF.ul.Hostility() = ' & SELF.ul.Hostility())
        CASE CLIP(SELF.ul.Hostility())
        OF hTpy:Unknown
            ! yellow
            nFillColor  = COLOR:Unknown
            sst.Trace('nFillColor = COLOR:Unknown')
        OF hTpy:AssumedFriend
            ! blue
            nFillColor  = COLOR:AssumedFriend
            sst.Trace('nFillColor = COLOR:AssumedFriend')
        OF hTpy:Friend
            ! blue
            nFillColor  = COLOR:Friend
            sst.Trace('nFillColor = COLOR:Friend')
        OF hTpY:Neutral
            ! green
            nFillColor  = COLOR:Neutral
            sst.Trace('nFillColor = COLOR:Neutral')
        OF hTpy:Suspect
            ! red
            nFillColor  = COLOR:Suspect
            sst.Trace('nFillColor = COLOR:Suspect')
        OF hTpy:Hostile
            ! red
            nFillColor  = COLOR:Hostile        
            sst.Trace('nFillColor = COLOR:Hostile')
        ELSE
            nFillColor  = COLOR:Unknown
            sst.Trace('nFillColor = COLOR:Unknown')
        END            
        
        ! Fill color depeding on Enable/Disable status for new drag&drop selections
        sst.Trace('SELF.ul.markForDisbl() = ' & SELF.ul.markForDisbl())
        IF SELF.ul.markForDisbl() = TRUE THEN
            ! Display as unable for newer selections
            nFillColor  = COLOR:NodeDisabled    
            sst.Trace('nFillColor = ' & nFillColor)
        END    
        sst.Trace('nFillColor = ' & nFillColor)
        sst.Trace('before BOX')
        SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(), 50, 30, nFillColor)
        sst.Trace('after BOX')
        sst.Trace('before SHOW')
        SELF.drwImg.Show(SELF.ul.xPos() + 5 + 50, SELF.ul.yPos() + 11, SELF.ul.UnitName())   
        sst.Trace('after SHOW')
        
        sst.Trace('SELF.ul.IsHQ() = ' & SELF.ul.IsHQ())
        IF SELF.ul.IsHQ() THEN
            ! Is HQ
            SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 0, 10)
        END
        
        sst.Trace('bAutoDisplay = ' & bAutoDisplay)
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
    
        sst.Trace('END:OrgChartC2IP.DrawNode_Default')
        RETURN TRUE      
    
OrgChartC2IP.Draw_innerSine PROCEDURE()
    CODE
        ! inner sine function
        SELF.drwImg.Arc(SELF.ul.xPos() - 5, SELF.ul.yPos() + 15 + 5, 10, -10, 2700, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5, SELF.ul.yPos() + 15 + 5, 10, -10, 0, 1800)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5 + 10, SELF.ul.yPos() + 10, 10, 10, 1800, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 + 5, 10, -10, 0, 1800)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 + 10, SELF.ul.yPos() + 10, 10, 10, 1800, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 50 - 5, SELF.ul.yPos() + 20, 10, -10, 900, 1800)
        
OrgChartC2IP.Draw_innerEllipse       PROCEDURE()
    CODE        
        ! inner ellipse
        SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 10, 20, 0)
        SELF.drwImg.Arc(SELF.ul.xPos() + 15 + 20 - 5, SELF.ul.yPos() + 10, 10, 10, 2700, 900)
        SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 20, 20, 0)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5 + 5, SELF.ul.yPos() + 10, 10, 10, 900, 2700)
        
OrgChartC2IP.Draw_medianLine        PROCEDURE()
    CODE
        ! median line
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 0, 30)

OrgChartC2IP.Draw_secondDiag        PROCEDURE()
    CODE        
        ! second diagonal
        SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 50, -30)
        
OrgChartC2IP.Draw_innerFork     PROCEDURE()
    CODE
        ! inner fork
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 - 5, 10, 0)
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 - 5, 0, 10)
    SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 0, 10)
    SELF.drwImg.Line(SELF.ul.xPos() + 25 + 5, SELF.ul.yPos() + 15 - 5, 0, 10)
        
        
OrgChartC2IP.Draw_innerPapillon     PROCEDURE()
pVertices    LONG, DIM(6)
    CODE
        ! inner papillon
        pVertices[1] = SELF.ul.xPos() + 25 - 5
        pVertices[2] = SELF.ul.yPos() + 15 - 5
        pVertices[3] = SELF.ul.xPos() + 25
        pVertices[4] = SELF.ul.yPos() + 15
        pVertices[5] = SELF.ul.xPos() + 25 - 5
        pVertices[6] = SELF.ul.yPos() + 15 + 5
        SELF.drwImg.Polygon(pVertices, COLOR:Black)
        pVertices[1] = SELF.ul.xPos() + 25
        pVertices[2] = SELF.ul.yPos() + 15
        pVertices[3] = SELF.ul.xPos() + 25 + 5
        pVertices[4] = SELF.ul.yPos() + 15 - 5
        pVertices[5] = SELF.ul.xPos() + 25 + 5
        pVertices[6] = SELF.ul.yPos() + 15 + 5
        SELF.drwImg.Polygon(pVertices, COLOR:Black)
        
OrgChartC2IP.Draw_innerSmallClepsydra    PROCEDURE()
pVertices    LONG, DIM(6)
    CODE
        ! inner clepsydra
        pVertices[1] = SELF.ul.xPos() + 25 - 5
        pVertices[2] = SELF.ul.yPos() + 15 - 5
        pVertices[3] = SELF.ul.xPos() + 25 + 5
        pVertices[4] = SELF.ul.yPos() + 15 - 5
        pVertices[5] = SELF.ul.xPos() + 25
        pVertices[6] = SELF.ul.yPos() + 15
        SELF.drwImg.Polygon(pVertices, COLOR:Black)
        pVertices[1] = SELF.ul.xPos() + 25
        pVertices[2] = SELF.ul.yPos() + 15
        pVertices[3] = SELF.ul.xPos() + 25 + 5
        pVertices[4] = SELF.ul.yPos() + 15 + 5
        pVertices[5] = SELF.ul.xPos() + 25 - 5
        pVertices[6] = SELF.ul.yPos() + 15 + 5
        SELF.drwImg.Polygon(pVertices, COLOR:Black)        
        
OrgChartC2IP.Draw_innerSmallRoundPapillon        PROCEDURE()
pVertices    LONG, DIM(6)
    CODE
        ! inner small papillon
        pVertices[1] = SELF.ul.xPos() + 25 - 4
        pVertices[2] = SELF.ul.yPos() + 15 - 1
        pVertices[3] = SELF.ul.xPos() + 25
        pVertices[4] = SELF.ul.yPos() + 15
        pVertices[5] = SELF.ul.xPos() + 25 - 4
        pVertices[6] = SELF.ul.yPos() + 15 + 1
        SELF.drwImg.Polygon(pVertices, COLOR:Black)
        pVertices[1] = SELF.ul.xPos() + 25
        pVertices[2] = SELF.ul.yPos() + 15
        pVertices[3] = SELF.ul.xPos() + 25 + 4
        pVertices[4] = SELF.ul.yPos() + 15 - 1
        pVertices[5] = SELF.ul.xPos() + 25 + 4
        pVertices[6] = SELF.ul.yPos() + 15 + 1
        SELF.drwImg.Polygon(pVertices, COLOR:Black)
        
        ! inner arc chords
        !SELF.drwImg.Chord(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() + 15 - 1, - 2, 3, 900, 2700, COLOR:Black)
        !SELF.drwImg.Chord(SELF.ul.xPos() + 25 + 2, SELF.ul.yPos() + 15 - 1, 2, 3, 2700, 3599, COLOR:Black)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 - 4 - 2, SELF.ul.yPos() + 15 - 1, 2, 3, 900, 2700)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 + 4 + 2, SELF.ul.yPos() + 15 - 1, 2, 3, 2700, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 + 4 + 2, SELF.ul.yPos() + 15 - 1, 2, 3, 0, 900)
        
    
OrgChartC2IP.Draw_innerRoundPapillon      PROCEDURE()
pVertices           LONG, DIM(6)
    CODE
        ! inner papillon
        SELF.Draw_innerPapillon()
        ! inner chords
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 - 5 - 5, SELF.ul.yPos() + 15 - 5, 10, 10, 900, 2700)
        !SELF.drwImg.Chord(SELF.ul.xPos() + 25 - 5 - 5, SELF.ul.yPos() + 15 - 5, 10, 10, 900, 2700, COLOR:Black)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 10, 10, 2700, 3599)
        !SELF.drwImg.Chord(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 10, 10, 2700, 3599, COLOR:Black)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 10, 10, 0, 900)
        !SELF.drwImg.Chord(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 10, 10, 0, 900, COLOR:Black)
        
OrgChartC2IP.Draw_innerTriangle PROCEDURE
pVertices           LONG, DIM(6)
    CODE
        ! inner triangle
        pVertices[1] = SELF.ul.xPos() + 25 - 5
        pVertices[2] = SELF.ul.yPos() + 15 + 2
        pVertices[3] = SELF.ul.xPos() + 25
        pVertices[4] = SELF.ul.yPos() + 15 - 3
        pVertices[5] = SELF.ul.xPos() + 25 + 5
        pVertices[6] = SELF.ul.yPos() + 15 + 2
        SELF.drwImg.Polygon(pVertices, COLOR:Black, COLOR:Black)
               
                                                     
OrgChartC2IP.DrawNode_Amphibious PROCEDURE(BOOL bAutoDisplay)
    CODE
        erroCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner sine function
        SELF.Draw_innerSine()
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
        
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Antiarmor PROCEDURE(BOOL bAutoDisplay)
    CODE
        erroCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner arrow
        SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 25, -30)
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 25, 30)            
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
        
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Antiarmor_Armored PROCEDURE(BOOL bAutoDisplay)
    CODE
        
        errCode#    = SELF.DrawNode_Antiarmor(bAutoDisplay)
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Antiarmor_Motorized       PROCEDURE(BOOL bAutoDisplay)
    CODE        
        errCode#    = SELF.DrawNode_Antiarmor(bAutoDisplay)
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Armor      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner ellipse
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
    RETURN TRUE

OrgChartC2IP.DrawNode_Armor_Recon        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Armor(bAutoDisplay)
        ! 2nd diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Armor_Amphibious   PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Armor(bAutoDisplay)
        ! inner sine
        SELF.Draw_innerSine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
                RETURN TRUE
        
OrgChartC2IP.DrawNode_ArmyAviation  PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#   = SELF.DrawNode_Default(bAutoDisplay)
        ! inner papillon
        SELF.Draw_innerPapillon()                
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
OrgChartC2IP.DrawNode_ArmyAviation_Recon     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_ArmyAviation(bAutoDisplay)
        ! second diagonale
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE                
        
OrgChartC2IP.DrawNode_AviationComposite     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()
        ! clepsydra
        SELF.Draw_innerSmallClepsydra()
        ! round papillon
        SELF.Draw_innerSmallRoundPapillon()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
OrgChartC2IP.DrawNode_AviationFixedWing     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()
        ! inner round papillon
        SELF.Draw_innerRoundPapillon()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE        
        
OrgChartC2IP.DrawNode_AviationFixedWing_Recon     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_AviationFixedWing(bAutoDisplay)        
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE        
                
        
OrgChartC2IP.DrawNode_Combat         PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()
        ! CBT
        SELF.drwImg.Show(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() + 15 + 5, 'CBT')       
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
OrgChartC2IP.DrawNode_CombinedArms   PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default(bAutoDisplay)
        
        ! inner ellipse
        SELF.Draw_innerEllipse()
        ! inner empty clepsydra
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() + 15 - 5, 20, 10)        
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() + 15 + 5, 20, -10)

        
        
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
        
    
OrgChartC2IP.DrawNode_Infantry      PROCEDURE(BOOL bAutoDisplay)
nFillColor          LONG
CODE

    errCode#    = SELF.DrawNode_Default(bAutoDisplay)
    SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos(), 50, 30)
    SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 50, -30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
    
OrgChartC2IP.DrawNode_Infantry_Amphibious        PROCEDURE(BOOL bAutoDisplay)
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)
    
    ! inner sine function
    SELF.Draw_innerSine()    
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_Armored   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)
    
    SELF.Draw_innerEllipse()    
            
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_MainGunSystem   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)    

    ! Left line
    SELF.drwImg.Line(SELF.ul.xPos() + 8, SELF.ul.yPos(), 0, 30)
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Infantry_Motorized   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)    
    
    ! Midle line
    SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 0, 30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE    
    
OrgChartC2IP.DrawNode_Infantry_FightingVehicle   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)    
    
    ! inner ellipse
    SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 10, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos() + 15 + 20 - 5, SELF.ul.yPos() + 10, 10, 10, 2700, 900)
    SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 20, 20, 0)
    SELF.drwImg.Arc(SELF.ul.xPos() + 5 + 5, SELF.ul.yPos() + 10, 10, 10, 900, 2700)
    ! Left line
    SELF.drwImg.Line(SELF.ul.xPos() + 8, SELF.ul.yPos(), 0, 30)
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE    

    
        
!OrgChartC2IP.DrawNode_Observer
OrgChartC2IP.DrawNode_Observer      PROCEDURE(BOOL bAutoDisplay)    
nFillColor      LONG
CODE
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    
    ! Fill color depending on Hostility
    CASE SELF.ul.Hostility()
    OF hTpy:Unknown
        ! yellow
        nFillColor  = COLOR:Unknown
    OF hTpy:AssumedFriend
        ! blue
        nFillColor  = COLOR:AssumedFriend
    OF hTpy:Friend
        ! blue
        nFillColor  = COLOR:Friend
    OF hTpY:Neutral
        ! green
        nFillColor  = COLOR:Neutral
    OF hTpy:Suspect
        ! red
        nFillColor  = COLOR:Suspect
    OF hTpy:Hostile
        ! red
        nFillColor  = COLOR:Hostile        
    ELSE
        nFillColor  = COLOR:Unknown
    END            
    
    ! Fill color depeding on Enable/Disable status for new drag&drop selections
    IF SELF.ul.markForDisbl() = TRUE THEN
        ! Display as unable for newer selections
        nFillColor  = COLOR:NodeDisabled    
    END    
    SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(), 50, 30, nFillColor)
        
    SELF.drwImg.Show(SELF.ul.xPos() + 5 + 50, SELF.ul.yPos() + 11, SELF.ul.UnitName())
    ! inner triangle
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 + 2, 5, -5)
    SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 3, 5, 5)      
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 + 2, 10, 0)
    
    IF SELF.ul.IsHQ() THEN
        SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 0, 10)
    END
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
OrgChartC2IP.DrawNode_Reconnaissance        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()        
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Reconnaissance_Recon  PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner triangle
        SELF.Draw_innerTriangle()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Reconnaissance_Marine PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner ellipse
        SELF.Draw_innerSine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Reconnaissance_Motorized      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner middle line
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
        
OrgChartC2IP.DrawNode_Engineer      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()        
        ! inner fork
        SELF.Draw_innerFork()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Engineer_Mechanized   PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner ellipse
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Engineer_Motorized    PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner median line
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
OrgChartC2IP.DrawNode_Engineer_Recon        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
    
OrgChartC2IP.DrawNode_Echelon       PROCEDURE(BOOL bAutoDisplay)
CODE
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)        
    
    CASE SELF.ul.Echelon()
    OF echTpy:Team
        ! Team
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
    OF echTpy:Squad
        ! Squad
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
    OF echTpy:Section
        ! Section
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
    OF echTpy:Platoon
        ! Platoon
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 7, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
        SELF.drwImg.Ellipse(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4, COLOR:Black)
    OF echTpy:Company
        ! Company
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 0, 4)
    OF echTpy:Battalion
        ! Battalion
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 1, SELF.ul.yPos() - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 0, 4)
    OF echTpy:Regiment
        ! Regiment
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() - 6, 0, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 2, SELF.ul.yPos() - 6, 0, 4)
    OF echTpy:Brigade
        ! Brigade
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:Division
        ! Division
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:Corps
        ! Corps
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4)        
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:Army
        ! Army
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:ArmyGroup
        ! Army Group
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 10, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 10, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2 - 5, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 2, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 8, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 8, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:Theater
        !Theater
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 15, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 15, SELF.ul.yPos() - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() - 3, 4, -4) 
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 6, SELF.ul.yPos() - 3, 4, -4)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 11, SELF.ul.yPos() - 6, 4, 4)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 11, SELF.ul.yPos() - 3, 4, -4)
    OF echTpy:Command
        ! Command
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 3, SELF.ul.yPos() - 6, 0, 5)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() - 4, 5, 0)
                
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 3, SELF.ul.yPos() - 6, 0, 5)
        SELF.drwImg.Line(SELF.ul.xPos() + 25 + 1, SELF.ul.yPos() - 4, 5, 0)
    END
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    
    RETURN TRUE
    

    
    
    
    
OrgChartC2IP.InsertNode     PROCEDURE
    CODE
        SELF.DisplayUnselection()
        SELF.ul.InsertNode()
        SELF.Redraw()
        SELF.DisplaySelection()
        
OrgChartC2IP.InsertNode     PROCEDURE(*UnitBasicRecord pURec)
    CODE
        errCode#    = SELF.ul.InsertNode(pUrec)
        IF errCode# = TRUE THEN
            SELF.Redraw()
        END
        
        
    
OrgChartC2IP.GetNode     PROCEDURE(*UnitBasicRecord pURec)
CODE
    ! get current node
    
    GET(SELF.ul.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        pUrec.UnitName          = SELF.ul.UnitName()
        !pUrec.UnitType          = SELF.ul.UnitType()
        pUrec.UnitTypeCode      = SELF.ul.UnitTypeCode()
        pUrec.Echelon           = SELF.ul.Echelon()
        pURec.Hostility         = SELF.ul.Hostility()
        pUrec.IsHQ              = SELF.ul.IsHQ()
        pUrec.xPos              = SELF.ul.xPos()
        pUrec.yPos              = SELF.ul.yPos()
        pUrec.TreePos           = SELF.ul.TreePos()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.DeleteNode     PROCEDURE
CODE
    ! do something
    SELF.ul.DeleteNode()
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    OMIT('__reeng')
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
                SELF.ul.yPos()    = (POINTER(SELF.ul)-1)*30 + 1
                PUT(SELF.ul)
                i# = i# + 1
            END            
        ELSE
            BREAK
        END
        
    END
    __reeng    
    
    
    
OrgChartC2IP.DisableNode    PROCEDURE
CODE
    ! do something
    SELF.ul.DisableNode()
    SELF.Redraw()  
    SELF.DisplaySelection()
    
    OMIT('__reeng')
    GET(SELF.ul, SELF.selQueuePos)
    IF NOT ERRORCODE() THEN
        ! Mark for disableling for new drag&drop selection
        SELF.ul.markForDisbl  = TRUE
        PUT(SELF.ul)
    END
    __reeng
    
    
    
    
    
OrgChartC2IP.DisplaySelection     PROCEDURE
CODE
    ! display SELECTION frame (red) for the current selection
    sst.Trace('BEGIN:OrgChartC2IP.DisplaySelection')
    IF SELF.ul.GetNode() = TRUE THEN
        SELF.drwImg.Setpencolor(COLOR:Red)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(),50,30)
        !SELF.drwImg.Show(SELF.ul.xPos() + 5 + 50, SELF.ul.yPos() + 11, SELF.ul.UnitName())
        SELF.drwImg.Display()
    END
    sst.Trace('END:OrgChartC2IP.DisplaySelection')
    
OrgChartC2IP.DisplaySelection       PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OrgChartC2IP.DisplaySelection(' & nXPos & ', ' & nYPos & ')')
        SELF.drwImg.Setpencolor(COLOR:Red)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(nXPos, nYPos,50,30)        
        SELF.drwImg.Display()
        sst.Trace('END:OrgChartC2IP.DisplaySelection')
        
    
    
OrgChartC2IP.DisplayUnselection     PROCEDURE
CODE
    ! display NORMAL frame (black) for the current selection
    sst.Trace('BEGIN:OrgChartC2IP.DisplayUnselection')
    IF SELF.ul.GetNode() = TRUE THEN
        SELF.drwImg.Setpencolor(COLOR:White)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(),50,30)
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(),50,30)
        SELF.drwImg.Display()
    END
    sst.Trace('END:OrgChartC2IP.DisplayUnselection')
    
OrgChartC2IP.DisplayUnselection     PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OrgChartC2IP.DisplayUnselection (' & nXPos & ', ' & nYPos & ')')
        SELF.drwImg.Setpencolor(COLOR:White)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(nXPos, nYPos,50,30)
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        SELF.drwImg.Box(nXPos, nYPos,50,30)
        SELF.drwImg.Display()
        sst.Trace('END:OrgChartC2IP.DisplayUnselection')
        
    
OrgChartC2IP.SelUp     PROCEDURE
CODE
    ! do something        
    SELF.DisplayUnselection()
    IF SELF.ul.SelUp() = TRUE THEN        
        ! do something
    END
    SELF.DisplaySelection()
     
    
OrgChartC2IP.SelDown     PROCEDURE
CODE
    ! do something
    SELF.DisplayUnselection()
    IF SELF.ul.SelDown() = TRUE THEN
        ! do something
    END
    SELF.DisplaySelection()
    
    OMIT('__reeng')
    IF SELF.selQueuePos<RECORDS(SELF.ul) THEN
        SELF.DisplayUnselection()
        !SELF.Redraw()
        SELF.selQueuePos = SELF.selQueuePos+1
        SELF.DisplaySelection()
    END
    __reeng
    
    
OrgChartC2IP.SelLeft     PROCEDURE
CODE
    ! do something
    
    
    
    
OrgChartC2IP.SelRight     PROCEDURE
CODE
    ! do something
    
    
    
    
OrgChartC2IP.SelectByMouse     PROCEDURE(LONG nXPos, LONG nYPos)
CODE
    ! do something
    sst.Trace('BEGIN:OrgChartC2IP.SelectByMouse')
    
    curSel#     = SELF.ul.Pointer()
    curXPos#    = SELF.ul.xPos()
    curYPos#    = SELF.ul.yPos()
        
    nodeFoundPos#   = SELF.ul.SelectByMouse(nXPos, nYPos)
    IF nodeFoundPos# > 0 THEN
        sst.Trace('node found')
        sst.Trace('curSel# = ' & curSel#)
        sst.Trace('curXPos# = ' & curXPos#)
        sst.Trace('curYPos# = ' & curYPos#)
        SELF.DisplayUnselection(curXPos#, curYPos#)
        
        SELF.selTreePos     = SELF.ul.TreePos()
        SELF.selQueuePos    = SELF.ul.Pointer()
        SELF.DisplaySelection()
    END
                
    sst.Trace('END:OrgChartC2IP.SelectByMouse')
    IF nodeFoundPos# > 0 THEN
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
        
OrgChartC2IP.Unselect     PROCEDURE()
CODE
    ! do something
    
    SELF.DisplayUnselection()
    
    RETURN TRUE
    
    
    
    
    
OrgChartC2IP.Destruct     PROCEDURE
CODE        
    PARENT.Destruct()
    
OrgChartC2IP.GetUnitName     PROCEDURE
CODE
    ! do something
    IF SELF.ul.Get() = TRUE THEN
        RETURN SELF.ul.UnitName()
    ELSE
        RETURN ''
    END    
    
OrgChartC2IP.SetUnitName     PROCEDURE(STRING sUnitName)
CODE
    ! do something
    IF SELF.ul.Get() = TRUE THEN
        IF SELF.ul.SetUnitName(sUnitName) = TRUE THEN
            SELF.Redraw()
            SELF.DisplaySelection()          
            RETURN TRUE            
        ELSE
            RETURN FALSE            
        END
    ELSE
        RETURN FALSE
    END
    
OrgChartC2IP.GetUnitTypeCode    PROCEDURE
    CODE
        IF SELF.ul.Get() = TRUE THEN
            RETURN SELF.ul.UnitTypeCode()
        ELSE
            RETURN ''
        END    
        
           
OrgChartC2IP.SetUnitTypeCode     PROCEDURE(STRING sUnitTypeCode)
CODE
    ! do something
    IF SELF.ul.SetUnitTypeCode(sUnitTypeCode) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END    
    
OrgChartC2IP.GetEchelon     PROCEDURE
CODE
    ! do something
    RETURN SELF.ul.Echelon()            
    
OrgChartC2IP.SetEchelon     PROCEDURE(LONG nEchelon)
CODE
    ! do something
    IF SELF.ul.SetEchelon(nEchelon) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END        
    
OrgChartC2IP.GetHostility     PROCEDURE
CODE
    ! do something
    RETURN SELF.ul.Hostility()
        
    
OrgChartC2IP.SetHostility     PROCEDURE(LONG nHostility)
CODE
    ! do something
    IF SELF.SetHostility(nHostility) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
        
    
OrgChartC2IP.GetHQ     PROCEDURE
    CODE
        
        RETURN SELF.ul.isHQ()
        
    
OrgChartC2IP.SetHQ     PROCEDURE(BOOL bIsHQ)
CODE
    ! do something
    IF SELF.ul.SetHQ(bIsHQ) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
       
    
OrgChartC2IP.Save     PROCEDURE()
CODE
    ! do something
    json.Start()
    !collection &= json.CreateCollection('Collection')
    !collection.Append(
    !json.Add('C2IPName', SELF.Name)
    collection &= json.CreateCollection('TaskOrg')
    collection.Append('C2IPName', SELF.Name, json:String)
    collection.Append(SELF.ul, 'Units')
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
!    LOOP i# = 1 TO RECORDS(SELF.refC2IPs)
!        GET(SELF.refC2IPs, i#)
!        IF ERROCODE() THEN
!            SELF.
!        END
!    END    
            
    json.SaveFile(CLIP(SELF.Name)&'.c2ip', TRUE)
    
    RETURN TRUE
    
OrgChartC2IP.Save     PROCEDURE(STRING sFileName)
CODE
    ! do something
    json.Start()
    !collection &= json.CreateCollection('Collection')
    !collection.Append(
    !json.Add('C2IPName', SELF.Name)
    collection &= json.CreateCollection('TaskOrg')
    collection.Append('C2IPName', SELF.Name, json:String)
    collection.Append(SELF.ul, 'Units')
    
    ! referenced C2IPs
    collection.Append(SELF.refC2IPs, 'refC2IPs')    
    
    json.SaveFile(sFileName, TRUE)
    
    RETURN TRUE
    
OrgChartC2IP.Load   PROCEDURE(STRING sFileName)
jsonItem  &JSONClass
CODE
    ! do something
    
    json.LoadFile(sFileName)
    
    i# = json.Records()
    !MESSAGE('found = ' & i#)
    
    ! C2IP Name
    jsonItem &= json.GetByName('C2IPName')
    IF NOT jsonItem &= Null THEN
        SELF.Name   = json.GetValueByName('C2IPName')
    END
    
    ! Units
    jsonItem &= json.GetByName('Units')
    IF NOT jsonItem &= NULL THEN
        !IF SELF.ul.Free() = TRUE THEN
        !END
        
        FREE(SELF.ul.ul)
        jsonItem.Load(SELF.ul.ul)
    END  
    
    ! refrenced C2IPs
    jsonItem &= json.GetByName('refC2IPs')
    IF NOT jsonItem &= NULL THEN
        FREE(SELF.refC2IPs)
        jsonItem.Load(SELF.refC2IPs)
    END
    
    
    SELF.Redraw()
    
    RETURN TRUE
    
    
    
! attach/detach C2IPs
OrgChartC2IP.AttachC2IP     PROCEDURE(STRING sFileName)
jsonItem                        &JSONClass
sC2IPName       STRING(100)
CODE
    ! do something
    
    json.LoadFile(sFileName)    
    i# = json.Records()
    
    ! C2IP Name
    jsonItem &= json.GetByName('C2IPName')
    IF NOT jsonItem &= Null THEN
        sC2IPName   = json.GetValueByName('C2IPName')
        
        SELF.refC2IPs.C2IPPath  = sFileName
        SELF.refC2IPs.C2IPName  = sC2IPName
        ADD(SELF.refC2IPs)
                
        RETURN TRUE
    ELSE
        RETURN FALSE
    END        
    
    
OrgChartC2IP.DetachC2IP     PROCEDURE(LONG nOPtion)
CODE
    ! do something
    
    
    RETURN TRUE    
    
    
    
OrgChartC2IP.TakeEvent   PROCEDURE(UNSIGNED nKeyCode)

CODE
    ! do something        
    
    RETURN TRUE
    
    
    
OrgChartC2IP.checkLabelEditMode   PROCEDURE()

CODE
    ! do something
    
    
    
    
OrgChartC2IP.TakeNodeAction   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Unit Name
!        CREATE(?uNameEntry, CREATE:entry)
!        SELF.uNameEntry = ''
!        ?uNameEntry{PROP:use} = SELF.uNameEntry
!        ?uNameEntry{PROP:text} = '@s100'
!        ?uNameEntry{PROP:Ypos} = 200
!        !?uNameEntry{PROP:
!        UNHIDE(?uNameEntry)
!        SELECT(?uNameEntry)
    OF 2
!        ! Unit Type        
!        UNHIDE(?ListSymbology)
!        SELECT(?ListSymbology)
    OF 3
        ! Echelon
        IF SELF.TakeEchelon(POPUP(SELF.EchelonMenuOptions())) = TRUE THEN
        END        
    OF 4
        ! Hostility
        IF SELF.TakeHostility(POPUP(SELF.HostilityMenuOptions())) = TRUE THEN
        END        
    OF 5
        ! HQ
!        CREATE(?uHQ, CREATE:check)
!        ?uHQ{PROP:Use} = SELF.bIsHQEntry
!        ?uHQ{PROP:TrueValue} = TRUE
!        ?uHQ{PROP:FalseValue} = FALSE
!        ?uHQ{PROP:XPos} = 30
!        ?uHQ{PROP:Ypos} = 200
!        UNHIDE(?uHQ)
!        SELECT(?uHQ)
    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.NodeActionsMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Change label | Change Unit type | Change Echelon | Change Hostility | Is HQ'
    
    
    
    
OrgChartC2IP.TakeEchelon   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Team
        ASSERT(SELF.SetEchelon(echTpy:Team), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Team)')
    OF 2
        ! Squad
        ASSERT(SELF.SetEchelon(echTpy:Squad), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Squad)')
    OF 3
        ! Section
        ASSERT(SELF.SetEchelon(echTpy:Section), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Section)')
    OF 4
        ! Platoon
        ASSERT(SELF.SetEchelon(echTpy:Platoon), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Platoon)')
    OF 5
        ! Company
        ASSERT(SELF.SetEchelon(echTpy:Company), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Company)')
    OF 6
        ! Battalion
        ASSERT(SELF.SetEchelon(echTpy:Battalion), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Battalion)')
    OF 7
        ! Regiment
        ASSERT(SELF.SetEchelon(echTpy:Regiment), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Regiment)')
    OF 8
        ! Brigade
        ASSERT(SELF.SetEchelon(echTpy:Brigade), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Brigade)')
    OF 9
        ! Division
        ASSERT(SELF.SetEchelon(echTpy:Division), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Division)')
    OF 10
        ! Corps
        ASSERT(SELF.SetEchelon(echTpy:Corps), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Corps)')
    OF 11
        ! Army
        ASSERT(SELF.SetEchelon(echTpy:Army), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Army)')
    OF 12
        ! Army Group
        ASSERT(SELF.SetEchelon(echTpy:ArmyGroup), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:ArmyGroup)')
    OF 13
        ! Theater
        ASSERT(SELF.SetEchelon(echTpy:Theater), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Theater)')
    OF 14
        ! Command
        ASSERT(SELF.SetEchelon(echTpy:Command), 'OrgChartC2IP.TakeEchelon()->SELF.SetEchelon(echTpy:Command)')

    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.EchelonMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Team o| Squad * | Section **| Platoon ***| Company :| Battalion ::| Regiment :::| Brigade x| Division xx| Corps xxx| Army xxxx| Army Group xxxxx| Theater xxxxxx| Command ++'
    
    
    
    
OrgChartC2IP.TakeHostility   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Unknown
        ASSERT(SELF.SetHostility(hTpy:Unknown), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Unknown)')
    OF 2
        ! Assumed Friend
        ASSERT(SELF.SetHostility(hTpy:AssumedFriend), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:AssumedFriend)')
    OF 3
        ! Friend
        ASSERT(SELF.SetHostility(hTpy:Friend), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Friend)')
    OF 4
        ! Neutral
        ASSERT(SELF.SetHostility(hTpy:Neutral), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Neutral)')
    OF 5
        ! Suspect/Joker
        ASSERT(SELF.SetHostility(hTpy:Suspect), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Suspect)')
    OF 6
        ! Hostile/Faker
        ASSERT(SELF.SetHostility(hTpy:Hostile), 'OrgChartC2IP.TakeHostility()->SELF.SetHostility(hTpy:Hostile)')
    END
    
    RETURN TRUE    
    
    
    
    
OrgChartC2IP.HostilityMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Unknown | Assumed Friend | Friend | Neutral | Suspect/Jokjer | Hostile/Faker'
    
    
    
    
        


OverlayC2IP.Construct       PROCEDURE()
    CODE
        PARENT.Construct()
        
OverlayC2IP.Destruct        PROCEDURE()
    CODE
        PARENT.Destruct()
        
        
OverlayC2IP.Redraw  PROCEDURE()
    CODE
        SELF.drwImg.Blank(COLOR:White)
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        
        LOOP i# = 1 TO RECORDS(SELF.ul)
            GET(SELF.ul.ul, i#)
            IF NOT ERRORCODE() THEN
                SELF.drwImg.Box(SELF.ul.xPos(), SELF.ul.yPos(), 50, 30, COLOR:Aqua)
            END
        END
 
        SELF.drwImg.Display()

        
        
OverlayC2IP.DeployBSO       PROCEDURE(*UnitBasicRecord pUrec, LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OverlayC2IP.DeployBSO')
        sst.Trace('nXPos = ' & nXPos & ', nYPos = ' & nYPos)
        pUrec.xPos  = nXPos
        pUrec.yPos  = nYPos
        
        errCode#    = SELF.ul.InsertNode(pUrec)
        IF errCode# = TRUE THEN
            SELF.Redraw()
        END
        
        sst.Trace('END:OverlayC2IP.DeployBSO')
        RETURN TRUE
        
OverlayC2IP.AttachC2IP      PROCEDURE(STRING sFileName)
jsonItem        &JSONClass
sC2IPName       STRING(100)
CODE
    ! do something
    
    json.LoadFile(sFileName)    
    i# = json.Records()
    
    ! C2IP Name
    jsonItem &= json.GetByName('C2IPName')
    IF NOT jsonItem &= Null THEN
        sC2IPName   = json.GetValueByName('C2IPName')
        
        SELF.refC2IPs.C2IPPath  = sFileName
        SELF.refC2IPs.C2IPName  = sC2IPName
        ADD(SELF.refC2IPs)
                
        RETURN TRUE
    ELSE
        RETURN FALSE
    END        