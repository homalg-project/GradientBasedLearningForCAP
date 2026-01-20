# SPDX-License-Identifier: GPL-2.0-or-later
# GradientBasedLearningForCAP: Gradient Based Learning via Category Theory
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "GradientBasedLearningForCAP",
Subtitle := "Gradient Based Learning via Category Theory",
Version := "2026.01-01",
Date := "2026-01-20",
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/GradientBasedLearningForCAP",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/GradientBasedLearningForCAP",
PackageInfoURL  := "https://homalg-project.github.io/GradientBasedLearningForCAP/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/GradientBasedLearningForCAP/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/GradientBasedLearningForCAP/releases/download/v", ~.Version, "/GradientBasedLearningForCAP-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "GradientBasedLearningForCAP",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Gradient Based Learning via Category Theory",
),

Dependencies := rec(
  GAP := ">= 4.13.0",
  NeededOtherPackages := [
                   [ "GAPDoc", ">= 1.5" ],
                   [ "CAP", ">= 2024.09-12" ],
                   [ "MonoidalCategories", ">= 2024.04-01" ],
                   [ "CartesianCategories", ">= 2024.04-01" ],
                   [ "ToolsForCategoricalTowers", ">= 2024.06-02" ],
                   ],
  SuggestedOtherPackages := [
                   [ "ToolsForHigherHomologicalAlgebra", ">= 2023.01-01" ], # for 'Show'ing latex-strings
                   ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

Keywords := [ "Explore Categorical Machine Learning" ],

));
