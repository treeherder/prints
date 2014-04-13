
module base(height, radius){

  difference(){
    cylinder(h=height*2, r1=12,r2=radius+6, $fn=32);
	translate([0,0,1]) cylinder(h=(height*2)+1, r=radius, $fn=32);
    translate([0,0,height*2-4]) cylinder(r=3.8, h=5, $fn=32);

    }//diff
}//module
module cap(height, radius){
  difference(){
    cylinder(h=height, r=radius*2, $fn=32);
	translate([0,0,height/3]) cylinder(h=height, r=radius, $fn=32);
    }//diff
}//module


base(5,2.1);
translate([30.30,0])cap(4,3.2);
