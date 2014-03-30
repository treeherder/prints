module oils(){ //the basic shape
union(){
translate([20,0,0])cube([40,52,16], center = true);
cylinder(r=26,h= 16, center = true);}
	}
module endtab(){
difference(){ //the holes subtracted from the shape
 oils();
 cylinder(r=16, h=17, center = true);
 translate([35, -16, 0]) scale([2.3,1.3,1])cylinder(r=6, h=17, center = true); 
translate([28, 16, 0]) cylinder(r=8, h=17, center = true);}
}

module separator(){
union(){
translate([75,0,0])cube([81,2,16],center=true);
translate([75,20,0])cube([80,2,16],center=true);
translate([114,10,0])cube([2,20,16],center=true);

endtab();}
}

separator();