#version 3.7;

#include "colors.inc"
#include "glass.inc"    
#include "woods.inc"
#include "textures.inc"  

//les dimensions sont en cm !

#declare UCube = box {<-1,-1,-1>,<1,1,1>}
#declare USphere = sphere {<0,0,0>,1} 
#declare UCylindre = cylinder {<0,0,-1>,<0,0,1>,1}   
#declare UCone = cone {<0,0,-1>,1,<0,0,1>,0}


/**Declarations Murs -----------------------------------**/

#declare Mur = box { <0,0,0>,<1,250,10> } 
 
#declare Piece = union {
    object {
        Mur
        scale <730,1,1>
    } 
    object {   
        Mur
        scale <530,1,1>
        rotate<0,-90,0>
    }
    object{
        Mur
        scale <100.4+10,1,1>
        translate<-10,0,530>      
    }
    object{
        Mur
        scale <100+10,1,1> 
        rotate<0,-90,0>
        translate<100.4,0,530>      
    }
    object{
        Mur
        scale <101.28 -5,1,1> 
        translate<100.4,0,630>      
    }
    object{
        Mur
        scale <631.96 + 10,1,1> 
        rotate<0,-90,0>
        translate<730,0,0>          
    }
    object{
        Mur
        scale <160.92 + 4,1,1>
        rotate <0,-29,0> 
        translate <100.4+101.28-5,0,630>      
    }
    object{
        Mur
        scale <243.60 +10,1,1>
        translate <100.4+101.28+140.76 - 5,0,630+78.02>      
    }
    object{
        Mur
        scale <161.68,1,1>
        rotate <0,27,0>
        translate <100.4+101.28+140.76+243.6,0,630+78.02>      
    }    
} 



/**Plafond ----------------------------------------------------------------**/

#declare Plafond = union {
    object {
        Mur
        scale <730,530/250,1>
        rotate <90,0,0>
        translate <0,250,0>
       
    }
    
    object {
        Mur
        scale <730-100.40,100/250,1>
        rotate<90,0,0> 
        translate<100.40,250,530> 
    }
    
    object {
        Mur
        scale <243.60,78.02/250,1>
        rotate <90,0,0>
        translate <100.4+101.28+140.74,250,530+100>
    }
    
    object { 
        Mur
        scale <144.06,(78.02-73.4)/250,1> 
        rotate <90,0,0>
        translate <100.4+101.28+140.74+243.6,250,530+100> 
    }
     
    //triangle droite
    object {
        prism {
            linear_spline -10,0,3
            <0,0>
            <144.06,0>
            <0,73.4>
            translate <100.4+101.28+140.74+243.6,250,530+100+(78.02-73.4)> 
            
       }
    }
    
    //triangle gauche
    object {
        prism {
            linear_spline -10,0,3
            <-20,0>
            <140.74,0>
            <140.74,78.8>
            translate <100.4+101.26,250,530+100> 
            
       }
    } 
}



/**Declarations Plancher --------------------------------------------------**/

#declare M_Planche1 = //materiau premier type de planche
    material { 
        texture {
            //motif bois
            pigment { wood color_map { [ 0 rgb < 156/256, 116/256, 55/256> ]
                                      [ 0.3 rgb < 205/256, 187/256, 160/256> ]
                                      [ 0.6 rgb < 216/256, 169/256, 97/256> ]
                                      [ 1 rgb < 236/256, 202/256, 151/256> ] } 
                      scale < 4, 1, 1>
            }
        }
    }
    
#declare M_Planche2 = //materiau deuxieme type de planche
    material { 
        texture {
            //motif bois avec couleurs differentes
            pigment { wood color_map { [ 0 rgb < 216/256, 169/256, 97/256> ]
                                      [ 0.3 rgb < 205/256, 187/256, 160/256> ]
                                      [ 0.6 rgb < 156/256, 116/256, 55/256> ]
                                      [ 1 rgb < 236/256, 202/256, 151/256> ] } 
                      scale < 5, 1, 1>
            }
        }
    }    

#declare Planche1 = //premier type de planche
    object {
        UCube
        scale < 109/2, 1.4/2, 13/2 >
        rotate < 0, 90, 0>
        material { M_Planche1 } //application du premier materiau
        rotate < 0, -90, 0>
        translate < 109/2, 0, 13/2>
    }    
     
#declare Planche2 = //Deuxieme type de planche
    object {
        UCube
        scale < 109/2, 1.4/2, 13/2 >
        rotate < 0, 90, 0>
        material { M_Planche2 } //application ddu deuxieme materiau
        rotate < 0, -90, 0> 
        translate < 109/2, 0, 13/2>
    }    
         
#declare DuoPlancher = //on colle deux planches differentes en ligne
    union {
        object {
            Planche1
        }
        object {
            Planche2
            translate < 109, 0, 0 >
        }
        translate < 0, 0, 10>    
    }
    
#declare LignePlancher = //ligne de planches 1 et 2 pour une longueur de piece
    union {
        object {
            DuoPlancher
        }
        object {
            DuoPlancher
            translate < 109*2, 0, 0 >
        } 
        object {
            DuoPlancher
            translate < 109*4, 0, 0 >
        }
        object {
            DuoPlancher
            translate < 109*6, 0, 0 >
        }
    }
    
#declare PortionPlancher = //motif de planches sur 4 lignes avec decalage entre chaque ligne pour creer motif parquet
    union {
        object {
            LignePlancher
        }
        object {
            LignePlancher
            translate < -109-109/3, 0, 13 >
        }
        object {
            LignePlancher 
            translate < 0, 0, 13*2 >
        }
        object {
            LignePlancher
            translate < -109/2, 0, 13*3 >
        }    
    }
    
#declare Plancher = //placement des motifs de parquet dans toute la piece
    union {
        #declare Index = 0;
        #while(Index <= 13)
        
          object {
            PortionPlancher
            translate < 0, 0, 13*4*Index >
          }
        
          #declare Index = Index + 1;
        #end 
        
    }



/**Declarations Cadre Plage -----------------------------------------**/ 
   
#macro Cadre(image) //macro pour pouvoir faire plusieurs cadres avec des images differentes
    object {
        union { 
            //creation cadre
            difference {
                object {
                    UCube
                    scale < .5,.5,.5 >   
                    translate  < 1/2, 1/2, 1/2 >
                    pigment { rgb < 1, 0.8, 0.3 > }
                    finish { specular .2 }        
                    scale < 21*2 + 2, 29.7*2 + 2, 1.5 >
                }
                object {
                    UCube
                    scale < .5,.5,.5 >   
                    translate  < 1/2, 1/2, 1/2 >
                    pigment { rgb < 1, 0.8, 0.5 > }        
                    scale < 21*2, 29.7*2, 1 >
                    translate < 1, 1, -1.5/2 >            
                }    
            }
            //on met l'image dans le cadre
            object {
                UCube
                scale < .5,.5,.5 >            
                scale < 1, 1, 1/10 >
                translate  < 1/2, 1/2, 1/2 >
                pigment {   
                    image_map {
                        jpeg image
                        map_type 0
                    }
                } 
                finish { reflection .4 }           
                scale < 21*2, 29.7*2, .6 >
                translate < 1, 1, 0.7 - 1.5/2 >
            }        
        } 
    }
#end                    



/**Lampe sur pied-----------------------------  **/
   
#declare ampoule = object{  //creation ampoule qui va contenir la lumiere
    USphere
    scale 10 
    translate<0,160,0>
    pigment{rgbf <.05,.34,1,.9>}
    finish { reflection .1 
             specular 0.5
             roughness 10e-4
    }
}

#declare PiedLampe = union {  
    //pied de lampe
    union {
        object {
            UCylindre
            rotate < 90, 0, 0 >
            scale < 40/2, 2/2, 40/2 >
            translate < 0, 1, 0 >
        }  
        object {
            UCylindre
            rotate < 90, 0, 0 >
            scale < 5/2, 160/2, 5/2 >
            translate < 0, 160/2, 0 >
        }
        object { UCube scale < 37, 1/2, 1/2 > translate < 0, 160 + 1/2, 0 > }                 
        pigment { rgb < .3, .3, .3 > }
        finish { diffuse 0.9 }   
    }
    //Partie haute lampe                         
    lathe {
        linear_spline 2
        < 40.6, 145 >, < 33, 145 + 35>
        pigment { rgbt < 1, 0.65, 0.75, .10 > }
        
    }              
}     

#declare Lampe = union { //assemblage du tout                        
    object {
        PiedLampe
        
    }
    object {
        ampoule
        texture { 
            pigment {color OldGold }
        }
        
    }
    
    light_source {
        <0, 160, 0>,color OldGold
        spotlight
        radius 40
        falloff 70
        tightness 0.2  
        area_light <5,0,0>, <0,  5, 0>, 5, 5
        adaptive 1 
        jitter
        point_at <0,0,0>
        projected_through {  ampoule} 
    }
              
}



/**Luminaire ------------------------------------------------------**/

#declare Luminaire = union {  
    //construction du luminaire a l'envers                        
    union {
        //accroche au plafond
        object {
            lathe {
                bezier_spline 12
                < 0, 0 >, < 0, 0 >, < 5, 0 >, < 5, 0 >,
                < 5, 0 >, < 5, 3 >, < 3, 5 >, < 0, 5 >,
                < 0, 5 >, < 0, 5 >, < 0, 0 >, < 0, 0 > 
            }
        }
        //gaine electrique
        object { UCylindre rotate < 90, 0, 0 > scale < .5, 35/2, .5 > translate < 0, 5 + 35/2, 0 > }
        //autour ampoule               
        object {
            difference {
                object { UCylindre rotate < 90, 0, 0 > scale < 8/2, 1/2, 8/2 > }
                object { UCylindre rotate < 90, 0, 0 > scale < 7.8/2, 0.8/2, 7.8/2 > translate < 0, 0.2, 0 > }
            }
            translate < 0, 40.2, 0 >
        }
        //materiau de la structure 
        pigment { rgb < .1, .1, .1 > }
        finish {
            metallic
        }        
    }
    //design
    object {
        lathe {
            bezier_spline 16 
            < 0, 0 >, < 12, 0 >, < 14, 5 >, < 14, 10 >,
            < 14, 10 >, < 14, 11 >, < 13, 11 >, < 13, 10 >,
            < 13, 10 >, < 13, 5 >, < 11, 0 >, < 0, 1 >,
            < 0, 1 >, < 0, 1 >, < 0, 0 >, < 0, 0 >
        }
        //materiau qui laisse passer la lumiere, verre teinte
        pigment { rgbt < 0.5, 0.5, 0.5, 1 > }
        finish {
            ambient 0.5 diffuse .05
            specular .1 roughness 1e-3
            reflection { .1, 1 fresnel on }
            conserve_energy
        }
        interior { ior 1.5 }
        translate < 0, 35, 0 >    
    }
    //on met le luminaire a l'endroit
    rotate < 180, 0, 0 >              
}



/**Declarations Bibliotheque -------------------------------------------**/

#declare EtagereBlanche = box { <0,0,0>,<80,210,4> texture {Soft_Silver} }   
#declare EtagereBois = box { <0,0,0>,<80,5,80> texture {DMFLightOak} }

#declare Bibliotheque = union {
    object {
        EtagereBlanche 
        rotate <0,90,0> 
        translate<-4,0,0>
        //pigment {White}
    }                 
    object {
        EtagereBlanche 
        rotate <0,90,0>
        translate <80,0,0>
        //pigment {White}
    } 
    object {
        EtagereBois  
        rotate<0,90,0>
        //texture {Brown}
    }
    #declare Index = 1;
    #while(Index <= 6)
    
      object {
        EtagereBois  
        rotate<0,90,0> 
        translate<0,Index*200/6,0>
        //pigment {Brown}
      }
    
      #declare Index = Index + 1;
    #end    
} 
       


/**on insere les fenetres ------------------------------- **/

//cadre pour trouer le mur
#declare Fenetre1 = object{ 
        Mur
        scale <150,240/400,1> 
   
}
#declare cadre_Fenetre = object{ 
        Mur
        scale <100,200/250,2>  //20 z
   
}   

#declare union_fenetre_cadre = union
{ 
    object{
         Mur scale <160.92,1,1>
         pigment {rgb <0.929, 0.855, 0.808>}                 
    } 
    object{
        cadre_Fenetre 
        scale<1,1,1>  
        translate<30.46,25,-4>  
        texture{
            pigment{color White}
            finish {ambient 0.1
                    diffuse 0.9
                    phong 1
                   }
        }                                                      
    }        
}

#declare Fenetre = union
{                                                                
    difference
    { 
        object{union_fenetre_cadre }
        
        object{
            cadre_Fenetre 
            scale<90/100,190/200,3>  
            translate<35.46,30,-5> 
            pigment{White}                                                      
        } 
        
    } 
    object{
        cadre_Fenetre 
        scale<90/100,190/200,1>  
        translate<35.46,30,-4>  
        texture{T_Glass3} 
    }
    
    object{
        cadre_Fenetre 
        scale<1,10/200,1>  
        translate<30.46,120,-4.02>  
        texture{
            pigment{color White}
            finish {ambient 0.1
                    diffuse 0.9
                    phong 1
                   }
        }                                                      
    }                                                               
    
} 



#declare piece_trou_fenetres = difference
{
    object{
        Piece
        pigment{rgb <0.929, 0.855, 0.808>}
        
    } 
        
    object{
       Fenetre1
       scale<1,1,3> 
       translate <342 + 50,80,708> 
       pigment{White}           
    }
    object{
        Fenetre1 
        scale<100/150,1,3>  
        rotate<0,27,0>
        translate<342 + 243.6+35,80,705-15>
        pigment{White}

    }
    object{
        Fenetre1 
        scale<100/150,1,3>  
        rotate<0,-29,0>
        translate<100.4+101.28+30,80,625+15> 
        pigment{White}                                                      
    }
    
}

#declare piece = union
{
    object{
        piece_trou_fenetres
    }
    object{ 
        Fenetre 
        scale<105/100,150/200,1>  
        rotate<0,-29,0> 
        translate<100.4+101.28-5,55,630>
    } 
    object{ 
        Fenetre 
        scale<150/100,150/200,1>  
        translate <342 + 50 -40,55,708> 
    }
    object{ 
        Fenetre 
        scale<100/100,150/200,1>  
        rotate<0,27,0>
        translate<100.4+101.28+140.76+243.6,55,630+78.02> 
    }
}



/**Pouf-----------------------------  **/

#declare Pouf = lathe {
     bezier_spline 8
     <0,0>
     <25,0> 
     <30,0>
     <29,15> 
     //deuxieme segment de courbe
     <29,15> 
     <28,30>
     <3,30>
     <0,30>
   
}



/**La table basse------------------  **/

#declare table = prism {
     cubic_spline 5,-2,13
     <14.75,0>,
     <59,14.75>,
     <103.25,13>,
     <118,25>  ,
     <101,44,>
     <88.5,69.3>,
     <61.95,73.75>,
     <36.8,50.15>,
     <14.75,44.25>,
     <0,17.7>,
     
     <14.75,0>, 
     <59,14.75>,
     <103.25,13>

      
}

#declare pied = cylinder {<0,0,0>,<0,27,0>,4} 

#declare table_basse = union{
 
    object { 
        table  
        translate <0,27,0>
        texture{
            pigment{color White}
            finish {
                    ambient 0.1 
                    diffuse 0.7
                    phong 1
                   }
        }
    }
    
    object { 
        pied
        translate<14.75,0,14.75>  
        pigment{Brown}
    } 
    object { 
        pied
        translate<103.25,0,25>  
        pigment{Brown}
    }
    object { 
        pied
        translate<70,0,60>  
        pigment{Brown}
    }
    
    

} 


  
/** Chaise ------------------------------------**/

#declare siege = prism {
    cubic_spline 0,2,7
    <0,0>
    <0,40>
    <40,40>
    <40,0>
    <0,0>
    <0,40>
    <40,40>
}

#declare soutien = prism {
     cubic_spline 0,2,9
     <0,0>
     <2,12>
     <22.5,12>
     <43,12>
     <45,0>
     <22.5,0>
     <0,0>
     <2,12>
     <22.5,12>
   
}

#declare barre = cylinder {<0,0,0>,<0,45,0>,1} 

#declare pied1 = cylinder {<0,0,0>,<0,40,0>,2}

#declare pieds = union{
    object{
        pied1
        translate <5,0,5>
    }
    object{
        pied1 
        translate  <35,0,5>
    }
    object{
        pied1 
        translate  <35,0,35>
    }
    object{
        pied1 
        translate  <5,0,35>
    }     
    
}

#declare barres = union {   
    #declare Index = 1;
    #while(Index <= 35)
    
      object {
        barre  
        translate<Index+10,0,0>
      }
    
      #declare Index = Index + 7;
    #end
}  

#declare Chaise = union {

    object{  
        soutien
        rotate<90,0,0>
        translate<-5,33 + 12 +40,0>
    }
    object{
        siege 
        translate<0,40,0> 
    }
    
    object{ 
        barres
        translate<-7,40,1>
    } 
    
    object{ 
        pieds
    } 

}



/** Canape ------------------------------------**/

#declare M_Canape = //materiau canape 
    material { 
        texture { 
            pigment {   
                rgb < 0, 50/255, 73/255 >
            }
            finish {
                crand .12 //pour donner de la texture et donner l'impression de tissu
                specular 0.001    
            }
        } 
    }    

#declare AssiseCanape = prism { //assise courbee pour effet mou, coussin, bombe
    linear_sweep
    bezier_spline 0, 14, 16   
    //courbe moins importante d un cote que de l'autre pour l assise  
    < 0, 10>, < 0, 0>, < 10, 0 >, < 70, 0>,
    < 70, 0>, < 80, 0 >, < 80, 10 >, < 80, 36 >,
    < 80, 36 >, < 80, 46 >, < 70, 59 >, < 10, 49 >,
    < 10, 49 >, < 0, 46 >, < 0, 36 >, < 0, 10>
    
    rotate < -90, 90, 0 >
    translate < 14, 0, 80 >
}

#declare DossierCanape = 
    //structure dossier qui tient les coussins
    object {
        superellipsoid { <.40, .15> }
        scale < (220-15-15)/2, 125/2, 15/2 >
        translate < (220-15-15)/2, 125/2, 15/2 > 
} 

#declare DossierCoussin =
    //pour effet bombe sur le dossier
    object {
        superellipsoid { <.15, .6> }
        scale < (220-15-15)/2/3, 75/2, 30/2 >
        translate < (220-15-15)/2/3, 75/2, 30/2 > 
}
    
#declare Accoudoir = object {
    //accoudir avec chanfreins arrondis
    superellipsoid { <.25, .25> }
    scale < 15/2, 75/2, 115/2 >
    translate < 15/2, 75/2, 115/2 > 
} 

#declare CoussinCanape = object { //coussin cylindre avec chanfreins ronds 
    superellipsoid { < 1, .25> }  
    scale 0.5 
    translate < .5,.5,.5 >
    texture { 
            pigment {   
                image_map {
                    jpeg "point_pattern.jpg" // texture avec image
                    map_type 0
                }
            }
            finish { specular 0.001 }
        }
    scale < 20, 20, 60 >    
}                   

#declare Canape = union { //assemblage des elements
    object { AssiseCanape scale < 192/14, 1, 1.2 > translate < 14, 0, 1 > }  
    
    object { Accoudoir }
    object { Accoudoir translate < 220 - 16, 0, 0 > } 
    
    //on incline legerement pour ne pas avoir un dossier vertical                     
    object { DossierCanape rotate < 10, 0, 0 > translate < 15, 0, 75+15 > }
    object { DossierCoussin rotate < 10, 0, 0 > translate < 15, 50, 67 > }
    object { DossierCoussin rotate < 10, 0, 0 > translate < 15 + (220-15-15)/3 , 50, 67 > }
    object { DossierCoussin rotate < 10, 0, 0 > translate < 15 + 2*(220-15-15)/3 , 50, 67 > } 
    
    //legere inclinaison due a l assise qui n est pas horizontale
    object { CoussinCanape translate < 14, 55.9, 10 > rotate < 5, 0, 0 > }
    object { CoussinCanape translate < 192 -14, 55.9, 10 > rotate < 5, 0, 0 > }
    
    //application du materiau canape
    material { M_Canape }
}    



/** Bouteille ------------------------------------**/

#declare Bouteille = lathe { //effectue a l aide d'inkscape pour les points de bezier
    bezier_spline
    204 //nr points
    /*   0*/ <-0.14557430, 0.04835892>, <0, 0.04835892>, <16.93494600, -0.40377108>, <16.93494600, -0.40377108>,
    /*   1*/ <16.93494600, -0.40377108>, <16.93494600, -0.40377108>, <23.01359600, -1.65969110>, <23.01359600, -1.65969110>,
    /*   2*/ <23.01359600, -1.65969110>, <23.01359600, -1.65969110>, <24.01832600, -1.25780110>, <25.27425600, -4.22177110>,
    /*   3*/ <25.27425600, -4.22177110>, <25.27425600, -4.22177110>, <26.53016600, -7.18574110>, <26.53016600, -7.18574110>,
    /*   4*/ <26.53016600, -7.18574110>, <26.53016600, -7.18574110>, <26.93206600, -11.20469100>, <26.93206600, -11.20469100>,
    /*   5*/ <26.93206600, -11.20469100>, <26.93206600, -11.20469100>, <27.08277600, -80.38077100>, <27.13301600, -84.39971100>,
    /*   6*/ <27.13301600, -84.39971100>, <27.18321600, -88.41866100>, <26.47993600, -91.88500100>, <26.47993600, -91.88500100>,
    /*   7*/ <26.47993600, -91.88500100>, <26.47993600, -91.88500100>, <24.77188600, -99.92289300>, <24.77188600, -99.92289300>,
    /*   8*/ <24.77188600, -99.92289300>, <24.77188600, -99.92289300>, <21.90838600, -110.07072000>, <21.90838600, -110.07072000>,
    /*   9*/ <21.90838600, -110.07072000>, <21.90838600, -110.07072000>, <18.24109600, -121.02235000>, <18.24109600, -121.02235000>,
    /*  10*/ <18.24109600, -121.02235000>, <18.24109600, -121.02235000>, <15.42783600, -130.01473000>, <15.42783600, -130.01473000>,
    /*  11*/ <15.42783600, -130.01473000>, <15.42783600, -130.01473000>, <13.87049600, -135.74173000>, <13.87049600, -135.74173000>,
    /*  12*/ <13.87049600, -135.74173000>, <13.87049600, -135.74173000>, <12.56433600, -141.77015000>, <12.56433600, -141.77015000>,
    /*  13*/ <12.56433600, -141.77015000>, <12.56433600, -141.77015000>, <11.40889600, -150.51135000>, <11.40889600, -150.51135000>,
    /*  14*/ <11.40889600, -150.51135000>, <11.40889600, -150.51135000>, <10.35391600, -158.14735000>, <10.35391600, -158.14735000>,
    /*  15*/ <10.35391600, -158.14735000>, <10.35391600, -158.14735000>, <9.65060580, -166.28571000>, <9.65060580, -166.28571000>,
    /*  16*/ <9.65060580, -166.28571000>, <9.65060580, -166.28571000>, <9.04776580, -175.73023000>, <9.04776580, -175.73023000>,
    /*  17*/ <9.04776580, -175.73023000>, <9.04776580, -175.73023000>, <9.04776580, -185.07427000>, <9.04776580, -185.07427000>,
    /*  18*/ <9.04776580, -185.07427000>, <9.04776580, -185.07427000>, <10.75581600, -185.12447000>, <10.75581600, -185.12447000>,
    /*  19*/ <10.75581600, -185.12447000>, <10.75581600, -185.12447000>, <11.40889600, -184.57187000>, <10.75581600, -186.12921000>,
    /*  20*/ <10.75581600, -186.12921000>, <10.75581600, -186.12921000>, <10.10273600, -187.68655000>, <10.10273600, -187.68655000>,
    /*  21*/ <10.10273600, -187.68655000>, <10.10273600, -187.68655000>, <9.49989580, -188.89223000>, <9.49989580, -188.89223000>,
    /*  22*/ <9.49989580, -188.89223000>, <9.49989580, -188.89223000>, <8.89704580, -190.44958000>, <8.89704580, -190.44958000>,
    /*  23*/ <8.89704580, -190.44958000>, <8.89704580, -190.44958000>, <8.49515580, -192.45905000>, <8.49515580, -192.45905000>,
    /*  24*/ <8.49515580, -192.45905000>, <8.49515580, -192.45905000>, <9.14823580, -193.46378000>, <9.14823580, -193.46378000>,
    /*  25*/ <9.14823580, -193.46378000>, <9.14823580, -193.46378000>, <9.04776580, -192.10739000>, <9.29894580, -194.51876000>,
    /*  26*/ <9.29894580, -194.51876000>, <9.55012580, -196.93012000>, <8.14349580, -196.02586000>, <8.14349580, -196.02586000>,
    /*  27*/ <8.14349580, -196.02586000>, <8.14349580, -196.02586000>, <4.77763580, -196.52823000>, <4.77763580, -196.52823000>,
    /*  28*/ <4.77763580, -196.52823000>, <4.77763580, -196.52823000>, <0, -196.62870000>, <0, -196.62870000>,
    /*  29*/ <0, -196.62870000>, <0, -196.62870000>, <0.00513570, -195.42302000>, <0.00513570, -195.42302000>,
    /*  30*/ <0.00513570, -195.42302000>, <0.00513570, -195.42302000>, <7.79184580, -194.87041000>, <7.79184580, -194.87041000>,
    /*  31*/ <7.79184580, -194.87041000>, <7.79184580, -194.87041000>, <8.24397580, -195.07136000>, <7.99278580, -193.41355000>,
    /*  32*/ <7.99278580, -193.41355000>, <7.99278580, -193.41355000>, <7.74160580, -191.75573000>, <7.74160580, -191.75573000>,
    /*  33*/ <7.74160580, -191.75573000>, <7.74160580, -191.75573000>, <7.49041580, -190.80123000>, <7.49041580, -190.80123000>,
    /*  34*/ <7.49041580, -190.80123000>, <7.49041580, -190.80123000>, <9.39941580, -187.13395000>, <9.39941580, -187.13395000>,
    /*  35*/ <9.39941580, -187.13395000>, <9.39941580, -187.13395000>, <8.49515580, -185.62684000>, <8.49515580, -185.62684000>,
    /*  36*/ <8.49515580, -185.62684000>, <8.49515580, -185.62684000>, <7.99278580, -182.56240000>, <7.99278580, -182.56240000>,
    /*  37*/ <7.99278580, -182.56240000>, <7.99278580, -182.56240000>, <8.19373580, -170.00319000>, <8.19373580, -170.00319000>,
    /*  38*/ <8.19373580, -170.00319000>, <8.19373580, -170.00319000>, <8.89704580, -159.10181000>, <8.89704580, -159.10181000>,
    /*  39*/ <8.89704580, -159.10181000>, <8.89704580, -159.10181000>, <11.81078600, -138.30377000>, <11.81078600, -138.30377000>,
    /*  40*/ <11.81078600, -138.30377000>, <11.81078600, -138.30377000>, <17.73872600, -117.65644000>, <17.73872600, -117.65644000>,
    /*  41*/ <17.73872600, -117.65644000>, <17.73872600, -117.65644000>, <24.16904600, -96.40627100>, <24.16904600, -96.40627100>,
    /*  42*/ <24.16904600, -96.40627100>, <24.16904600, -96.40627100>, <25.62590600, -89.07170100>, <25.62590600, -89.07170100>,
    /*  43*/ <25.62590600, -89.07170100>, <25.62590600, -89.07170100>, <25.87709600, -11.45583100>, <25.87709600, -11.45583100>,
    /*  44*/ <25.87709600, -11.45583100>, <25.87709600, -11.45583100>, <24.52069600, -6.83404110>, <24.52069600, -6.83404110>,
    /*  45*/ <24.52069600, -6.83404110>, <24.52069600, -6.83404110>, <23.31501600, -4.02078110>, <23.31501600, -4.02078110>,
    /*  46*/ <23.31501600, -4.02078110>, <23.31501600, -4.02078110>, <20.45151600, -2.61415110>, <20.45151600, -2.61415110>,
    /*  47*/ <20.45151600, -2.61415110>, <20.45151600, -2.61415110>, <12.91599600, -1.70989110>, <12.91599600, -1.70989110>,
    /*  48*/ <12.91599600, -1.70989110>, <12.91599600, -1.70989110>, <4.37573580, -1.70989110>, <4.37573580, -1.70989110>,
    /*  49*/ <4.37573580, -1.70989110>, <4.37573580, -1.70989110>, <0.00513570, -1.76009110>, <0.00513570, -1.76009110>,
    /*  50*/ <0.00513570, -1.76009110>, <0.00513570, -1.76009110>, <0, 0.04835892>, <0, 0.04835892>    
    
    //materiau semblable au verre
    pigment {  rgbt < .9, .95, 1, 0.3 > filter .85}     
    finish { diffuse 0.2 
             reflection .4 
             specular 0.05
             roughness 10e-4
    }
    //indice de refraction 
    interior { ior 1.5 }
   
    scale 0.15
    rotate <180,0,0> 
    translate < 4, 0, 4 >
}



/** Verre ------------------------------------**/

#declare Verre = lathe {
    linear_spline 7
    < 0, 0.0000001 >, < 7.2/2, 0 >, < 7.2/2, 8.4 >,
    < 6.000001/2, 8.4 >, < 6.000001/2, 1 >, < 0, 1 >, <0, 0.0000001 > 
   
    //materiau verre   
    pigment { rgbt < .9, .95, 1, 0.3 > filter .85}     
    finish { diffuse 0.2 
             reflection .4 
             specular 0.05
             roughness 10e-4
    } 
    interior { ior 1.5 }
}  

#declare VerreRempli = union { //verre rempli d eau
    object { Verre }
    object {
        lathe {
            linear_spline 4
            < 0, 1 >, < 6/2, 1 >, < 6/2, 7 >, < 0, 7 >
            
            pigment { rgbt < .70, .70, 1, 0.2 > filter 0.45} 
    
            
            finish { reflection .1 
                     specular 0.05
                     roughness 10e-4 
            }
            //indice de refraction eau
            interior { ior 1.33 }
                    
        }    
    } 
} 



/** Livres -----------------------------------**/

#declare couverture1 = box {<0,0,0><15,21,0.2>}

#declare bourdure = box {<0,0,0><1.7,21,0.2>}

#declare pages =  box {<0,0,0><13,20.8,1.5>}
    
#macro Livre(couleur)
    object{
        union {   
            object{ 
                couverture1 
                pigment {rgb couleur}
            }
            object{ 
                couverture1  
                translate <0,0,1.7>  
                pigment {rgb couleur}
            } 
            object{ 
                bourdure
                rotate<0,-90,0> 
                pigment {rgb couleur}
            }
            object{
                pages 
                translate <0,0.2,0.2>
                pigment {White}
            } 
       }    
    }
#end

#declare livre = union { 
      //1ere etage
    #declare Index = 0;
    #while (Index <= 15)
        object {     
            Livre(<0.2*Index/4,0.05*Index/2,0.4>)
            scale<1,1,2> 
            translate <640,6,222+ Index*5> // les etageres c'est tous les x*200/6
        }
    #declare Index = Index + 1;
    #end 
    
    //deuxieme
    #declare Index = 0;
    #while (Index <= 10)
        object {     
            Livre(<0.8,0.2,0.4*(Index+1)/12>)
            scale<1,1,2> 
            translate <640,6 + 200/6,222+ Index*5> // les etageres c'est tous les x*200/6
        }
    #declare Index = Index + 1;
    #end 
    
    object { 
        Livre (<0.8,0.2,0.4*(11+1)/12>) 
        scale<1,1,2> 
        rotate<-10,0,0>
        translate <640,6 + 200/6,222+ 11*5 + 2.5>
    }
    
    //troisieme
    #declare Index = 0;
    #while (Index <= 1)
        object {     
            Livre(<0.15,0.05,0.83*(Index+1)/12>)
            scale<1,1,2>
            rotate<90,-2,0> 
            translate <640, 10 + 2*200/6+ Index*3.5,222 + 60> // les etageres c'est tous les x*200/6
        }
        object {     
            Livre(<0.03,0.11,0.32*(Index+1+2)/12>)
            scale<1,1,2>
            rotate<90,-20,0> 
            translate <640,10 + 2*200/6+ (Index+2)*3.5,222 + 60> // les etageres c'est tous les x*200/6
        }
    #declare Index = Index + 1;
    #end 
    #declare Index = 0;
    #while (Index <= 8)
        object {     
            Livre(<0.92,0.94,0.81*(Index+4)/7>)
            scale<1,1,2> 
            translate <640,6+ 2*200/6, 222 + 55 - Index*5> 
        }
    #declare Index = Index + 1;
    #end 
    object {     
            Livre(<0.92,0.94,0.81*(9+4)/7>)
            scale<1,1,2>
            rotate<15,0,0> 
            translate <640,6+ 2*200/6, 222 + 50.8 - 9*5> 
        }
    //4eme etage
    #declare Index = 0;
    #while (Index <= 7)
        object {     
            Livre(<0.92,0.94,0.81>)
            scale<1,1,2> 
            translate <640,6+ 3*200/6, 222 + 80 - Index*5> 
        }
    #declare Index = Index + 1;
    #end
    object {     
            Livre(<0.812,0.632,0.631>)
            scale<1,1,2> 
            translate <640,6+ 3*200/6, 222 + 80 - 8*5> 
    }
     
    object {     
            Livre(<0.812,0.632,0.631>)
            scale<1,1,2> 
            translate <640,6+ 3*200/6, 222 + 80 - 9*5> 
    }
    
    //5eme etage
    #declare Index = 0;
    #while (Index <= 14)
        object {     
            Livre(<0.3,0.15*Index/8,0.27*Index/8>)
            scale<1,1,2> 
            translate <640,6 + 4*200/6,222+ Index*5> 
        }
    #declare Index = Index + 1;
    #end 
    
    //6eme etage
    #declare Index = 0;
    #while (Index <= 9)
        object {     
            Livre(<0.8*Index/12,0.87*(Index+1)/12,0.83*Index/8>)
            scale<1,1,2> 
            translate <640,6 + 5*200/6,222+ Index*5> // les etageres c'est tous les x*200/6
        }
    #declare Index = Index + 1;
    #end 
    
    object { 
        Livre (<0.8*10/12,0.87*(10+1)/12,0.83*10/8>) 
        scale<1,1,2> 
        rotate<-10,0,0>
        translate <640,6 + 5*200/6,222+ 10*5 + 2.5>
    }

}


 
/** Casse tete ----------------------------------------------*/

#declare Baton = box {<0,0,0>,<1.5,9.5,1.5>}

#declare Barres = union { // set de 4 barres placees  
    object{ 
    Baton
    texture {pigment {  wood turbulence 0.02 scale 0.05 }}
    } 
    object{ 
        Baton   
        translate<1.5,0,0>
        texture {pigment { wood turbulence 0.02 scale 0.05 }}
    }
    object{ 
        Baton   
        translate<-1.5 -1.5,0,0>
        texture {pigment { wood turbulence 0.02 scale 0.05 }}
    } 
    object{ 
        Baton   
        translate<-1.5 -1.5 -1.5,0,0>
        texture {pigment { wood turbulence 0.02 scale 0.05 }}
    }    
        
}

#declare Casse_tete = union //placement des sets de barres sur chaque axe
{
    //derriere (batons debouts)
    object{       
        Barres
    }  
    
    
    //devant (batons debouts)
    object{ 
        Barres
        translate<0,0,2.8+1.5>
    } 
    
    //horizontale selon x (bas)
    object{ 
        Barres
        rotate<-90,90,0>  
        translate<3*1.5,2,1.5 + 0.8>
    }  
    
    //horizontale selon x (haut)
    object{ 
        Barres
        rotate<-90,90,0>  
        translate<3*1.5,2 +1.5 +2.8,1.5 + 0.8>
    }    
    
    //horizontale selon z (bas)
    object{ 
        Barres
        rotate<-90,0,90>  
        translate<1.5 + 0.5 ,5.8,8>
    }  
    
    //horizontale selon z (haut)
    object{ 
        Barres
        rotate<-90,0,90>  
        translate<1.5 + 0.5 ,5.8,8>  
        translate<-1.5-3,0,0>
    }

}



/** Bureau --------------------------------------**/

#declare table_bureau = box { <0,0,0>,<150,5,73> }

#declare pied_bureau = cylinder {<0,0,0>,<0,40,0>,3}

#declare mat_bois = material {
    texture {
        pigment{
            bozo
            color_map {
                [.2 rgb <0.722, 0.494, 0.282>]
                [.8 rgb <0.678, 0.404, 0.141>]
            }
        }
        finish {
            ambient .1 diffuse .6
            specular .3 roughness 1e-2
        }
    }                
} 

#declare bureau = union {
    object {table_bureau translate<-10,40,0> material {mat_bois}}
    object {pied_bureau translate<0,0,5> material {mat_bois}} 
    object {pied_bureau translate<145-10,0,5> material {mat_bois}}  
    object {pied_bureau translate<145-10,0,73-5> material {mat_bois}} 
    object {pied_bureau translate<0,0,73-5> material {mat_bois}}
}



/** Tasse --------------------------------------**/

#declare Tasse = blob{ //utilisation de blob
    cylinder{-y*3.5,y*3.56,1.25,2.9 scale y*0.7/3} // side
    cylinder{-y*2,y*3.44,.79,-15 scale y*0.7}      // hollow     
    
    #declare i=0; 
    
    #while(i<1.01) // handle       
    
        #declare X=cos(1.02-pow((i-.5)*2,2))*1.5;
        sphere{
            y*0.6,0.11,.3
            scale z*2
            translate
            x*2.32
            -y*.6
            +y*sin((i-.5)*pi*1.6)*.6
            -x*X
        }
        #declare i=i+1/150;  
        
    #end
    sphere{0,0.8,15.75 scale y*0.15 translate -y*0.83} // and bottom
    sturm
    translate y*.85  
    
    //materiau ceramique mauve
    pigment { rgb < 204/255, 153/255, 1> }
    finish {
        ambient .1 diffuse .6
        specular .1 roughness 1e-2
        reflection .1
    }    
}



/** Globe --------------------------------------**/

#declare m_Globe = material { //materiau structure globe
    texture {
        pigment {
            bozo
            color_map {
                [ 0.1 rgb < .5, .5, .5 >/2 ]
                [ 0.15 rgb < .5, .5, .50 > ]
            }    
        }  
        finish {
            ambient .1 diffuse .5
            specular .3 roughness 1e-3
            reflection .05
            metallic
        }    
    } 
    scale .05
}

#declare Terre = object { //maquette de la terre
    USphere
    pigment {   
        image_map {
            jpeg "earth_map.jpg" //utilisation d'une image
            map_type 1
        }
    }
    scale 20/2
} 

#declare ArcCercleGlobe = difference { //arc de cercle autour de la maquette de la terre
    object {
        USphere
        scale 24/2
    }
    object {
        USphere
        scale 22/2 
    }
    object {
        UCube
        scale 37/2
        rotate < 0, 0, 45 >   
        translate < 30/2 + 2, 0, 0 >
    } 
    object {
        UCube
        scale 30/2   
        translate < 0, 0, 30/2 + .5 >
    } 
    object {
        UCube
        scale 30/2   
        translate < 0, 0, -(30/2 + .5) >
    }               
} 

#declare StructureGlobe = union { //structure superieure du globe
    object { Terre }
    object {
        UCylindre
        rotate < 90, 0, 0 >  
        scale < .4, 25/2, .4 >
    }
    object {
        USphere
        scale .6
        translate < 0, .5/2 + 25/2, 0 >
    }
    object {
        USphere
        scale .6
        translate < 0, -(.5/2 + 25/2), 0 >
    }
    object {
        ArcCercleGlobe
    }       
    rotate < 0, 0, 25 >
}  

#declare BaseGlobe = lathe { //structure inferieure du globe
    linear_spline 7
    < 0, 0 >, < 10, 0 >, < 10, .7 >, < .5, 4 >, < .5, 12 >, < 0, 12 >, < 0, 0 >    
}   

#declare Globe = union { //assemblage du globe
    object { StructureGlobe translate < 0, 20/2+10, 0 > }
    object { BaseGlobe }
    
    //application du materiau sur la structure
    material { m_Globe }
}                                                  


 
//Mise en scene ------------------------------------------------------------------------------- 
//tous les objets sont surélevés de 1.4/2 a cause du plancher 
 
//Plancher
object {
    Plancher
} 
 
//la piece (les murs + fenetre)
object{
    piece
} 

//le pouf
object { 
    Pouf     
    scale<1.1,1.4,1.1>                                                                                          
    translate < 600, 1.4/2, 600>
    //application materiau
    pigment { agate turbulence 0.2 color_map{ [0.3 rgb<0.98, 0.949, 0.89>] [0.5 rgb<0.941, 0.886, 0.784>] [1 rgb<0.902, 0.816, 0.647>] } scale 5 } 
}

//table basse
object{
    table_basse
    scale<1.4,1.1,1.4> 
    rotate<0,90,0>
    translate<460,1.4/2,510>
}

//chaise
object {  
    Chaise
    translate < 450, 1.4/2, 594>
    //application materiau
    pigment {rgb <0.22, 0.118, 0.039>}
} 

//bureau
object {
    bureau 
    scale<1,1.48,1>
    translate < 410, 1.4/2, 630>
}

//bibliotheque
object{  
    Bibliotheque
    scale<1.1,1,0.8>
    rotate<0,-90,0> 
    translate < 640, 1.4/2, 220>                
}

//livres
object { 
    livre
}  

//casse tete
object {     
        Casse_tete
        scale<1,1,1> 
        translate <660,6+ 1*200/6, 222 + 70> 
}

//plafond
object { 
    Plafond
    pigment {White}
}

//Cadres
object {
    Cadre("Plage_BOUCHER_SELLIER_3A-AVM.jpg")
    rotate < 0, 90, 0 >               
    translate < 730 - 10 - 1, 135, 540>  
}
object {
    Cadre("totoro.jpg")
    rotate < 0, 90, 0 >               
    translate < 730 - 10 -1, 140 + 1.4/2, 400>  
}
object {
    Cadre("citron.jpg")                 
    scale < 50/(21*2), 50/(29.7*2), 1>   
    rotate < 0, 90, 0 >                             
    translate < 730 - 10 - 1, 170 + 1.4/2, 470>  
}                                      
object {
    Cadre("easter_egg.jpg")                 
    scale < 30/(21*2), 30/(29.7*2), 1>   
    rotate < 0, 90, 0 >                             
    translate < 730 - 10 - 1, 180 + 1.4/2, 590>  
} 

//Lampe
object {
    Lampe
    rotate < 0, 45, 0 >
    translate < 665, 1.4/2, 600 >
}  

//Canape
object {
    Canape
    rotate < 0, 90, 0 >
    translate < 730 - 137, 1.4/2, 220 + 330 >  
}

//Bouteille
object {
    Bouteille
    translate < 530, 1.4/2 + 31.9, 420 >  
}

//Verres
object {
    VerreRempli
    translate < 525, 1.4/2 + 31.9, 405 > 
} 
object {
    Verre
    translate < 510, 1.4/2 + 31.9, 435 > 
} 

//Tasse                                                
object {                                                   
    Tasse
    scale 10/2 
    rotate < 0, 200, 0 >                     
    translate < 457, 67 + 1.4/2 , 660 >
    
} 

//Globe
object {
    Globe  
    translate < 515, 67 + 1.4/2, 680 >
}    

//Livre sur bureau 
object {
    Livre(<1,0,0 >)
    rotate < 90, 0, 0 >
    translate < 470, 69 + 1.4/2, 640 >
}                                     

//Lampe bureau
object {
    Lampe
    scale 0.2
    translate < 450, 67 + 1.4/2, 686 >
}    
 
//luminaire
object { 
    Luminaire
    translate < 420, 240, 420 >
}  
//lumiere du luminaire
light_source {
    <420, 240 - 40.5, 420> 
    //lumiere legerement magenta
    rgb < .9, .7, 1 >

    area_light x*10 z*22 2 2
}  
   


global_settings{
    radiosity{ }//{ Rad_Settings(Radiosity_IndoorHQ,no,no)} 
    photons{ count 1e6}
    
}    

plane {
    <0,1,0>, 0
    pigment {
    granite
        turbulence 3
        color_map {
            [0.000 color rgb <0.5, 0.6, 0.2>]
            [0.25 color rgb <0.7, 1, 0.2>]
            [0.5 color rgb <1, 0.6, 0.2>]
            [0.75 color rgb <.5, 0.9, 0.2>]
            [1 color rgb <0.3, 0.9, 0.2>]
        }
        scale 0.035
    }
}
 
//vue vers le canape   
camera { 
    //fisheye
    right x * image_width/image_height
    up y    * 1
    location <240,120,400>
    look_at <600,100,500> 
    angle 80      
    
    focal_point < 635, 140, 440>    // pink sphere in focus
    aperture 0.4     // a nice compromise
}    

background {SkyBlue }