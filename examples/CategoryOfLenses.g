#! @Chapter Category of Lenses

#! @Section Examples

LoadPackage( "GradientBasedLearningForCAP" );

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
A := ObjectConstructor( Lenses, [ Smooth.( 1 ), Smooth.( 2 ) ] );
#! (ℝ^1, ℝ^2)
IsWellDefined( A );
#! true
CapCategory( A );
#! CategoryOfLenses( SkeletalSmoothMaps )
A_datum := ObjectDatum( A );
#! [ ℝ^1, ℝ^2 ]
CapCategory( A_datum[1] );
#! SkeletalSmoothMaps
B := ObjectConstructor( Lenses, [ Smooth.( 3 ), Smooth.( 4 ) ] );
#! (ℝ^3, ℝ^4)
get := RandomMorphism( Smooth.( 1 ), Smooth.( 3 ), 5 );
#! ℝ^1 -> ℝ^3
put := RandomMorphism( Smooth.( 1 + 4 ), Smooth.( 2 ), 5 );
#! ℝ^5 -> ℝ^2
f := MorphismConstructor( Lenses, A, [ get, put ], B );
#! (ℝ^1, ℝ^2) -> (ℝ^3, ℝ^4) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^3
#!
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^2
MorphismDatum( f );
#! [ ℝ^1 -> ℝ^3, ℝ^5 -> ℝ^2 ]
IsWellDefined( f );
#! true
Display( f );
#! (ℝ^1, ℝ^2) -> (ℝ^3, ℝ^4) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^3
#!
#! ‣ 0.766 * x1 ^ 4 + 0.234
#! ‣ 1. * x1 ^ 4 + 0.388
#! ‣ 0.459 * x1 ^ 4 + 0.278
#!
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^2
#!
#! ‣ 0.677 * x1 ^ 5 + 0.19 * x2 ^ 4 + 0.659 * x3 ^ 4
#! + 0.859 * x4 ^ 5 + 0.28 * x5 ^ 1 + 0.216
#! ‣ 0.37 * x1 ^ 5 + 0.571 * x2 ^ 4 + 0.835 * x3 ^ 4
#! + 0.773 * x4 ^ 5 + 0.469 * x5 ^ 1 + 0.159
id_A := IdentityMorphism( Lenses, A );
#! (ℝ^1, ℝ^2) -> (ℝ^1, ℝ^2) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^1
#!
#! Put Morphism:
#! ------------
#! ℝ^3 -> ℝ^2
Display( id_A );
#! (ℝ^1, ℝ^2) -> (ℝ^1, ℝ^2) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^1
#!
#! ‣ x1
#!
#! Put Morphism:
#! ------------
#! ℝ^3 -> ℝ^2
#!
#! ‣ x2
#! ‣ x3
IsCongruentForMorphisms( PreCompose( id_A, f ), f );
#! true
TensorUnit( Lenses );
#! (ℝ^0, ℝ^0)
TensorProductOnObjects( A, B );
#! (ℝ^4, ℝ^6)
f1 := RandomMorphism( A, B, 5 );
#! (ℝ^1, ℝ^2) -> (ℝ^3, ℝ^4) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^3
#!
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^2
f2 := RandomMorphism( A, B, 5 );
#! (ℝ^1, ℝ^2) -> (ℝ^3, ℝ^4) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^3
#!
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^2
f3 := RandomMorphism( A, B, 5 );
#! (ℝ^1, ℝ^2) -> (ℝ^3, ℝ^4) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^1 -> ℝ^3
#!
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^2
f1_f2 := TensorProductOnMorphisms( Lenses, f1, f2 );
#! (ℝ^2, ℝ^4) -> (ℝ^6, ℝ^8) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^6
#!
#! Put Morphism:
#! ------------
#! ℝ^10 -> ℝ^4
f2_f3 := TensorProductOnMorphisms( Lenses, f2, f3 );
#! (ℝ^2, ℝ^4) -> (ℝ^6, ℝ^8) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^6
#!
#! Put Morphism:
#! ------------
#! ℝ^10 -> ℝ^4
t1 := TensorProductOnMorphisms( Lenses, f1_f2, f3 );
#! (ℝ^3, ℝ^6) -> (ℝ^9, ℝ^12) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^3 -> ℝ^9
#!
#! Put Morphism:
#! ------------
#! ℝ^15 -> ℝ^6
t2 := TensorProductOnMorphisms( Lenses, f1, f2_f3 );
#! (ℝ^3, ℝ^6) -> (ℝ^9, ℝ^12) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^3 -> ℝ^9
#!
#! Put Morphism:
#! ------------
#! ℝ^15 -> ℝ^6
IsCongruentForMorphisms( t1, t2 );
#! true
Display( Braiding( A, B ) );
#! (ℝ^4, ℝ^6) -> (ℝ^4, ℝ^6) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^4
#!
#! ‣ x2
#! ‣ x3
#! ‣ x4
#! ‣ x1
#!
#! Put Morphism:
#! ------------
#! ℝ^10 -> ℝ^6
#!
#! ‣ x9
#! ‣ x10
#! ‣ x5
#! ‣ x6
#! ‣ x7
#! ‣ x8
Display( PreCompose( Braiding( A, B ), BraidingInverse( A, B ) ) );
#! (ℝ^4, ℝ^6) -> (ℝ^4, ℝ^6) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^4
#!
#! ‣ x1
#! ‣ x2
#! ‣ x3
#! ‣ x4
#!
#! Put Morphism:
#! ------------
#! ℝ^10 -> ℝ^6
#!
#! ‣ x5
#! ‣ x6
#! ‣ x7
#! ‣ x8
#! ‣ x9
#! ‣ x10
#! @EndExample

#! @Section Operations

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
R := ReverseDifferentialLensFunctor( Smooth, Lenses );
#! Embedding functor into category of lenses
SourceOfFunctor( R );
#! SkeletalSmoothMaps
RangeOfFunctor( R );
#! CategoryOfLenses( SkeletalSmoothMaps )
f := DirectProductFunctorial( [ Smooth.Power(3), Smooth.Power(2) ] );
#! ℝ^2 -> ℝ^2
Display( f );
#! ℝ^2 -> ℝ^2
#! 
#! ‣ x1 ^ 3
#! ‣ x2 ^ 2
f := PreCompose( f, Smooth.Sum(2) );
#! ℝ^2 -> ℝ^1
Display( f );
#! ℝ^2 -> ℝ^1
#! 
#! ‣ x1 ^ 3 + x2 ^ 2
Rf := ApplyFunctor( R, f );;
Display( Rf );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^1) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ x1 ^ 3 + x2 ^ 2
#! 
#! Put Morphism:
#! ------------
#! ℝ^3 -> ℝ^2
#! 
#! ‣ x3 * (1 * (3 * x1 ^ 2) + 0)
#! ‣ x3 * (0 + 1 * (2 * x2 ^ 1))
#! @EndExample

#! @Section Optimizers

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
optimizer := Lenses.GradientDescentOptimizer( :learning_rate := 0.01 )( 2 );
#! (ℝ^2, ℝ^2) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! Put Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
dummy_input := [ "theta_1", "theta_2", "g1", "g2" ];;
dummy_input := CreateContextualVariables( dummy_input );
#! [ theta_1, theta_2, g1, g2 ]
Display( optimizer : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ theta_1
#! ‣ theta_2
#! Put Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! ‣ theta_1 + 0.01 * g1
#! ‣ theta_2 + 0.01 * g2
optimizer := Lenses.GradientDescentWithMomentumOptimizer(
            :learning_rate := 0.01, momentum := 0.9 )( 2 );
#! (ℝ^4, ℝ^4) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! Put Morphism:
#! ------------
#! ℝ^6 -> ℝ^4
dummy_input := [ "s1", "s2", "theta_1", "theta_2", "g1", "g2" ];;
dummy_input := CreateContextualVariables( dummy_input );
#! [ s1, s2, theta_1, theta_2, g1, g2 ]
Display( optimizer : dummy_input := dummy_input );
#! (ℝ^4, ℝ^4) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! ‣ theta_1
#! ‣ theta_2
#! Put Morphism:
#! ------------
#! ℝ^6 -> ℝ^4
#! 
#! ‣ 0.9 * s1 + 0.01 * g1
#! ‣ 0.9 * s2 + 0.01 * g2
#! ‣ theta_1 + (0.9 * s1 + 0.01 * g1)
#! ‣ theta_2 + (0.9 * s2 + 0.01 * g2)
optimizer := Lenses.AdagradOptimizer( :learning_rate := 0.01 )( 2 );
#! (ℝ^4, ℝ^4) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! Put Morphism:
#! ------------
#! ℝ^6 -> ℝ^4
Display( optimizer : dummy_input := dummy_input );
#! (ℝ^4, ℝ^4) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! ‣ theta_1
#! ‣ theta_2
#! Put Morphism:
#! ------------
#! ℝ^6 -> ℝ^4
#! 
#! ‣ s1 + g1 ^ 2
#! ‣ s2 + g2 ^ 2
#! ‣ theta_1 + 0.01 * g1 / (1.e-07 + Sqrt( s1 + g1 ^ 2 ))
#! ‣ theta_2 + 0.01 * g2 / (1.e-07 + Sqrt( s2 + g2 ^ 2 ))
optimizer := Lenses.AdamOptimizer(
          :learning_rate := 0.01, beta_1 := 0.9, beta_2 := 0.999 )( 2 );
#! (ℝ^7, ℝ^7) -> (ℝ^2, ℝ^2) defined by:
#!
#! Get Morphism:
#! ------------
#! ℝ^7 -> ℝ^2
#! Put Morphism:
#! ------------
#! ℝ^9 -> ℝ^7
dummy_input :=
  [ "t", "m1", "m2", "v1", "v2", "theta_1", "theta_2", "g1", "g2" ];;
dummy_input := CreateContextualVariables( dummy_input );
#! [ t, m1, m2, v1, v2, theta_1, theta_2, g1, g2 ]
Display( optimizer : dummy_input := dummy_input );
#! (ℝ^7, ℝ^7) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^7 -> ℝ^2
#! 
#! ‣ theta_1
#! ‣ theta_2
#! Put Morphism:
#! ------------
#! ℝ^9 -> ℝ^7
#! 
#! ‣ t + 1
#! ‣ 0.9 * m1 + 0.1 * g1
#! ‣ 0.9 * m2 + 0.1 * g2
#! ‣ 0.999 * v1 + 0.001 * g1 ^ 2
#! ‣ 0.999 * v2 + 0.001 * g2 ^ 2
#! ‣ theta_1 + 0.01 /
#!  (1 - 0.999 ^ t) *
#!     ((0.9 * m1 + 0.1 * g1) /
#!         (1.e-07 + Sqrt( (0.999 * v1 + 0.001 * g1 ^ 2) / (1 - 0.999 ^ t) )))
#! ‣ theta_2 + 0.01 /
#!  (1 - 0.999 ^ t) *
#!     ((0.9 * m2 + 0.1 * g2) /
#!         (1.e-07 + Sqrt( (0.999 * v2 + 0.001 * g2 ^ 2) / (1 - 0.999 ^ t) )))
#! @EndExample
