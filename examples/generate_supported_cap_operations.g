#! @Chapter Skeletal Category of Smooth Maps

#! @Section Supported CAP Operations

#! @Subsection Generate Documentation

#! @Example

LoadPackage( "GradientBasedLearningForCAP", false );
#! true

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ SkeletalSmoothMaps, "SkeletalSmoothMaps", 0 ],
    ],
    "GradientBasedLearningForCAP",
    "SkeletalCategoryOfSmoothMaps.autogen.gd",
    "Skeletal Category of Smooth Maps",
    "Supported CAP Operations"
);
#! @EndExample


#! @Chapter Category of Parametrised Morphisms

#! @Section Supported CAP Operations

#! @Subsection Generate Documentation

#! @Example
LoadPackage( "GradientBasedLearningForCAP", false );
#! true

Para := CategoryOfParametrisedMorphisms( SkeletalSmoothMaps );;

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ Para, "Category of Parametrised Smooth Maps", 0 ],
    ],
    "GradientBasedLearningForCAP",
    "CategoryOfParametrisedMorphisms.autogen.gd",
    "Category of Parametrised Morphisms",
    "Supported CAP Operations"
);

Lenses := CategoryOfLenses( SkeletalSmoothMaps );;

CAP_INTERNAL_GENERATE_DOCUMENTATION_FOR_CATEGORY_INSTANCES(
    [
        [ Lenses, "Category of Lenses of Smooth Maps", 0 ],
    ],
    "GradientBasedLearningForCAP",
    "CategoryOfLenses.autogen.gd",
    "Category of Lenses",
    "Supported CAP Operations"
);
#! @EndExample
