    MEMBER('UnitTests')

    MAP
    END

    INCLUDE('Equates.CLW'),ONCE
    INCLUDE('KEYCODES.CLW'),ONCE
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
        SELF.ul     &= NEW(UnitsQueue)
        SELF.tmpul  &=NEW(UnitsQueue)
        
        ! collection
        SELF.collection &= NEW(UnitsClassQueue)
        
UnitsCollection.Destruct      PROCEDURE()
    CODE
        ! collection
        DISPOSE(SELF.collection)
        
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
        !sst.Trace('START:UnitsCollection.insertFirstNode')
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
            !sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
            !sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
            !sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        ELSE
            !sst.Trace('ADD(SELF.ul) error')
        END
        !sst.Trace('END:UnitsCollection.insertFirstNode')
        
        
        
        
        
UnitsCollection.prepNewNode   PROCEDURE(LONG nNewRecPosition)
    CODE
        !sst.Trace('START:UnitsCollection.prepNewNode')        
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
        !sst.Trace('END:UnitsCollection.prepNewNode')        
        
UnitsCollection.moveNodesToTmp        PROCEDURE(LONG nStartPos, LONG nEndPos)
    CODE
        !sst.Trace('START:UnitsCollection.moveNodesToTmp')        
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
        !sst.Trace('END:UnitsCollection.moveNodesToTmp')        
        
UnitsCollection.addEmptyNode       PROCEDURE
    CODE
        !sst.Trace('START:UnitsCollection.insertEmptyNode')        
        ADD(SELF.ul)
        IF NOT ERRORCODE() THEN
        END        
        !sst.Trace('END:UnitsCollection.insertEmptyNode')        
        
UnitsCollection.insertCurrentPrepNode     PROCEDURE(LONG nPosition)
    CODE
        !sst.Trace('START:UnitsCollection.insertCurrentNode')        
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
        !sst.Trace('END:UnitsCollection.insertCurrentNode')        
        
UnitsCollection.moveNodesBackFromTmp  PROCEDURE(LONG nStartPos)        
    CODE
        !sst.Trace('START:UnitsCollection.moveNodesBackFromTmp')        
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
        !sst.Trace('END:UnitsCollection.moveNodesBackFromTmp')        
        
UnitsCollection.insertLastNode        PROCEDURE()
    CODE
        !sst.Trace('START:UnitsCollection.insertLastNode')        
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
            !sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
            !sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
            !sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        ELSE
            !sst.Trace('ADD(SELF.ul) error')
        END        
        !sst.Trace('END:UnitsCollection.insertLastNode')        
        
        
        
UnitsCollection.InsertNode    PROCEDURE
tmpUnitName     STRING(100)
CODE
    ! insert a new node to the current collection
    !sst.Trace('START:UnitsCollection.InsertNode')
        
    tmpUnitName    = SELF.prepRndName()
    
    IF RECORDS(SELF.ul) = 0 THEN
        ! 1st records
        !sst.Trace('1st queue record')        
        !sst.Trace('CALL:SELF.insertFirstNode()')
        SELF.insertFirstNode()                   
    ELSE
        ! inside the queue
        !sst.Trace('inside the queue')
        
        ! increment Tree Position
        !sst.Trace('increment Tree Position')
        SELF.selTreePos  = SELF.ul.TreePos + 1
        IF SELF.selTreePos > SELF.maxTreePos THEN
            SELF.maxTreePos = SELF.selTreePos
        END
        
        ! preserve current position and all records number
        !sst.Trace('preserve current position and all records number')
        allPos# = RECORDS(SELF.ul)
                
        ! prepare the new record
        !sst.Trace('prepare the new record')
        !sst.Trace('CALL:SELF.prepNewNode()')
        SELF.prepNewNode(SELF.selQueuePos + 1)               
        
        ! check the position inside the queue
        ! move to the temporary queue
        ! change yPos values
        !sst.Trace('check the position inside the queue')
        IF (SELF.selQueuePos + 1) < (allPos# + 1) THEN            
            ! in the middle of queue
            !sst.Trace('in the middle of queue')           
            !sst.Trace('CALL:SELF.moveNodesToTmp(SELF.selQueuePos + 1, allPos#)')           
            SELF.moveNodesToTmp(SELF.selQueuePos + 1, allPos#)
                                    
            ! add empty record
            !sst.Trace('add empty record')
            !sst.Trace('CALL:SELF.addEmptyNode()')           
            SELF.addEmptyNode()            
            
            
            ! insert current record
            !sst.Trace('insert current record')
            !sst.Trace('CALL:SELF.insertCurrentNode(SELF.selQueuePos + 1)')           
            SELF.insertCurrentPrepNode(SELF.selQueuePos + 1)        
                        
            ! copy back records
            !sst.Trace('copy back records')
            IF POINTER(SELF.tmpul) > 0 THEN
                !sst.Trace('CALL:SELF.moveNodesBackFromTmp(SELF.selQueuePos + 2)')                                           
                SELF.moveNodesBackFromTmp(SELF.selQueuePos + 2)
                
            END    
            
            ! get new current Position            
            !sst.Trace('get new current Position')
            SELF.selQueuePos    = SELF.selQueuePos + 1
            GET(SELF.ul, SELF.selQueuePos + 1)
            IF NOT ERRORCODE() THEN
                SELF.selTreePos = SELF.ul.TreePos
            END                        
        ELSE
            ! last on queue
            !sst.Trace('last on queue')
            !sst.Trace('CALL:SELF.insertLastNode()')             
            SELF.insertLastNode()            
        END                              
    END
    !sst.Trace('SELF.selTreePos = ' & SELF.selTreePos)
    !sst.Trace('SELF.maxTreePos = ' & SELF.maxTreePos)
    !sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
    !sst.Trace('END:UnitsCollection.InsertNode')
    
    
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
    
UnitsCollection.InsertNode  PROCEDURE(*BSO pBSO)
    CODE
        sst.Trace('UnitsCollection.InsertNode  PROCEDURE(*BSO pBSO) BEGIN')
        
        sst.Trace('UnitsCollection.InsertNode  PROCEDURE(*BSO pBSO) END')
           
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
        !MESSAGE('Units = ' & RECORDS(SELF.ul))
        RETURN TRUE
        
UnitsCollection.AddNode  PROCEDURE(*BSO pBSO)
    CODE
        sst.Trace('UnitsCollection.AddNode  PROCEDURE(*BSO pBSO) BEGIN')
        
        sst.Trace('pBSO.urec.UnitName = ' & pBSO.urec.UnitName)
        sst.Trace('pBSO.urec.UnitType = ' & pBSO.urec.UnitType)
        sst.Trace('pBSO.urec.UnitTypeCode = ' & pBSO.urec.UnitTypeCode)
        
        
        SELF.collection.unit    &= NEW(BSO)
        
        SELF.collection.unit.urec.UnitName  = pBSO.urec.UnitName
        sst.Trace('UnitName')
        SELF.collection.unit.urec.UnitType  = pBSO.urec.UnitType
        sst.Trace('UnitType')
        SELF.collection.unit.urec.UnitTypeCode  = pBSO.urec.UnitTypeCode
        SELF.collection.unit.urec.Echelon       = pBSO.urec.Echelon
        SELF.collection.unit.urec.Hostility     = pBSO.urec.Hostility
        SELF.collection.unit.urec.IsHQ          = pBSO.urec.IsHQ
        SELF.collection.unit.urec.xPos          = pBSO.urec.xPos
        SELF.collection.unit.urec.yPos          = pBSO.urec.yPos
        ADD(SELF.collection)
        SELF.selQueuePos    = POINTER(SELF.collection)
                
        sst.Trace('UnitsCollection.AddNode  PROCEDURE(*BSO pBSO) END')
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
        
UnitsCollection.GetNode       PROCEDURE(LONG nPointer, *UnitBasicRecord pURec)
    CODE
        ! get current node
        
        currPos# = POINTER(SELF.ul)
        
        GET(SELF.ul, nPointer)
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
            ret#    = TRUE
        ELSE
            ret#    = FALSE
        END
        
        GET(SELF.ul, currPos#)
        RETURN ret#
               
        
UnitsCollection.GetNode       PROCEDURE()
    CODE
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END

        
Action.Construct    PROCEDURE()
    CODE
        SELF.arec.ActionPoints          &= NEW(PosList)
        
Action.Init    PROCEDURE(*ActionBasicRecord pARec)
    CODE
        SELF.arec.ActionName            = pArec.ActionName
        SELF.arec.ActionPointsNumber    = pArec.ActionPointsNumber
        SELF.arec.ActionType            = pArec.ActionType
        SELF.arec.ActionTypeCode        = pArec.ActionTypeCode
        ! action points
        !SELF.arec.ActionPoints          &= NEW(PosList)
        LOOP i# = 1 TO RECORDS(pArec.ActionPoints)
            GET(pArec.ActionPoints, i#)
            IF NOT ERRORCODE() THEN
                SELF.arec.ActionPoints.xPos = pArec.ActionPoints.xPos
                SELF.arec.ActionPoints.yPos = pArec.ActionPoints.yPos
                ADD(SELF.arec.ActionPoints)
                
                ! usual Position records
                CASE i#
                OF 1
                    SELF.xPos1  = pArec.ActionPoints.xPos
                    SELF.yPos1  = pArec.ActionPoints.yPos
                    
                    SELF.lowestX = SELF.xPos1
                    SELF.lowestY = SELF.yPos1
                OF 2
                    SELF.xPos2  = pArec.ActionPoints.xPos
                    SELF.yPos2  = pArec.ActionPoints.yPos
                    
                    IF SELF.xPos2 < SELF.lowestX THEN
                        SELF.lowestX    = SELF.xPos2
                    ELSE
                        SELF.highestX   = SELF.xPos2
                    END
                    IF SELF.yPos2 < SELF.lowestY THEN
                        SELF.lowestY    = SELF.yPos2
                    ELSE
                        SELF.highestY   = SELF.yPos2
                    END                                                           
                ELSE
                    ! lowest & highest
                    IF pArec.ActionPoints.xPos < SELF.lowestX THEN
                        SELF.lowestX    = pArec.ActionPoints.xPos
                    END
                    IF pArec.ActionPoints.xPos > SELF.highestX THEN
                        SELF.highestX    = pArec.ActionPoints.xPos
                    END
                    IF pArec.ActionPoints.yPos < SELF.lowestY THEN
                        SELF.lowestY    = pArec.ActionPoints.yPos
                    END
                    IF pArec.ActionPoints.yPos > SELF.highestY THEN
                        SELF.highestY   = pArec.ActionPoints.yPos
                    END                    
                END
            END            
        END
        
        !SELF.arec.xPos                  = pArec.xPos
        !SELF.arec.yPos                  = pArec.yPos
        
        RETURN TRUE
        
Action.Destruct     PROCEDURE()
    CODE
        DISPOSE(SELF.arec.ActionPoints)
        
        
Action.ComputeSelectRectangle       PROCEDURE()
    CODE
        LOOP i# = 1 TO RECORDS(SELF.arec.ActionPoints)
            GET(SELF.arec.ActionPoints, i#)
            IF NOT ERRORCODE() THEN                                
                x#  = SELF.arec.ActionPoints.xPos
                y#  = SELF.arec.ActionPoints.yPos
                ! usual Position records
                CASE i#
                OF 1
                    SELF.lowestX = x#
                    SELF.lowestY = y#
                OF 2                    
                    IF x# < SELF.lowestX THEN
                        SELF.lowestX    = x#
                    ELSE
                        SELF.highestX   = x#
                    END
                    IF y# < SELF.lowestY THEN
                        SELF.lowestY    = y#
                    ELSE
                        SELF.highestY   = y#
                    END                                                           
                ELSE
                    ! lowest & highest
                    IF x# < SELF.lowestX THEN
                        SELF.lowestX    = x#
                    END
                    IF x# > SELF.highestX THEN
                        SELF.highestX    = x#
                    END
                    IF y# < SELF.lowestY THEN
                        SELF.lowestY    = y#
                    END
                    IF y# > SELF.highestY THEN
                        SELF.highestY   = y#
                    END                    
                END
            END            
        END
        
Action.GetAnchorPoints      PROCEDURE(*LONG pLowestX, *LONG pLowestY, *LONG pHighestX, *LONG pHighestY)        
    CODE
        SELF.ComputeSelectRectangle()
        pLowestX    = SELF.lowestX
        pLowestY    = SELF.lowestY
        pHighestX   = SELF.highestX
        pHighestY   = SELF.highestY
        RETURN TRUE
        
Action.SetText      PROCEDURE(STRING sText)
    CODE
        SELF.arec.editableText  = sText
        RETURN TRUE
        
Action.CheckLineByMouse     PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        currentSlope$   = (SELF.xPos1 - SELF.xPos2) / (SELF.yPos1 - SELF.yPos2)
        computedSlope$  = (SELF.xPos1 - nXPos) / (SELF.yPos1 - nYPos)        
        
        !MESSAGE('slopes ' & currentSlope$ & ' vs. ' & computedSlope$)
        IF ROUND(ABS(currentSlope$), 0.1) = ROUND(ABS(computedSlope$), 0.1) THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        
Action.CheckRectangleByMouse        PROCEDURE(LONG nXPos, LONG nYPos)                       
    CODE
        !sst.Trace('Action.CheckRectangleByMouse BEGIN')
        IF (SELF.xPos1 <= nXPOs) AND (nXPos <= SELF.xPos2) AND |
            (SELF.yPos1 <= nYPos) AND (nYPos <= SELF.yPos2) THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END
        !sst.Trace('Action.CheckRectangleByMouse END')
        
Action.CheckFreeHandByMouse PROCEDURE(LONG nXPos, LONG nYPos)
    CODE                

        retVal# = FALSE
        
        IF (SELF.lowestX <= nXPos) AND |
            (nXPos <= SELF.highestX) AND |
            (SELF.lowestY <= nYPos) AND |
            (nYPos <= SELF.highestY) THEN
            retVal# = TRUE            
        END
        
        
        OMIT('_noCompile')
        LOOP i# = 1 TO RECORDS(SELF.arec.ActionPoints)
            GET(SELF.arec.ActionPoints, i#)
            IF NOT ERRORCODE() THEN
                IF i# = 1 THEN
                    xPos1# = SELF.arec.ActionPoints.xPos
                    yPos1# = SELF.arec.ActionPoints.yPos
                END
                IF i# = 2 THEN
                    xPos2# = SELF.arec.ActionPoints.xPos
                    yPos2# = SELF.arec.ActionPoints.yPos
                    
                    currentSlope$   = (xPos1# - xPos2#) / (yPos1# - yPos2#)
                    computedSlope$  = (xPos1# - nXPos) / (yPos1# - nYPos)    
                    
                    IF ROUND(ABS(currentSlope$), 0.1) = ROUND(ABS(computedSlope$), 0.1) THEN
                        retVal# = TRUE
                        BREAK                        
                    END
                END
                IF i# > 2 THEN
                    xPos1#  = xPos2#
                    yPos1#  = yPos2#
                    
                    xPos2# = SELF.arec.ActionPoints.xPos
                    yPos2# = SELF.arec.ActionPoints.yPos
                    
                    currentSlope$   = (xPos1# - xPos2#) / (yPos1# - yPos2#)
                    computedSlope$  = (xPos1# - nXPos) / (yPos1# - nYPos)      
                    
                    IF ROUND(ABS(currentSlope$), 0.1) = ROUND(ABS(computedSlope$), 0.1) THEN
                        retVal# = TRUE
                        BREAK
                    END
                END                                                                                         
            END                        
        END        
        _noCompile
        
        RETURN retVal#
        
        
                              
        
        
        
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
        !sst.Trace('BEGIN:UnitsCollection.Records')
        !sst.Trace('RECORDS(SELF.ul) = ' & RECORDS(SELF.ul))
        !sst.Trace('END:UnitsCollection.Records')
        RETURN RECORDS(SELF.ul)
        
UnitsCollection.Pointer       PROCEDURE()
    CODE
        !sst.Trace('BEGIN:UnitsCollection.Pointer')
        !sst.Trace('POINTER(SELF.ul) = ' & POINTER(SELF.ul))
        !sst.Trace('END:UnitsCollection.Pointer')
        RETURN POINTER(SELF.ul)
        
UnitsCollection.GetCurrentSelPos      PROCEDURE()
    CODE
        !sst.Trace('BEGIN:UnitsCollection.GetCurrentSelPos')
        !sst.Trace('SELF.selQueuePos = ' & SELF.selQueuePos)
        !sst.Trace('END:UnitsCollection.GetCurrentSelPos')
        RETURN SELF.selQueuePos
        
                                

UnitsCollection.Get        PROCEDURE()
    CODE
        !sst.Trace('BEGIN:UnitsCollection.Get()')
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            success# = TRUE
        ELSE
            success# = FALSE
        END
        !sst.Trace('END:UnitsCollection.Get')
        RETURN success#

UnitsCollection.UnitTypeCode  PROCEDURE()
    CODE
        !sst.Trace('BEGIN:UnitsCollection.UnitTypeCode')
        !sst.Trace('SELF.ul.UnitTypeCode = ' & SELF.ul.UnitTypeCode)
        !sst.Trace('END:UnitsCollection.UnitTypeCode')
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
        !sst.Trace('BEGIN:UnitsCollection.Echelon')
        !sst.Trace('SELF.ul.Echelon = ' & SELF.ul.Echelon)
        !sst.Trace('END:UnitsCollection.Echelon')
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
        !sst.Trace('BEGIN:UnitsCollection.Hostility')
        !sst.Trace('SELF.ul.Hostility = ' & SELF.ul.Hostility)
        !sst.Trace('END:UnitsCollection.Hostility')
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
        !MESSAGE('selQPos = ' & SELF.selQueuePos)
        GET(SELF.ul, SELF.selQueuePos)
        IF NOT ERRORCODE() THEN
            SELF.ul.UnitName    = sUnitName
            PUT(SELF.ul)
            IF NOT ERRORCODE() THEN
                RETURN TRUE
            ELSE
                MESSAGE('error PUT')
                RETURN FALSE                
            END
        ELSE
            !MESSAGE('error GET')
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
                        sst.Trace('UnitsCollection.SelectByMouse = ' & i#)
                        SELF.selTreePos     = SELF.ul.TreePos
                        SELF.selQueuePos    = i#
                        RETURN TRUE
                    END                
                END            
            END
        END
        
        RETURN FALSE
        
UnitsCollection.CheckByMouse        PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        currentSelTreePos# = SELF.selTreePos
        currentSelQueuePos# = SELF.selQueuePos
                
        LOOP i# = 1 TO RECORDS(SELF.ul)
            GET(SELF.ul, i#)
            IF NOT ERRORCODE() THEN
                IF (SELF.ul.xPos < nXPos) AND (nXPos < SELF.ul.xPos + 50) THEN
                    IF (SELF.ul.yPos < nYPos) AND (nYPos < SELF.ul.yPos + 30) THEN
                        ! found Unit selection
                        !sst.Trace('UnitsCollection.CheckByMouse = ' & i#)
                        GET(SELF.ul, currentSelQueuePos#)
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
        
BSO.Init            PROCEDURE(*UnitBasicRecord pUrec)
    CODE
        SELF.urec.Echelon       = pUrec.Echelon
        SELF.urec.Hostility     = pUrec.Hostility
        SELF.urec.IsHQ          = pUrec.IsHQ
        SELF.urec.TreePos       = pUrec.TreePos
        SELF.urec.UnitName      = pUrec.UnitName
        SELF.urec.UnitType      = pUrec.UnitType
        SELF.urec.UnitTypeCode  = pUrec.UnitTypeCode
        SELF.urec.xPos          = pUrec.xPos
        SELF.urec.yPos          = pUrec.yPos                
        
        RETURN TRUE

        
BSO.BSOOpr.Eql      PROCEDURE(GenericClass c)
    CODE
        RETURN PARENT.ClassOperators.Eql(c)
        
BSO.BSOOpr.Eql      PROCEDURE(BSO c)
    CODE
        sst.Trace('BSO.BSOOpr.Eql      PROCEDURE(BSO c) BEGIN')        
                
        SELF.urec.Echelon     = c.urec.Echelon
        SELF.urec.Hostility   = c.urec.Hostility
        SELF.urec.IsHQ        = c.urec.IsHQ
        SELF.urec.TreePos     = c.urec.TreePos        
        sst.Trace('     SELF.urec.UnitName = ' & SELF.urec.UnitName)
        sst.Trace('     c.urec.UnitName = ' & c.urec.UnitName)
        SELF.urec.UnitName    = c.urec.UnitName        
        sst.Trace('     SELF.urec.UnitName = ' & SELF.urec.UnitName)
        SELF.urec.UnitType    = c.urec.UnitType
        SELF.urec.UnitTypeCode    = c.urec.UnitTypeCode
        SELF.urec.xPos        = c.urec.xPos
        SELF.urec.yPos        = c.urec.yPos
        
        sst.Trace('BSO.BSOOpr.Eql      PROCEDURE(BSO c) END')        
        RETURN TRUE
        
BSO.BSOOpr.IsEql    PROCEDURE(GenericClass c)
    CODE
        RETURN PARENT.ClassOperators.IsEql(c)

BSO.BSOOpr.IsEql    PROCEDURE(BSO c)
    CODE
        retCode#    = FALSE
        IF SELF.urec.UnitName = c.urec.UnitName THEN
            retCode#    = TRUE
        END
        
        RETURN retCode#
        
                
SECTION('GenericCollection INTERFACES')
GenericCollection.CollectionOperators.Eql   PROCEDURE(GenericCollection c)
    CODE
        RETURN TRUE
        
GenericCollection.CollectionOperators.Get   PROCEDURE()
    CODE
        RETURN TRUE
                
GenericCollection.CollectionOperators.Add   PROCEDURE(GenericClass c)
    CODE
        RETURN TRUE
        
GenericCollection.CollectionOperators.Rpl       PROCEDURE()
    CODE
        RETURN TRUE
        
GenericCollection.CollectionOperators.Ins   PROCEDURE()
    CODE
        RETURN TRUE
        
GenericCollection.CollectionOperators.Find  PROCEDURE(GenericClass c, *LONG pFoundID)
    CODE
        pFoundID = 0
        RETURN TRUE
        
SECTION('GenericClass INTERFACES')        
GenericClass.ClassOperators.Eql     PROCEDURE(GenericClass c)
    CODE
        RETURN TRUE
        
GenericClass.ClassOperators.IsEql   PROCEDURE(GenericClass c)
    CODE
        RETURN TRUE

SECTION('UnitsCollection INTERFACES')        
UnitsCollection.BSOCollOpr.Eql     PROCEDURE(GenericCollection c)
    CODE
        RETURN PARENT.CollectionOperators.Eql(c)
        
UnitsCollection.BSOCollOpr.Eql     PROCEDURE(UnitsCollection c)
    CODE
        sst.Trace('UnitsCollection.BSOCollOpr.Eql     PROCEDURE(UnitsCollection c) BEGIN')
 
        LOOP i# = 1 TO RECORDS(c.collection)

        END
        
        OMIT('_noCompile')
        c1.collection.unit.urec.UnitName  = pBSO.urec.UnitName
        c1.collection.unit.urec.UnitType  = pBSO.urec.UnitType
        c1.collection.unit.urec.UnitTypeCode  = pBSO.urec.UnitTypeCode
        c1.collection.unit.urec.Echelon       = pBSO.urec.Echelon
        c1.collection.unit.urec.Hostility     = pBSO.urec.Hostility
        c1.collection.unit.urec.IsHQ          = pBSO.urec.IsHQ
        c1.collection.unit.urec.xPos          = pBSO.urec.xPos
        c1.collection.unit.urec.yPos          = pBSO.urec.yPos
        ADD(c1.collection)
        SELF.selQueuePos    = POINTER(SELF.collection)
        _noCompile
                
        sst.Trace('UnitsCollection.BSOCollOpr.Eql     PROCEDURE(UnitsCollection c) END')
        RETURN TRUE

        
UnitsCollection.BSOCollOpr.Add      PROCEDURE(GenericClass c)
    CODE
        RETURN PARENT.CollectionOperators.Add(c)
        
UnitsCollection.BSOCollOpr.Add      PROCEDURE(BSO cBSO)
    CODE
        SELF.collection.unit    &= NEW(BSO)
        retVal# = SELF.collection.unit.BSOOpr.Eql(cBSO)
        ADD(SELF.collection)
        RETURN retVal#
        
        
UnitsCollection.BSOCollOpr.Get      PROCEDURE()
    CODE
        RETURN PARENT.CollectionOperators.Get()
        
        
UnitsCollection.BSOCollOpr.Get      PROCEDURE(LONG nIndex, *BSO pBSO)
    CODE
        IF (nIndex <= RECORDS(SELF.collection)) AND (nIndex<>0) THEN
            GET(SELF.collection, nIndex)
            IF NOT ERRORCODE() THEN
                pBSO.BSOOpr.Eql(SELF.collection.unit)
                retVal# = TRUE
            ELSE
                retVal# = FALSE
            END
            
        ELSE
            retVal# = FALSE
        END
        
        RETURN retVal#
        

UnitsCollection.BSOCollOpr.Rpl  PROCEDURE()
    CODE
        RETURN PARENT.CollectionOperators.Rpl()
        
UnitsCollection.BSOCollOpr.Rpl     PROCEDURE(LONG nIndex, BSO cBSO)
    CODE
        IF (nIndex <= RECORDS(SELF.collection)) AND (nIndex<>0) THEN
            GET(SELF.collection, nIndex)
            IF NOT ERRORCODE() THEN
                SELF.collection.unit.BSOOpr.Eql(cBSO)
                PUT(SELF.collection)
                retVal# = TRUE
            ELSE
                retVal# = FALSE
            END
        ELSE
            retVal# = FALSE            
        END
        
        RETURN retVal#
        
UnitsCollection.BSOCollOpr.Ins      PROCEDURE()
    CODE
        RETURN PARENT.CollectionOperators.Ins()
        
UnitsCollection.BSOCollOpr.Ins      PROCEDURE(LONG nIndex, BSO cBSO)
aBSO        BSO
    CODE
        IF (nIndex <= RECORDS(SELF.collection)) AND (nIndex<>0) THEN
            GET(SELF.collection, nIndex)
            IF NOT ERRORCODE() THEN
                aBSO.BSOOpr.Eql(SELF.collection.unit)
                SELF.collection.unit.BSOOpr.Eql(cBSO)
                retVal# = TRUE
            ELSE
                retVal# = FALSE
            END
        ELSE
            retVal# = FALSE            
        END
        
        RETURN retVal#
        
UnitsCollection.BSOCollOpr.Find     PROCEDURE(GenericClass c, *LONG pFoundID)
    CODE
        RETURN PARENT.CollectionOperators.Find(c, pFoundID)
        
UnitsCollection.BSOCollOPr.Find     PROCEDURE(BSO cBSO, *LONG pFoundID)
foundBSO    BSO
    CODE
        IF RECORDS(SELF.collection) > 0 THEN
            i# = 1
            LOOP
                retCode#    = SELF.BSOCollOpr.Get(i#, foundBSO)
                IF retCode# = TRUE THEN
                    IF foundBSO.BSOOpr.IsEql(cBSO) = TRUE THEN
                        retCode#    = TRUE
                        pFoundID    = i#
                    END                    
                END   
                i# = i# + 1
            UNTIL (i# > RECORDS(SELF.collection) OR retCode# = TRUE)
        ELSE
            RETURN FALSE
        END
                        
        RETURN TRUE
        