#!/bin/bash

function populate_module {
# $1: working directory
# $2: module name

#check if working directory provided
if [ -z "$1" ]; then 
    echo "ERROR: no working directory provided."
    return 0
fi

#check if module name provided
if [ -z "$2" ]; then 
    echo "ERROR: no module name provided."
    return 0
fi

working_directory=$1;
module_name=$2;

cat <<EOF > $working_directory/$module_name.module

<?php

/**
 * @file $module_name module.
 */

//---------------------------------------------------------------------------------------------------------------------------
// Hooks and preprocess functions
//---------------------------------------------------------------------------------------------------------------------------

/**
 * Implementation of hook_permission().
 * Set permissions for module
 */
function ${module_name}_permission() {
  return array(
      'view $module_name' => array(
          'title' => 'View $module_name Pages',
          'description' => t('Allow user to view $module_name pages.')
      ),
  );
}

/**
 * Implements hook_menu().
 *
 * @return array
 */
function ${module_name}_menu() {
  \$routes = array();
  \$path = drupal_get_path('module', '$module_name') . '/includes/views';
  
  return \$routes;
}

function ${module_name}_theme() {
  \$themes = array();

  return \$themes;
}

EOF

}