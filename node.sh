#!/bin/bash
#
# Copyright 2017 Liu Hongyu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#===  FUNCTION  ================================================================
#         NAME:  version
#  DESCRIPTION:  Convert a version string to integer
# PARAMETER  1:  Version string
#===============================================================================

for i in `seq 1 200`;
do
    DIRNAME="vol$i"
    mkdir -p /mnt/data/$DIRNAME 
    chcon -Rt svirt_sandbox_file_t /mnt/data/$DIRNAME
    chmod 777 /mnt/data/$DIRNAME
done
