/* [Tray] */
// X (mm)
TrayWidth = 50;
// Y (mm)
TrayLength = 50;
// Z (mm)
TrayHeight = 10;
// Corner R (mm)
CornerRadius = 15;
// Wall Thickness (mm)
TrayThickness = 2.5;

/* [Magnet] */
// Magnet Diameter (mm)
MagnetDiameter = 5;
// Magnet Height (mm)
MagnetHeight = 2;
// Offset from edges (mm)
MagnetOffset = 10;
// Include centre magnet?
Centre="Y"; // [Y:Yes, N:No]

/* [Cover] */
// Generate Cover?
Cover="N"; // [Y:Yes, N:No]
// Generate Finger Grips?
FingerGrips="Y"; // [Y:Yes, N:No]
// Cover Slop (mm)
CoverSlop = 0.1;

/* [Logo] */
// Add logo?
Logo="N"; // [Y:Yes, N:No]
// Logo SVG
LogoFile = "./_media/OBC.svg";
// Logo X
LogoX=7;
// Logo Y
LogoY=7;
// Logo Depth
LogoDepth=0.4;

// ###########################################

/* [Hidden] */
RenderCludge = 0.01; // Cludge to tidy up rendering interface
$fn=60;

// ###########################################

include <ParametricTrays.scad>;

module RoundedCornerSquareTrayWithMagnets()
{
   difference()
   {
      // Base tray
      RoundedCornerSquareTray(TrayWidth, TrayLength, TrayHeight, CornerRadius);
        
      // Add corner magnets
      for (x = [MagnetOffset, TrayWidth - MagnetOffset], y = [MagnetOffset, TrayLength - MagnetOffset])
      {
         translate([x, y, -RenderCludge]) // Slightly below zero to ensure full cut
         {
            cylinder(h = MagnetHeight, d = MagnetDiameter + 0.1, $fn=50);
         }
      }

      if( Centre == "Y" )
      {
         // Add centre magnet
         translate([TrayWidth / 2, TrayLength / 2, -RenderCludge])
         {
            cylinder(h = MagnetHeight, d = MagnetDiameter);
         }
      }
   }
}

module Cover()
{
   CoverWidth = TrayWidth + (TrayThickness * 2) + CoverSlop;
   CoverLength = TrayLength + (TrayThickness * 2) + CoverSlop;
   CoverHeight = TrayHeight + TrayThickness + (CoverSlop / 2);
   
   rotate([0, 180, 0])
       translate([-CoverWidth + (CoverSlop / 2) + TrayThickness,0 - TrayThickness - (CoverSlop / 2), -TrayHeight - TrayThickness - CoverSlop])
         RoundedCornerSquareTray(CoverWidth, CoverLength, CoverHeight, CornerRadius);

}

if( Cover == "Y" )
{
   difference() //
   {
      difference()
      {
         Cover();
         if (Logo == "Y")
         {
            translate([LogoX,LogoY,TrayHeight + CoverSlop - RenderCludge])
               linear_extrude(height = 4)
                  import(LogoFile);
         }
      }
      
      if (FingerGrips == "Y")
      {
         rotate([0, 90, 0])
            translate([0,TrayLength/2, -TrayWidth/2])
               cylinder(h = TrayWidth * 2, d = TrayHeight*2);
      }
   }
}
else
{
   difference()
   {
      RoundedCornerSquareTrayWithMagnets();
      if (Logo == "Y")
      {
         translate([LogoX,LogoY,TrayThickness - LogoDepth])
            linear_extrude(height = 4)
               import(LogoFile);
      }
   }
}
