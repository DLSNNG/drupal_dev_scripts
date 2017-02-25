#!/bin/bash
# $1: module name
# $2: theme name
# $3: comma separated variables

function update_module_themes {
  #check if module name provided
  if [ -z "$1" ]; then 
      echo "ERROR: no module name provided."
      return 0
  fi
  
  #check if theme name provided
  if [ -z "$2" ]; then 
      echo "ERROR: no theme name provided."
      return 0
  fi
  
  #check if variables provided
  if [ -z "$3" ]; then 
      echo "ERROR: no variables provided."
      return 0
  fi
  
  module_name=$1;
  theme_name=$2;
  variables=$3;
  current_directory=$(pwd);
  theme_text=$(get_theme_text $theme_name $variables);
  
  #insert the theme definition above the "return $theme" line in our module file
  sed -i "/return \$themes;/i $theme_text" $current_directory/$module_name.module;
}

# this produces the text that will be inserted into the modules hook_theme function
function get_theme_text {
  
  #check if module name provided
  if [ -z "$1" ]; then 
      echo "ERROR: no theme name provided."
      return 0
  fi
  
  #check if variables provided
  if [ -z "$2" ]; then 
      echo "ERROR: no variables provided."
      return 0
  fi
  
  theme_name=$1;
  variables=$2;
  # grab the text for our theme's variable definitions
  variable_string="$(get_variable_string $variables)";
  
  # return the full text to be inserted
  echo "\\\
  \$themes['${theme_name}']['variables'] = array( \n $variable_string \t); \n";
}

# this loops through the variables passed into the command
function get_variable_string {
  variables=$1;
  IFS=',' read -r -a variable_array <<< "$variables";
  variable_string="";
  for element in "${variable_array[@]}"
  do
    variable_string+="\t\t'$element' => NULL, \n\ ";
  done
  echo $variable_string;
}