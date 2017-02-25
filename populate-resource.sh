#!/bin/bash

source /home/ubuntu/workspace/scripts/module/underscore_to_camel_case.sh;

function populate_resource {
# $1: file path
# $2: module name

#check if file path provided
if [ -z "$1" ]; then 
    echo "ERROR: no file path provided."
    return 0
fi

#check if module name provided
if [ -z "$2" ]; then 
    echo "ERROR: no module name provided."
    return 0
fi

file_path=$1;
module_name=$2;
class_name=$(underscore_to_camel_case $module_name);

cat <<EOF > $file_path;

<?php

  module_load_include('inc', 'dls_resource', 'rest_routes');

  class ${class_name}Resources {
    
    public static function TestResource() {
      \$resource = new RestRoutesResource('${module_name}', 'TestRoute');
      return \$resource;
    }
    
  }

EOF

}