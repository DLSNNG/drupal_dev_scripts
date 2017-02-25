#!/bin/bash

function populate_install {
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

cat <<EOF > $working_directory/$module_name.install
<?php

  module_load_include('inc', 'dls_rest_routes', '/includes/models/dls_rest_routes.rest_routes');
  module_load_include('inc', 'dls_rest_routes', '/includes/models/dls_rest_routes.rest_credentials');

  /**
   * Implements hook_install()
   */
   
  function ${module_name}_install() {
    \$restRoutes = RestRoutes::get()
      ->setRoute('$module_name', 'TestRoute', 'http://localhost.com')
      ->save();
    \$restCredentials = RestCredentials::get()
      ->setCredentials('$module_name')
      ->save();
  }

  /**
   * Implements hook_uninstall().
   */
  function ${module_name}_uninstall() {
    //remove route
    \$restRoutes = RestRoutes::get()
      ->removeGroup('$module_name')
      ->save();
    //remove credentials
    \$restCredentials = RestCredentials::get()
      ->removeCredentials('$module_name')
      ->save();
    // remove variables
    \$vars = array(
    );
    if (!empty(\$vars)) {
      foreach (\$vars as \$var):
        variable_del(\$var);
      endforeach;
    }
  }

EOF

}