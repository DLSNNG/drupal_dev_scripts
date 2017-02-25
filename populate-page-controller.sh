#!/bin/bash

function populate_controller {
# $1: module name
# $2: class name
# $3: file path

#check if class name provided
if [ -z "$1" ]; then 
    echo "ERROR: no class name provided."
    return 0
fi

#check if file path provided
if [ -z "$2" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

module_name=$1
class_name=$2;
file_path=$3;

cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_components', 'core');
  module_load_include('inc', '${module_name}', '/includes/resources/${module_name}.resources');
  
  class ${class_name}Controller extends dcontroller {
  
    protected \$allowedActions = array(
        
    );
    
    protected function onInit() {
      
      \$this->model->props = array(
        'title' => '${class_name} Title',
      );
    }
  }

EOF

}