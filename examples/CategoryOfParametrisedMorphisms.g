#! @Chapter Category of Parametrised Morphisms

#! @Section Examples

LoadPackage( "GradientBasedLearningForCAP" );

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
Display( Para );
#! A CAP category with name CategoryOfParametrisedMorphisms( SkeletalSmoothMaps ):
#!
#! 12 primitive operations were used to derive 21 operations for this category
R1 := Smooth.( 1 );
#! ℝ^1
R2 := Smooth.( 2 );
#! ℝ^2
R3 := Smooth.( 3 );
#! ℝ^3
R1 / Para;
#! ℝ^1
Para.( 1 );
#! ℝ^1
Para.( 1 ) = R1 / Para;
#! true
f := Para.Sin;;
Display( f );
#! ℝ^1 -> ℝ^1 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^0
#!
#! Underlying Morphism:
#! -------------------
#! ℝ^1 -> ℝ^1
#!
#! ‣ Sin( x1 )
p1 := ProjectionInFactorOfDirectProduct( Smooth, [ R3, R3 ], 1 );;
Display( p1 );
#! ℝ^6 -> ℝ^3
#! 
#! ‣ x1
#! ‣ x2
#! ‣ x3
p2 := ProjectionInFactorOfDirectProduct( Smooth, [ R3, R3 ], 2 );;
Display( p2 );
#! ℝ^6 -> ℝ^3
#! 
#! ‣ x4
#! ‣ x5
#! ‣ x6
m := MultiplicationForMorphisms( p1, p2 );
#! ℝ^6 -> ℝ^3
Display( m );
#! ℝ^6 -> ℝ^3
#! 
#! ‣ x1 * x4
#! ‣ x2 * x5
#! ‣ x3 * x6
h := MorphismConstructor( Para, Para.(3), [ R3, m ], Para.(3) );;
Display( h );
#! ℝ^3 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^3
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^6 -> ℝ^3
#! 
#! ‣ x1 * x4
#! ‣ x2 * x5
#! ‣ x3 * x6
dummy_input := CreateContextualVariables(
                  [ "w1", "w2", "w3", "z1", "z2", "z3" ] );
#! [ w1, w2, w3, z1, z2, z3 ]
Display( h : dummy_input := dummy_input );
#! ℝ^3 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^3
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^6 -> ℝ^3
#! 
#! ‣ w1 * z1
#! ‣ w2 * z2
#! ‣ w3 * z3
r := DirectProductFunctorial( Smooth,
        [ Smooth.Sqrt, Smooth.Log, Smooth.Exp ] );;
Display( r );
#! ℝ^3 -> ℝ^3
#!
#! ‣ Sqrt( x1 )
#! ‣ Log( x2 )
#! ‣ Exp( x3 )
g := ReparametriseMorphism( h, r );;
Display( g : dummy_input := dummy_input );
#! ℝ^3 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^3
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^6 -> ℝ^3
#! 
#! ‣ Sqrt( w1 ) * z1
#! ‣ Log( w2 ) * z2
#! ‣ Exp( w3 ) * z3
#! @EndExample

#! Let us illustrate the natural embedding functor from the category of smooth maps into 
#! the category of parametrised morphisms.

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
iota := NaturalEmbedding( Smooth, Para );
#! Natural embedding into category of parametrised morphisms
ApplyFunctor( iota, Smooth.( 1 ) );
#! ℝ^1
psi := ApplyFunctor( iota, Smooth.Sum( 2 ) );
#! ℝ^2 -> ℝ^1 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^0
#!
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^1
Display( psi );
#! ℝ^2 -> ℝ^1 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^0
#!
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^1
#!
#! ‣ x1 + x2
#! @EndExample

#! @Section Available Parametrised Morphisms

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
Display( Para.Relu( 2 ) );
#! ℝ^2 -> ℝ^2 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^0
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^2
#! 
#! ‣ Relu( x1 )
#! ‣ Relu( x2 )
dummy_input := DummyInputForAffineTransformation( 3, 2, "w", "b", "z" );
#! [ w1_1, w2_1, w3_1, b_1, w1_2, w2_2, w3_2, b_2, z1, z2, z3 ]
affine_transformation := Para.AffineTransformation( 3, 2 );;
Display( affine_transformation : dummy_input := dummy_input );
#! ℝ^3 -> ℝ^2 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^8
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^2
#! 
#! ‣ w1_1 * z1 + w2_1 * z2 + w3_1 * z3 + b_1
#! ‣ w1_2 * z1 + w2_2 * z2 + w3_2 * z3 + b_2
"Let us convert these 2 togits to probabilities via softmax layer.";;
softmax_layer := Para.Softmax( 2 );;
Display( softmax_layer );
#! ℝ^2 -> ℝ^2 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^0
#!
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^2
#!
#! ‣ Exp( x1 ) / (Exp( x1 ) + Exp( x2 ))
#! ‣ Exp( x2 ) / (Exp( x1 ) + Exp( x2 ))
probs := PreCompose( affine_transformation, softmax_layer );;
Display( probs : dummy_input := dummy_input );
#! ℝ^3 -> ℝ^2 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^8
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^2
#! 
#! ‣ Exp( w1_1 * z1 + w2_1 * z2 + w3_1 * z3 + b_1 )
#!    / (Exp( w1_1 * z1 + w2_1 * z2 + w3_1 * z3 + b_1 )
#!     + Exp( w1_2 * z1 + w2_2 * z2 + w3_2 * z3 + b_2 ))
#! ‣ Exp( w1_2 * z1 + w2_2 * z2 + w3_2 * z3 + b_2 )
#!    / (Exp( w1_1 * z1 + w2_1 * z2 + w3_1 * z3 + b_1 )
#!     + Exp( w1_2 * z1 + w2_2 * z2 + w3_2 * z3 + b_2 ))
parameters := [ 0.91, 0.24, 0.88, 0.59, 0.67, 0.05, 0.85, 0.31 ];;
logits := [ 1.0, 2.0, 3.0 ];;
Eval( probs, [ parameters, logits ] );
#! [ 0.729088, 0.270912 ]
#! @EndExample
