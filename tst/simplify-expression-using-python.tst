#############################################################################
# Tests for SimplifyExpressionUsingPython
#############################################################################

gap> LoadPackage( "GradientBasedLearningForCAP" );
true

gap> vars := [ "x1", "x2", "x3" ];;

gap> exprs := [
>   "x1 + 0",
>   "0 + x2",
>   "x1 * 1",
>   "1 * x2",
>   "x1 - x1",
>   "x1^2 * x1^3",
>   "Exp(Log(x1))",
>   "Sin(x1)^2 + Cos(x1)^2",
>   "Relu(x1)" ];;

gap> out := SimplifyExpressionUsingPython( vars, exprs );;
gap> Assert( 0, IsDenseList( out ) );
gap> Assert( 0, Length( out ) = Length( exprs ) );
gap> Assert( 0, ForAll( out, IsString ) );

# Spot checks that are stable across SymPy versions.
gap> Assert( 0, out[1] = "x1" );
gap> Assert( 0, out[2] = "x2" );
gap> Assert( 0, out[3] = "x1" );
gap> Assert( 0, out[4] = "x2" );
gap> Assert( 0, out[5] = "0" );
gap> Assert( 0, out[6] in [ "x1**5", "x1^5" ] );
gap> Assert( 0, out[8] in [ "1", "1.0" ] );

# Expressions containing Diff are intentionally not passed through python and must be preserved.
gap> exprs2 := [ "Diff( [\"x1\"], \"x1^2\", 1 )( [x1] )", "x1 + 0" ];;
gap> out2 := SimplifyExpressionUsingPython( ["x1"], exprs2 );;
gap> Assert( 0, out2[1] = exprs2[1] );
gap> Assert( 0, out2[2] = "x1" );

# A small randomized batch: ensure it returns without error and preserves length.
gap> RandSeed := 12345;;
gap> RandomSource( IsMersenneTwister, RandSeed );;
gap> ops := [ "+", "-", "*" ];;
gap> rand_exprs := List( [ 1 .. 20 ], i ->
>   Concatenation(
>     "(",
>     Random( vars ),
>     Random( ops ),
>     String( Random( [ 0, 1, 2, 3 ] ) ),
>     ")",
>     Random( ops ),
>     "(",
>     Random( vars ),
>     Random( ops ),
>     "0",
>     ")" ) );;
gap> rand_out := SimplifyExpressionUsingPython( vars, rand_exprs );;
gap> Assert( 0, Length( rand_out ) = Length( rand_exprs ) );
gap> Assert( 0, ForAll( rand_out, IsString ) );
