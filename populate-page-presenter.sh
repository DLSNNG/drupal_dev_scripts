#!/bin/bash

function populate_presenter {
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

module_name=$1;
page_name=$2;
class_name=$3;
file_path=$4;

cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_components', 'core');
  module_load_include('inc', '$module_name', '/includes/components/${module_name}.${page_name}_component');
  
  class ${class_name}Presenter extends dpresenter {
  
    protected \$allowedActions = array(
        
    );
    
    protected function determineProps() {
      
      \$this->props = array(
        'title' => '${class_name} Title',
      );
    }
  }

EOF

}