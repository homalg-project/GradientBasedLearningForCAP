# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Category of Parametrised Morphisms


#! @Section Definition

#! Let $(C, \otimes, I)$ be a strict symmetric monoidal category. The category $P(C)$ of parametrized morphisms
#! is given by the following data:
#!
#! * **Objects**: $\mathrm{Obj}(P(C)) := \mathrm{Obj}(C)$
#!
#! * **Morphisms**: For two objects $A$ and $B$ in $P(C)$, a morphism $f \colon A \to B$ in $P(C)$ consists of:
#!   * A parameter object $P \in \mathrm{Obj}(C)$
#!   * A morphism $f_P \colon P \otimes A \to B$ in $C$
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}[baseline=-2pt]
#! \node[draw, minimum width=2cm, minimum height=1cm] (F) {$f_P$};
#! \node[left=1.2cm of F] (A) {$A$};
#! \node[right=1.2cm of F] (B) {$B$};
#! \node[above=1cm of F] (P) {$P$};
#! 
#! \draw[->] (A) -- (F);
#! \draw[->] (F) -- (B);
#! \draw[->] (P) -- (F);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! * **Composition**: Given two morphisms $f=(P,f_P) \colon A \to B$ and $g =(Q,g_Q) \colon B \to C$ in $P(C)$,
#! their composition $f \cdot g \colon A \to C$ is given by the pair
#! @BeginLatexOnly
#! \[
#! \left( Q \otimes P, (\mathrm{id}_Q \otimes f_P) \cdot g_Q \colon (Q \otimes P) \otimes A \to C \right).
#! \]
#! \[
#! \begin{tikzpicture}[baseline=-2pt]
#! \node[draw, minimum width=2cm, minimum height=1cm] (F) {$Q \otimes P \otimes A \xrightarrow{\mathrm{id}_Q \otimes f_P} Q \otimes B \xrightarrow{g_Q} C$};
#! \node[left=1.2cm of F] (A) {$A$};
#! \node[right=1.2cm of F] (C) {$C$};
#! \node[above=1cm of F] (QP) {$Q \otimes P$};
#! 
#! \draw[->] (A) -- (F);
#! \draw[->] (F) -- (C);
#! \draw[->] (QP) -- (F);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! * **Identity morphisms**: For each object $A$ in $P(C)$, the identity morphism is given by
#! the pair $\mathrm{id}_A = \left( I, (\mathrm{id}_A)_I := \mathrm{id}_A \in \mathbf{Hom}_C(A, A)) \right)$.

#! @Section GAP Categories

#! @Description
#!  The &GAP; category of a category of parametrised morphisms.
DeclareCategory( "IsCategoryOfParametrisedMorphisms",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a category of parametrised morphisms.
DeclareCategory( "IsObjectInCategoryOfParametrisedMorphisms",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a category of parametrised morphisms.
DeclareCategory( "IsMorphismInCategoryOfParametrisedMorphisms",
        IsCapCategoryMorphism );

#! @Section Constructors

#! @Description
#!  Construct the category of parametrised morphisms over the category <A>C</A>.
#! @Arguments C
#! @Returns a category
DeclareOperation( "CategoryOfParametrisedMorphisms", [ IsCapCategory ] );

if false then
#! @Description
#!  Construct an object in the category of parametrised morphisms.
#! @Arguments Para, A
#! @Returns an object in the category of parametrised morphisms
DeclareOperation( "ObjectConstrutor", [ IsCategoryOfParametrisedMorphisms, IsCapCategoryObject ] );


#! @Description
#!  Construct a morphism in the category of parametrised morphisms.
#! The datum is a pair consisting of the parameter object $P$ and the underlying morphism $f_P \colon P \otimes A \to B$.
#! @Arguments Para, A, datum, B
#! @Returns a morphism in the category of parametrised morphisms
DeclareOperation( "MorphismConstructor",
    [ IsCategoryOfParametrisedMorphisms,
      IsObjectInCategoryOfParametrisedMorphisms,
      IsDenseList,
      IsObjectInCategoryOfParametrisedMorphisms ] );
fi;

#! @Section Attributes

#! @Description
#!  Returns the underlying category of a category of parametrised morphisms.
#! @Arguments Para
#! @Returns a category
DeclareAttribute( "UnderlyingCategory", IsCategoryOfParametrisedMorphisms );

#! @Description
#!  Returns the underlying object for an object in the category of parametrised morphisms.
#! @Arguments A
#! @Returns an object in the underlying category
DeclareAttribute( "UnderlyingObject", IsObjectInCategoryOfParametrisedMorphisms );

#! @Description
#!  Returns the parameter object (underlying object) of a parametrised morphism.
#! @Arguments f
#! @Returns an object in the underlying category
DeclareAttribute( "UnderlyingObject", IsMorphismInCategoryOfParametrisedMorphisms );

#! @Description
#!  Returns the underlying morphism $f_p:P \otimes A \to B \in C$ in $C$ of a parametrised morphism
#!  $f = (P, f_p:P \otimes A \to B):A \to B$ in $P(C)$.
#! @Arguments f
#! @Returns a morphism in the underlying category
DeclareAttribute( "UnderlyingMorphism", IsMorphismInCategoryOfParametrisedMorphisms );

#! @Section Operations

#! @Description
#!  The input is a parametrised morphism $f=(P,f_P: P\otimes A \to B): A \to B$ and a morphism $r: Q \to P$ in $C$.
#!  The output is the reparametrised morphism $\hat{f}=(Q,\hat{f}_Q: Q \otimes A \to B): A \to B$ where $\hat{f}_Q := (r \otimes \mathrm{id}_A) \cdot f_P \colon Q \otimes A \to B$.
#! @Arguments f, r
#! @Returns a parametrised morphism
DeclareOperation( "ReparametriseMorphism", [ IsMorphismInCategoryOfParametrisedMorphisms, IsCapCategoryMorphism ] );

#! @Description
#!  The input is a parametrised morphism $f=(P,f_P: P\otimes A \to B): A \to B$.
#!  The output is the parametrised morphism $\hat{f}=(A,\hat{f}_A: A \otimes P \to B): P \to A$ where $\hat{f}_A := \sigma_{A,P} \cdot f_P \colon A \otimes P \to B$,
#!  with $\sigma_{A,P}: A \otimes P \to P \otimes A$ being the symmetry isomorphism (braiding) in the underlying symmetric monoidal category $C$.
#! @Arguments f
#! @Returns a parametrised morphism
DeclareOperation( "FlipParameterAndSource", [ IsMorphismInCategoryOfParametrisedMorphisms ] );

DeclareSynonym( "FlipSourceAndParameter", FlipParameterAndSource );

#! @Description
#!  Adjusts a parametrised morphism to process a batch of <A>n</A> inputs simultaneously.
#!  Given a parametrised morphism $f = (P, f_P \colon P \otimes A \to B): A \to B$ where the target $B$ has rank 1,
#!  this operation produces a new parametrised morphism that can handle $n$ copies of $A$ at once (a batch of size $n$).
#!  
#!  The construction works as follows:
#!  * The source becomes the direct product of $n$ copies of $A$: $A^n = A \times \cdots \times A$
#!  * The parameter object remains $P$
#!  * The underlying morphism is constructed by: $\alpha \cdot f_P^{(n)} \cdot \mu_n \colon P \otimes A^n \to B$
#!    where:
#!    - $\alpha:P \otimes A^n \to (P \otimes A)^n$ is the morphism that reuses the parameter $P$ across the $n$ components.
#!      For example, when $n=2$, $\alpha$ sends $(p, a_1, a_2) \in P \otimes A^2$ to $(p, a_1, p, a_2) \in (P \otimes A)^2$, i.e., the same parameter $p$ is paired with each input (training example) $a_i$.
#!    - $f_P^{(n)}: (P \otimes A)^n \to B^n$ is the direct product of $n$ copies of $f_P$,
#!    - $\mu_n: B^n \to B$ is the mean aggregator that averages the $n$ outputs into a single output in $B$ (since $B$ has rank 1).
#! @Arguments f, n
#! @Returns a parametrised morphism
DeclareOperation( "Batchify", [ IsMorphismInCategoryOfParametrisedMorphisms, IsInt ] );

#! @Description
#!  Natural embedding functor from category <A>C</A> into category of parametrised morphisms <A>P</A> (of <A>C</A>).
#!  Objects are mapped to themselves, and a morphism $f: A \to B$ in <A>C</A> is mapped to the parametrised morphism
#!  $(I, f_I: I \otimes A \xrightarrow{f} B): A \to B$ in <A>P</A>. Note that $I \otimes A = A$ by the strict monoidal unit property.
#!  This functor reflects the fact that ordinary morphisms can be viewed as parametrised morphisms with a trivial (unit) parameter.
#! @Arguments C, P
#! @Returns a functor
DeclareOperation( "NaturalEmbedding", [ IsCapCategory, IsCategoryOfParametrisedMorphisms ] );

#! @Description
#!  Embedding functor from category of parametrised morphisms <A>Para</A> into another category of parametrised morphisms <A>Para_Lenses</A>.
#! @Arguments Para, Para_Lenses
#! @Returns a functor
DeclareOperation( "EmbeddingIntoCategoryOfParametrisedMorphisms", [ IsCategoryOfParametrisedMorphisms, IsCategoryOfParametrisedMorphisms ] );

#! @Section Available Parametrised Morphisms

#! All available smooth maps can be lifted to parametrised morphisms in the category of parametrised morphisms
#! by using one of the following two methods:
#! - Using the natural embedding functor from the category of smooth maps into the category of parametrised morphisms,
#!   which associates to each smooth map $f: A \to B$ the parametrised morphism
#!   $(I, f_I: I \otimes A \xrightarrow{f} B): A \to B$ where $I$ is the monoidal unit. For example, $\mathrm{Cos}$, $\mathrm{Exp}$, $\mathrm{Log}$ etc.
#! - Constructing parametrised morphisms directly by specifying the parameter object and the underlying morphism.
#!    For instance, the construction of an affine transformation as a parametrised morphism:
#!    @BeginLatexOnly
#!    \[
#!    \begin{tikzpicture}[baseline=-2pt]
#!    \node[draw, minimum width=2cm, minimum height=1cm] (F) {$f_P:\mathbb{R}^{(m+1)n+m} \to \mathbb{R}^n$};
#!    \node[left=1.2cm of F] (A) {$\mathbb{R}^m$};
#!    \node[right=1.2cm of F] (B) {$\mathbb{R}^n$};
#!    \node[above=1cm of F] (P) {$\mathbb{R}^{(m+1)n}$};
#!    
#!    \draw[->] (A) -- (F);
#!    \draw[->] (F) -- (B);
#!    \draw[->] (P) -- (F);
#!    \end{tikzpicture}
#!    \]
#!    where $f_P:\mathbb{R}^{(m+1)n+m} \to \mathbb{R}^n$ is the standard smooth affine transformation map that
#!    computes $z W + b$, where
#!    $W \in \mathbb{R}^{m \times n}$ is the weight matrix, $b \in \mathbb{R}^{1 \times n}$
#!    is the bias row vector and $z \in \mathbb{R}^{1 \times m}$ is the logits row-vector.
#!    More explicitly, the input to this morphism consists of $(m+1)n + m$ components 
#!    structured as follows:
#!    \begin{itemize}
#!      \item The first $(m+1)n$ components encode the weight matrix $W$ and bias vector $b$
#!            by concatenating the columns of the augmented matrix 
#!            $\begin{pmatrix} W \\ b \end{pmatrix} \in \mathbb{R}^{(m+1) \times n}$.
#!            Explicitly, for each output dimension $i \in \{1,\ldots,n\}$, we have
#!            the $i$-th column $(w_{1,i}, w_{2,i}, \ldots, w_{m,i}, b_i)^T$, i.e., $(m+1)$ parameters.
#!            Thus, the parameter object $P$ is $\mathbb{R}^{(m+1)n}$.
#!      \item The last $m$ components represent the logits $z = (z_1, \ldots, z_m)$ to be transformed.
#!      Usually, these correspond to the activations from the previous layer in a neural network.
#!    \end{itemize}
#!    For example, for $m=2$ and $n=3$, the morphism $f_P$ maps
#!    $$(w_{1,1}, w_{1,2}, w_{1,3}, b_1, w_{2,1}, w_{2,2}, w_{2,3}, b_2, z_1, z_2, z_3) \in \mathbb{R}^{(3+1) \cdot 2 + 3} = \mathbb{R}^{8+3}=\mathbb{R}^{11}$$
#!    to
#!    $\begin{pmatrix} z_1 & z_2 & z_3 & 1 \end{pmatrix} \cdot \begin{pmatrix} w_{1,1} & w_{1,2} \\ w_{2,1} & w_{2,2} \\ w_{3,1} & w_{3,2} \\ b_1 & b_2 \end{pmatrix} = $
#!    $\begin{pmatrix} z_1 & z_2 & z_3 \end{pmatrix} \cdot \begin{pmatrix} w_{1,1} & w_{1,2} \\ w_{2,1} & w_{2,2} \\ w_{3,1} & w_{3,2} \end{pmatrix} + \begin{pmatrix} b_1 & b_2 \end{pmatrix}$ \\
#!    which compiles to $$(w_{1,1} z_1 + w_{2,1} z_2 + w_{3,1} z_3 + b_1,\; w_{1,2} z_1 + w_{2,2} z_2 + w_{3,2} z_3 + b_2) \in \mathbb{R}^2.$$
#!    @EndLatexOnly
