#! /bin/bash
# Copyright 2020 Mavenir
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


ARTIFACTS_PATH="./artifacts"
CHART_NAME="cnf_chart_template"

echo -e "[CNF-PACKAGING] Setting Artifacts Environment"
rm -rf $ARTIFACTS_PATH
mkdir -p $ARTIFACTS_PATH
mkdir -p $ARTIFACTS_PATH/images
mkdir -p $ARTIFACTS_PATH/template

version="$(cat $CHART_NAME/Chart.yaml | grep '^version:' | cut -d':' -f2 | tr -d '"' | tr -d '[:blank:]')"
name="$(cat $CHART_NAME/Chart.yaml | grep '^name:' | awk '{print $2}' | tr -d '"' | tr -d '[:blank:]')"
echo -e "[CNF-PACKAGING] chart-name: $name, chart-version: $version"

echo -e "[CNF-PACKAGING] Generating Artifacts!!!"
mkdir -p $ARTIFACTS_PATH/template/${name}_${version}
cp -rf $CHART_NAME/* $ARTIFACTS_PATH/template/${name}_${version}/
cp -rf images/* $ARTIFACTS_PATH/images/
cd $ARTIFACTS_PATH/template/
tar -czf "${name}-${version}.tgz" ${name}_${version}

rm -rf ${name}_${version}
echo -e "[CNF-PACKAGING] Released Artifacts: @$ARTIFACTS_PATH"
