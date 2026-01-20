# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage( "AutoDoc", "2025.12.19" ) then
    
    Error( "AutoDoc version 2025.12.19 or newer is required." );
    
fi;

AutoDoc( rec(
    autodoc := rec(
        files := [ "doc/Doc.autodoc" ],
        scan_dirs := [ "doc", "gap", "examples", "examples/doc",
                       "examples/NeuralNetwork_BinaryCrossEntropy", 
                       "examples/NeuralNetwork_CrossEntropy",
                       "examples/NeuralNetwork_QuadraticLoss",
                        ],
    ),
    extract_examples := rec(
        units := "Single",
    ),
    gapdoc := rec(
        LaTeXOptions := rec(
            LateExtraPreamble := """
                \usepackage{tikz}
                \usetikzlibrary{positioning}
                \usepackage{mathtools}
                \usepackage{stmaryrd}
                \DeclareUnicodeCharacter{211D}{\ensuremath{\mathbb{R}}}
                \DeclareUnicodeCharacter{2023}{\ensuremath{\blacktriangleright}}
            """,
        ),
    ),
    scaffold := rec(
        entities := rec( homalg := "homalg", CAP := "CAP" ),
    ),
) );

QUIT;
