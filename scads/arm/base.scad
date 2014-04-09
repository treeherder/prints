module base(height,width){
difference(){
union(){
cube([100,100,10]);
translate([0,0,0])cube([10,100,100]);
translate([90,0,0])cube([10,100,100]);
  }
  translate([-10,40,50]) rotate([90,0,90])  cylinder(r=20, h=120);
	}
}
base(1,10);