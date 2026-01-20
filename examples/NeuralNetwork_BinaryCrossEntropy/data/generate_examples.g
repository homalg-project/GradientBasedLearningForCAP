LoadPackage( "GradientBasedLearningForCAP" );

# create a file for the training dataset

# we have 2 classes in the plan

# class 0:
#!   everything inside the circle: x1^2 + (x2-0.5)^2 - 0.16 = 0
#    i.e., the solutions of: x1^2 + (x2-0.5)^2 - 0.16 <= 0

#    everything below the line: x2 = -0.5,
#    i.e., the solutions of: x2 + 0.5 <= 0.

# class 1: everything else

files_name := "training_examples.txt";
nr_examples := 500;

file := Filename( DirectoryCurrent( ), files_name );

PrintTo( file, "[\n" );

for j in [ 1 .. nr_examples ] do
    
    x1 := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
    x2 := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
    
    if x1^2 + (x2 - 0.5)^2 - 0.16 <= 0. then
        
        label := [ 0 ];
        
    elif x2 + 0.5 <= 0. then
        
        label := [ 0 ];
        
    else
        
        label := [ 1 ];
        
    fi;
    
    AppendTo( file, Concatenation( [ x1, x2 ], label ), ",\n" );
    
od;

AppendTo( file, "];" );


# plotting the dataset
file := Filename( DirectoryCurrent( ), "training_examples.txt" );
data := EvalString( IO_ReadUntilEOF( IO_File( file ) ) );
x := List( data, e -> [ e[1], e[2] ] );
y := List( data, e -> e[3] );
ScatterPlotUsingPython( x, y );

Display( "Done!" );
QUIT;
