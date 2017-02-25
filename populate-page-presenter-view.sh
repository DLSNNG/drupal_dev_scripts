#!/bin/bash

function populate_view {
# $1: module name
# $2: page name
# $3: class name
# $4: file path

#check if module name provided
if [ -z "$1" ]; then 
    echo "ERROR: no module name provided."
    return 0
fi

#check if page name provided
if [ -z "$2" ]; then 
    echo "ERROR: no class name provided."
    return 0
fi

#check if class name provided
if [ -z "$3" ]; then 
    echo "ERROR: no class name provided."
    return 0
fi

#check if file path provided
if [ -z "$4" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

module_name=$1;
page_name=$2;
class_name=$3;
file_path=$4;


cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_components', 'core');
  module_load_include('inc', '$module_name', '/includes/models/${module_name}.${page_name}_model');
  module_load_include('inc', '$module_name', '/includes/components/${module_name}.${page_name}_component');
  module_load_include('inc', '$module_name', '/includes/controllers/${module_name}.${page_name}_presenter');

  function view_${module_name}_${page_name}() {
    \$block = ${class_name}Presenter::make(new ${class_name}Model(), new ${class_name}(array()));
    
    \$block['#attached']['css'][] = drupal_get_path('module', '${module_name}')
          . '/includes/views/${module_name}.${page_name}.css';
          
    return \$block;
  }

EOF

}