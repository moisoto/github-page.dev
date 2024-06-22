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

submodule=public
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

submodule=themes/soho
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

# Initialize Submodules listed on .gitmodules
echo "\033[0;32mInitializing Submodules\033[0m"
git submodule update --init

if [[ -d $submodule ]] ; then
	cd ${submodule}
        echo "" # Skip Line
        echo "" # Skip Line
	echo "\033[0;32mFixing Tracking for Submodule ${submodule}\033[0m"
	git checkout -b custom --track origin/custom
        cd - > /dev/null # Go to previous folder. Don't show command output.
fi

submodule=public
if [[ -d $submodule ]] ; then
        echo "" # Skip Line
        echo "" # Skip Line
	echo "\033[0;32mFixing Tracking for Submodule ${submodule}\033[0m"
	cd ${submodule}
	git switch main
fi

# Check Remotes
echo "" # Skip Line
echo "" # Skip Line
echo "\033[0;32mRemotes for this Repo:\033[0m"
cd - > /dev/null
echo ""
echo "Parent Repo location: $(pwd)" 
git status | head -n2
git remote -v
cd themes/soho
echo ""
echo "Submodule location: $(pwd)" 
git status | head -n2
git remote -v
cd - > /dev/null
cd public
echo ""
echo "Submodule location: $(pwd)" 
git status | head -n2
git remote -v
