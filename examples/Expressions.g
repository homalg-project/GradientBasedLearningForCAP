
#! @Chapter Expressions

LoadPackage( "GradientBasedLearningForCAP" );;

#! @Section Examples

#! @Example
e1 := Expression( ["x", "y"], "x + Sin( y )" );
#! x + Sin( y )
e2 := Expression( ["y", "z"], "( y + Sin( z ) ) ^ 2" );
#! (y + Sin( z )) ^ 2
CategoriesOfObject( e1 );
#! [ "IsExtAElement", "IsNearAdditiveElement", "IsNearAdditiveElementWithZero",
#!   "IsNearAdditiveElementWithInverse", "IsAdditiveElement", "IsExtLElement",
#!   "IsExtRElement", "IsMultiplicativeElement", "IsExpression" ]
KnownAttributesOfObject( e1 );
#! [ "String", "Variables" ]
String( e1 );
#! "x + Sin( y )"
Variables( e1 );
#! [ "x", "y" ]
Variables( e2 );
#! [ "y", "z" ]
e1 + e2;
#! x + Sin( y ) + (y + Sin( z )) ^ 2
e1 * e2;
#! (x + Sin( y )) * (y + Sin( z )) ^ 2
e := Sin( e1 ) / e2;
#! Sin( x + Sin( y ) ) / (y + Sin( z )) ^ 2
Variables( e );
#! [ "x", "y", "z" ]
ConstantExpression( "tau" );
#! #I  MakeReadWriteGlobal: tau already read-write
#! tau
Variables( tau );
#! [  ]
e3 := e1 * Sin( tau );
#! (x + Sin( y )) * Sin( tau )
Variables( e3 );
#! [ "x", "y" ]
f := AsFunction( e );
#! function( vec ) ... end
Display( f );
#! function ( vec )
#!     local x, y, z;
#!     Assert( 0, IsDenseList( vec ) and Length( vec ) = 3 );
#!     x := vec[1];
#!     y := vec[2];
#!     z := vec[3];
#!     return Sin( x + Sin( y ) ) / (y + Sin( z )) ^ 2;
#! end
x := [ 3, 2, 4 ];
#! [ 3, 2, 4 ]
f( x );
#! -0.449348
dummy_input := CreateContextualVariables( [ "x1", "x2", "x3" ] );
#! [ x1, x2, x3 ]
f( dummy_input );
#! Sin( x1 + Sin( x2 ) ) / (x2 + Sin( x3 )) ^ 2
AssignExpressions( dummy_input );
#! #I  MakeReadWriteGlobal: x1 already read-write
#! #I  MakeReadWriteGlobal: x2 already read-write
#! #I  MakeReadWriteGlobal: x3 already read-write
x1;
#! x1
Variables( x1 );
#! [ "x1", "x2", "x3" ]
[ [ x1, x2 ] ] * [ [ x3 ], [ -x3 ] ];
#! [ [ x1 * x3 + x2 * (- x3) ] ]
#! @EndExample

#! @Chapter Tools

#! @Section Python Integration

#! @Example
dummy_input := CreateContextualVariables( [ "a", "b", "c" ] );
#! [ a, b, c ]
AssignExpressions( dummy_input );;
#! #I  MakeReadWriteGlobal: a already read-write
#! #I  MakeReadWriteGlobal: b already read-write
#! #I  MakeReadWriteGlobal: c already read-write
e := Sin( a ) + Cos( b );
#! Sin( a ) + Cos( b )
Diff( e, 1 )( dummy_input );
#! Cos( a )
LazyDiff( e, 1 )( dummy_input );
#! Diff( [ "a", "b", "c" ], "(Sin(a))+(Cos(b))", 1 )( [ a, b, c ] )
JacobianMatrixUsingPython( [ a*Cos(b)+Exp(c), a*b*c ], [ 1, 2, 3 ] );
#! [ [ "Cos(b)", "-a*Sin(b)", "Exp(c)" ], [ "b*c", "a*c", "a*b" ] ]
JacobianMatrix(
  [ "a", "b", "c" ],
  [ "a*Cos(b)+Exp(c)", "a*b*c" ],
  [ 1, 2, 3 ] )(dummy_input);
#! [ [ Cos(b), (-a)*Sin(b), Exp(c) ], [ b*c, a*c, a*b ] ]
SimplifyExpressionUsingPython(
  [ "a", "b" ],
  [ "Sin(a)^2 + Cos(a)^2", "Exp(Log(b))" ] );
#! [ "1", "b" ]
LaTeXOutputUsingPython( e );
#! "\\sin{\\left(a \\right)} + \\cos{\\left(b \\right)}"
AsCythonFunction( [[ "x", "y" ], [ "z" ]], ["f", "g"], ["x*y", "Sin(z)"] );;
"""
It will produce output similar to the following lines:
$ cd /tmp/gaptempdirI6rq3l/
$ python
>>> from cython_functions import f, g
>>> w = [ 2, 3 ] # or any other vector in R^2
>>> f(w)
6.0
""";;
#! @EndExample

#! @Example
sigmoid := Expression( [ "x" ], "Exp(x)/(1+Exp(x))" );
#! Exp( x ) / (1 + Exp( x ))
sigmoid := AsFunction( sigmoid );
#! function( vec ) ... end
sigmoid( [ 0 ] );
#! 0.5
points := List( 0.1 * [ -20 .. 20 ], x -> [ x, sigmoid( [ x ] ) ] );
#! [ [ -2., 0.119203 ], [ -1.9, 0.130108 ], [ -1.8, 0.141851 ], [ -1.7, 0.154465 ],
#!   [ -1.6, 0.167982 ], [ -1.5, 0.182426 ], [ -1.4, 0.197816 ], [ -1.3, 0.214165 ],
#!   [ -1.2, 0.231475 ], [ -1.1, 0.24974 ], [ -1., 0.268941 ], [ -0.9, 0.28905 ],
#!   [ -0.8, 0.310026 ], [ -0.7, 0.331812 ],  [ -0.6, 0.354344 ], [ -0.5, 0.377541 ],
#!   [ -0.4, 0.401312 ], [ -0.3, 0.425557 ], [ -0.2, 0.450166 ], [ -0.1, 0.475021 ],
#!   [ 0., 0.5 ], [ 0.1, 0.524979 ], [ 0.2, 0.549834 ], [ 0.3, 0.574443 ],
#!   [ 0.4, 0.598688 ], [ 0.5, 0.622459 ], [ 0.6, 0.645656 ], [ 0.7, 0.668188 ],
#!   [ 0.8, 0.689974 ], [ 0.9, 0.71095 ], [ 1., 0.731059 ], [ 1.1, 0.75026 ],
#!   [ 1.2, 0.768525 ], [ 1.3, 0.785835 ], [ 1.4, 0.802184 ],  [ 1.5, 0.817574 ],
#!   [ 1.6, 0.832018 ], [ 1.7, 0.845535 ], [ 1.8, 0.858149 ], [ 1.9, 0.869892 ],
#!   [ 2., 0.880797 ] ]
labels := List( points, point -> 0 );;
ScatterPlotUsingPython( points, labels : size := "100", action := "save" );;
#! @EndExample

#! @BeginLatexOnly
#! \begin{figure}[ht]
#!     \centering
#!     \includegraphics[width=0.5\textwidth]{sigmoid.png}
#!     \caption{Sigmoid function plot.}
#!     \label{fig:sigmoid}
#! \end{figure}
#! @EndLatexOnly
