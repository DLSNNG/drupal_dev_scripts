#!/bin/bash

function underscore_to_camel_case {
    # $1: input string
    input_string=$1;
    echo $input_string | sed -r 's/(^|_)([a-z])/\U\2/g';
}
