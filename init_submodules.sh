submodule=public
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

submodule=themes/soho
if [[ -d $submodule ]] ; then
	rm -rf ${submodule}
fi

git submodule update --init
