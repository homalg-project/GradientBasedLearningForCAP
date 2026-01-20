# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Skeletal Category of Smooth Maps

#! @Section GAP Categories

#! @Description
#!  The &GAP; category of a category of skeletal smooth maps.
DeclareCategory( "IsSkeletalCategoryOfSmoothMaps",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a category of skeletal smooth maps.
DeclareCategory( "IsObjectInSkeletalCategoryOfSmoothMaps",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a category of skeletal smooth maps.
DeclareCategory( "IsMorphismInSkeletalCategoryOfSmoothMaps",
        IsCapCategoryMorphism );

#! @Section Constructors

#! @Description
#!  Construct the category of skeletal smooth maps.
#!  Objects in this category are the Euclidean spaces $\mathbb{R}^n$ for non-negative integers $n$.
#!  Morphisms are smooth maps between these spaces, represented by a map function and its Jacobian matrix.
#! @Returns a category
DeclareGlobalFunction( "SkeletalCategoryOfSmoothMaps" );

if false then

#! @Description
#!  Construct the object representing the Euclidean space $\mathbb{R}^{n}$ in the category of skeletal smooth maps.
#!  Points in Euclidean spaces are represented as row vectors.
#! @Arguments Smooth, n
#! @Returns an object in the category of skeletal smooth maps
DeclareOperation( "ObjectConstructor",
    [ IsSkeletalCategoryOfSmoothMaps, IsInt ] );

#! @Description
#!  Construct a smooth morphism from <A>source</A> to <A>target</A> using the given <A>datum</A>.
#!  The <A>datum</A> should be a pair <C>[ map_func, jacobian_func ]</C> where:
#!  <List>
#!  <Item><A>map_func</A> is a function that takes a list of <M>m</M> elements (where <M>m</M> is the rank of <A>source</A>)
#!        and returns a list of <M>n</M> elements (where <M>n</M> is the rank of <A>target</A>).
#!        This represents the smooth map <M>f: \mathbb{R}^m \to \mathbb{R}^n</M>,
#!        $[x_1, x_2, \ldots, x_m] \mapsto [f_1(x_1, \ldots, x_m), f_2(x_1, \ldots, x_m), \ldots, f_n(x_1, \ldots, x_m)]$.
#!        </Item>
#!  <Item><A>jacobian_func</A> is a function that takes a list of <M>m</M> elements
#!        and returns an <M>n \times m</M> matrix (represented as a list of <M>n</M> lists, each containing <M>m</M> elements).
#!        This matrix represents the Jacobian <M>Df(x)</M> at point <M>x</M>, where entry <M>(i,j)</M> is <M>\frac{\partial f_i}{\partial x_j}(x)</M>.</Item>
#!  </List>
#! @Arguments Smooth, source, datum, target
#! @Returns a morphism in the category of skeletal smooth maps
DeclareOperation( "MorphismConstructor",
    [ IsSkeletalCategoryOfSmoothMaps,
      IsObjectInSkeletalCategoryOfSmoothMaps,
      IsDenseList,
      IsObjectInSkeletalCategoryOfSmoothMaps ] );
fi;

#! @Description
#! Delegates to MorphismConstructor to create a smooth morphism.
#! @Arguments Smooth, source, datum, target
#! @Returns a morphism in the category of skeletal smooth maps
DeclareOperation( "SmoothMap",
    [ IsSkeletalCategoryOfSmoothMaps, IsObjectInSkeletalCategoryOfSmoothMaps, IsDenseList, IsObjectInSkeletalCategoryOfSmoothMaps ] );

#! @Section Attributes

#! @Description
#!  The rank (dimension) of the Euclidean space represented by the object <A>obj</A>.
#!  For an object representing $\mathbb{R}^n$, this returns $n$.
#! @Arguments obj
#! @Returns a non-negative integer
DeclareAttribute( "RankOfObject", IsObjectInSkeletalCategoryOfSmoothMaps );

#! @Description
#!  The underlying map function of a smooth morphism <A>f</A>.
#!  For a morphism $f: \mathbb{R}^m \to \mathbb{R}^n$, this is a function that takes a list of $m$ elements
#!  and returns a list of $n$ elements.
#! @Arguments f
#! @Returns a function
DeclareAttribute( "Map", IsMorphismInSkeletalCategoryOfSmoothMaps );

#! @Description
#!  The Jacobian matrix function of a smooth morphism <A>f</A>.
#!  For a morphism $f: \mathbb{R}^m \to \mathbb{R}^n$, this is a function that takes a list of $m$ elements
#!  and returns an $n \times m$ matrix representing the partial derivatives.
#! @Arguments f
#! @Returns a function
DeclareAttribute( "JacobianMatrix", IsMorphismInSkeletalCategoryOfSmoothMaps );

#! @Section Operations

#! @Description
#!  Evaluate the smooth morphism <A>f</A> at the point <A>x</A>.
#! @Arguments f, x
#! @Returns a dense list
DeclareOperation( "Eval", [ IsMorphismInSkeletalCategoryOfSmoothMaps, IsDenseList ] );

#! @Description
#!  Evaluate the Jacobian matrix of the smooth morphism <A>f</A> at the point <A>x</A>.
#! @Arguments f, x
#! @Returns a matrix (list of lists)
DeclareOperation( "EvalJacobianMatrix", [ IsMorphismInSkeletalCategoryOfSmoothMaps, IsDenseList ] );

DeclareGlobalVariable( "GradientBasedLearningForCAP" );

#! @Section Available Smooth Maps

#! @BeginLatexOnly
#! The category of skeletal smooth maps offer several pre-implemented helper functions:
#! \begin{itemize}
#! \item \textbf{Sqrt}: The square root function. Returns the square root map $\mathbb{R}^1 \to \mathbb{R}^1$,
#! given by $x \to \sqrt{x}$. Its Jacobian matrix is given by $\frac{1}{2 \sqrt{x}}$.
#! \item \textbf{Exp}: The exponential function. Returns the map $\mathbb{R}^1 \to \mathbb{R}^1$ given by $x \mapsto e^x$.
#! Its Jacobian matrix is $e^x$.
#! \item \textbf{Log}: The natural logarithm function. Returns the map $\mathbb{R}^1 \to \mathbb{R}^1$ given by $x \mapsto \log(x)$.
#! Its Jacobian matrix is $\frac{1}{x}$.
#! \item \textbf{Sin}: The sine function. Returns the map $\mathbb{R}^1 \to \mathbb{R}^1$ given by $x \mapsto \sin(x)$.
#! Its Jacobian matrix is $\cos(x)$.
#! \item \textbf{Cos}: The cosine function. Returns the map $\mathbb{R}^1 \to \mathbb{R}^1$ given by $x \mapsto \cos(x)$.
#! Its Jacobian matrix is $-\sin(x)$.
#! \item \textbf{Constant(rank\_s, l)} or \textbf{Constant(l)}: Returns a constant morphism $\mathbb{R}^{\text{rank\_s}} \to \mathbb{R}^m$ 
#! that maps any input to the fixed list $l$ (where $m = |l|$). If rank\_s is omitted, it defaults to 0.
#! \item \textbf{Zero(s, t)}: Returns the zero morphism $\mathbb{R}^s \to \mathbb{R}^t$.
#! \item \textbf{IdFunc(n)}: Returns the identity morphism $\mathbb{R}^n \to \mathbb{R}^n$.
#! \item \textbf{Relu(n)}: Returns the rectified linear unit function $\mathbb{R}^n \to \mathbb{R}^n$ applied componentwise, 
#! given by $x_i \mapsto \max(0, x_i)$.
#! \item \textbf{Sigmoid(n)}: Returns the sigmoid activation function $\mathbb{R}^n \to \mathbb{R}^n$ applied componentwise,
#! given by $x_i \mapsto \frac{1}{1 + e^{-x_i}}$.
#! \item \textbf{Softmax(n)}: Returns the softmax function $\mathbb{R}^n \to \mathbb{R}^n$ given by 
#! $x_i \mapsto \frac{e^{x_i}}{\sum_{j=1}^n e^{x_j}}$.
#! \item \textbf{Sum(n)}: Returns the sum function $\mathbb{R}^n \to \mathbb{R}^1$ given by $(x_1, \ldots, x_n) \mapsto \sum_{i=1}^n x_i$.
#! \item \textbf{Mean(n)}: Returns the mean function $\mathbb{R}^n \to \mathbb{R}^1$ given by $(x_1, \ldots, x_n) \mapsto \frac{1}{n}\sum_{i=1}^n x_i$.
#! \item \textbf{Variance(n)}: Returns the variance function $\mathbb{R}^n \to \mathbb{R}^1$ given by 
#! $(x_1, \ldots, x_n) \mapsto \frac{1}{n}\sum_{i=1}^n (x_i - \mu)^2$ where $\mu$ is the mean.
#! \item \textbf{StandardDeviation(n)}: Returns the standard deviation function $\mathbb{R}^n \to \mathbb{R}^1$ 
#! given by the square root of the variance.
#! \item \textbf{Mul(n)}: Returns the multiplication function $\mathbb{R}^n \to \mathbb{R}^1$ given by 
#! $(x_1, \ldots, x_n) \mapsto \prod_{i=1}^n x_i$.
#! \item \textbf{Power(n)}: Returns the power function $\mathbb{R}^1 \to \mathbb{R}^1$ given by $x \mapsto x^n$.
#! Its Jacobian matrix is $n \cdot x^{n-1}$.
#! \item \textbf{PowerBase(n)}: Returns the exponential function with base $n$, i.e., $\mathbb{R}^1 \to \mathbb{R}^1$ 
#! given by $x \mapsto n^x$. Its Jacobian matrix is $\log(n) \cdot n^x$.
#! \item \textbf{QuadraticLoss(n)}: Returns the quadratic loss function $\mathbb{R}^{2n} \to \mathbb{R}^1$ 
#! given by $(\hat{y}_1, \ldots, \hat{y}_n, y_1, \ldots, y_n) \mapsto \frac{1}{n}\sum_{i=1}^n (\hat{y}_i-y_i)^2$,
#! where the first $n$ components are the ground truth values and the last $n$ components are the predicted values.
#! \item \textbf{BinaryCrossEntropyLoss()}: Returns the binary cross-entropy loss function $\mathbb{R}^2 \to \mathbb{R}^1$ 
#! (requires $n=1$) given by $(\hat{y}, y) \mapsto -(y \log(\hat{y}) + (1-y) \log(1-\hat{y}))$, where $\hat{y}$ is the predicted probability 
#! and $y$ is the ground truth label.
#! \item \textbf{SigmoidBinaryCrossEntropyLoss()}: Returns the loss obtained by 
#! precomposing the binary cross-entropy loss with a functorial direct product of 
#! the sigmoid function (applied to the predicted logit) and the identity (applied 
#! to the ground-truth label). Formally, this is implemented as
#! \[
#! \text{SigmoidBinaryCrossEntropyLoss()}
#! \;=\;
#! \bigl( \,\sigma \times \mathrm{Id}\, \bigr)
#! \cdot
#! \text{BinaryCrossEntropyLoss}
#! \]
#! This corresponds to applying a sigmoid to the prediction component while leaving
#! the label component unchanged, followed by a numerically stable binary 
#! cross-entropy evaluation. In particular,
#! $(\hat{y}, y) \mapsto \log( 1 + e^{ -\hat{y} } ) + ( 1 - y ) \hat{y}$.
#! \item \textbf{CrossEntropyLoss(n)}: Returns the cross-entropy loss function $\mathbb{R}^{2n} \to \mathbb{R}^1$ 
#! given by $(\hat{y}_1, \ldots, \hat{y}_n, y_1, \ldots, y_n) \mapsto -\frac{1}{n}\sum_{i=1}^n y_i \log(\hat{y}_i)$, where 
#! the first $n$ components are predicted probabilities and the last $n$ components are ground truth labels.
#! \item \textbf{SoftmaxCrossEntropyLoss(n)}: Returns the loss obtained by 
#! applying a softmax transformation to the predicted logits and then evaluating
#! the multi-class cross-entropy with respect to the ground-truth labels.
#! Formally, the construction proceeds categorically as follows:
#! \begin{itemize}
#!   \item The predicted logits are extracted using the projection
#!         $p_1 : \mathbb{R}^n \times \mathbb{R}^n \to \mathbb{R}^n$.
#!   \item These logits are mapped to class probabilities via the softmax
#!         morphism $\mathrm{Softmax}_n$, yielding
#!         $p_1 \cdot \mathrm{Softmax}_n$.
#!   \item The ground-truth label vector is extracted by the second projection
#!         $p_2 : \mathbb{R}^n \times \mathbb{R}^n \to \mathbb{R}^n$.
#!   \item The softmax-transformed predictions and the ground-truth vector are
#!         recombined using the universal morphism into the direct product,
#!         forming $(\,p_1 \cdot \mathrm{Softmax}_n,\; p_2\,)$.
#!   \item Finally, this pair is composed with the multi-class cross-entropy loss
#!         $\mathrm{CrossEntropyLoss}_n$.
#! \end{itemize}
#! Altogether, the resulting morphism is
#! \[
#! \text{SoftmaxCrossEntropyLoss}(n)
#!   \;=\;
#! \bigl(\,p_1 \cdot \mathrm{Softmax}_n,\; p_2\,\bigr)
#! \cdot
#! \text{CrossEntropyLoss}_n.
#! \]
#! \item \textbf{AffineTransformation(m, n)}: Returns an affine transformation 
#! $\mathbb{R}^{(m+1)n+m} \to \mathbb{R}^n$ implementing the standard linear layer 
#! operation $z W + b$, where $z \in \mathbb{R}^{1 \times m}$ is the logits row vector,
#! $W \in \mathbb{R}^{m \times n}$ is the weight matrix, and $b \in \mathbb{R}^{1 \times n}$ 
#! is the bias row vector. The input to this morphism consists of $(m+1)n + m$ components 
#! structured as follows:
#! \begin{itemize}
#!   \item The first $(m+1)n$ components encode the weight matrix $W$ and bias vector $b$
#!         by concatenating the columns of the augmented matrix 
#!         $\begin{pmatrix} W \\ b \end{pmatrix} \in \mathbb{R}^{(m+1) \times n}$.
#!         Explicitly, for each output dimension $i \in \{1,\ldots,n\}$, we store
#!         the $i$-th column $(w_{1,i}, w_{2,i}, \ldots, w_{m,i}, b_i)^T$.
#!   \item The last $m$ components represent the logits $z = (z_1, \ldots, z_m)$ to be transformed.
#!   Usually, these correspond to the activations from the previous layer in a neural network.
#! \end{itemize}
#! The output is the $n$-dimensional vector
#! \[
#! \begin{pmatrix} z & 1 \end{pmatrix} \cdot \begin{pmatrix} W \\ b \end{pmatrix} = z\cdot W + b
#! \]
#! whose $i$-th component is given by
#! \[
#! \sum_{j=1}^m w_{j,i} \, z_j \;+\; b_i.
#! \]
#! For example, with $m=2$ and $n=3$, the input structure is
#! $$(w_{1,1}, w_{2,1}, b_1, w_{1,2}, w_{2,2}, b_2, w_{1,3}, w_{2,3}, b_3, z_1, z_2) \in \mathbb{R}^{(2+1)3 + 2} = \mathbb{R}^{11},$$
#! and the output is
#! $\begin{pmatrix} z_1 & z_2 \end{pmatrix} \cdot \begin{pmatrix} w_{1,1} & w_{1,2} & w_{1,3} \\ w_{2,1} & w_{2,2} & w_{2,3} \end{pmatrix} + \begin{pmatrix} b_1 & b_2 & b_3 \end{pmatrix}$,
#! which compiles to
#! \[
#! (w_{1,1} z_1 + w_{2,1} z_2 + b_1,\; 
#!  w_{1,2} z_1 + w_{2,2} z_2 + b_2,\; 
#!  w_{1,3} z_1 + w_{2,3} z_2 + b_3) \in \mathbb{R}^3.
#! \]
#! \end{itemize}
#! @EndLatexOnly

#! @Description
#!  List the names of available skeletal smooth maps.
#! @Returns a list of strings
#! @Arguments Smooth
DeclareGlobalFunction( "AvailableSkeletalSmoothMaps" );

DeclareGlobalFunction( "DummyInputStringsForAffineTransformation" );

#! @Description
#!  Generate dummy input expressions for an affine transformation with <A>m</A> inputs and <A>n</A> outputs.
#!  Its length is $(m+1)n + m$.
#!  Additional arguments specify the weight string, bias string, and a logits string.
#!  For example, for <A>m</A>=2 and <A>n</A>=3, with weight string "w", bias string "b", and logits string "z", the output is
#! <C>[ w1_1, w2_1, b_1, w1_2, w2_2, b_2, w1_3, w2_3, b_3, z1, z2 ]</C>.
#! @Arguments m, n, weight_str, bias_str, logits_str
#! @Returns a list of expressions
DeclareGlobalFunction( "DummyInputForAffineTransformation" );

DeclareGlobalFunction( "DummyInputStringsForPolynomialTransformation" );

DeclareGlobalFunction( "DummyInputForPolynomialTransformation" );
