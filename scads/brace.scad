d =25;

difference (){cylinder(h = 20, r1 = 30, r2 = 14, center = true);
cylinder(h = 21, r = 11, center = true);

translate([d,0,0])cylinder(h = 21, r = 2, center = true);
translate([-d,0,0])cylinder(h = 21, r = 2, center = true);
translate([0,d,0])cylinder(h = 21, r = 2, center = true);
translate([0,-d,0])cylinder(h = 21, r = 2, center = true);}