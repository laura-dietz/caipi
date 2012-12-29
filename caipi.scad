hand=true;
handle=true;
thorns=true;

diam=25;
handheight=11;
handlelength=100;
tR=4;
tH=5;
thornN = 5;


tW = 2*tR;
thornTrans = tW*thornN/2;

module thorn() {
	polyhedron(
  	points=[ [tR,tR,0],[tR,-tR,0],[-tR,-tR,0],[-tR,tR,0], // the four points at base
           [0,0,tH]  ],                                 // the apex point 
  	triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
	 );
}


// hand part
if(hand) difference() {

	translate([0,0,handheight]) difference() {
		color("blue")  sphere(r=diam/2);
		translate([0,0,diam/4]) cube([diam,diam,diam/2],center=true); // cut off top half
	}
	translate([0,0,-handheight]) cube([diam,diam,diam],center=true); //scrape off bottom
}


// handle

if(handle) translate([0,0,handheight]) color("red") cylinder(h=handlelength,r=diam/2);

// thorns



if(thorns) {
    translate([0,0, (handlelength+handheight)]) 
	intersection() {
 	    translate([-thornTrans, -thornTrans, 0]) {
			for (x = [0 : thornN]){
 				for(y = [0:thornN]){
					translate([x*tW, y*tW,0]) thorn();
				}
			}
	      }
		cylinder(h=diam,r=diam/2);
	}
}
