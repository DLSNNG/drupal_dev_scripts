#!/bin/bash

function populate_info {
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

cat <<EOF > $working_directory/$module_name.info
name = $module_name
description = Description of $module_name.
core = 7.x
package = "DLS"
version = VERSION

; Files
files[] = $module_name.module

; Dependencies
dependencies[] = dls_rest_routes
dependencies[] = dls_resource
dependencies[] = dls_components
EOF

}