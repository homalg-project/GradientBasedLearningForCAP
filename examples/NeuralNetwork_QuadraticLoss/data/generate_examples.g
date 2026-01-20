LoadPackage( "GradientBasedLearningForCAP" );

## we want to approximate these secret perfect weights!
perfect_weights := [ 2, -3, 1 ];

## The input dimension is 2 and the output dimension is 1 --> an example dimension is 2 + 1 = 3.
## Each training example is of the form [x1, x2, y ] where y := 2x1 - 3x2 + 1 + some_error.

nr_examples := 100;

noise := 0.5;

training_examples := [  ];

for j in [ 1 .. nr_examples ] do
    
    x1 := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
    x2 := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
    
    error := Random( [ -0.001, 0.001 ] ) * Random( [ 1 .. 100 ] );
    
    y := perfect_weights[1] * x1 + perfect_weights[2] * x2 + perfect_weights[3] + error;
    
    Add( training_examples, [ x1, x2, y ] );
    
od;

file := Filename( DirectoryCurrent( ), "training_examples.txt" );

PrintTo( file, "[\n" );
for example in training_examples do
    AppendTo( file, example, ",\n" );
od;
AppendTo( file, "]" );

Display( "Done!" );
QUIT;
