
bspace = 31/2; // bolt spacing
ybase = 42.5;
xbase = 42.5;
holerad = 1.75;

shuttlelength = 50;
shuttlewidth  = 80 ;
tubelength = 100;

v608innerdiam = 6;

pi=3.1415926535897932384626433832795;
innerRadius=3.1;//shaft radius, in mm
borders=2.5;//how thick should the borders around the central "shaft" be, in mm
diametralPitch=12;
numberOfTeeth=19;
pressureAngle=20*pi/180;
centerAngle=25;//angle at center of teeth

divs = 30; // how round to make all the circles

div = divs; // how round to make all the circles


module rack(innerRadius,borders,P,N,PA,CA)
{
	// P = diametral pitch
	// N = number of teeth
	// PA = pressure angle in radians
	// x, y = linear offset distances
	a = 1/P; // addendum (also known as "module")
	d = 1.25/P; // dedendum (this is set by a standard)
	multiplier=20;//20
	height=(d+a)*multiplier;
	
	
	// find the tangent of pressure angle once
	tanPA = tan(PA*(180/pi));
	// length of bottom and top horizontal segments of tooth profile
	botL = (pi/P/2 - 2*d*tanPA)*multiplier;
	topL =( pi/P/2 - 2*a*tanPA)*multiplier;

	slantLng=tanPA*height;
	realBase=2*slantLng+topL;
	
	
	offset=topL+botL+2*slantLng;
	length=(realBase+botL)*N;

	supportSize=(innerRadius+borders)*2;

	//calculate tooth params
	basesegmentL=realBase/2;
	basesegmentW=supportSize/2;

	topsegmentL=topL/2;
	topsegmentW=supportSize/2;

	baseoffsetY=tan(CA)*basesegmentW;
	topoffsetY=tan(CA)*topsegmentW;
	
	//calculate support params

	totalSupportLength=(N)*(offset);
	supportL=totalSupportLength/2;
	supportW=supportSize/1.99;
	
	echo("Total length",totalSupportLength+baseoffsetY);
	echo("Total height",supportSize);

	
	rotate([90,90,0])
	{
	translate([-supportSize/2,supportSize/2,0])
	{
	union()
	{
		translate(v=[0,0,3.8])
			support(supportL,supportW,supportSize/3,baseoffsetY);
	
		for (i = [0:N-1]) 
		{
			translate([0,i*offset-length/2+realBase/2,supportSize/2+height/2]) 
			{	
				
				tooth(basesegmentL,basesegmentW,topsegmentL,topsegmentW,height,baseoffsetY,topoffsetY);
				
			}
		}
	}
	
	}
	}
}

module support(supportL,supportW,height,offsetY)
{
	 tooth(supportL,supportW,supportL,supportW,height,offsetY,offsetY);
}

module myrack()
{
	difference()
	{
	union()
	{
		rotate(a=[-90,0,90])
			rack(innerRadius,borders,diametralPitch,numberOfTeeth,pressureAngle,centerAngle);

		translate(v = [-12.4,3,5.55])
			cube([2.5,99.25,7.5],center = true);

		translate(v = [1.25,3,5.55])
			cube([2.5,99.25,7.5],center = true);
	}
	translate(v = [-15,0,-3])
		cube([40,120,10],center = true);
	}
}

module tooth(basesegmentL,basesegmentW,topsegmentL,topsegmentW,height,baseoffsetY,topoffsetY)//top : width*length, same for base
{
	
	////////////////
	basePT1=[
	-basesegmentW,
	basesegmentL-baseoffsetY,
	-height/2];

	basePT2=[
	0,
	basesegmentL,
	-height/2];

	basePT3=[
	basesegmentW,
	basesegmentL-baseoffsetY,
	-height/2];

	basePT4=[
	basesegmentW,
	basesegmentL-(baseoffsetY+basesegmentL*2),
	-height/2];
	
	basePT5=[
	0,
	-basesegmentL,
	-height/2];

	basePT6=[
	-basesegmentW,
	basesegmentL-(baseoffsetY+basesegmentL*2),
	-height/2];
	//////////////////////////
	topPT1=[
	-topsegmentW,
	topsegmentL-topoffsetY,
	height/2];

	topPT2=[
	0,
	topsegmentL,
	height/2];

	topPT3=[
	topsegmentW,
	topsegmentL-topoffsetY,
	height/2];

	topPT4=[
	topsegmentW,
	topsegmentL-(topoffsetY+topsegmentL*2),
	height/2];
	
	topPT5=[
	0,
	-topsegmentL,
	height/2];

	topPT6=[
	-topsegmentW,
	topsegmentL-(topoffsetY+topsegmentL*2),
	height/2];
	//////////////////////////

	//////////////////////////

	polyhedron(
	points=[
		basePT1,
		basePT2,
		basePT3,
		basePT4,
		basePT5,
		basePT6,
		topPT1,
		topPT2,
		topPT3,
		topPT4,
		topPT5,
		topPT6],
	triangles=[
	//base
	[5,1,0],
	[4,1,5],
	[4,2,1],
	[3,2,4],	

	//front
	[1,6,0],
	[7,6,1],
	[2,7,1],
	[8,7,2],
	//back
	[11,10,5],
	[5,10,4],
	[10,9,4],
	[4,9,3],	
	//side 1
	[0,11,5],
	[6,11,0],
	//side 2
	[3,8,2],
	[9,8,3],
	//top
	[9,10,8],
	[10,7,8],
	[11,7,10],
	[6,7,11],
	]
	);
}


// this module makes the mounting hole for the Nema 1.7 motor
module steppermount(cx,cy,cz)
{
		//make a hole for the stepper
         		 translate(v=[cx,cy,cz])
          	{
	       		 cylinder(h = 30, r=11.5,$fn =div); // 22mm radius for center on motor
		}
		//bolts are 31 mm spaced from each other

         		 translate(v=[cx+bspace,cy+bspace,cz-10])
          	{
	       		 cylinder(h = 30, r=holerad,$fn =div);
		}	
         		 translate(v=[cx+bspace,cy-bspace,cz-10])
          	{
	       		 cylinder(h = 30, r=holerad,$fn =div);
		}	
         		 translate(v=[cx-bspace,cy+bspace,cz-10])
          	{
	       		 cylinder(h = 30, r=holerad,$fn =div);
		}	
         		 translate(v=[cx-bspace,cy-bspace,cz-10])
          	{
	       		 cylinder(h = 30, r=holerad,$fn =div);
		}	
}

module tube2()
{
	difference()
	{
	union()
	{
		difference()
		{
			union()
			{
				cube([40,tubelength,20],center = true);

				translate(v=[0,0,-15])
				{
					cube([20,tubelength,10],center = true);
				}

				translate(v=[0,0,-27.5 + 5])
				{
					cube([40,tubelength,5],center = true);					
				}

			}
			//create the v-grooves
			translate(v=[-25,0,0])
				vgroove();
			translate(v=[25,0,0])
				vgroove();


			translate(v=[0,0,-12.5])
			{
				cube([10,tubelength,15],center = true);
			}

		}

	}
			//take the center out for the herringbone inlay

		translate(v=[0,0,6.25])
			cube([16.1,tubelength,7.5],center = true);

	}
}

module vgroove()
{
		scale(v=[1,1,2])
		{
			rotate(a= [0,45,0])
			{
				cube([15,tubelength,15],center = true);
			}
		}
}


module shuttle()
{
	difference()
	{
		union()
		{
			
			cube([shuttlewidth,shuttlelength,7.5],center = true); //main base
			translate(v=[-((shuttlewidth/2)-9),0,-5])
				cube([18,shuttlelength,5],center = true); // bearing support right

			translate(v=[((shuttlewidth/2)-4),0,-2.25])
				cube([30,shuttlelength,12],center = true); //bearing support left
		}
				
         		 translate(v=[-((shuttlewidth/2)-10),20,-20]) //mounting hole for shaft for vbearing (right side)
		       		 cylinder(h = 40, r=(v608innerdiam/2));

         		 translate(v=[-((shuttlewidth/2)-10),-20,-20]) //2nd mounting hole for shaft for vbearing (right side)
	       		 cylinder(h = 40, r=(v608innerdiam/2));


			for(n=[8:16]) // create a sliding mounting hole for the left side vbearing
	         		 translate(v=[((shuttlewidth/2)-n),0,-20])
			       		 cylinder(h = 40, r=(v608innerdiam/2));

		translate(v=[0,-5,0]) // taking out the center of the shuttle for the gear
			cube([12,30,15],center = true);

		//now a rail for the gear to slide down
		translate(v=[0,-5,0]) // taking out the center of the shuttle for the gear
			rotate(a=[-22.5,0,0])
				cube([17,5,20],center = true);

		//shave some off the left
		translate(v=[(shuttlewidth/2)+5,0,0]) // taking out the center of the shuttle for the gear
			cube([12,shuttlelength,20],center = true);


		//make the slidemount for attaching the motor mount
		translate(v = [-26.5,5,0])
			rotate(a=[0,0,180])
				slidemount(holerad); //tri pattern

		//make a hole for tightening the vbearing using a bolt
		translate(v = [30,0,-2])
			rotate(a=[0,90,0])
	       		 cylinder(h = 20, r=holerad,$fn = divs);
		
	}
}

vbearingdiam = 27;
vbearingheight = 12;
vbearingshartdiam = 5;// in mm

module vbearing2()
{
	difference()
	{
		union()
		{
//			cylinder(h = (vbearingheight/2), r1 = (vbearingdiam/4), r2 = (vbearingdiam/2),$fn=100, center = true);
			translate(v=[0,0,vbearingheight/2])
				cylinder(h = (vbearingheight/2), r1 = (vbearingdiam/2), r2 = (vbearingdiam/4)+2,$fn=100, center = true);
		}
		translate(v = [0,0,-10])
			cylinder(h = 30,r=(vbearingshartdiam/2),$fn=100);
	}

}

outersleevediam = 22;
vbOD = 30;// v-bearing outside diameter
vbH = 30;// half of vbOD to maintain 45 degree slop

module vbearing()
{
	
	difference()
	{
		union()
		{
			//translate(v=[0,0,-bearingheight/2])
				cylinder(h = vbH,r1 = vbOD/2, r2 =0 ,$fn=divs);
			translate(v=[0,0,-vbH])
				cylinder(h = vbH,r2 = vbOD/2, r1 =0 ,$fn=divs);
		}
		//create a place for the bearing to rest
		translate(v=[0,0,-3]) // move down 3 mm
			cylinder(h = vbH*2,r = ((outersleevediam+1)/2),$fn=divs );

		//make a center hole for the bearing
		translate(v=[0,0,-8]) // move down 3 mm
			cylinder(h = vbH*2,r = 15/2,$fn=divs );
		//cut out he bottom
		translate(v=[0,0,-30])
			cube(size=[30,30,45],center = true);

		//70 mm is the bearing height
	}

}

mmfaceplatewidth = 45;
mmfaceplateheight = 45;
mmfaceplatethick = 5;
mmbasewidth = 40;
mmbaselength = 50;
mmbaseplatethick = 7.5;

module Motormount()
{
	difference()
	{
		union()
		{
			cube([mmbasewidth,mmbaselength,mmbaseplatethick],center = true);
			translate(v=[-17.5,0,23.5])
				cube([mmfaceplatethick,mmfaceplatewidth,mmfaceplateheight],center = true);
		}
		rotate(a=[0,90,0])
			steppermount(-26,0,-28);

		slidemount(holerad);

		translate(v=[0,0,19])
			slidemount(3.5);
	}
	
}

module slidemount(rad)
{
		for(n=[1:10]) //sliding mount hole
	         		 translate(v=[-10,n+8,-20])
			       		 cylinder(h = 40, r=(rad));

			for(n=[1:10]) //sliding mount hole
	         		 translate(v=[-10,(n-14),-20])
			       		 cylinder(h = 40, r=(rad));

			for(n=[1:10]) //sliding mount hole
	         		 translate(v=[5,(n-3),-20])
			       		 cylinder(h = 40, r=(rad));	
}


showtube = 1;
showshuttle = 1;
showbearings =1;
showmotormount =1;
showrack = 1;
showvgroove = 0;

module main()
{
	if(showvgroove==1)
	{
		vgroove();
	}
	if(showtube ==1)
	{
		tube2();
	}	
	if(showrack ==1)
	{
		translate(v =[5.5,0,0.5] )
			myrack();
	}	
	if(showshuttle == 1)
	{
		translate(v=[0,0,17])
			shuttle();
	}
	if(showmotormount == 1)
	{
		rotate(a=[0,0,180])
		translate(v=[27,-5,24.5])
			Motormount();
	}
	if(showbearings == 1)
	{
		translate(v=[30,00,0])
			vbearing();
		translate(v=[-30,20,0])
			vbearing();
		translate(v=[-30,-20,0])
			vbearing();
	}
}

main();
