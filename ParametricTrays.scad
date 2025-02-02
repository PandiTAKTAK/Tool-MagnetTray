/*************************************************************************************
 *
 * Parametric tray implementation.
 *
 *************************************************************************************
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHOR OR COPYRIGHT
 * HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * IT IS NOT PERMITTED TO MODIFY THIS COMMENT BLOCK.
 *
 * (c)2024, Claude "Tryphon" Theroux, Montreal, Quebec, Canada
 * http://www.ctheroux.com/
 *
 ************************************************************************************/

////////////////////////////////////////////////////////////////
// 
// Computed values. Nothing should be modified below this line.
//

module SquareTray() {
    translate([ -TrayWidth / 2, -TrayLength / 2, 0 ]) difference() {
        cube([TrayWidth, TrayLength, TrayHeight]);
        translate([TrayThickness, TrayThickness, TrayThickness]) cube([TrayWidth - 2 * TrayThickness, TrayLength - 2 * TrayThickness, TrayHeight - TrayThickness]);
    }
}

module RoundedCornerVolume(Width, Length, Height, CornerRadius) {
    $fn = 120;
    linear_extrude(height = Height) hull() {
        translate([ CornerRadius, CornerRadius, 0 ]) circle(r = CornerRadius);
        translate([ Width - CornerRadius, CornerRadius, 0 ]) circle(r = CornerRadius);
        translate([ CornerRadius, Length - CornerRadius, 0 ]) circle(r = CornerRadius);
        translate([Width - CornerRadius, Length - CornerRadius, 0]) circle(r = CornerRadius);
    }
}

module RoundedCornerSquareTray() {
    difference() {
        RoundedCornerVolume(TrayWidth, TrayLength, TrayHeight, CornerRadius);
        translate([TrayThickness, TrayThickness, TrayThickness ]) RoundedCornerVolume(TrayWidth - 2 * TrayThickness, TrayLength - 2 * TrayThickness, TrayHeight - TrayThickness, CornerRadius);
    }
}

module RoundTray() {
    $fn = 120;
    difference() {
        cylinder(d = TrayDiameter, h = TrayHeight);
        translate([ 0, 0, TrayThickness ]) cylinder(d = TrayDiameter - 2 * TrayThickness, h = TrayHeight - TrayThickness);
    }
}
