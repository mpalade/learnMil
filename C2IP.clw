

  MEMBER('learnMil')

OMIT('***')
 * Created with Clarion 10.0
 * User: mihai.palade
 * Date: 16.01.2019
 * Time: 19:37
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

C2IP.Construct      PROCEDURE()
    CODE
        ! initialize default objects    
        SELF.ul     &= NEW(UnitsCollection)
        SELF.tmpul  &= NEW(UnitsCollection)
    
        ! default C2IP Name
        SELF.Name   = ''
        LOOP 10 TIMES
            SELF.Name = CLIP(SELF.Name) & CHR(RANDOM(97, 122))    
        END       
    
        ! referenced C2IPs list
        SELF.refC2IPs   &= NEW(C2IPsList)
    
        SELF.labelEditMode  = FALSE        
        
        SELF.isSelection        = FALSE        
        SELF.isPointsCollection = FALSE                
        SELF.isMouseDown    = FALSE
    
        
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
                  
C2IP.DrawNode_HQ    PROCEDURE()
    CODE
        IF SELF.ul.IsHQ() = TRUE THEN
            ! Is HQ
            SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 0, 10)
        END
        
!C2IP.DrawNode_*.*
C2IP.DrawNode_Default       PROCEDURE(BOOL bAutoDisplay)
nFillColor      LONG
    CODE
        sst.Trace('BEGIN:C2IP.DrawNode_Default')
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
        SELF.DrawNode_HQ()

        
        sst.Trace('bAutoDisplay = ' & bAutoDisplay)
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
    
        sst.Trace('END:C2IP.DrawNode_Default')
        RETURN TRUE      
    
C2IP.Draw_innerSine PROCEDURE()
    CODE
        ! inner sine function
        SELF.drwImg.Arc(SELF.ul.xPos() - 5, SELF.ul.yPos() + 15 + 5, 10, -10, 2700, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5, SELF.ul.yPos() + 15 + 5, 10, -10, 0, 1800)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5 + 10, SELF.ul.yPos() + 10, 10, 10, 1800, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 + 5, 10, -10, 0, 1800)
        SELF.drwImg.Arc(SELF.ul.xPos() + 25 + 10, SELF.ul.yPos() + 10, 10, 10, 1800, 3599)
        SELF.drwImg.Arc(SELF.ul.xPos() + 50 - 5, SELF.ul.yPos() + 20, 10, -10, 900, 1800)
        
C2IP.Draw_innerEllipse       PROCEDURE()
    CODE        
        ! inner ellipse
        SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 10, 20, 0)
        SELF.drwImg.Arc(SELF.ul.xPos() + 15 + 20 - 5, SELF.ul.yPos() + 10, 10, 10, 2700, 900)
        SELF.drwImg.Line(SELF.ul.xPos() + 15, SELF.ul.yPos() + 20, 20, 0)
        SELF.drwImg.Arc(SELF.ul.xPos() + 5 + 5, SELF.ul.yPos() + 10, 10, 10, 900, 2700)
        
C2IP.Draw_medianLine        PROCEDURE()
    CODE
        ! median line
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 0, 30)

C2IP.Draw_secondDiag        PROCEDURE()
    CODE        
        ! second diagonal
        SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 50, -30)
        
C2IP.Draw_innerFork     PROCEDURE()
    CODE
        ! inner fork
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 - 5, 10, 0)
    SELF.drwImg.Line(SELF.ul.xPos() + 25 - 5, SELF.ul.yPos() + 15 - 5, 0, 10)
    SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos() + 15 - 5, 0, 10)
    SELF.drwImg.Line(SELF.ul.xPos() + 25 + 5, SELF.ul.yPos() + 15 - 5, 0, 10)
        
        
C2IP.Draw_innerPapillon     PROCEDURE()
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
        
C2IP.Draw_innerSmallClepsydra    PROCEDURE()
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
        
C2IP.Draw_innerSmallRoundPapillon        PROCEDURE()
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
        
    
C2IP.Draw_innerRoundPapillon      PROCEDURE()
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
        
C2IP.Draw_innerTriangle PROCEDURE
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
               
                                                     
C2IP.DrawNode_Amphibious PROCEDURE(BOOL bAutoDisplay)
    CODE
        erroCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner sine function
        SELF.Draw_innerSine()
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
        
        RETURN TRUE
        
C2IP.DrawNode_Antiarmor PROCEDURE(BOOL bAutoDisplay)
    CODE
        erroCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner arrow
        SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 25, -30)
        SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 25, 30)            
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
        
        RETURN TRUE
        
C2IP.DrawNode_Antiarmor_Armored PROCEDURE(BOOL bAutoDisplay)
    CODE
        
        errCode#    = SELF.DrawNode_Antiarmor(bAutoDisplay)
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        
        RETURN TRUE
        
C2IP.DrawNode_Antiarmor_Motorized       PROCEDURE(BOOL bAutoDisplay)
    CODE        
        errCode#    = SELF.DrawNode_Antiarmor(bAutoDisplay)
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
        RETURN TRUE
        
C2IP.DrawNode_Armor      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#   = SELF.DrawNode_Default(bAutoDisplay)    
        
        ! inner ellipse
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
    RETURN TRUE

C2IP.DrawNode_Armor_Recon        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Armor(bAutoDisplay)
        ! 2nd diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        
        RETURN TRUE
        
C2IP.DrawNode_Armor_Amphibious   PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Armor(bAutoDisplay)
        ! inner sine
        SELF.Draw_innerSine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
                RETURN TRUE
        
C2IP.DrawNode_ArmyAviation  PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#   = SELF.DrawNode_Default(bAutoDisplay)
        ! inner papillon
        SELF.Draw_innerPapillon()                
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
C2IP.DrawNode_ArmyAviation_Recon     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_ArmyAviation(bAutoDisplay)
        ! second diagonale
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE                
        
C2IP.DrawNode_AviationComposite     PROCEDURE(BOOL bAutoDisplay)
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
        
C2IP.DrawNode_AviationFixedWing     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()
        ! inner round papillon
        SELF.Draw_innerRoundPapillon()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE        
        
C2IP.DrawNode_AviationFixedWing_Recon     PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_AviationFixedWing(bAutoDisplay)        
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE        
                
        
C2IP.DrawNode_Combat         PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()
        ! CBT
        SELF.drwImg.Show(SELF.ul.xPos() + 25 - 10, SELF.ul.yPos() + 15 + 5, 'CBT')       
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END 
        RETURN TRUE
        
C2IP.DrawNode_CombinedArms   PROCEDURE(BOOL bAutoDisplay)
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
        
        
    
C2IP.DrawNode_Infantry      PROCEDURE(BOOL bAutoDisplay)
nFillColor          LONG
CODE

    errCode#    = SELF.DrawNode_Default(bAutoDisplay)
    SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos(), 50, 30)
    SELF.drwImg.Line(SELF.ul.xPos(), SELF.ul.yPos() + 30, 50, -30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
    
C2IP.DrawNode_Infantry_Amphibious        PROCEDURE(BOOL bAutoDisplay)
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)
    
    ! inner sine function
    SELF.Draw_innerSine()    
        
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
C2IP.DrawNode_Infantry_Armored   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)
    
    SELF.Draw_innerEllipse()    
            
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
C2IP.DrawNode_Infantry_MainGunSystem   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)    

    ! Left line
    SELF.drwImg.Line(SELF.ul.xPos() + 8, SELF.ul.yPos(), 0, 30)
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE
    
C2IP.DrawNode_Infantry_Motorized   PROCEDURE(BOOL bAutoDisplay)    
CODE
    errCode#    = SELF.DrawNode_Infantry(bAutoDisplay)    
    
    ! Midle line
    SELF.drwImg.Line(SELF.ul.xPos() + 25, SELF.ul.yPos(), 0, 30)    
    
    IF bAutoDisplay THEN
        SELF.drwImg.Display()
    END
    
    RETURN TRUE    
    
C2IP.DrawNode_Infantry_FightingVehicle   PROCEDURE(BOOL bAutoDisplay)    
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

    
        
!C2IP.DrawNode_Observer
C2IP.DrawNode_Observer      PROCEDURE(BOOL bAutoDisplay)    
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
    
C2IP.DrawNode_Reconnaissance        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()        
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Reconnaissance_Recon  PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner triangle
        SELF.Draw_innerTriangle()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Reconnaissance_Marine PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner ellipse
        SELF.Draw_innerSine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Reconnaissance_Motorized      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Reconnaissance(bAutoDisplay)        
        ! inner middle line
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
        
C2IP.DrawNode_Engineer      PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Default()        
        ! inner fork
        SELF.Draw_innerFork()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Engineer_Mechanized   PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner ellipse
        SELF.Draw_innerEllipse()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Engineer_Motorized    PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner median line
        SELF.Draw_medianLine()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
        
C2IP.DrawNode_Engineer_Recon        PROCEDURE(BOOL bAutoDisplay)
    CODE
        errCode#    = SELF.DrawNode_Engineer(bAutoDisplay)
        ! inner second diagonal
        SELF.Draw_secondDiag()
        
        IF bAutoDisplay THEN
            SELF.drwImg.Display()
        END
        RETURN TRUE
    
C2IP.DrawNode_Echelon       PROCEDURE(BOOL bAutoDisplay)
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

    
C2IP.DisplaySelection     PROCEDURE
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
    
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    sst.Trace('END:OrgChartC2IP.DisplaySelection')
    
C2IP.DisplaySelection       PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        sst.Trace('BEGIN:OrgChartC2IP.DisplaySelection(' & nXPos & ', ' & nYPos & ')')
        SELF.drwImg.Setpencolor(COLOR:Red)
        SELF.drwImg.SetPenWidth(3)
        SELF.drwImg.Box(nXPos, nYPos,50,30)        
        SELF.drwImg.Display()
        
        SELF.drwImg.Setpencolor(COLOR:Black)
        SELF.drwImg.SetPenWidth(1)
        sst.Trace('END:OrgChartC2IP.DisplaySelection')
        
    
    
C2IP.DisplayUnselection     PROCEDURE
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
    
    SELF.drwImg.Setpencolor(COLOR:Black)
    SELF.drwImg.SetPenWidth(1)
    sst.Trace('END:OrgChartC2IP.DisplayUnselection')
    
C2IP.DisplayUnselection     PROCEDURE(LONG nXPos, LONG nYPos)
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
        
   
    
    
C2IP.SelectByMouse  PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        RETURN SELF.ul.SelectByMouse(nXPos, nYPos)
        
C2IP.MoveTo         PROCEDURE(LONG nXPos, LONG nYPos)
    CODE
        RETURN SELF.ul.ChangeNodePos(nXPos, nYPos)    


C2IP.Unselect     PROCEDURE()
CODE
    ! do something
    
    SELF.DisplayUnselection()
    
    RETURN TRUE
    
C2IP.GetUnitName     PROCEDURE
CODE
    ! do something
    IF SELF.ul.Get() = TRUE THEN
        RETURN SELF.ul.UnitName()
    ELSE
        RETURN SELF.ul.UnitName()
    END        
    
C2IP.SetUnitName     PROCEDURE(STRING sUnitName)
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
    
C2IP.GetUnitTypeCode    PROCEDURE
    CODE
        IF SELF.ul.Get() = TRUE THEN
            RETURN SELF.ul.UnitTypeCode()
        ELSE
            RETURN ''
        END    
        
           
C2IP.SetUnitTypeCode     PROCEDURE(STRING sUnitTypeCode)
CODE
    ! do something
    IF SELF.ul.SetUnitTypeCode(sUnitTypeCode) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END    
    
C2IP.GetEchelon     PROCEDURE
CODE
    ! do something
    RETURN SELF.ul.Echelon()            
    
C2IP.SetEchelon     PROCEDURE(LONG nEchelon)
CODE
    ! do something
    IF SELF.ul.SetEchelon(nEchelon) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END        
    
C2IP.GetHostility     PROCEDURE
CODE
    ! do something
    RETURN SELF.ul.Hostility()
        
    
C2IP.SetHostility     PROCEDURE(LONG nHostility)
CODE
    ! do something
    IF SELF.SetHostility(nHostility) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
        
    
C2IP.GetHQ     PROCEDURE
    CODE
        
        RETURN SELF.ul.isHQ()
        
    
C2IP.SetHQ     PROCEDURE(BOOL bIsHQ)
CODE
    ! do something
    IF SELF.ul.SetHQ(bIsHQ) = TRUE THEN
        SELF.Redraw()
        SELF.DisplaySelection()
        RETURN TRUE
    ELSE
        RETURN FALSE
    END
    
C2IP.DrawNode_MainSymbol    PROCEDURE
    CODE
        
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
        
C2IP.Redraw         PROCEDURE()
    CODE
        ! nothing to redraw at this class level    
        
C2IP.TakeEvent      PROCEDURE()
    CODE
        IF SELF.isSelection = FALSE
            CASE EVENT()
            OF EVENT:MouseMove
                ! Mouse Move
                CASE DRAGID()
                OF 'BSOMove'
                    !SETCURSOR(CURSOR:Size)
                    SELF.MoveTo(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                END  
            OF EVENT:MouseUp
                ! Mouse Up                
                CASE DROPID()
                OF 'BSOMove'
                    SELF.MoveTo(SELF.drwImg.MouseX(), SELF.drwImg.MouseY())
                    !xPos# = DrwOverlay.MouseX()
                    !yPos# = DrwOverlay.MouseY()
                    !IF (xPos# > 0) AND (yPos# > 0) THEN
                    !    ! move BSO position
                    !    errCode#    = mainOverlay.MoveTo(xPos#, yPos#)
                    !    IF errCode# = TRUE THEN
                    !    END    
                    !END   
                    !SETCURSOR(CURSOR:Arrow)
                END
            END
        END
                
        
            
        
        
            
        

        
        
        
        