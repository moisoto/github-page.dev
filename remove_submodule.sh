#!/bin/bash
# Procedure Credits: 
#    https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule

submodule=$1
rmv_repo=$2


if [[ -z $submodule ]] ; then
    echo "Sintax:"
    echo "    ./remove_submodule.sh <submodule_path> [--delete]"
    echo
    exit
else
    echo # Skip line
fi

# Checks if folder is a repository ($? will be equal 0 if it is)
git rev-parse --is-inside-work-tree >/dev/null 2>&1
if [[ ! $? -eq 0 ]] ; then
    echo "Not a Repository!"
    exit
fi 

if [[ ! -f .gitmodules ]] ; then
    echo "Repository $repo has no submodules"
    exit
fi

if [[ ! -d $submodule ]] ; then
    echo "Folder $submodule not found."
    exit
fi

if [[ ! -d .git/modules/$submodule ]] ; then
    echo "Submodule $submodule not found."
    exit
fi

# Check if folder is actually a submodule (according to file .gitmodules)
vrf_module=`git config --file .gitmodules --get-regexp path | awk '{ print $2}' | grep "$submodule"`
if [[ $vrf_module != $submodule ]] ; then
    echo "$submodule is not actually a submodule."
    exit
fi

repo=${PWD##*/}
echo "This will REMOVE Submodule $submodule from repository $repo"

printf "Do you wish to continue (Y/n)?"
read REPLY
[[ $REPLY == "y" ]] && echo "Please use Capital Y if you wish to continue"
if [[ $REPLY != "Y" ]] ; then
    echo "Script Cancelled!"
    exit
fi

echo "Removing Submodule $submodule from repository $repo"
mv $submodule ${submodule}_tmp
git submodule deinit -f -- $submodule
rm -rf .git/modules/$submodule

if [[ $rmv_repo = "--delete" ]] ; then
    echo "Removing Submodule folder $submodule"
    git rm -f $submodule
    rm -rf ${submodule}_tmp
    git commit -m "Remove $submodule submodule."
else
    echo "Keeping Submodule folder $submodule"
    git rm --cached $submodule
    mv ${submodule}_tmp $submodule
fi
