macro(CreateSubmodule Submodule)
  set(${Submodule}_include_dirs ${${Submodule}_include_dirs} ${CMAKE_CURRENT_SOURCE_DIR})
  set_property(GLOBAL PROPERTY ${Submodule}IncludeDirs ${${Submodule}_include_dirs})
  set_property(GLOBAL PROPERTY ${Submodule}Libs ${${Submodule}_libraries})
endmacro()

# Example:
# CreateSubmodule(Mask)
# expands to:

# set(Mask_include_dirs ${Mask_include_dirs} ${CMAKE_CURRENT_SOURCE_DIR})
# set_property(GLOBAL PROPERTY MaskIncludeDirs ${Mask_include_dirs})
# set_property(GLOBAL PROPERTY MaskLibs ${Mask_libraries})