#!/bin/bash

function populate_component {
# $1: component name
# $2: file path
# $3: variables
# $4: variable types

#check if class name provided
if [ -z "$1" ]; then 
    echo "ERROR: no component name provided."
    return 0
fi

#check if file path provided
if [ -z "$2" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

#check if variables provided
if [ -z "$3" ]; then 
    echo "ERROR: no theme variables provided."
    return 0
fi

#check if variable types provided
if [ -z "$4" ]; then 
    echo "ERROR: no theme variable types provided."
    return 0
fi

component_name=$1;
file_path=$2;
theme_variables=$3;
theme_variable_types=$4;
comment_string=$(get_comment_string $theme_variables $theme_variable_types);
check_variable_string=$(check_variable_types $component_name $theme_variables $theme_variable_types);


cat <<EOF > $file_path;

<?php

  /*************************************************************
   *
$comment_string
   *  @returns: drupal render array
   *
   *************************************************************/

  function theme_${component_name}(\$variables) {
  

$check_variable_string

    ///////////////////////////////////////
    //  Render Component
    ///////////////////////////////////////
    
    \$block = array(
      '#type' => 'markup',
      '#markup' => 'implement theme ${component_name}',
    );
    return \$block;
  }

EOF

}

# this loops through the variables passed into the command
function get_comment_string {
  variables=$1;
  types=$2;
  IFS=',' read -r -a variable_array <<< "$variables";
  IFS=',' read -r -a type_array <<< "$types";
  
  num_variables=${#variable_array[@]};
  comment_string="";
  for (( i=0; i<${num_variables}; i++ ));
  do
    variable=${variable_array[$i]};
    type=${type_array[$i]};
    echo "   *  @param: $variable = $type";
  done
}

function check_variable_types {
  component_name=$1;
  variables=$2;
  types=$3;
  IFS=',' read -r -a variable_array <<< "$variables";
  IFS=',' read -r -a type_array <<< "$types";
  
  num_variables=${#variable_array[@]};
  comment_string="";
  for (( i=0; i<${num_variables}; i++ ));
  do
    variable=${variable_array[$i]};
    type=${type_array[$i]};
    echo "    // Validate and set $variable property";
    echo "    if((gettype(\$variables['$variable']) == '$type')) { ";
    echo "      \$$variable = \$variables['$variable'];";
    echo "    }";
    echo "    else {";
    echo "      form_set_error('', 'theme $component_name - $variable should be $type. Received ' . gettype(\$variables['$variable']) . '.');";
    echo "      return;"
    echo "    }";    
  done
}