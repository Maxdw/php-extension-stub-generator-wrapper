# PHP stub generator

## LICENSE
This is basically a wrapper of sasezaki/php-extension-stub-generator and inherits its license.

## PURPOSE
- Generate stubs for a specific PHP extension from a Docker container
- Generate stubs using different versions of the stub generator

## USAGE EXAMPLE
``./generate.sh 0.0.4 libxml``
**argument 1**: version tag of php-extension-stub-generator
**argument 2**: php extension name
result: PHP stub files are output in src/ directory