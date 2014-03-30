$fn=40;

//608ZZ dimensions: outerDiameter = 22, width = 7
//603ZZ dimensions: outerDiameter = 9, width = 5

numberOfBearings=2;
outerBearingDiameter = 22;
bearingWidth = 7;
extrusionGapWidth = 6;

module vRoller() {

	difference() {
		union() {
			cylinder(r = outerBearingDiameter / 2 + 4, h = bearingWidth * numberOfBearings, center = true);
			cylinder(r = outerBearingDiameter / 2 + 5, h = bearingWidth * numberOfBearings - 4, center = true);
			hull() {
				cylinder(r = outerBearingDiameter / 2 + 5, h = extrusionGapWidth + 3, center = true);
				cylinder(r = outerBearingDiameter / 2 + 10, h = extrusionGapWidth - 3, center = true);
			}
			
		}
		//Center hole
		cylinder(r = outerBearingDiameter / 2 + .1, h = bearingWidth * numberOfBearings * 2, center = true);
	}
}

vRoller();