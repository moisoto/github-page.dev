# GitHub Account Web Page Hugo Development Repository

### Creating the Web Page 

- This repository was created with [Hugo](https://gohugo.io).

- The first step was to create an empty repository on github (or any other repository hub). In this case the repository is called github-page.dev.

- Then we create the site using hugo and add the remote origin:
```
$ hugo new site github-page.dev.repo
$ cd github-page.dev.repo
$ git init
$ git add *
$ git commit -m "Initial Commit"
$ git remote add origin https://github.com/moisoto/github-page.dev.git
$ git push --set-upstream origin master
```

The theme used was [SOHO](https://github.com/alexandrevicenzi/soho).

Since this themes requires changes to the theme itself It was forked to (https://github.com/moisoto/soho.git)

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

### Clonning your repository

Since this repository has submodules, please remember to initialize them after you clone:
```
$ git clone https://github.com/moisoto/github-page.dev.git github-page.dev.repo
$ cd github-page.dev.repo
$ git submodule update --init
```

### Adding Content

#### Setting Up Archetypes

When creating a site, HUGO will create a file called *./archetypes/default.md* that will be used whenever you create a file using the commang `hugo new <filename>`. This file is used as a template for generating the front matter of your new file.

Now, we will create a file called *post.md* on that folder. Hugo will use that file instead of *default.md* when you create a new post by using `hugo new post/filename>`.

For HUGO you can use the following template:
```
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
toc: false
tags: []
categories: []
---

# Descriptive text here...
<!--more-->
```

This will:
* Use the filename of the markdown file to set the post title by replacing dash character (-) with spaces. For example if your run the command `hugo new post/My-First-Post`, the front matter will contain the text `title: "My First Post"` on the generated file.

*  Add the tags specified on `tags: []` to your post. For example you can change this to `tags: ["Coding", "Golang"]` and your post will be associated to those tags and display them at the bottom (in the case of soho theme).

* Use the markdown text before `<!--more-->` as as a description to be shown on the home page along the post title.
