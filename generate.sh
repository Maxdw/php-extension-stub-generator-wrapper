#!/bin/bash
git submodule update --init --remote --quiet
output_dir="./src"
requested_tag="$1"
extension="$2"
module_path="modules/php-extension-stub-generator/"
if [[ -z $requested_tag ]]
then
    msg="Error: call $0 with stub generator tag name e.g. '$0 0.0.1'"
    tags=$(cd $module_path && git tag)
    echo -e "$msg\\nversions:\\n$tags" 1>&2
    exit 1
fi
tag=$(cd $module_path && git tag | grep -m 1 $requested_tag)
tag="$tag"
if [[ -z $tag ]]
then
    echo "Error: requested tag name '$requested_tag' does not exist" 1>&2
    exit 1
fi
if [[ -z $extension ]]
then
    echo "Error: call $0 with installed php extension e.g. '$0 libxml'" 1>&2
    exit 1
fi
if [[ -z $(php -m | grep -m 1 $extension) ]]
then
    echo "Error: PHP extension $extension is not installed or configured" 1>&2
    exit 1
fi
$(cd $module_path && git checkout --quiet $tag)
chmod 0744 $module_path/php-extension-stub-generator.phar
rm -rf $output_dir/*
(echo "y" | $module_path/php-extension-stub-generator.phar dump-files $extension $output_dir) && status=0 || status=1
$(cd $module_path && git reset --hard --quiet && git checkout master)
exit $status