include <bosl2/std.scad>
include <bosl2/threading.scad>
include <bosl2/walls.scad>
include <bosl2/bottlecaps.scad>


//    $fn=360;


module outer_wall(
    od=50,
    od2=43,
    wall=3,
    height=70,
    length=15,
    count=36
) {
    difference() {
            tube(
                od1=od,
                od2=od2,
                wall=wall,
                l=height-10,
                anchor=BOTTOM
            )
            attach(TOP)
            sp_neck(48,400,2);

        up(15)
        zcopies(n=3, spacing=length+3)
            arc_copies(
                d=od2, 
                n=count
            )
            zrot(90)
            cuboid([2,10,length], anchor=BOTTOM);
        }
}

module inner_wall(
    water_out_diameter=32,
    od2=32,
    wall=3,
    length1=17,
    length2=13,
    count=16
) {
    difference() {
        union() {
            tube(
                od2=water_out_diameter+2*wall,
                od1=od2+2*wall,
                wall=wall,
                l=20,
                anchor=BOTTOM
            )

            attach(BOTTOM, BOTTOM)
                tube(
                    od1=od2+2*wall,
                    od2=2*wall,
                    wall=wall,
                    h=20
                );
        }
        
        
        up(0)
           zrot($idx * 180 / count)
            arc_copies(
                d=water_out_diameter, 
                n=count
            )
            zrot(90)
            prismoid(
                size1=[1,15],
                size2=[3,15],
                h=length1, 
                anchor=BOTTOM
            );
        
        up(22)
           zrot(180 / count)
            arc_copies(
                d=water_out_diameter, 
                n=count
            )
            zrot(90)
            prismoid(
                size1=[0.5,20],
                size2=[2,20],
                h=length2, 
                anchor=BOTTOM
            );
    }   
}

module bottom_part(
    filter_base_h = 1.6,
    thread_h = 12.6,
    space_for_removing = 0.05,
    water_out_diameter = 32,
    filter_diameter=50,
    height=70,
    wall=2
) {


    diff() {
        trapezoidal_threaded_rod(
            d=36, 
            l=thread_h, 
            pitch=4, 
            thread_depth=1.5
        ) {
            tag("remove")
                zcyl(
                    d=water_out_diameter, 
                    l=thread_h+2*space_for_removing
                );
            
            tag("keep")
                attach(TOP)
                tube(
                    h=filter_base_h, 
                    od=filter_diameter, 
                    id=water_out_diameter
                );

            attach(TOP, TOP)
                inner_wall(
                    water_out_diameter=water_out_diameter,
                    od2=water_out_diameter-2,
                    wall=wall,
                    count=9
                );
                
            attach(TOP, BOTTOM)
                outer_wall(
                    od=filter_diameter,
                    wall=wall,
                    height=height,
                    count=17,
                    length=17
                );
        }
    }
}



bottom_part(
    water_out_diameter=28,
    wall=1.5
);