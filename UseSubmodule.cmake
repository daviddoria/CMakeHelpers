macro(UseSubmodule Submodule CurrentProject)
 get_property(Found${Submodule} GLOBAL PROPERTY ${Submodule}IncludeDirs SET)
 if(NOT Found${Submodule})
   add_subdirectory(${Submodule})
 endif()

 get_property(${Submodule}IncludeDirs GLOBAL PROPERTY ${Submodule}IncludeDirs)
 set(${CurrentProject}_include_dirs ${${CurrentProject}_include_dirs} ${${Submodule}IncludeDirs})
 get_property(${Submodule}Libs GLOBAL PROPERTY ${Submodule}Libs)
 set(${CurrentProject}_libraries ${${CurrentProject}_libraries} ${${Submodule}Libs})

  include_directories(${${CurrentProject}_include_dirs})
endmacro()

# Example:
# UseSubmodule(Mask PatchBasedInpainting)
# expands to:

# get_property(FoundMask GLOBAL PROPERTY MaskIncludeDirs SET)
# if(NOT FoundMask)
#   add_subdirectory(Mask)
# endif()
# 
# get_property(MaskIncludeDirs GLOBAL PROPERTY MaskIncludeDirs)
# set(PatchBasedInpainting_include_dirs ${PatchBasedInpainting_include_dirs} ${MaskIncludeDirs})
# get_property(MaskLibs GLOBAL PROPERTY MaskLibs)
# set(PatchBasedInpainting_libraries ${PatchBasedInpainting_libraries} ${MaskLibs})
