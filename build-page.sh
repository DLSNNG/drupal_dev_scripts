#!/bin/bash
# $1: page name

source /home/ubuntu/workspace/scripts/module2/populate-page-view.sh
source /home/ubuntu/workspace/scripts/module2/append-route-to-module.sh

function build_page {
    # check if page name provided
    if [ -z "$1" ]; then 
        echo "ERROR: no page name provided."
        return 0
    fi
    # init variables
    page_name=$1
    current_directory=$(pwd);
    module_name=${current_directory##*/}
    # compose directory paths
    includes=$current_directory/includes;
    views_directory=$includes/views/${page_name};
    # create view directory
    mkdir -p $views_directory;
    # create file for page callback
    views_path=$views_directory/${module_name}.${page_name}.inc;
    touch $views_path;
    populate_view $module_name $page_name $views_path;
    # create file for page styles
    css_path=$views_directory/${module_name}.${page_name}.css;
    touch $css_path;
    # add page callback to module routes
    update_module_routes $module_name $page_name;
}

build_page $1;