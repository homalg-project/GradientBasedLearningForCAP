LoadPackage( "GradientBasedLearningForCAP" );

# create a file for the training dataset

# we have 3 classes in the plan

# class 0 ~ [1, 0, 0]:
#!   everything inside the circle: x1^2 + (x2-0.5)^2 - 0.16 = 0
#    i.e., the solutions of: x1^2 + (x2-0.5)^2 - 0.16 <= 0
# class 1 ~ [0, 1, 0]:
#    everything below the line: x2 = -0.5,
#    i.e., the solutions of: x2 + 0.5 <= 0
# class 2 ~ [0, 0, 1]: everything else


nr_examples := 500;
nr_examples_per_class := Int( nr_examples / 3 );

class_0_count := 0;
class_1_count := 0;
class_2_count := 0;

training_examples := [ ];

while class_0_count < nr_examples_per_class do
      x := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      y := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      if x^2 + (y - 0.5)^2 - 0.16 <= 0. then
          Add( training_examples, Concatenation( [ x, y ], [ 1, 0, 0 ] ) );
          class_0_count := class_0_count + 1;
      fi;
od;;

while class_1_count < nr_examples_per_class do
      x := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      y := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      if y + 0.5 <= 0. then
          Add( training_examples, Concatenation( [ x, y ], [ 0, 1, 0 ] ) );
          class_1_count := class_1_count + 1;
      fi;
od;;

while class_2_count < nr_examples_per_class do
      x := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      y := Random( [ -0.01, 0.01 ] ) * Random( [ 1 .. 100 ] );
      if not ( x^2 + (y - 0.5)^2 - 0.16 <= 0. or y + 0.5 <= 0. ) then
          Add( training_examples, Concatenation( [ x, y ], [ 0, 0, 1 ] ) );
          class_2_count := class_2_count + 1;
      fi;
od;;


# shuffle the training examples
training_examples := Shuffle( training_examples );

# write the training examples to a file
files_name := "training_examples.txt";
file := Filename( DirectoryCurrent( ), files_name );

PrintTo( file, "[\n" );
for example in training_examples do
    AppendTo( file, example, ",\n" );
od;
AppendTo( file, "];" );

# plotting the dataset
file := Filename( DirectoryCurrent( ), files_name );
data := EvalString( IO_ReadUntilEOF( IO_File( file ) ) );
x := List( data, e -> [ e[1], e[2] ] );
y := List( data, e -> Position( e{[3,4,5]}, 1 ) - 1 );
ScatterPlotUsingPython( x, y );

Display( "Done!" );
QUIT;
