submodule=public
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

submodule=themes/soho
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

git submodule update --init
if [[ -d $submodule ]] ; then
	cd ${submodule}
	echo "\033[0;32mFixing Tracking for Submodule ${submodule}\033[0m"
	git checkout -b custom --track origin/custom
	cd -
fi

submodule=public
if [[ -d $submodule ]] ; then
	echo "\033[0;32mFixing Tracking for Submodule ${submodule}\033[0m"
	cd ${submodule}
	git switch main
fi
