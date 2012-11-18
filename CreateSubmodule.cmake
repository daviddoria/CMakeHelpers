macro(CreateSubmodule Submodule)
  set(${Submodule}_include_dirs ${${Submodule}_include_dirs} ${CMAKE_CURRENT_SOURCE_DIR})
  set_property(GLOBAL PROPERTY ${Submodule}IncludeDirs ${${Submodule}_include_dirs})
  set_property(GLOBAL PROPERTY ${Submodule}Libs ${${Submodule}_libraries})

  # Display where this code was used from (if it is used as a submodule,
  # there may be multiple instances of this submodule in the project, only the first of which is used)
  option(${Submodule}_ShowSubmoduleLocation "Show the path from which ${Submodule} was used?" OFF)
  if(${Submodule}_ShowSubmoduleLocation)
    message("${Submodule} used from ${CMAKE_CURRENT_SOURCE_DIR}")
  endif(${Submodule}_ShowSubmoduleLocation)

endmacro()

# Example:
# CreateSubmodule(Mask)
# expands to:

# set(Mask_include_dirs ${Mask_include_dirs} ${CMAKE_CURRENT_SOURCE_DIR})
# set_property(GLOBAL PROPERTY MaskIncludeDirs ${Mask_include_dirs})
# set_property(GLOBAL PROPERTY MaskLibs ${Mask_libraries})
