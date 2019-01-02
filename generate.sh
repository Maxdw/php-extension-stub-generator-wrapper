#!/bin/bash
git submodule update --init --quiet
requested_tag="$1"
module_path="modules/php-extension-stub-generator/"
if [[ -z $requested_tag ]]
then
    echo "Error: call $0 with stub generator tag name e.g. '$0 0.0.1'"
    exit 1
fi
tag=$(cd $module_path && git tag | grep -m 1 $requested_tag)
tag="$tag"
if [[ -z $tag ]]
then
    echo "Error: requested tag name '$requested_tag' does not exist"
    exit 1
fi
$(cd $module_path && git checkout --quiet $tag)
chmod 0744 $module_path/php-extension-stub-generator.phar
$module_path/php-extension-stub-generator.phar dump-files swoole ./src