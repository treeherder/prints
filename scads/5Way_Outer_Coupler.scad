// 5-way right angle pipe outer coupler (half)
// http://www.thingiverse.com/thing:27648
// 29 July 2012
// cbonsig
//

module pvc_coupler()
{
	pipe_od = 26.67; // outer diameter of the pipe. 3/4" SCH 40 = 1.050 in = 26.67 mm
	gap = 1.0; // clearance between pipe OD and coupler ID. Slip fit in this case
	ledge = 2.0; // size of the ledge that stops the pipe from sliding through
	wall = 3.0; // wall thickness of the coupler

	pad_w = 0.4; // wall thickness of anti-warping pads (0 for none)
	pad_r = 6.0; //radius of anti-warping pads
	
	inner = pipe_od + gap;
	outer = inner + (wall*2);

	od_r = r_from_dia(outer);
	cy_h = r_from_dia(outer * 3.0); // total length = 3x diameter

	id_r = od_r - wall;

	function r_from_dia(d) = d / 2;

	module rotcy(rot, r, h) {
		rotate(90, rot)
			cylinder(r = r, h = h, center = false);
	}

	
	// rotates the flat side of the half coupler to face down

	rotate(a=[0,180,0])
	{
		// join a large and small structure to form the coupler.
		// the small one forms the ledge in the middle to prevent
		// the coupler from freely sliding down the pipe
		
		union() {

			// large one: the main body of the coupler

			difference() {
				union() {
					cylinder(r = od_r, h = cy_h*2, center = true);
					rotcy([1,0,0], od_r, cy_h);
					rotcy([0,1,0], od_r, cy_h);
					rotcy([-1,0,0], od_r, cy_h); 
				}
					cylinder(r = id_r, h = (cy_h*2+1), center = true);
					rotcy([1,0,0], id_r, (cy_h+1));
					rotcy([0,1,0], id_r, (cy_h+1));
					rotcy([-1,0,0], id_r, (cy_h+1));
					
					// chop off one half for easy printing
					cylinder(r = 100, h = 100, center = false);
			}
	
			// smaller one: in middle to form a ledge

			difference() {

				union() {
					// single vertical portion of coupler (Z)
					cylinder(r = (od_r-ledge), h = (od_r*2), center = true);

					// two horizontal portions of the coupler (X, Y)
					rotcy([1,0,0], (od_r-ledge), (od_r));
					rotcy([0,1,0], (od_r-ledge), (od_r));
					rotcy([-1,0,0], (od_r-ledge), (od_r));
				}
					// now subtract the same structure, but smaller
					cylinder(r = (id_r-ledge), h = ((od_r*2)+1), center = true);
					rotcy([1,0,0], (id_r-ledge), ((od_r)+1));
					rotcy([0,1,0], (id_r-ledge), ((od_r)+1));
					rotcy([-1,0,0], (id_r-ledge), (od_r)); 

					// chop off one half of the whole thing for easy printing
					cylinder(r = 100, h = 100, center = false);
			}
			
			// add some pads at the ends to help prevent warping

			translate(v = [(cy_h+pad_r*0.9),(od_r-(wall*0.5)),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			translate(v = [(cy_h+pad_r*0.9),-(od_r-(wall*0.5)),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			translate(v = [(od_r-(wall*0.5)),-(cy_h+pad_r*0.9),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			translate(v = [-(od_r-(wall*0.5)),-(cy_h+pad_r*0.9),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			translate(v = [(od_r-(wall*0.5)),(cy_h+pad_r*0.9),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			translate(v = [-(od_r-(wall*0.5)),(cy_h+pad_r*0.9),-pad_w]){
			cylinder(r = pad_r, h = pad_w, center = false);
			}

			
		}
	}
}

pvc_coupler();

