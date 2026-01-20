# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Neural Networks

#! @Section Definition
#! A neural network can be viewed as a composition of parametrised affine transformations
#! and non-linear activation functions (such as ReLU, Sigmoid, Softmax, etc.).
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}[baseline=-2pt]
#! \node[draw, minimum width=1cm, minimum height=1cm] (F1) {affine-trans};
#! \node[left=0.75cm of F1] (A1) {$\mathbb{R}^{m_1}$};
#! \node[right=0.3cm of F1] (A2) {$\mathbb{R}^{m_2}$};
#! \node[above=0.75cm of F1] (P1) {$\mathbb{R}^{(m_1+1)m_2}$};
#! \node[draw, minimum width=1cm, minimum height=1cm, right=0.3cm of A2] (F2) {ReLU};
#! \node[right=0.3cm of F2] (A3) {$\mathbb{R}^{m_2}$};
#! \node[above=0.75cm of F2] (P2) {$\mathbb{R}^0$};
#! \node[draw, minimum width=1cm, minimum height=1cm, right=0.3cm of A3] (F3) {affine-trans};
#! \node[right=0.3cm of F3] (A4) {$\mathbb{R}^{m_3}$};
#! \node[above=0.75cm of F3] (P3) {$\mathbb{R}^{(m_2+1)m_3}$};
#! \node[draw, minimum width=1cm, minimum height=1cm, right=0.3cm of A4] (F4) {ReLU};
#! \node[right=0.3cm of F4] (A5) {$\mathbb{R}^{m_3}$};
#! \node[above=0.75cm of F4] (P4) {$\mathbb{R}^0$};
#! \node[right=0.3cm of A5] (F5) {$\cdots$};
#! \draw[->] (A1) -- (F1);
#! \draw[->] (F1) -- (A2);
#! \draw[->] (P1) -- (F1);
#! \draw[->] (A2) -- (F2);
#! \draw[->] (F2) -- (A3);
#! \draw[->] (P2) -- (F2);
#! \draw[->] (A3) -- (F3);
#! \draw[->] (F3) -- (A4);
#! \draw[->] (P3) -- (F3);
#! \draw[->] (A4) -- (F4);
#! \draw[->] (F4) -- (A5);
#! \draw[->] (P4) -- (F4);
#! \draw[->] (A5) -- (F5);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly


#! @Section Operations

#! @Description
#!  The arguments are <A>Para</A>, a parametrised morphism category,
#!  <A>s</A>, a positive integer giving the input dimension,
#!  <A>hidden_layers_dims</A>, a list of positive integers giving the sizes of
#!  the hidden layers in order, and <A>t</A>, a positive integer giving the output dimension.
#!  This operation constructs a parametrised morphism that computes the logits (pre-activation outputs)
#!  of a fully-connected feed-forward neural network. The signature of the parametrised morphism is
#!  $\mathbb{R}^s \to \mathbb{R}^t$ and is parameterised by the network weights and biases.
#!  More specifically, the parametrised morphism represents the function that maps an input vector
#!  $x \in \mathbb{R}^s$ and a parameter vector $p \in \mathbb{R}^d$ to the output vector $y \in \mathbb{R}^t$,
#!  where $d$ is the total number of weights and biases in the network defined by the given architecture.
#!   - For a layer with input dimension $m_i$ and output dimension $m_{i+1}$, the parameter object has dimension
#!     $(m_i + 1) \times m_{i+1}$, accounting for both the $m_i \times m_{i+1}$ weights matrix and the $m_{i+1}$ biases.
#!   - Hidden layers use ReLU nonlinearity between linear layers. The final layer
#!     is linear (no activation) so the returned morphism produces logits suitable
#!     for subsequent application of a loss or classification activation.
#! @Arguments Para, s, hidden_layers_dims, t
#! @Returns a parametrised morphism
DeclareOperation( "NeuralNetworkLogitsMorphism", [ IsCategoryOfParametrisedMorphisms, IsPosInt, IsDenseList, IsPosInt ] );

#! @Description
#! It composes the logits morphisms with the specified activation function to create a
#! parametrised morphism representing the predictions of a neural network.
#! The network has the architecture specified by <A>s</A>, <A>hidden_layers_dims</A>, and <A>t</A>,
#! i.e., the source and target of the parametrised morphism are $\mathbb{R}^{s}$ and $\mathbb{R}^{t}$, respectively.
#! The <A>activation</A> determines the final activation function:
#! * $\mathbf{Softmax}$: applies the softmax activation to turn logits into probabilities for multi-class classification.
#! * $\mathbf{Sigmoid}$: applies the sigmoid activation to turn logits into probabilities for binary classification.
#! * $\mathbf{IdFunc}$: applies the identity function (no activation) for regression tasks.
#! @Arguments Para, s, hidden_layers_dims, t, activation
#! @Returns a parametrised morphism
DeclareOperation( "NeuralNetworkPredictionMorphism", [ IsCategoryOfParametrisedMorphisms, IsPosInt, IsDenseList, IsPosInt, IsString ] );

#! @Description
#!  Construct a parametrised morphism representing the training loss of a fully-connected
#!  feed-forward neural network with architecture given by <A>s</A>, <A>hidden_layers_dims</A>
#!  and <A>t</A>. The returned parametrised morphism is parameterised by the network
#!  weights and biases and maps a pair (input, target) to a scalar loss:
#!  its source is $\mathbb{R}^s \times \mathbb{R}^t$ (an input vector $x$ and a target vector $y$)
#!  and its target is $\mathbb{R}$ (the scalar loss).
#! 
#!  The behaviour of the loss depends on the <A>activation</A> argument:
#!   - $\mathbf{Softmax}$:
#!       * Used for multi-class classification.
#!       * Softmax is applied to the logits to convert them into a probability distribution.
#!       * The loss is the (negative) cross-entropy between the predicted probabilities and the target distribution.
#!       * Targets y may be one-hot vectors or probability distributions over classes.
#!   - $\mathbf{Sigmoid}$:
#!       * Used for binary classification. Requires $t = 1$.
#!       * Applies the logistic sigmoid to the single logit to obtain a probability $\hat{y}$ in $[0,1]$.
#!       * The loss is binary cross-entropy: $\mathrm{loss} = - ( y\log(\hat{y}) + (1-y)\log(1-\hat{y}) )$.
#!   - $\mathbf{IdFunc}$:
#!       * Used for regression.
#!       * No final activation is applied. The loss is the mean squared error (MSE).
#! 
#! @Arguments Para, s, hidden_layers_dims, t, activation
#! @Returns a parametrised morphism
DeclareOperation( "NeuralNetworkLossMorphism", [ IsCategoryOfParametrisedMorphisms, IsPosInt, IsDenseList, IsPosInt, IsString ] );


##
DeclareGlobalFunction( "DummyInputStringsForNeuralNetwork" );

##
DeclareGlobalFunction( "DummyInputForNeuralNetwork" );
