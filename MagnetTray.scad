/* [Tray] */
// X (mm)
TrayWidth = 100;
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
      RoundedCornerSquareTray();
        
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

difference()
{
   RoundedCornerSquareTrayWithMagnets();
   translate([32,7,TrayThickness - 0.4])
      linear_extrude(height = 4)
         import("./_media/OBC.svg");
}