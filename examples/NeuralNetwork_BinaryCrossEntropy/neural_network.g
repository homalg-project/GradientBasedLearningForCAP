#! @Chapter Examples

#! @Section Binary-Class Neural Network with Binary Cross-Entropy Loss Function

LoadPackage( "GradientBasedLearningForCAP" );

#! This example demonstrates how to train a small feed-forward neural network
#! for a binary classification task using the $\texttt{GradientBasedLearningForCAP}$
#! package. We use the binary cross-entropy loss and optimise the network
#! parameters with gradient descent.
#! 
#! The dataset consists of points $(x_1, x_2) \in \mathbb{R}^2$ labelled by a
#! non-linear decision rule describing two regions that form $\emph{class 0}$:
#! @BeginLatexOnly
#! \[
#! x_1^2 + (x_2 - 0.5)^2 \le 0.16
#! \qquad\text{(inside a circle of radius $0.4$ centred at $(0,0.5)$)}
#! \]
#! together with
#! \[
#! x_2 \le -0.5
#! \qquad\text{(below the horizontal line)}
#! \]
#! @EndLatexOnly
#! 
#! All remaining points belong to $\emph{class 1}$.

#! @BeginLatexOnly
#! \begin{center}
#! \includegraphics[width=0.5\textwidth]{../examples/NeuralNetwork_BinaryCrossEntropy/data/scatter_plot_training_examples.png}
#! \end{center}
#! @EndLatexOnly

#! Hence the classification
#! boundary is not linearly separable and requires a non-linear model.
#! We build a neural network with three hidden layers and a sigmoid output, fit
#! it on the provided training examples for several epochs, and then evaluate
#! the trained model on a grid of input points to visualise the learned
#! decision regions.

#! @BeginLatexOnly
#! Concretely, we choose three hidden layers, each with 6 neurons:
#! \[
#! \texttt{hidden\_layers} = [6,6,6].
#! \]
#! With input dimension \(2\) and output dimension \(1\), the affine maps between
#! consecutive layers therefore have the following matrix dimensions (together
#! bias vectors):
#! \[
#! \binom{W_1}{b_1} \in \mathbb{R}^{ 3 \times 6},\quad
#! \binom{W_2}{b_2} \in \mathbb{R}^{ 7 \times 6},\quad
#! \binom{W_3}{b_3} \in \mathbb{R}^{ 7 \times 6},\quad
#! \binom{W_4}{b_4} \in \mathbb{R}^{ 7 \times 1}.
#! \]
#! Equivalently, each layer computes for an input $a_k$ the output \(z_{k+1} := (a_k\;\;1)\binom{W_{k+1}}{b_{k+1}}=a_k W_{k+1} + b_{k+1}\), where
#! \(a_0 \in \mathbb{R}^2\), \(a_1,a_2,a_3 \in \mathbb{R}^6\), and the final output
#! lies in \(\mathbb{R}^1\).
#! The non-linear activation function ReLU is applied after each hidden layer.
#! And Sigmoid is applied after the final layer to obtain a probability
#! estimate for class \(1\).
#! \[
#! a_0 \mapsto 
#! \color{red}\mathbf{Sigmoid}\left(
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
#! \color{red}\right) \in \mathbb{R}^1
#! \]
#! If that probability is greater than \(0.5\), we predict class \(1\), otherwise class \(0\).
#! That is, the total number of parameters (weights and biases) is \(109\).
#! After training, we obtain a weight vector \(w \in \mathbb{R}^{109}\).
#! The first $7$ entries of $w$ correspond to the column $\binom{W_4}{b_4}\in \mathbb{R}^{7\times 1}$,
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
f := NeuralNetworkLossMorphism( Para, 2, hidden_layers, 1, "Sigmoid" );;
optimizer := Lenses.GradientDescentOptimizer( : learning_rate := 0.01 );
#! function( n ) ... end
training_examples_path := Filename(
  DirectoriesPackageLibrary("GradientBasedLearningForCAP", "examples")[1],
  "NeuralNetwork_BinaryCrossEntropy/data/training_examples.txt" );;
batch_size := 2;
#! 2
one_epoch_update := OneEpochUpdateLens( f, optimizer,
                        training_examples_path, batch_size );
#! (ℝ^109, ℝ^109) -> (ℝ^1, ℝ^0) defined by:
#! 
#! Get Morphism:
#! ------------
#! ℝ^109 -> ℝ^1
#! 
#! Put Morphism:
#! ------------
#! ℝ^109 -> ℝ^109
nr_weights := RankOfObject( Source( PutMorphism( one_epoch_update ) ) );
#! 109
rs := RandomSource( IsMersenneTwister, 1 );;
w := List( [ 1 .. nr_weights ], i -> 0.001 * Random( rs, [ -1000 .. 1000 ] ) );;
w{[ 1 .. 5 ]};
#! [ 0.789, -0.767, -0.613, -0.542, 0.301 ]
nr_epochs := 25;
#! 25
w := Fit( one_epoch_update, nr_epochs, w : verbose := true );;
#! Epoch  0/25 - loss = 0.6274786697292678
#! Epoch  1/25 - loss = 0.50764552556010512
#! Epoch  2/25 - loss = 0.46701509497218296
#! Epoch  3/25 - loss = 0.43998434603387304
#! Epoch  4/25 - loss = 0.41390897205434185
#! Epoch  5/25 - loss = 0.38668229524419645
#! Epoch  6/25 - loss = 0.3615103023137366
#! Epoch  7/25 - loss = 0.33852687543477167
#! Epoch  8/25 - loss = 0.31713408584173464
#! Epoch  9/25 - loss = 0.29842876608165969
#! Epoch 10/25 - loss = 0.28310739567373933
#! Epoch 11/25 - loss = 0.26735508537538627
#! Epoch 12/25 - loss = 0.25227135017462571
#! Epoch 13/25 - loss = 0.23858070423434527
#! Epoch 14/25 - loss = 0.22557724727481232
#! Epoch 15/25 - loss = 0.2151923109202202
#! Epoch 16/25 - loss = 0.20589044111812799
#! Epoch 17/25 - loss = 0.19857151366814263
#! Epoch 18/25 - loss = 0.19229381748983518
#! Epoch 19/25 - loss = 0.18814544378812006
#! Epoch 20/25 - loss = 0.18465371077598913
#! Epoch 21/25 - loss = 0.18166012790192537
#! Epoch 22/25 - loss = 0.17685616213693178
#! Epoch 23/25 - loss = 0.17665872918251943
#! Epoch 24/25 - loss = 0.17073585936950184
#! Epoch 25/25 - loss = 0.16744783175344116
w;
#! [ 1.47751, -0.285187, -1.87358, -1.87839, 0.687266,
#!   -0.88329, -0.607225, 0.57876, 0.084489, 1.1218,
#!   0.289778, -1.15844, 0.562299, -0.725222, 0.724775,
#!   0.643942, 0.202536, 0.131565, 0.768751, -0.345379,
#!   -0.147853, -1.52103, -1.26183, 1.39931, 0.00143737,
#!   -0.819752, -0.90015, -0.534457, 0.74204, -0.768,
#!   -1.85381, 0.225274, -0.384199, 1.1034, 0.82565,
#!   0.423966, 0.719847, 0.487972, 0.266537, -0.442324,
#!   0.520839, 0.306871, -0.205834, -0.314044, 0.0395323,
#!   -0.489954, -0.368816, 0.305383, -0.181872, 0.775344,
#!   -0.57507, -0.792, -0.937068, 1.39995, -0.0236236,
#!   0.370827, -0.778542, -0.783943, 0.034, 0.343554,
#!   -1.00419, 0.857391, -1.07632, -0.677147, 0.839605,
#!   0.719, 1.40418, -0.221851, 1.29824, 0.510027,
#!   0.217811, 0.344086, 0.579, 0.576412, 0.070248,
#!   -0.145523, 0.468713, 0.680618, 0.199966, -0.497,
#!   -0.408801, 0.0519444, -0.597412, 0.137205, 1.25696,
#!   -0.0884903, -0.252, -0.721624, -1.25962, 0.894349,
#!   0.447327, -1.00492, -1.54383, 0.464574, -0.723211,
#!   -0.108064, -0.486439, -0.385, -0.484, -0.862,
#!   -0.121845, 1.0856, 1.09068, 1.69466, 0.938733,
#!   0.529301, -0.465345, 1.23872, 1.07609 ]
predict := NeuralNetworkPredictionMorphism( Para, 2, hidden_layers, 1, "Sigmoid" );
#! ℝ^2 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^109
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^111 -> ℝ^1
predict_given_w := ReparametriseMorphism( predict, Smooth.Constant( w ) );
#! ℝ^2 -> ℝ^1 defined by:
#! 
#! Underlying Object:
#! -----------------
#! ℝ^0
#! 
#! Underlying Morphism:
#! -------------------
#! ℝ^2 -> ℝ^1
predict_using_w := UnderlyingMorphism( predict_given_w );
#! ℝ^2 -> ℝ^1
inputs := Cartesian( 0.1 * [ -10 .. 10 ], 0.1 * [ -10 .. 10 ] );;
predictions := List( inputs, x -> 
          SelectBasedOnCondition( predict_using_w( x )[1] > 0.5, 1, 0 ) );;
# ScatterPlotUsingPython( inputs, predictions );
#! @EndExample

#! Executing the command $\texttt{ScatterPlotUsingPython( inputs, predictions );}$ produces the following plot:
#! @BeginLatexOnly
#! \begin{center}
#! \includegraphics[width=0.5\textwidth]{../examples/NeuralNetwork_BinaryCrossEntropy/scatter_plot_predictions.png}
#! \end{center}
#! @EndLatexOnly
