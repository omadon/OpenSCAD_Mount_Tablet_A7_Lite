// Mount for the Samsung Galaxy Tab 7 Lite
// Originally made for: 
//      - Honda CRF 300L Rally
//      - CFMMOTO 450MT
// Version 1.1.0
// 小熊维尼 - Winnie the Pooh
// 赤城 - Akagi

$fn = 250;

CENTER_X = 106.5;
CENTER_Y = 62.5;

module InitialMount() {
    import("A7_Lite_Mount_no_camera.stl",convexity=3);
}

module Logo1() {
    linear_extrude(5)
    scale(.5)
    import(file = "450mt.svg", center = true, dpi = 300);
}

module Text1() {
    linear_extrude(5)
    scale(0.5)
    text("小熊维尼", font="Arial Unicode MS:style=Regular");
}

module CenterCube() {
    x=55;
    y=125;
    z=5;
    translate([CENTER_X - x/2,0,0])cube([x, y ,z]);
}
module TopCube(){
    x=155;
    y=15;
    z=5;
    translate([29,125-y,0])cube([x, y ,z]);
}
module PortCube(){
    union() {
        translate([213,54.5,0])cube([3, 7 ,5]);
        translate([212,54.5,5])cube([4, 7, 8]);
    }
}
module Mount() {
    union() {
        InitialMount();
        CenterCube();
        TopCube();
        //PortCube();
    }
}

module Screw() {
    SCREW_DIAMETER = 4.2;
    SCREW_HEIGHT = 5.1;
    CONE_HEIGHT = 2.5; // 2.14
    CONE_BOTTOM_DIAMETER = 4.8; // 4.2
    CONE_TOP_DIAMETER = 8.4; // 7.84
    union() {
        translate([0, 0, -0.05])cylinder(d=SCREW_DIAMETER, h=SCREW_HEIGHT, center=false);
        translate([0, 0, SCREW_HEIGHT-CONE_HEIGHT - 0.05])cylinder(h=CONE_HEIGHT, d1=CONE_BOTTOM_DIAMETER, d2=CONE_TOP_DIAMETER);
    }
}
module ScrewsAMPS(X=38, Y=30) {
    // AMPS standard is 38mm x 30mm
    translate([0, 0, 0])Screw();
    translate([X, 0, 0])Screw();
    translate([0, Y, 0])Screw();
    translate([X, Y, 0])Screw();
}

module FinalMount() {
    offset = 35;
    AMPS_X = 38;
    AMPS_Y = 30;
    //InitialMount();
    //CenterCube();
    //TopCube();
    //Text1();
    //translate([CENTER_X, CENTER_Y+40,4])color("red")Logo1();
    //translate([CENTER_X-14, CENTER_Y-15,4])color("red")Text1();
    difference() { 
        Mount();
        PortCube();
        //Center dot for positioning
        //translate([CENTER_X, CENTER_Y, 0])color("red")cylinder(5.1,1,1);
        translate([CENTER_X, CENTER_Y+40, 4.0])color("red")Logo1();
        translate([CENTER_X-14, CENTER_Y-15,4.0])color("red")Text1();
        translate([CENTER_X-AMPS_X/2, offset, 0])color("red")ScrewsAMPS(AMPS_X, AMPS_Y);
        translate([CENTER_X-AMPS_X/2, offset + AMPS_Y/2, 0])color("red")ScrewsAMPS(AMPS_X, AMPS_Y);
        translate([CENTER_X-AMPS_X/2, offset - AMPS_Y/2, 0])color("red")ScrewsAMPS(AMPS_X, AMPS_Y);
    }
}

FinalMount();