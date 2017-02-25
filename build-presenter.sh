#!/bin/bash
# $1: page name

source /home/ubuntu/workspace/scripts/module/underscore_to_camel_case.sh;
source /home/ubuntu/workspace/scripts/module/populate-page-model.sh
source /home/ubuntu/workspace/scripts/module/populate-page-component.sh
source /home/ubuntu/workspace/scripts/module/populate-page-presenter.sh
source /home/ubuntu/workspace/scripts/module/populate-page-presenter-view.sh
source /home/ubuntu/workspace/scripts/module/append-route-to-module.sh

function build_page {
    # check if page name provided
    if [ -z "$1" ]; then 
        echo "ERROR: no page name provided."
        return 0
    fi
    # init variables
    page_name=$1
    class_name=$(underscore_to_camel_case $page_name);
    current_directory=$(pwd);
    module_name=${current_directory##*/}
    # compose directory paths
    includes=$current_directory/includes;
    models_directory=$includes/models;
    components_directory=$includes/components;
    controller_directory=$includes/controllers;
    views_directory=$includes/views;
    # create page files
    model_path=$models_directory/${module_name}.${page_name}_model.inc;
    touch $model_path;
    populate_model $module_name $class_name $model_path;
    component_path=$components_directory/${module_name}.${page_name}_component.inc;
    touch $component_path;
    populate_component $class_name $component_path;
    controller_path=$controller_directory/${module_name}.${page_name}_presenter.inc;
    touch $controller_path;
    populate_presenter $module_name $page_name $class_name $controller_path;
    view_path=$views_directory/${module_name}.${page_name}.inc;
    touch $view_path;
    populate_view $module_name $page_name $class_name $view_path;
    style_path=$views_directory/${module_name}.${page_name}.css;
    touch $style_path;
    update_module_routes $module_name $page_name $class_name $class_name;
}

build_page $1;