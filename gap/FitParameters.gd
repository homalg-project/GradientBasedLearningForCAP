# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Fitting Parameters

#! @Section Introduction

#! Suppose we have a parametrised morphism $(\mathbb{R}^p, f):\mathbb{R}^n \to \mathbb{R}$
#! where $\mathbb{R}^p$ is the parameters of the morphism and
#! $f:\mathbb{R}^{p+n} \to \mathbb{R}$ is a morphism in a skeletal category of smooth maps
#! (It represents a loss function over an input in $\mathbb{R}^n$ and parameter vector in $\mathbb{R}^p$).
#! Given a set of training examples $\{X_1, \ldots, X_m\}$ where each $X_i \in \mathbb{R}^n$,
#! we want to fit a parameter vector $\Theta \in \mathbb{R}^p$ such that the output of $f$ is minimized on the training examples.
#! 
#! We can achieve this by creating an update-lens for each training example.
#! This update-lens reads the current parameters $\Theta$ and updates it according to the gradient of the loss function $f$ at the example $X_i$.
#! We start by substituting the training example $X_i$ into $f$ resulting in a morphism $f_i:\mathbb{R}^p \to \mathbb{R}$
#! defined by $f_i(\Theta) = f(\Theta, X_i)$.
#! By applying the reverse differential lens functor <C>ReverseDifferentialLensFunctor</C>
#! $$\mathbf{R}: \mathrm{Smooth} \to \mathrm{Lenses}(\mathrm{Smooth}),$$
#! on $f_i$,
#! we obtain a lens $\mathbf{R}(f_i):(\mathbb{R}^p, \mathbb{R}^p) \to (\mathbb{R}^1, \mathbb{R}^1)$.
#! The get-morphism of this lens reads the current parameters $\Theta$ and computes the loss $f_i(\Theta)$,
#! while the put-morphism $Rf_i:\mathbb{R}^p \times \mathbb{R}^1 \to \mathbb{R}^p$
#! is given by $(\Theta, r) \mapsto rJ_{f_i}(\Theta)$ where $J_{f_i}(\Theta) \in \mathbb{R}^{1 \times p}$ is the Jacobian matrix of $f_i$ evaluated at $\Theta$.
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-3, 1) {$\mathbb{R}^p$};
#! \node (B)  at ( 3, 1) {$\mathbb{R}^1$};
#! \node (Ap) at (-3,-1) {$\mathbb{R}^p$};
#! \node (Bp) at ( 3,-1) {$\mathbb{R}^1$};
#! \draw (-1.5,-1.8) rectangle (1.5,1.8);
#! \draw[->] (A) -- node[below] {$f_i$} (B);
#! \draw[->] (A) -- node[above] {$\Theta \mapsto f_i(\Theta)$} (B);
#! \draw[->] (Bp) -- node[midway, above] {$Rf_i$} (Ap);
#! \draw[->] (Bp) -- node[midway, below] {$rJ_{f_i}(\Theta) \mapsfrom (\Theta, r)$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#!
#! The One-Epoch update lens for the example $X_i$ is then obtained by precomposing an optimizer lens (e.g., gradient descent, Adam, etc.)
#! to the following lens $\mathbf{R}(f_i) \cdot \varepsilon$ where
#! $\varepsilon:(\mathbb{R}^1, \mathbb{R}^0) \to (\mathbb{R}^1, \mathbb{R}^1)$ is the lens defined by:
#! - Get morphism: the identity morphism on $\mathbb{R}^1$.
#! - Put morphism: the morphism $\mathbb{R}^1 \to \mathbb{R}^0$ defined by $r \mapsto -r$.
#! This lens merely negates the gradient signal.
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! \node (A)  at (-3, 1) {$\mathbb{R}^p$};
#! \node (B)  at ( 3, 1) {$\mathbb{R}^1$};
#! \node (C)  at (9, 1) {$\mathbb{R}^1$};
#! \node (Ap) at (-3,-1) {$\mathbb{R}^p$};
#! \node (Bp) at ( 3,-1) {$\mathbb{R}^1$};
#! \node (Cp) at (9,-1) {$\mathbb{R}^0$};
#! \draw (-1.5,-1.8) rectangle (1.5,1.8);
#! \draw[->] (A) -- node[below] {$f_i$} (B);
#! \draw[->] (A) -- node[above] {$\Theta \mapsto f_i(\Theta)$} (B);
#! \draw[->] (Bp) -- node[midway, above] {$Rf_i$} (Ap);
#! \draw[->] (Bp) -- node[midway, below] {$rJ_{f_i}(\Theta) \mapsfrom (\Theta, r)$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \draw[-] (5,1) to[out=-90, in=90] (7,-1);
#! \draw (4.5,-1.8) rectangle (7.5,1.8);
#! \draw[->] (B) -- node[above] {$r \mapsto r$} (C);
#! \draw[->] (Cp) -- node[midway, below] {$-r \mapsfrom r$} (Bp);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! 
#! Suppose we choose the optimizer lens to be the gradient descent optimizer with learning rate $\eta = 0.01 > 0$,
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-3, 1) {$\mathbb{R}^p$};
#! \node (B)  at ( 3, 1) {$\mathbb{R}^p$};
#! \node (Ap) at (-3,-1) {$\mathbb{R}^p$};
#! \node (Bp) at ( 3,-1) {$\mathbb{R}^p$};
#! \draw (-1.5,-1.8) rectangle (1.5,1.8);
#! \draw[->] (A) -- node[above] {$\Theta \mapsto \Theta$} (B);
#! \draw[->] (Bp) -- node[midway, below] {$\Theta + \eta g \mapsfrom (\Theta, g)$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! then the resulting One-Epoch update lens for the example $X_i$ is given by
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-3, 1) {$\mathbb{R}^p$};
#! \node (B)  at ( 3, 1) {$\mathbb{R}^p$};
#! \node (Ap) at (-3,-1) {$\mathbb{R}^p$};
#! \node (Bp) at ( 3,-1) {$\mathbb{R}^0$};
#! \draw (-1.5,-1.8) rectangle (1.5,1.8);
#! \draw[->] (A) -- node[above] {$\Theta \mapsto f_i(\Theta)$} (B);
#! \draw[->] (Bp) -- node[midway, below] {$\Theta - \eta J_{f_i}(\Theta) \mapsfrom \Theta$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! Now, we can start by a random parameter vector $\Theta_0 \in \mathbb{R}^p$
#! and apply the update morphism of the One-Epoch update lens for $X_1$ to obtain a new parameter vector $\Theta_1$,
#! then use $\Theta_1$ and the One-Epoch update lens for $X_2$ to obtain $\Theta_2$, and so on.
#! After going through all training examples, we have completed one epoch of training.
#! To perform multiple epochs of training, we can simply repeat the process.
#!
#! For example, suppose we start with the parmetised morphism ($\mathbb{R}^2, f):\mathbb{R}^2 \to \mathbb{R}$
#! where $f:\mathbb{R}^{2+2} \to \mathbb{R}$ is
#! defined by $f(\theta_1, \theta_2, x_1, x_2) = (x_1-\theta_1)^2 + (x_2-\theta_2)^2$ where $\Theta := (\theta_1, \theta_2) \in \mathbb{R}^2$ represents the parameters
#! and $x = (x_1, x_2) \in \mathbb{R}^2$ is the input.
#! Given training examples $X_1 = (1,2)$ and $X_2 = (3,4)$,
#! the morphism $f_1:\mathbb{R}^2 \to \mathbb{R}$ is defined by $f_1(\theta_1, \theta_2) = (1 - \theta_1)^2 + (2 - \theta_2)^2$
#! with Jacobian matrix
#! @BeginLatexOnly
#! \[
#! J_{f_1}(\theta_1, \theta_2) = \begin{pmatrix}-2(1 - \theta_1) & -2(2 - \theta_2)\end{pmatrix}.
#! \]
#! @EndLatexOnly
#! Thus, the One-Epoch update lens for $X_1$ is given by:
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-5, 1) {$\mathbb{R}^2$};
#! \node (B)  at ( 5, 1) {$\mathbb{R}^2$};
#! \node (Ap) at (-5,-1) {$\mathbb{R}^2$};
#! \node (Bp) at ( 5,-1) {$\mathbb{R}^0$};
#! \draw (-4,-2.5) rectangle (4,2);
#! \draw[->] (A) -- node[above] {$(\theta_1, \theta_2) \mapsto (1 - \theta_1)^2 + (2 - \theta_2)^2$} (B);
#! \draw[->] (Bp) -- node[midway, below] {$(\underbrace{\theta_1 + \eta \cdot 2(1-\theta_1)}_{0.98\theta_1 + 0.02}, \underbrace{\theta_2 + \eta \cdot 2(2-\theta_2)}_{0.98\theta_2 + 0.04}) \mapsfrom (\theta_1, \theta_2)$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! and the One-Epoch update lens for $X_2$ is given by:
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-5, 1) {$\mathbb{R}^2$};
#! \node (B)  at ( 5, 1) {$\mathbb{R}^2$};
#! \node (Ap) at (-5,-1) {$\mathbb{R}^2$};
#! \node (Bp) at ( 5,-1) {$\mathbb{R}^0$};
#! \draw (-4,-2.5) rectangle (4,2);
#! \draw[->] (A) -- node[above] {$(\theta_1, \theta_2) \mapsto (3 - \theta_1)^2 + (4 - \theta_2)^2$} (B);
#! \draw[->] (Bp) -- node[midway, below] {$(\underbrace{\theta_1 + \eta \cdot 2(3-\theta_1)}_{0.98\theta_1 + 0.06}, \underbrace{\theta_2 + \eta \cdot 2(4-\theta_2)}_{0.98\theta_2 + 0.08}) \mapsfrom (\theta_1, \theta_2)$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! Suppose we start with the parameter vector $\Theta = (0,0)$. Then:
#! - After applying the update lens for $X_1$: $\Theta_1 = (0.98 \cdot 0 + 0.02, 0.98 \cdot 0 + 0.04) = (0.02, 0.04)$.
#! - After applying the update lens for $X_2$: $\Theta_2 = (0.98 \cdot 0.02 + 0.06, 0.98 \cdot 0.04 + 0.08) = (0.0796, 0.1192)$.
#! Thus, after one epoch of training, the updated parameters are $\Theta_2 = (0.0796, 0.1192)$.
#! Repeating this process for multiple epochs will further refine the parameters to minimize the loss function over the training examples.
#! Eventually, we expect the parameters to converge to $\Theta = [2, 3]$ which minimizes the loss function.
#! The point whose distance from $[1, 2]$ and $[3, 4]$ is minimized is $[2, 3]$.
#! See the examples section for the implementation of this process in &GAP;.


#! @Section Notes on Batching
#! Given a parametrised (loss) morphism $(\mathbb{R}^p, f):\mathbb{R}^n \to \mathbb{R}$
#! and a set of training examples $\{X_1, \ldots, X_m\}$ where each $X_i \in \mathbb{R}^n$.
#! If the number of training examples $m$ is large, it may be beneficial to use mini-batches during training.
#! Given a positive integer <A>batch_size</A>, the loss morphism is first batched using <C>Batchify</C>.
#! This means, we create a new parametrised morphism $(\mathbb{R}^p, f_{batch}):\mathbb{R}^{batch\_size \cdot n} \to \mathbb{R}$
#! where $f_{batch}(\Theta, X_{i_1}, \ldots, X_{i_{batch\_size}}) = \frac{1}{batch\_size} \sum_{j=1}^{batch\_size} f(\Theta, X_{i_j})$.
#! We divide the training examples into mini-batches of size <A>batch_size</A>
#! (padding the list by repeating randomly chosen examples if necessary to make its length divisible by <A>batch_size</A>).
#! And then we consider each mini-batch as a single training example. Now, we can repeat the training process described above using the
#! batched loss morphism and the new training examples. For example, if the parametrised morphism is
#! $(\mathbb{R}^p, f):\mathbb{R}^2 \to \mathbb{R}$
#! where $f(\theta_1, \theta_2, x_1, x_2) = (x_1-\theta_1)^2 + (x_2-\theta_2)^2$,
#! and we have training examples $[[1,2], [3,4], [5,6], [7,8], [9,10]]$, then for <A>batch_size</A> = $2$,
#! the batched loss morphism is $(\mathbb{R}^p, f_{batch}):\mathbb{R}^4 \to \mathbb{R}$
#! where $f_{batch}(\theta_1, \theta_2, x_1, x_2, x_3, x_4) = \frac{1}{2} \left( (x_1-\theta_1)^2 + (x_2-\theta_2)^2 + (x_3-\theta_1)^2 + (x_4-\theta_2)^2 \right)$
#! (See <C>Batchify</C> operation).
#! Since the number of training examples is not divisible by <A>batch_size</A>,
#! we pad the list by randomly choosing an example (say, $[1,2]$) and appending it to the list.
#! Then the new training examples set would be $[[1,2,3,4], [5,6,7,8], [9,10,1,2]]$.

#! @Section Operations

#! @Description
#!  Create an update lens for one epoch of training.
#!
#!  The argument <A>parametrised_morphism</A> must be a morphism in a category of parametrised morphisms
#!  whose target has rank $1$ (a scalar loss).
#!
#!  The argument <A>optimizer</A> is a function which takes the number of parameters <C>p</C> and returns
#!  an optimizer lens in the category of lenses over <A>Smooth</A>.
#!  Typical examples are <C>Lenses.GradientDescentOptimizer</C>, <C>Lenses.AdamOptimizer</C>, etc.
#!
#!  The list <A>training_examples</A> must contain at least one example; each example is a dense list
#!  representing a vector in $\mathbb{R}^n$.
#!
#! @Arguments parametrised_morphism, optimizer, training_examples, batch_size
#! @Returns a morphism in a category of lenses (the epoch update lens)
DeclareOperation( "OneEpochUpdateLens", [ IsMorphismInCategoryOfParametrisedMorphisms, IsFunction, IsDenseList, IsPosInt ] );

#! @Description
#!  Same as <C>OneEpochUpdateLens</C>, but reads the training examples from a file.
#!  The file is evaluated using <C>EvalString</C> and is expected to contain a GAP expression
#!  evaluating to a dense list of examples.
#! @Arguments parametrised_morphism, optimizer, training_examples_path, batch_size
#! @Returns a morphism in a category of lenses (the epoch update lens)
DeclareOperation( "OneEpochUpdateLens", [ IsMorphismInCategoryOfParametrisedMorphisms, IsFunction, IsString, IsPosInt ] );

#! @Description
#!  Perform <A>nr_epochs</A> epochs of training using the given <A>one_epoch_update_lens</A> and initial weights <A>initial_weights</A>.
#!
#!  The lens <A>one_epoch_update_lens</A> must have get-morphism $\mathbb{R}^p \to \mathbb{R}^1$ and
#!  put-morphism $\mathbb{R}^p \to \mathbb{R}^p$ for the same $p$ as the length of <A>initial_weights</A>.
#!  The option <A>verbose</A> controls whether to print the loss at each epoch.
#! @Arguments one_epoch_update_lens, nr_epochs, initial_weights
#! @Returns a list of final weights
DeclareOperation( "Fit", [ IsMorphismInCategoryOfLenses, IsPosInt, IsDenseList ] );
