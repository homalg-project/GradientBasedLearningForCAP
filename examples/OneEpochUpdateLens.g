#! @Chapter Fitting Parameters

#! @Section Examples

LoadPackage( "GradientBasedLearningForCAP" );

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
D := [ Smooth.1, Smooth.1, Smooth.1, Smooth.1 ];
#! [ ℝ^1, ℝ^1, ℝ^1, ℝ^1 ]
p1 := ProjectionInFactorOfDirectProduct( Smooth, D, 1 );
#! ℝ^4 -> ℝ^1
p2 := ProjectionInFactorOfDirectProduct( Smooth, D, 2 );
#! ℝ^4 -> ℝ^1
p3 := ProjectionInFactorOfDirectProduct( Smooth, D, 3 );
#! ℝ^4 -> ℝ^1
p4 := ProjectionInFactorOfDirectProduct( Smooth, D, 4 );
#! ℝ^4 -> ℝ^1
f := PreCompose( (p3 - p1), Smooth.Power(2) )
        + PreCompose( (p4 - p2), Smooth.Power(2) );
#! ℝ^4 -> ℝ^1
dummy_input := CreateContextualVariables( [ "theta_1", "theta_2", "x1", "x2" ] );
#! [ theta_1, theta_2, x1, x2 ]
Display( f : dummy_input := dummy_input );
#! ℝ^4 -> ℝ^1
#! 
#! ‣ (x1 + (- theta_1)) ^ 2 + (x2 + (- theta_2)) ^ 2
f := MorphismConstructor( Para, Para.2, [ Smooth.2, f ], Para.1 );
#! ℝ^2 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^4 -> ℝ^1
Display( f : dummy_input := dummy_input );
#! ℝ^2 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^4 -> ℝ^1
#! 
#! ‣ (x1 + (- theta_1)) ^ 2 + (x2 + (- theta_2)) ^ 2
optimizer := Lenses.GradientDescentOptimizer( :learning_rate := 0.01 );
#! function( n ) ... end
dummy_input := CreateContextualVariables( [ "theta_1", "theta_2", "g1", "g2" ] );
#! [ theta_1, theta_2, g1, g2 ]
Display( optimizer( 2 ) : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^2, ℝ^2) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ theta_1
#! ‣ theta_2
#! 
#! Put Morphism:
#! ------------
#! ℝ^4 -> ℝ^2
#! 
#! ‣ theta_1 + 0.01 * g1
#! ‣ theta_2 + 0.01 * g2
update_lens_1 := OneEpochUpdateLens( f, optimizer, [ [ 1, 2 ] ], 1 );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
dummy_input := CreateContextualVariables( [ "theta_1", "theta_2" ] );
#! [ theta_1, theta_2 ]
Display( update_lens_1 : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ ((1 + (- theta_1)) ^ 2 + (2 + (- theta_2)) ^ 2) / 1 / 1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ theta_1 + 0.01 * (-1 * (0 + 0 + (1 * ((2 * (1 + (- theta_1)) ^ 1 * -1 + 0) * 1 
#!   + 0 + 0 + 0) * 1 + 0 + 0 + 0) * 1 + 0))
#! ‣ theta_2 + 0.01 * (-1 * (0 + 0 + 0 + (0 + 1 * (0 +
#!   (0 + 2 * (2 + (- theta_2)) ^ 1 * -1) * 1 + 0 + 0) * 1 + 0 + 0) * 1))
update_lens_1 := SimplifyMorphism( update_lens_1, infinity );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
Display( update_lens_1 : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ (theta_1 - 1) ^ 2 + (theta_2 - 2) ^ 2
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ 0.98 * theta_1 + 0.02
#! ‣ 0.98 * theta_2 + 0.04
update_lens_2 := OneEpochUpdateLens( f, optimizer, [ [ 3, 4 ] ], 1 );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
Display( update_lens_2 : dummy_input := dummy_input );
#!
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#!
#! ‣ ((3 + (- theta_1)) ^ 2 + (4 + (- theta_2)) ^ 2) / 1 / 1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ theta_1 + 0.01 * (-1 * (0 + 0 + (1 * ((2 * (3 + (- theta_1)) ^ 1 * -1 + 0) * 1 
#! + 0 + 0 + 0) * 1 + 0 + 0 + 0) * 1 + 0))
#! ‣ theta_2 + 0.01 * (-1 * (0 + 0 + 0 + (0 + 1 * (0 +
#! (0 + 2 * (4 + (- theta_2)) ^ 1 * -1) * 1 + 0 + 0) * 1 + 0 + 0) * 1))
update_lens_2 := SimplifyMorphism( update_lens_2, infinity );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
Display( update_lens_2 : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ (theta_1 - 3) ^ 2 + (theta_2 - 4) ^ 2
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ 0.98 * theta_1 + 0.06
#! ‣ 0.98 * theta_2 + 0.08
update_lens := OneEpochUpdateLens( f, optimizer, [ [ 1, 2 ], [ 3, 4 ] ], 1 );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
Display( update_lens : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ (
#!     ((1 + (- theta_1)) ^ 2 + (2 + (- theta_2)) ^ 2) / 1 +
#!     ((3 + (- theta_1)) ^ 2 + (4 + (- theta_2)) ^ 2) / 1
#!   ) / 2
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ theta_1 + 0.01 * (-1 * (0 + 0 + (1 * ((2 * (1 + (- theta_1)) ^ 1 * -1 + 0) * 1
#!   + 0 + 0 + 0) * 1 + 0 + 0 + 0) * 1 + 0)) + 0.01 * (-1 * (0 + 0 +
#!   (1 * ((2 * (3 + (- (theta_1 + 0.01 * (-1 * (0 + 0 +
#!   (1 * ((2 * (1 + (- theta_1)) ^ 1 * -1 + 0) * 1 + 0 + 0 + 0) * 1
#!   + 0 + 0 + 0) * 1 + 0))))) ^ 1 * -1 + 0) * 1 + 0 + 0 + 0) * 1 + 0 + 0 + 0) * 1 
#!   + 0))
#! ‣ theta_2 + 0.01 * (-1 * (0 + 0 + 0 + (0 + 1 * (0 + (0 + 2 * (2 + 
#!   (- theta_2)) ^ 1 * -1) * 1 + 0 + 0) * 1 + 0 + 0) * 1)) + 0.01
#!   * (-1 * (0 + 0 + 0 + (0 + 1 * (0 + (0 + 2 * (4 +
#!   (- (theta_2 + 0.01 * (-1 * (0 + 0 + 0 + (0 + 1 * (0 + (0 + 2 * (2 +
#!   (- theta_2)) ^ 1 * -1) * 1 + 0 + 0) * 1 + 0 + 0) * 1))))) ^ 1 * -1) * 1 
#!   + 0 + 0) * 1 + 0 + 0) * 1))
update_lens := SimplifyMorphism( update_lens, infinity );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
Display( update_lens : dummy_input := dummy_input );
#! (ℝ^2, ℝ^2) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ theta_1 ^ 2 - 4 * theta_1 + theta_2 ^ 2 - 6 * theta_2 + 15
#! 
#! Put Morphism:
#! ------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ 0.9604 * theta_1 + 0.0796
#! ‣ 0.9604 * theta_2 + 0.1192
"If we used only update_lens_1, the parameters converge to (1,2)";;
theta := [ 0, 0 ];;
for i in [ 1 .. 1000 ] do theta := PutMorphism( update_lens_1 )( theta ); od;
theta;
#! [ 1., 2. ]
"If we used only update_lens_2, the parameters converge to (3,4)";;
theta := [ 0, 0 ];;
for i in [ 1 .. 1000 ] do theta := PutMorphism( update_lens_2 )( theta ); od;
theta;
#! [ 3., 4. ]
"If we use the combined update_lens, the parameters converge to (2,3)";;
theta := [ 0, 0 ];;
for i in [ 1 .. 1000 ] do theta := PutMorphism( update_lens )( theta ); od;
theta;
#! [ 2.0101, 3.0101 ]
"Inseated of manually applying the put-morphism, we can use the Fit operation:";;
"For example, to fit theta = (0,0) using 10 epochs:";;
theta := [ 0, 0 ];;
theta := Fit( update_lens, 10, theta );
#! Epoch  0/10 - loss = 15
#! Epoch  1/10 - loss = 13.9869448
#! Epoch  2/10 - loss = 13.052687681213568
#! Epoch  3/10 - loss = 12.19110535502379
#! Epoch  4/10 - loss = 11.39655013449986
#! Epoch  5/10 - loss = 10.663813003077919
#! Epoch  6/10 - loss = 9.9880895506637923
#! Epoch  7/10 - loss = 9.3649485545394704
#! Epoch  8/10 - loss = 8.790302999738083
#! Epoch  9/10 - loss = 8.2603833494932317
#! Epoch 10/10 - loss = 7.7717128910720641
#! [ 0.668142, 1.00053 ]
#! @EndExample


#! Let us in this example find a solution to the equation $\theta^3-\theta^2-4=0$. We can reframe this 
#! as a minimization problem by considering the parametrised morphism
#! $(\mathbb{R}^1, f):\mathbb{R}^0 \to \mathbb{R}^1$ where $f(\theta) = (\theta^3-\theta^2-4)^2$.

#! @BeginExample
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
f := Smooth.Power( 3 ) - Smooth.Power( 2 ) - Smooth.Constant([ 4 ]);
#! ℝ^1 -> ℝ^1
Display( f );
#! ℝ^1 -> ℝ^1
#! ‣ x1 ^ 3 + (- x1 ^ 2) + - 4
f := PreCompose( f, Smooth.Power( 2 ) );
#! ℝ^1 -> ℝ^1
Display( f );
#! ℝ^1 -> ℝ^1
#! 
#! ‣ (x1 ^ 3 + (- x1 ^ 2) + - 4) ^ 2
f := MorphismConstructor( Para, Para.0, [ Smooth.1, f ], Para.1 );
#! ℝ^0 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^1
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^1 -> ℝ^1
dummy_input := CreateContextualVariables( [ "theta" ] );
#! [ theta ]
Display( f : dummy_input := dummy_input );
#! ℝ^0 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^1
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^1 -> ℝ^1
#! 
#! ‣ (theta ^ 3 + (- theta ^ 2) + -4) ^ 2
optimizer := Lenses.AdamOptimizer( :learning_rate := 0.01,
                beta1 := 0.9, beta2 := 0.999, epsilon := 1.e-7 );
#! function( n ) ... end
dummy_input := CreateContextualVariables( [ "t", "m", "v", "theta", "g" ] );
#! [ t, m, v, theta, g ]
Display( optimizer( 1 ) : dummy_input := dummy_input );
#! (ℝ^4, ℝ^4) -> (ℝ^1, ℝ^1) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^1
#! 
#! ‣ theta
#! 
#! Put Morphism:
#! ------------
#! ℝ^5 -> ℝ^4
#! 
#! ‣ t + 1
#! ‣ 0.9 * m + 0.1 * g
#! ‣ 0.999 * v + 0.001 * g ^ 2
#! ‣ theta + 0.01 / (1 - 0.999 ^ t) * ((0.9 * m + 0.1 * g) /
#! (1.e-07 + Sqrt( (0.999 * v + 0.001 * g ^ 2) / (1 - 0.999 ^ t) )))
update_lens := OneEpochUpdateLens( f, optimizer, [ [ ] ], 1 );
#! (ℝ^4, ℝ^4) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^4 -> ℝ^4
dummy_input := CreateContextualVariables( [ "t", "m", "v", "theta" ] );
#! [ t, m, v, theta ]
Display( update_lens : dummy_input := dummy_input );
#! (ℝ^4, ℝ^4) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^4 -> ℝ^1
#! 
#! ‣ (theta ^ 3 + (- theta ^ 2) + -4) ^ 2 / 1 / 1
#! 
#! Put Morphism:
#! ------------
#! ℝ^4 -> ℝ^4
#! 
#! ‣ t + 1
#! ‣ 0.9 * m + 0.1 * (-1 * (1 * (2 * (theta ^ 3 + (- theta ^ 2) + -4) ^ 1 *
#!   (3 * theta ^ 2 + (- 2 * theta ^ 1)) * 1) * 1 * 1))
#! ‣ 0.999 * v + 0.001 * (-1 * (1 * (2 * (theta ^ 3 + (- theta ^ 2) + -4) ^ 1 *
#!   (3 * theta ^ 2 + (- 2 * theta ^ 1)) * 1) * 1 * 1)) ^ 2
#! ‣ theta + 0.01 / (1 - 0.999 ^ t) * ((0.9 * m + 0.1 *
#!   (-1 * (1 * (2 * (theta ^ 3 + (- theta ^ 2) + -4) ^ 1 * 
#!   (3 * theta ^ 2 + (- 2 * theta ^ 1)) * 1) * 1 * 1))) /
#!   (1.e-07 + Sqrt( (0.999 * v + 0.001 * (-1 * (1 * (2 *
#!   (theta ^ 3 + (- theta ^ 2) + -4) ^ 1 * (3 * theta ^ 2 + (- 2 * theta ^ 1)) * 1)
#!   * 1 * 1)) ^ 2) / (1 - 0.999 ^ t) )))
Fit( update_lens, 10000, [ 1, 0, 0, 8 ] : verbose := false );
#! [ 10001, 4.11498e-13, 1463.45, 2. ]
UnderlyingMorphism( f )( [ 2. ] );
#! [ 0. ]
#! @EndExample
