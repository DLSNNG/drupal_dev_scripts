#!/bin/bash
# $1: component name
# $2: theme variables

source /home/ubuntu/workspace/scripts/module2/populate-page-component.sh
source /home/ubuntu/workspace/scripts/module2/append-theme-to-module.sh

function build_component {
    # check if component name provided
    if [ -z "$1" ]; then 
        echo "ERROR: no component name provided.";
        return 0
    fi
    
    # prompt user for variables
    theme_variables="";
    theme_variable_types="";
    collect_input=1;
    while [ $collect_input = 1 ]; do
        echo "Add a theme variable. (Type 'cancel' to quit or 'done' to continue)";
        read VARIABLE;
        # check if user canceled script
        if [ "$VARIABLE" = "cancel" ]; then
            return 0;
        fi
        # check if user is done entering variables. Otherwise add variables.
        if [ "$VARIABLE" = "done" ]; then
            collect_input=0;
        else
            theme_variables+="$VARIABLE,";
            # ask user for type of variable if one is supplied, then add to list.
            echo "Enter variable type";
            read TYPE;
            theme_variable_types+="$TYPE,"
        fi
    done
    
    # init variables
    component_name=$1;
    current_directory=$(pwd);
    module_name=${current_directory##*/};
    # add theme definition to module
    update_module_themes $module_name $component_name $theme_variables;
    # compose directory paths
    theme_directory=$current_directory/theme;
    # create component file
    component_path=$theme_directory/${module_name}.${component_name}.inc;
    touch $component_path;
    # populate component file
    populate_component $component_name $component_path $theme_variables $theme_variable_types;
}

build_component $1 $2;