# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# Declarations
#

#! @Chapter Expressions

#! @Section GAP Categories

#! @Description
#!  The &GAP; category of symbolic expressions.
#!  Expressions are used to represent mathematical formulas symbolically,
#!  allowing operations like differentiation to be performed symbolically before evaluation.
#! @Arguments e
DeclareCategory( "IsExpression", IsNearAdditiveElementWithInverse and IsAdditiveElement and IsMultiplicativeElement );

#! @Description
#!  The &GAP; category of constant expressions (expressions with no variables).
#!  Constant expressions represent fixed numerical values and can be evaluated directly.
#! @Arguments e
DeclareCategory( "IsConstantExpression", IsExpression );

#! @Section Constructors

#! @Description
#!  Create an expression from a list of <A>variables</A> and a <A>string</A> representation.
#! @Arguments variables, string
#! @Returns an expression
DeclareOperation( "Expression", [ IsDenseList, IsString ] );

#! @Description
#!  Create a constant expression from a <A>string</A>.
#!  The expression will have no variables and will also be registered as a global constant.
#! @Arguments string
#! @Returns a constant expression
DeclareOperation( "ConstantExpression", [ IsString ] );

#! @Section Attributes

#! @Description
#!  The list of variables of an expression.
#! @Arguments e
#! @Returns a list of strings
DeclareAttribute( "Variables", IsExpression );

#! @Description
#!  The string representation of an expression.
#! @Arguments e
#! @Returns a string
DeclareAttribute( "String", IsExpression );

#! @Description
#!  Convert an expression to a &GAP; function that can be evaluated numerically.
#! @Arguments e
#! @Returns a function
DeclareAttribute( "AsFunction", IsExpression );

DeclareOperation( "AsFunction", [ IsDenseList, IsString ] );

#! @Section Operations

DeclareOperation( "DummyInputStrings", [ IsString, IsInt ] );

#! @Description
#!  Generate a list of dummy input expressions using base name <A>var</A> with indices from 1 to <A>n</A>.
#!  For example, <C>DummyInput("x", 3)</C> returns a list of three expressions <C>x1, x2, x3</C>.
#!  Those can be used as input to smooth morphisms constructed from expressions.
#! @Arguments var, n
#! @Returns a list of expressions
DeclareOperation( "DummyInput", [ IsString, IsInt ] );

#! @Section Global Functions

#! @Description
#!  Assign to each string in <A>constants</A> a global constant expression defined by that string.
#!  The variables of these expressions will be empty.
#!  For example, <C>ConvertToConstantExpressions( ["Pi"] )</C> returns <C>[ Pi ]</C>,
#!  and <C>Variables(Pi)=[]</C>.
#! @Arguments constants
#! @Returns a list of constant expressions
DeclareGlobalFunction( "ConvertToConstantExpressions" );

#! @Description
#!  Assigns to each string in <A>variables</A> an expression with the same name.
#!  The variables of these expressions equals the list <A>variables</A> itself.
#!  After that, one would be able for example to construct more complex expressions using these variables,
#!  e.g., <C>x1 + Sin(x2)</C>.
#!  For example, <C>ConvertToExpressions( ["x1", "x2"] )</C> returns a pair <C>[ x1, x2 ]</C>,
#!  where <C>x1</C> and <C>x2</C> are expressions with string representations "x1" and "x2",
#!  and <C>Variables(x1) = ["x1", "x2"]</C>, <C>Variables(x2) = ["x1", "x2"]</C>.
#! @Arguments variables
#! @Returns a list of expressions
DeclareGlobalFunction( "CreateContextualVariables" );

#! @Description
#!  Assign each expression in <A>vars</A> to a global variable with the same name.
#!  For example, if <C>vars = [ x1, x2 ]</C>, this function will create global variables <C>x1</C> and <C>x2</C>
#!  corresponding to the expressions in the list.
#! @Arguments vars
DeclareGlobalFunction( "AssignExpressions" );

DeclareGlobalVariable( "LIST_OF_GLOBAL_CONSTANT_EXPRESSIONS" );
