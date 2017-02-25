#!/bin/bash

function populate_view {
# $1: module name
# $2: page name
# $3: file path

#check if module name provided
if [ -z "$1" ]; then 
    echo "ERROR: no module name provided."
    return 0
fi

#check if page name provided
if [ -z "$2" ]; then 
    echo "ERROR: no page name provided."
    return 0
fi

#check if file path provided
if [ -z "$3" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

module_name=$1;
page_name=$2;
file_path=$3;


cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_components', 'core');

  function view_${module_name}_${page_name}() {
    \$block = array(
      '#type' => 'markup',
      '#markup' => 'testing',
    );
    
    \$block['#attached']['css'][] = drupal_get_path('module', '${module_name}')
          . '/includes/views/${module_name}.${page_name}.css';
          
    return \$block;
  }

EOF

}