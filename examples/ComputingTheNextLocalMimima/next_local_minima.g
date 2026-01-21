#! @Chapter Examples

#! @Section Next Local Minima

#! In this example we demonstrate how to use the fitting machinery of
#! $\texttt{GradientBasedLearningForCAP}$ to find a nearby local minimum of a smooth
#! function by gradient-based optimisation.
#!
#! We consider the function
#! @BeginLatexOnly
#! \[
#! f(\theta_1,\theta_2) = \sin(\theta_1)^2 + \log(\theta_2)^2,
#! \]
#! @EndLatexOnly
#! which has local minima at the points $(\pi k, 1)$ for $k \in \mathbb{Z}$.
#! We use the Adam optimiser to find a local minimum starting from an initial point.
#! Hence, the parameter vector is of the form
#! @BeginLatexOnly
#! \[
#! w = (t, m_1, m_2, v_1, v_2, \theta_1, \theta_2),
#! \]
#! @EndLatexOnly
#! where $t$ is the time step, $m_1$ and $m_2$ are the first moment estimates for
#! $\theta_1$ and $\theta_2$ respectively, and $v_1$ and $v_2$ are the second moment
#! estimates for $\theta_1$ and $\theta_2$ respectively.
#! We start from the initial point
#! @BeginLatexOnly
#! \[
#! w = (1, 0, 0, 0, 0, 1.58, 0.1),
#! \]
#! @EndLatexOnly
#! which is close to the local minimum at $(\pi, 1)$.
#! After running the optimisation for $500$ epochs, we reach the point
#! @BeginLatexOnly
#! \[
#! w = (501, -9.35215 \times 10^{-12}, 0.041779, 0.00821802, 1.5526, 3.14159, 0.980292),
#! \]
#! @EndLatexOnly
#! where the last two components correspond to the parameters $\theta_1$ and $\theta_2$.
#! Evaluating the function $f$ at this point gives us the value
#! @BeginLatexOnly
#! \[
#! f(3.14159, 0.980292) = 0.000396202,
#! \]
#! @EndLatexOnly
#! which is very close to $0$, the value of the function at the local minima.
#! Thus, we have successfully found a local minimum using gradient-based optimisation.
#! Note that during the optimisation process,
#! the $\theta_1$ parameter moved from approximately $1.58$ to approximately $\pi$,
#! while the $\theta_2$ parameter moved from $0.1$ to approximately $1$.
#!
#! @BeginLatexOnly
#! \begin{center}
#! \includegraphics[width=0.6\textwidth]{../examples/ComputingTheNextLocalMimima/plot-with-3-local-minimas.png}
#! \end{center}
#! @EndLatexOnly

LoadPackage( "GradientBasedLearningForCAP" );

#! @Example
Smooth := SkeletalCategoryOfSmoothMaps( );
#! SkeletalSmoothMaps
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )

f_smooth := PreCompose( Smooth,
        DirectProductFunctorial( Smooth, [ Smooth.Sin ^ 2, Smooth.Log ^ 2 ] ),
        Smooth.Sum( 2 ) );
#! ℝ^2 -> ℝ^1
dummy_input := CreateContextualVariables( [ "theta_1", "theta_2" ] );
#! [ theta_1, theta_2 ]
Display( f_smooth : dummy_input := dummy_input );
#! ℝ^2 -> ℝ^1
#! 
#! ‣ Sin( theta_1 ) * Sin( theta_1 ) + Log( theta_2 ) * Log( theta_2 )

f := MorphismConstructor( Para,
        ObjectConstructor( Para, Smooth.( 0 ) ),
        Pair( Smooth.( 2 ), f_smooth ),
        ObjectConstructor( Para, Smooth.( 1 ) ) );
#! ℝ^0 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^1
Display( f : dummy_input := dummy_input );
#! ℝ^0 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^2
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^1
#! 
#! ‣ Sin( theta_1 ) * Sin( theta_1 ) + Log( theta_2 ) * Log( theta_2 )
optimizer := Lenses.AdamOptimizer( );
#! function( n ) ... end
training_examples := [ [ ] ];
#! [ [ ] ]
batch_size := 1;
#! 1
one_epoch_update := OneEpochUpdateLens( f, optimizer, training_examples, batch_size );
#! (ℝ^7, ℝ^7) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^7 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^7 -> ℝ^7
dummy_input := CreateContextualVariables(
      [ "t", "m_1", "m_2", "v_1", "v_2", "theta_1", "theta_2" ] );
#! [ t, m_1, m_2, v_1, v_2, theta_1, theta_2 ]
Display( one_epoch_update : dummy_input := dummy_input );
#! (ℝ^7, ℝ^7) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^7 -> ℝ^1
#! 
#! ‣ (Sin( theta_1 ) * Sin( theta_1 ) + Log( theta_2 ) * Log( theta_2 )) / 1 / 1
#! 
#! Put Morphism:
#! ------------
#! ℝ^7 -> ℝ^7
#! 
#! ‣ t + 1
#! ‣ 0.9 * m_1 + 0.1 * (-1 * ((1 * ((1 * (Sin( theta_1 ) * Cos( theta_1 ) + Sin( theta_1 ) * Cos( theta_1 )) + 0) * 1 + 0) * 1 + 0) * 1 + 0))
#! ‣ 0.9 * m_2 + 0.1 * (-1 * (0 + (0 + 1 * (0 + (0 + 1 * (Log( theta_2 ) * (1 / theta_2) + Log( theta_2 ) * (1 / theta_2))) * 1) * 1) * 1))
#! ‣ 0.999 * v_1 + 0.001 * (-1 * ((1 * ((1 * (Sin( theta_1 ) * Cos( theta_1 ) + Sin( theta_1 ) * Cos( theta_1 )) + 0) * 1 + 0) * 1 + 0) * 1 + 0)) ^ 2
#! ‣ 0.999 * v_2 + 0.001 * (-1 * (0 + (0 + 1 * (0 + (0 + 1 * (Log( theta_2 ) * (1 / theta_2) + Log( theta_2 ) * (1 / theta_2))) * 1) * 1) * 1)) ^ 2
#! ‣ theta_1 + 0.001 / (1 - 0.999 ^ t) * ((0.9 * m_1 + 0.1 * (-1 * ((1 * ((1 * (Sin( theta_1 ) * Cos( theta_1 ) + Sin( theta_1 ) * Cos( theta_1 )) + 0) * 1 + 0) * 1 + 0) * 1 + 0))) / (1.e-0\
#! 7 + Sqrt( (0.999 * v_1 + 0.001 * (-1 * ((1 * ((1 * (Sin( theta_1 ) * Cos( theta_1 ) + Sin( theta_1 ) * Cos( theta_1 )) + 0) * 1 + 0) * 1 + 0) * 1 + 0)) ^ 2) / (1 - 0.999 ^ t) )))
#! ‣ theta_2 + 0.001 / (1 - 0.999 ^ t) * ((0.9 * m_2 + 0.1 * (-1 * (0 + (0 + 1 * (0 + (0 + 1 * (Log( theta_2 ) * (1 / theta_2) + Log( theta_2 ) * (1 / theta_2))) * 1) * 1) * 1))) / (1.e-07 \
#! + Sqrt( (0.999 * v_2 + 0.001 * (-1 * (0 + (0 + 1 * (0 + (0 + 1 * (Log( theta_2 ) * (1 / theta_2) + Log( theta_2 ) * (1 / theta_2))) * 1) * 1) * 1)) ^ 2) / (1 - 0.999 ^ t) )))
w := [ 1, 0, 0, 0, 0, 1.58, 0.1 ];
#! [ 1, 0, 0, 0, 0, 1.58, 0.1 ]
nr_epochs := 500;
#! 500
w := Fit( one_epoch_update, nr_epochs, w : verbose := false );
#! [ 501, -9.35215e-12, 0.041779, 0.00821802, 1.5526, 3.14159, 0.980292 ]
theta := w{ [ 6, 7 ] };
#! [ 3.14159, 0.980292 ]
Map( f_smooth )( theta );
#! [ 0.000396202 ]
#! @EndExample
