#!/bin/bash

DST=/usr/local/bin

mkdir -p $DST

cp syntax_check $DST
cp syntax_check_git $DST
cp syntax_check_lib $DST

mkdir -p /etc/syntax_checker
cp -i config_files/* /etc/syntax_checker/

echo "syntax_checker depends on several 3rd party programs to do syntax checking."
echo "You may need to install those dependencies. On Debian based systems you should"
echo "be able to run install_deps.sh as an administrator"
echo ""
echo "To use within git, add these lines to your ~/.gitconfig

[alias]
ok = !syntax_check_git
bad = !syntax_check_git -f  
"
echo ""
echo "To check an individual file, run :

syntax_check \$filename
syntax_check my_bash_script.sh"
echo ""

echo "To force a specific syntax checker, add the extension of the filetype you want to use:

syntax_check \$filename \$extension
syntax_check my_bash_script sh"

echo ""
