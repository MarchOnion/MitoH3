#!/bin/bash
json=$1
java  -jar /cromwell-36.jar  run  /script/s1_MitochondriaPipeline.wdl  -i  $json
