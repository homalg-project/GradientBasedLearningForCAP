# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Category of Lenses

#! @Section Definition
#! Let $C$ be a cartesian category. The category of lenses $\mathbf{Lenses}(C)$ has:
#! - Objects: pairs of objects $(S_1, S_2)$ in $C$.
#! - Morphisms: a morphism from $f:(S_1, S_2) \to (T_1, T_2)$ is given by a pair of morphisms in $C$:
#!   - A "get" (or "forward") morphism $f_g: S_1 \to T_1$ in $C$.
#!   - A "put" (or "backward") morphism $f_p: S_1 \times T_2 \to S_2$ in $C$.
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}
#! % Nodes
#! \node (A)  at (-3, 1) {$S_1$};
#! \node (B)  at ( 3, 1) {$T_1$};
#! \node (Ap) at (-3,-1) {$S_2$};
#! \node (Bp) at ( 3,-1) {$T_2$};
#! \draw (-1.5,-1.8) rectangle (1.5,1.8);
#! \draw[->] (A) -- node[above] {$f_g$} (B);
#! \draw[->] (Bp) -- node[midway, below] {$f_p$} (Ap);
#! \draw[-] (-1,1) to[out=-90, in=90] (1,-1);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! - Composition: given lenses $f: (S_1, S_2) \to (T_1, T_2)$ and $h: (T_1, T_2) \to (U_1, U_2)$,
#!   their composition $f \cdot h: (S_1, S_2) \to (U_1, U_2)$ is defined by:
#!   - Get morphism: $f_g \cdot h_g: S_1 \to U_1$.
#!   - Put morphism: $\langle \pi_{S_1}, (f_g \times U_2)\cdot h_p\rangle \cdot f_p:S_1 \times U_2 \to S_2$,
#!     where $\langle -, -\rangle$ denotes the universal morphism into the product object.
#! @BeginLatexOnly
#! \[
#! \begin{tikzpicture}[node distance=3cm, auto]
#!   \node (S1U2) {$S_1 \times U_2$};
#!   \node (S1T2) [right of=S1U2, node distance=5cm] {$S_1 \times T_2$};
#!   \node (T1U2) [below of=S1U2] {$T_1 \times U_2$};
#!   \node (S1) [above of=S1T2] {$S_1$};
#!   \node (T2) [below of=S1T2] {$T_2$};
#!   \node (S2) [right of=S1T2] {$S_2$};
#!   \draw[->] (S1U2) -- node {$\langle \pi_{S_1}, (f_g \times U_2)\cdot h_p\rangle$} (S1T2);
#!   \draw[->] (S1U2) -- node {$\pi_{S1}$} (S1);
#!   \draw[->] (S1U2) -- node [left] {$f_g\times U_2$} (T1U2);
#!   \draw[->] (T1U2) -- node {$h_p$} (T2);
#!   \draw[->] (S1T2) -- node {$f_p$} (S2);
#! \end{tikzpicture}
#! \]
#! @EndLatexOnly
#! - Identity: the identity lens on $(S_1, S_2)$ has:
#!   - Get morphism: $id_{S_1}: S_1 \to S_1$.
#!   - Put morphism: the projection morphism $\pi_{S_2}: S_1 \times S_2 \to S_2$.

#! @Section GAP Categories

#! @Description
#!  The &GAP; category of a category of lenses.
DeclareCategory( "IsCategoryOfLenses",
        IsCapCategory );

#! @Description
#!  The &GAP; category of objects in a category of lenses.
DeclareCategory( "IsObjectInCategoryOfLenses",
        IsCapCategoryObject );

#! @Description
#!  The &GAP; category of morphisms in a category of lenses.
DeclareCategory( "IsMorphismInCategoryOfLenses",
        IsCapCategoryMorphism );

#! @Section Constructors

#! @Description
#!  Construct the category of lenses over the category <A>C</A>.
#!  A lens is a pair of morphisms: a "get" morphism and a "put" morphism,
#!  which together model bidirectional data flow used in automatic differentiation.
#! @Arguments C
#! @Returns a category
DeclareOperation( "CategoryOfLenses", [ IsCapCategory ] );

if false then

#! @Description
#!  Construct an object in the category of lenses given a pair of objects.
#! @Arguments Lens, obj_list
#! @Returns an object in the category of lenses
DeclareOperation( "ObjectConstructor", [ IsCategoryOfLenses, IsDenseList ] );

#! @Description
#!  Construct a morphism in the category of lenses given a pair of morphisms:
#!  a "get" morphism and a "put" morphism.
#! @Arguments Lens, source_obj, morphism_list, target_obj
#! @Returns a morphism in the category of lenses
DeclareOperation( "MorphismConstructor", [ IsCategoryOfLenses, IsObjectInCategoryOfLenses, IsDenseList, IsObjectInCategoryOfLenses ] );

fi;

#! @Section Attributes

#! @Description
#!  Returns the underlying pair of objects $(S_1, S_2)$ for an object in the category of lenses.
#!  This operation is a synonym for <C>ObjectDatum</C>.
#! @Arguments obj
#! @Returns a pair of objects
DeclareAttribute( "UnderlyingPairOfObjects", IsObjectInCategoryOfLenses );

#! @Description
#!  Returns the underlying pair of morphisms for a morphism in the category of lenses.
#! This operation is a synonym for <C>MorphismDatum</C>.
#! @Arguments f
#! @Returns a pair of morphisms
DeclareAttribute( "UnderlyingPairOfMorphisms", IsMorphismInCategoryOfLenses );

#! @Description
#!  Returns the "get" morphism of a lens.
#!  For a lens $f: (S_1, S_2) \to (T_1, T_2)$, the output is the get morphism $S_1 \to T_1$.
#! @Arguments f
#! @Returns a morphism
DeclareAttribute( "GetMorphism", IsMorphismInCategoryOfLenses );

#! @Description
#!  Returns the "put" morphism of a lens.
#!  For a lens $f: (S_1, S_2) \to (T_1, T_2)$, the output is the put morphism $S_1 \times T_2 \to S_2$.
#! @Arguments f
#! @Returns a morphism
DeclareAttribute( "PutMorphism", IsMorphismInCategoryOfLenses );

#! @Section Operations

#! @Description
#!  Embedding functor from the category <A>Smooth</A> of smooth maps into its category of lenses <A>Lenses</A>.
#!  An object $\mathbb{R}^m$ in <A>Smooth</A> is mapped to the lens $(\mathbb{R}^m, \mathbb{R}^m)$,
#!  and a morphism $f: \mathbb{R}^m \to \mathbb{R}^n$ is mapped to the lens
#!  with get morphism $f: \mathbb{R}^m \to \mathbb{R}^n$ and put morphism 
#!  $Rf: \mathbb{R}^m \times \mathbb{R}^n \to \mathbb{R}^m$ given by
#!  $(u,v) \mapsto vJ_f(u)$, where $J_f(u) \in \mathbb{R}^{n \times m}$ is the Jacobian matrix of $f$ evaluated 
#!  at $u \in \mathbb{R}^m$. This functor might be defined for any cartesian reverse-differentiable category,
#!  but the category of smooth maps is the only such category currently implemented in this package.
#!  For example, if $f: \mathbb{R}^2 \to \mathbb{R}$ is defined by
#!  $f(x_1, x_2) = (x_1^3 + x_2^2)$, the the corresponding $Rf:\mathbb{R}^2 \times \mathbb{R} \to \mathbb{R}^2$ is given by
#!  $Rf((x_1, x_2), y) = y(3x_1^2, 2x_2) = (3x_1^2y, 2x_2y)$.
#! @Arguments Smooth, Lenses
#! @Returns a functor
DeclareOperation( "ReverseDifferentialLensFunctor", [ IsSkeletalCategoryOfSmoothMaps, IsCategoryOfLenses ] );

#! @Section Optimizers

#! @BeginLatexOnly
#! In this section we document the optimizers provided via the dot operator
#! $\mathrm{Lenses}.( .. )$ when the underlying category is the skeletal category of smooth maps.
#! The optimizers are lenses whose get-part reads the current parameters and whose put-part
#! performs the parameter/state update.
#! In the formulas below we use the following conventions:
#! \begin{itemize}
#! \item $\theta_t \in \mathbb{R}^n$: the current parameter vector.
#! \item $g_t \in \mathbb{R}^n$: the current gradient (coming from backpropagation).
#! \item $\eta > 0$: learning rate.
#! \item All operations on vectors are meant componentwise.
#! \end{itemize}
#! \begin{itemize}
#! \item
#!  \textbf{GradientDescentOptimizer}:
#!  This is plain gradient descent with update
#!  $$(\theta_t,g_t) \mapsto \theta_t + \eta g_t =: \theta_{t+1}.$$
#! \item
#!  \textbf{GradientDescentWithMomentumOptimizer}:
#!  This optimizer maintains a momentum vector $s_t \in \mathbb{R}^n$.
#!  With momentum parameter $\mu \in [0,1)$ the update is
#!  $$(s_t, \theta_t, g_t) \mapsto (\mu\, s_t + \eta\, g_t, \theta_t + \mu\, s_t + \eta\, g_t) =: (s_{t+1}, \theta_{t+1}).$$
#!  Note that the \textbf{GradientDescentOptimizer} is a special case of this optimizer with $\mu = 0$.
#! \item
#!  \textbf{AdagradOptimizer}:
#!  This optimizer maintains an accumulator $s_t \in \mathbb{R}^n$ of squared gradients.
#!  With $\epsilon > 0$ the update is
#!  $$ (s_t, \theta_t, g_t) \mapsto (s_t + g_t^2, \theta_t + \eta\, \frac{g_t}{\epsilon + \sqrt{s_t + g_t^2}}) =: (s_{t+1}, \theta_{t+1}).$$
#!  \item
#!  \textbf{AdamOptimizer}:
#!  This optimizer maintains first and second moment estimates $m_t, v_t \in \mathbb{R}^n$.
#!  With parameters $\beta_1,\beta_2 \in [0,1)$ and $\epsilon > 0$ the update is
#!    $$ (t, m_t, v_t, \theta_t, g_t) \mapsto (t+1, \beta_1 m_t + (1-\beta_1) g_t, \beta_2 v_t + (1-\beta_2) g_t^2, \theta_t + \eta\, \frac{\hat m_{t+1}}{\epsilon + \sqrt{\hat v_{t+1}}}) =: (t+1, m_{t+1}, v_{t+1}, \theta_{t+1})$$
#!  where
#!  \begin{align*}
#!    \hat m_{t+1} &= \frac{\beta_1 m_t + (1-\beta_1) g_t}{1-\beta_1^{t+1}}, \\
#!    \hat v_{t+1} &= \frac{\beta_2 v_t + (1-\beta_2) g_t^2}{1-\beta_2^{t+1}}. \\
#!  \end{align*}
#!  The iteration counter $t$ is included in the input because the update formulas depend on it ($\beta_1^{t+1}$ and $\beta_2^{t+1}$),
#!  while in the other optimizers $t$ was merely an index and not needed for the update.
#!  \end{itemize}
#! @EndLatexOnly
