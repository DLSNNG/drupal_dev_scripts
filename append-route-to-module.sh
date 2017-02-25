#!/bin/bash
# $1: module name
# $2: page name

function update_module_routes {
  current_directory=$(pwd);
  route_text=$(get_route_text $1 $2);
  sed -i "/return \$routes;/i $route_text" $current_directory/$1.module;
}

function get_route_text {
  
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
  
  module_name=$1;
  page_name=$2;
  
  echo "\\\
  \$routes['${module_name}/${page_name}'] = array( \n\
    'title' => '${module_name} ${page_name}', \\n\
    'page callback' => 'view_${module_name}_${page_name}', \n\
    'access arguments' => array('view $module_name'), \n\
    'file path' => \$path . '/${page_name}', \n\
    'file' => '${module_name}.${page_name}.inc', \n\
  ); \n\
  ";
}