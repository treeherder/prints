
module base(height, radius){

  difference(){
    cylinder(h=height*2, r1=12,r2=radius+6);
	translate([0,0,1]) cylinder(h=(height*2)+1, r=radius);
    translate([0,0,16]) cylinder(r=3.8, h=5);

    }//diff
}//module
module cap(height, radius){
  difference(){
    cylinder(h=height, r=radius+6);
	translate([0,0,4]) cylinder(h=height, r=radius);
    }//diff
}//module


base(10,2.5);
translate([30.30,0])cap(8,4);
