#! @Chapter Examples for neural networks

#! @Section Multi-class neural network with cross-entropy loss function

LoadPackage( "GradientBasedLearningForCAP" );

#! This example demonstrates how to train a small feed-forward neural network
#! for a multi-class classification task using the $\texttt{GradientBasedLearningForCAP}$
#! package. We employ the cross-entropy loss function and optimise the network
#! parameters with gradient descent.
#! 
#! The dataset consists of points $(x_1, x_2) \in \mathbb{R}^2$ labelled by a
#! non-linear decision rule describing three regions that form
#! @BeginLatexOnly
#! \begin{itemize}
#! \item $\emph{class 0}$:
#! \[
#! x_1^2 + (x_2 - 0.5)^2 \le 0.16
#! \qquad\text{(inside a circle of radius $0.4$ centred at $(0,0.5)$)}
#! \]
#! \item \emph{class 1}:
#! \[
#! x_2 \le -0.5
#! \qquad\text{(below the horizontal line)}
#! \]
#! \item $\emph{class 2}$: everything else.
#! \end{itemize}
#! @EndLatexOnly

#! @BeginLatexOnly
#! \begin{center}
#! \includegraphics[width=0.5\textwidth]{../examples/NeuralNetwork_CrossEntropy/data/scatter_plot_training_examples.png}
#! \end{center}
#! @EndLatexOnly

#! We build a neural network with three hidden layers and a Softmax output, fit
#! it on the provided training examples for several epochs, and then evaluate
#! the trained model on a grid of input points to visualise the learned
#! decision regions.

#! @BeginLatexOnly
#! Concretely, we choose three hidden layers, each with 6 neurons:
#! \[
#! \texttt{hidden\_layers} = [6,6,6].
#! \]
#! With input dimension \(2\) (representing point coordinates) and output dimension \(3\) (the probability of each class), the affine maps between
#! consecutive layers therefore have the following matrix dimensions (together
#! bias vectors):
#! \[
#! \binom{W_1}{b_1} \in \mathbb{R}^{ 3 \times 6},\quad
#! \binom{W_2}{b_2} \in \mathbb{R}^{ 7 \times 6},\quad
#! \binom{W_3}{b_3} \in \mathbb{R}^{ 7 \times 6},\quad
#! \binom{W_4}{b_4} \in \mathbb{R}^{ 7 \times 3}.
#! \]
#! Equivalently, each layer computes for an input $a_k$ the output \(z_{k+1} := (a_k\;\;1)\binom{W_{k+1}}{b_{k+1}}=a_k W_{k+1} + b_{k+1}\), where
#! \(a_0 \in \mathbb{R}^2\), \(a_1,a_2,a_3 \in \mathbb{R}^6\), and the final output
#! lies in \(\mathbb{R}^3\).
#! The non-linear activation function ReLU is applied after each hidden layer.
#! And Softmax is applied after the final layer to obtain a probability
#! estimate for the classes.
#! \[
#! a_0 \mapsto 
#! \color{red}\mathbf{Softmax}\left(
#!   \color{blue}\left(
#!     \color{green}\mathbf{Relu}\left(
#!       \color{yellow}\left(
#!         \color{red}\mathbf{Relu}\left(
#!           \color{blue}\left(
#!             \color{green}\mathbf{Relu}\left(
#!               \color{yellow}\left(
#!                 a_0\;\; 1
#!               \color{yellow}\right)
#!               \binom{W_1}{b_1}
#!             \color{green}\right)
#!             \;\; 1
#!           \color{blue}\right)
#!           \binom{W_2}{b_2}
#!         \color{red}\right)
#!         \;\; 1
#!       \color{yellow}\right)
#!       \binom{W_3}{b_3}
#!     \color{green}\right)
#!     \;\; 1
#!   \color{blue}\right)
#!   \binom{W_4}{b_4}
#! \color{red}\right) \in \mathbb{R}^3
#! \]
#! The predicted class is the one with the highest probability.
#! That is, the total number of parameters (weights and biases) is \(123\).
#! After training, we obtain a weight vector \(w \in \mathbb{R}^{123}\).
#! The first $21$ entries of $w$ correspond to the concatenation of the columns of $\binom{W_4}{b_4}\in \mathbb{R}^{7\times 3}$,
#! the next $42$ entries correspond to the concatenation of the columns of $\binom{W_3}{b_3}\in \mathbb{R}^{7\times 6}$, and so on.
#! @EndLatexOnly

#! @Example
Smooth := SkeletalSmoothMaps;
#! SkeletalSmoothMaps
Lenses := CategoryOfLenses( Smooth );
#! CategoryOfLenses( SkeletalSmoothMaps )
Para := CategoryOfParametrisedMorphisms( Smooth );
#! CategoryOfParametrisedMorphisms( SkeletalSmoothMaps )
hidden_layers := [ 6, 6, 6 ];;
f := NeuralNetworkLossMorphism( Para, 2, hidden_layers, 3, "Softmax" );;
optimizer := Lenses.GradientDescentOptimizer( : learning_rate := 0.1 );
#! function( n ) ... end
training_examples_path := Filename(
  DirectoriesPackageLibrary("GradientBasedLearningForCAP", "examples")[1],
  "NeuralNetwork_CrossEntropy/data/training_examples.txt" );;
batch_size := 4;
#! 4
one_epoch_update := OneEpochUpdateLens( f, optimizer,
                        training_examples_path, batch_size );
#! (ℝ^123, ℝ^123) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^123 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^123 -> ℝ^123
nr_weights := RankOfObject( Source( PutMorphism( one_epoch_update ) ) );
#! 123
rs := RandomSource( IsMersenneTwister, 1 );;
w := List( [ 1 .. nr_weights ], i -> 0.001 * Random( rs, [ -1000 .. 1000 ] ) );;
Display( w{[ 1 .. 5 ]} );
#! [ 0.789, -0.767, -0.613, -0.542, 0.301 ]
nr_epochs := 16;
#! 16
w := Fit( one_epoch_update, nr_epochs, w : verbose := true );;
#! Epoch  0/16 - loss = 0.80405334335407785
#! Epoch  1/16 - loss = 0.18338542093217905
#! Epoch  2/16 - loss = 0.1491650040794873
#! Epoch  3/16 - loss = 0.13186409729963983
#! Epoch  4/16 - loss = 0.12293129048146505
#! Epoch  5/16 - loss = 0.11742704538825839
#! Epoch  6/16 - loss = 0.11191588532335346
#! Epoch  7/16 - loss = 0.10441947487056685
#! Epoch  8/16 - loss = 0.095102838431592687
#! Epoch  9/16 - loss = 0.092441708967385072
#! Epoch 10/16 - loss = 0.097057579505470393
#! Epoch 11/16 - loss = 0.093295953606638768
#! Epoch 12/16 - loss = 0.082114375099200984
#! Epoch 13/16 - loss = 0.082910416530212819
#! Epoch 14/16 - loss = 0.082815082271383303
#! Epoch 15/16 - loss = 0.085405485529683856
#! Epoch 16/16 - loss = 0.087825108242740729
w;
#! [ 0.789, -1.09294, -1.43008, -0.66714, 1.27126, -1.12774, -0.240397, 0.213, 
#!   -0.382376, 1.42204, 0.300837, -1.79451, 0.392967, -0.868913, 0.858, 
#!   1.16231, 0.769031, 0.309303, 0.555253, -0.142223, 0.0703106, -0.997, 
#!   -0.746, 0.9, -0.248, -0.801, -0.317, -0.826, 0.0491083, -1.51073, -1.01246, 
#!   0.371752, -0.852, 0.342548, 1.01666, 1.39005, 0.958034, 0.357176, 0.3225, 
#!   -0.29, -1.0095, 0.154876, -0.460859, -0.582425, 0.223943, -0.402, -0.368, 
#!   0.275911, -0.0791975, 0.0986371, -0.487903, -0.699542, -0.553485, 0.766, 
#!   1.88163, 0.903741, -0.895688, -0.949546, 0.034, 0.13, -0.91, 0.67043, 
#!   -0.784672, -0.195688, 1.49813, 0.881451, 0.679593, -0.380004, 0.743062, 
#!   0.529804, 0.221497, 0.487694, 1.12092, 1.38134, -0.313891, 0.780071, 
#!   0.00526383, 0.422997, 0.287254, -0.42555, -0.0525988, -0.159442, -0.256285, 
#!   -0.296361, 0.822117, -0.23663, -0.252, -0.986452, -0.955211, 0.52727, 
#!   0.261295, -0.867, -0.787, -0.395, -0.871, -0.205, -0.315, -0.385, 
#!   -0.292919, -1.46115, -0.634953, 0.818446, 0.903525, 0.833456, 1.59504, 
#!   -0.500531, -0.191608, 0.390861, 0.808496, -1.94883, 0.445591, -1.62511, 
#!   -0.601054, -0.154008, -1.20266, -0.255521, 0.989522, 0.29963, 0.372084, 
#!   1.07529, -0.909025, 0.454265, 0.539106 ]
predict := NeuralNetworkPredictionMorphism( Para, 2, hidden_layers, 3, "Softmax" );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^123
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^125 -> ℝ^3
predict_given_w := ReparametriseMorphism( predict, Smooth.Constant( w ) );
#! ℝ^2 -> ℝ^3 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^0
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^3
predict_using_w := UnderlyingMorphism( predict_given_w );
#! ℝ^2 -> ℝ^3
inputs := Cartesian( 0.1 * [ -10 .. 10 ], 0.1 * [ -10 .. 10 ] );;
predictions := List( inputs, x ->
    -1 + Position( predict_using_w( x ), Maximum( predict_using_w( x ) ) ) );;
# ScatterPlotUsingPython( inputs, predictions );
#! @EndExample

#! Executing the command $\texttt{ScatterPlotUsingPython( inputs, predictions );}$ produces the following plot:
#! @BeginLatexOnly
#! \begin{center}
#! \includegraphics[width=0.5\textwidth]{../examples/NeuralNetwork_CrossEntropy/scatter_plot_predictions.png}
#! \end{center}
#! @EndLatexOnly
