# GitHub Account Web Page Hugo Development Repository

### Creating the Web Page 

This repository was created with [Hugo](https://gohugo.io):
```
$ hugo new site github-page.dev.repo
$ cd github-page.dev.repo
$ git init
$ git add *
$ git commit -m "Initial Commit"
$ git remote add origin https://github.com/moisoto/github-page.dev.git
$ git push --set-upstream origin master
```

The theme used was [SOHO](https://github.com/alexandrevicenzi/soho).<br>
Since this themes requires changes to the theme itself It was forked to this account: (https://github.com/moisoto/soho.git)<br>
And added as a submodule:
```
$ git submodule add https://github.com/moisoto/soho.git themes/soho
$ git commit -m "Add SOHO Theme as a submodule."
$ git push
```

**Note:** For more info about the workflow of working with a fork of your favorite HUGO theme, [check this article](https://www.andrewhoog.com/post/git-submodule-for-hugo-themes/).

### Setting up the SOHO theme

Make sure you modify the config.toml file as specified by your theme [README.md](https://github.com/alexandrevicenzi/soho/blob/master/README.md).

For soho, please notice that you should put the profile picture in the `./themes/soho/static/images` folder

You can test your website is setup properly by running the HUGO Server and checking at (http://localhost:1313):
```
$ hugo server
```

### Building the Static Website

Before building the static website we should make it so that the public directory points to the github account web page repository.<br>
This repository should already exist (with at least a README.md file) on github as specified in (https://pages.github.com).<br>
Also, notice we use the `-b main` flag, that is because the moisoto.github.io repository was created on github.com which now creates a main branch instead of master when adding files to an empty repository.
```
$ git submodule add -b main https://github.com/moisoto/moisoto.github.io.git public
$ git commit -m "Add github account web page as a submodule."
$ git push
```

After this you can build the static website by running hugo with no parameters:
```
$ # Builds the static website on the ./public folder
$ hugo
$ cd public
$ git add *
$ git commit -m "First Build of Static Website"
$ git push
$ cd ..
$ git add public
$ git commit -m "Push new commits of 'public' submodule."
$ git push
```
