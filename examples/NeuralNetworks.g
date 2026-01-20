#! @Chapter Neural Networks

#! @Section Examples

LoadPackage( "GradientBasedLearningForCAP" );

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
N213_Logits := NeuralNetworkLogitsMorphism( Para, 2, [ 1 ], 3 );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
dummy_input := DummyInputForNeuralNetwork( 2, [ 1 ], 3 );
#! [ w2_1_1, b2_1, w2_1_2, b2_2, w2_1_3, b2_3, w1_1_1, w1_2_1, b1_1, z1, z2 ]
Display( N213_Logits : dummy_input := dummy_input );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
#! 
#! ‣ w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1
#! ‣ w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2
#! ‣ w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3
N213_Pred := NeuralNetworkPredictionMorphism( Para, 2, [ 1 ], 3, "IdFunc" );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
N213_Pred = N213_Logits;
#! true
N213_Loss := NeuralNetworkLossMorphism( Para, 2, [ 1 ], 3, "IdFunc" );
#! ℝ^5 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^14 -> ℝ^1
vars := Concatenation(
                DummyInputStringsForNeuralNetwork( 2, [ 1 ], 3 ),
                DummyInputStrings( "y", 3 ) );
#! [ "w2_1_1", "b2_1", "w2_1_2", "b2_2", "w2_1_3", "b2_3", "w1_1_1", "w1_2_1", 
#!   "b1_1", "z1", "z2", "y1", "y2", "y3" ]
dummy_input := CreateContextualVariables( vars );
#! [ w2_1_1, b2_1, w2_1_2, b2_2, w2_1_3, b2_3, w1_1_1, w1_2_1, b1_1, z1, z2,
#!   y1, y2, y3 ]
Display( N213_Loss : dummy_input := dummy_input );
#! ℝ^5 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^14 -> ℝ^1
#! 
#! ‣ ((w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 - y1) ^ 2
#!    + (w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 - y2) ^ 2
#!    + (w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 - y3) ^ 2) / 3
#! @EndExample

#! @BeginExample
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
N213_Logits := NeuralNetworkLogitsMorphism( Para, 1, [ ], 1 );
#! ℝ^1 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^3 -> ℝ^1
dummy_input := DummyInputForNeuralNetwork( 1, [ ], 1 );
#! [ w1_1_1, b1_1, z1 ]
Display( N213_Logits : dummy_input := dummy_input );
#! ℝ^1 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^3 -> ℝ^1
#! 
#! ‣ w1_1_1 * z1 + b1_1
N213_Pred := PreCompose( N213_Logits, Para.Sigmoid( 1 ) );
#! ℝ^1 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^3 -> ℝ^1
N213_Pred = NeuralNetworkPredictionMorphism( Para, 1, [ ], 1, "Sigmoid" );
#! true
Display( N213_Pred : dummy_input := dummy_input );
#! ℝ^1 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^3 -> ℝ^1
#! 
#! ‣ 1 / (1 + Exp( - (w1_1_1 * z1 + b1_1) ))
N213_Loss := NeuralNetworkLossMorphism( Para, 1, [ ], 1, "Sigmoid" );
#! ℝ^2 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^4 -> ℝ^1
vars := Concatenation(
                DummyInputStringsForNeuralNetwork( 1, [ ], 1 ),
                [ "y1" ] );
#! [ "w1_1_1", "b1_1", "z1", "y1" ]
dummy_input := CreateContextualVariables( vars );
#! [ w1_1_1, b1_1, z1, y1 ]
Display( N213_Loss : dummy_input := dummy_input );
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
#! ‣ Log( 1 + Exp( - (w1_1_1 * z1 + b1_1) ) ) + (1 - y1) * (w1_1_1 * z1 + b1_1)
#! @EndExample

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
N213_Logits := NeuralNetworkLogitsMorphism( Para, 2, [ 1 ], 3 );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
dummy_input := DummyInputForNeuralNetwork( 2, [ 1 ], 3 );
#! [ w2_1_1, b2_1, w2_1_2, b2_2, w2_1_3, b2_3, w1_1_1, w1_2_1, b1_1, z1, z2 ]
Display( N213_Logits : dummy_input := dummy_input );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
#! 
#! ‣ w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1
#! ‣ w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2
#! ‣ w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3
N213_Pred := PreCompose( N213_Logits, Para.Softmax( 3 ) );
#! ℝ^2 -> ℝ^3 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
N213_Pred = NeuralNetworkPredictionMorphism( Para, 2, [ 1 ], 3, "Softmax" );
#! true
Display( N213_Pred : dummy_input := dummy_input );
#! ℝ^2 -> ℝ^3 defined by:
#!
#! Underlying Object:
#! -----------------
#! ℝ^9
#!
#! Underlying Morphism:
#! -------------------
#! ℝ^11 -> ℝ^3
#! ‣ Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 )
#!   / (Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 )
#!      + Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 )
#!        + Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 ))
#! ‣ Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 )
#!   / (Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 )
#!      + Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 )
#!        + Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 ))
#! ‣ Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 )
#!   / (Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 )
#!      + Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 )
#!        + Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 ))
N213_Loss := NeuralNetworkLossMorphism( Para, 2, [ 1 ], 3, "Softmax" );
#! ℝ^5 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^14 -> ℝ^1
vars := Concatenation(
                DummyInputStringsForNeuralNetwork( 2, [ 1 ], 3 ),
                DummyInputStrings( "y", 3 ) );
#! [ "w2_1_1", "b2_1", "w2_1_2", "b2_2", "w2_1_3", "b2_3", "w1_1_1", "w1_2_1", 
#!   "b1_1", "z1", "z2", "y1", "y2", "y3" ]
dummy_input := CreateContextualVariables( vars );
#! [ w2_1_1, b2_1, w2_1_2, b2_2, w2_1_3, b2_3, w1_1_1, w1_2_1, b1_1, z1, z2,
#!   y1, y2, y3 ]
Display( N213_Loss : dummy_input := dummy_input );
#! ℝ^5 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^9
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^14 -> ℝ^1
#! 
#! ‣ (
#!     (
#!       Log(
#!         Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 ) +
#!         Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 ) +
#!         Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 )
#!       )
#!       - (w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1)
#!     ) * y1 +
#!     (
#!       Log( Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 ) +
#!            Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 ) +
#!            Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 )
#!       )
#!       - (w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2)
#!     ) * y2
#!     +
#!     (
#!       Log( Exp( w2_1_1 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_1 ) +
#!            Exp( w2_1_2 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_2 ) +
#!            Exp( w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3 )
#!       )
#!       - (w2_1_3 * Relu( w1_1_1 * z1 + w1_2_1 * z2 + b1_1 ) + b2_3)
#!     ) * y3
#!   ) / 3
#! @EndExample
