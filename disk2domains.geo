cl__1 = 1;

Include "disk2domains.dat";

Point(1)  = {x_min, 	    y_min, 	   0, inf_step};
Point(2)  = {x_min, 	    y_max, 	   0, inf_step};
Point(3)  = {x_max,         y_max, 	   0, inf_step};
Point(4)  = {x_max, 	    y_min, 	   0, inf_step};
Point(5)  = {x_min,         y_min+y_width, 0, step};
Point(6)  = {x_max-x_width, y_min+y_width, 0, step};
Point(7)  = {x_max-x_width, y_max-y_width, 0, step};
Point(8)  = {x_min, 	    y_max-y_width, 0, step};
Point(9)  = {x_min,         disk_y,        0, disk_step};
Point(10) = {disk_radius,   disk_y, 	   0, disk_step};
Point(11) = {x_min, 	    0, 		   0, division_step};
Point(12) = {x_max-x_width, 0, 		   0, division_step};
Point(13) = {x_max, 	    0, 		   0, inf_step};

Line(1) = {8, 9};
Line(3) = {9, 10};
Line(5) = {1, 5};
Line(6) = {5, 6};
Line(7) = {1, 4};
Line(8) = {4, 6};
Line(10) = {7, 3};
Line(12) = {2, 8};
Line(13) = {8, 7};
Line(14) = {3, 2};
Line(24) = {11, 5};
Line(25) = {6, 12};
Line(26) = {12, 11};
Line(27) = {4, 13};
Line(28) = {13, 12};
Line(29) = {13, 3};
Line(30) = {7, 12};
Line(31) = {9, 11};

Line Loop(16) = {12, 13, 10, 14};
Plane Surface(16) = {16};
Line Loop(20) = {-6, -5, 7, 8};
Plane Surface(20) = {20};
Line Loop(32) = {24, 6, 25, 26};
Plane Surface(33) = {32};
Line Loop(34) = {28, -25, -8, 27};
Plane Surface(35) = {34};
Line Loop(36) = {30, -28, 29, -10};
Plane Surface(37) = {36};
Line Loop(38) = {-13, 1, 3, -3, 31, -26, -30};
Plane Surface(39) = {38};

Physical Line(AXISY) = {12, 1, 31, 4, 5};
Physical Line(BNDINF) = {14, 29, 27, 7};
Physical Line(DISK) = {3};
Physical Surface(DOMAIN1) = {39};
Physical Surface(DOMAIN2) = {33};
Physical Surface(INFY1) = {16};
Physical Surface(INFY2) = {20};
Physical Surface(INFX1) = {37};
Physical Surface(INFX2) = {35};

