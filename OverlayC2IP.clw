

  MEMBER('learnMil')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 16.01.2019
 * Time: 19:57
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

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

OverlayC2IP.SelectByMouse   PROCEDURE(LONG nXPos, LONG nYPos)    
    CODE
        curSel#     = SELF.ul.Pointer()
        curXPos#    = SELF.ul.xPos()
        curYPos#    = SELF.ul.yPos()
            
        nodeFoundPos#   = PARENT.SelectByMouse(nXPos, nYPos)
        IF nodeFoundPos# > 0 THEN
            sst.Trace('node found')
            sst.Trace('curSel# = ' & curSel#)
            sst.Trace('curXPos# = ' & curXPos#)
            sst.Trace('curYPos# = ' & curYPos#)
            SELF.DisplayUnselection(curXPos#, curYPos#)
            
            !SELF.selTreePos     = SELF.ul.TreePos()
            !SELF.selQueuePos    = SELF.ul.Pointer()
            SELF.DisplaySelection()
        ELSE
            SELF.DisplaySelection()
        END
                    
        IF nodeFoundPos# > 0 THEN
            RETURN TRUE
        ELSE
            RETURN FALSE
        END            
        
    
OverlayC2IP.MoveTo  PROCEDURE(LONG nXPos, LONG nYPos)            
    CODE
        PARENT.MoveTo(nXPos, nYPos)
        SELF.Redraw()
        RETURN TRUE
    
       
    
    
    
    
    
    
    
    
    
        


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
        
        ! background map
        IF LEN(CLIP(SELF.map)) > 0 THEN
            SELF.drwImg.Image(1, 1, , , SELF.map)
        END
        
        
        LOOP i# = 1 TO RECORDS(SELF.ul)
            GET(SELF.ul.ul, i#)
            IF NOT ERRORCODE() THEN
                ! Draw Main Symbol
                SELF.DrawNode_MainSymbol()
                ! Draw Echelon
                SELF.DrawNode_Echelon()
                ! Draw HQ
                SELF.DrawNode_HQ()
            END
        END
 
        SELF.drwImg.Display()

        
        
OverlayC2IP.DeployBSO       PROCEDURE(*UnitBasicRecord pUrec, LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OverlayC2IP.DeployBSO')
        sst.Trace('nXPos = ' & nXPos & ', nYPos = ' & nYPos)
        pUrec.xPos  = nXPos
        pUrec.yPos  = nYPos
        
        errCode#    = SELF.ul.AddNode(pUrec)
        IF errCode# = TRUE THEN
            SELF.Redraw()
            SELF.DisplaySelection()
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
    
    
OverlayC2IP.AttachMap       PROCEDURE(STRING sFileName)
    CODE
        SELF.map    = sFileName
        !SELF.drwImg.Image(1, 1, , , sFileName)
        SELF.Redraw()        
        RETURN TRUE
    
    

        
        
OverlayC2IP.TakeNodeAction   PROCEDURE(LONG nOption)

CODE
    ! do something
    
    CASE nOption
    OF 1
        ! Supporting Attack
    END
    
    RETURN TRUE    
    
    
    
    
OverlayC2IP.NodeActionsMenuOptions   PROCEDURE()

CODE
    ! do something
    
    RETURN 'Supporting Attack'        
    
    



