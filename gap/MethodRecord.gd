# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter CAP Operations for GradientBasedLearningForCAP

DeclareGlobalVariable( "CRDC_INTERNAL_METHOD_NAME_RECORD" );

#! @Section Basic Operations

#! @Description
#!  Compute the pointwise multiplication of two morphisms with the same source and target.
#!  For morphisms $f, g: A \to B$, returns a morphism whose output at each component
#!  is the product of the outputs of $f$ and $g$.
#! @Arguments alpha, beta
#! @Returns a morphism
DeclareOperation( "MultiplicationForMorphisms", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

#! @Description
#!  Compute the reverse differential of a morphism <A>alpha</A> with given source and target objects.
#!  For a morphism $f: \mathbb{R}^m \to \mathbb{R}^n$, the reverse differential is a morphism
#!  $Df: \mathbb{R}^m \times \mathbb{R}^n \to \mathbb{R}^m$ that computes $y \cdot J_f(x)$
#!  where $J_f$ is the Jacobian matrix of $f$.
#! @Arguments source, alpha, range
#! @Returns a morphism
DeclareOperation( "ReverseDifferentialWithGivenObjects",
      [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

#! @Description
#!  Compute the reverse differential of a morphism <A>alpha</A>.
#!  This is equivalent to <C>ReverseDifferentialWithGivenObjects</C> with automatically computed source and target.
#! @Arguments alpha
#! @Returns a morphism
DeclareAttribute( "ReverseDifferential", IsCapCategoryMorphism );
