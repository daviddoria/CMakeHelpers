# A function to get all user defined variables with a specified prefix
function (getListOfVarsStartingWith _prefix _varResult)
    get_cmake_property(_vars VARIABLES)
    string (REGEX MATCHALL "(^|;)${_prefix}[A-Za-z0-9_]*" _matchedVars "${_vars}")
    set (${_varResult} ${_matchedVars} PARENT_SCOPE)
endfunction()

# This macro allows us to toggle a group of bool CMake variables
# I.e. if there are variables called myproject_ExeA, myproject_ExeB,
# and myproject_ExeC, we can enable/disable them all together using
# ToggleGroup(myproject)

macro(ToggleGroup GroupPrefix)
  # Add options to allow enabling/disabling of a set of targets
  option(TurnOnAll${GroupPrefix} "Turn on all variables starting with ${GroupPrefix}_")
  option(TurnOffAll${GroupPrefix} "Turn off all variables starting with ${GroupPrefix}_")

  if(TurnOnAll${GroupPrefix} AND TurnOffAll${GroupPrefix})
    message(FATAL_ERROR "You cannot turn a group of variables on and off at the same time!")
  endif()

  if(TurnOnAll${GroupPrefix})
      getListOfVarsStartingWith("${GroupPrefix}_" matchedVars)
      foreach (_var IN LISTS matchedVars)
          get_property(currentHelpString CACHE "${_var}" PROPERTY HELPSTRING)
          set(${_var} ON CACHE BOOL ${currentHelpString} FORCE)
      endforeach()

      get_property(turnOnHelpString CACHE "TurnOnAll${GroupPrefix}" PROPERTY HELPSTRING)
      set(TurnOnAll${GroupPrefix} OFF CACHE BOOL ${turnOnHelpString} FORCE)  # Set itself back to off, as this is a one time thing.
  endif()

  if(TurnOffAll${GroupPrefix})
      getListOfVarsStartingWith("${GroupPrefix}_" matchedVars)
      foreach (_var IN LISTS matchedVars)
          get_property(currentHelpString CACHE "${_var}" PROPERTY HELPSTRING)
          set(${_var} OFF CACHE BOOL ${currentHelpString} FORCE)
      endforeach()

      get_property(turnOffHelpString CACHE "TurnOffAll${GroupPrefix}" PROPERTY HELPSTRING)
      set(TurnOffAll${GroupPrefix} OFF CACHE BOOL ${turnOffHelpString} FORCE)  # Set itself back to off, as this is a one time thing.
  endif()
endmacro()
