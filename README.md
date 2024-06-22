# GitHub Account Web Page Hugo Development Repository

### Creating the Web Page 

- This repository was created with [Hugo](https://gohugo.io).

- The first step was to create an empty repository on github (or any other repository hub). In this case the repository is called github-page.dev.

- Then we create the site using hugo and add the remote origin:
```shell
$ hugo new site github-page.dev.repo
$ cd github-page.dev.repo
$ git init
$ git add *
$ git commit -m "Initial Commit"
$ # Use ssh instead of https which is no longer recommended
$ # git remote add origin https://github.com/moisoto/github-page.dev.git
$ git remote add origin git@github.com:moisoto/github-page.dev.git # Cloning with SSH
$ git push --set-upstream origin master
```

The theme used was [SOHO](https://github.com/alexandrevicenzi/soho).

Since this themes requires changes to the theme itself It was forked to (https://github.com/moisoto/soho.git)

And added as a submodule:
```shell
$ # Use ssh instead of https which is no longer recommended
$ # git submodule add https://github.com/moisoto/soho.git themes/soho
$ git submodule add git@github.com:moisoto/soho.git themes/soho
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
```shell
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

Since this repository has submodules, please remember to initialize them after you clone.

The command for initializing the modules is as simple as `git submodule update --init`. But I've noticed that the submodules will be in a DETACHED state after this. To fix this I've now included a script that will take care of it.

Also now the SOHO theme commits are made on a different branch so it's easy to update master to the last version.
```
$ git clone git@github.com:moisoto/github-page.dev.git github-page.dev.repo
$ cd github-page.dev.repo
$ ./init_submodules.sh
```

### Setting Up Archetypes

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


For more information about HUGO Archetypes, please check the [HUGO Documentation](https://gohugo.io/content-management/archetypes/).

### Adding custom Shortcodes

You may need to create custom shortcodes if you need to do additional formatting on your static files.

For example this shortcode can be added to allow centering of text:
```html
<div style="text-align: center;">
{{.Inner}}
</div>
```

Adding a shortcode to the hugo website is achieved by creating a ./layouts/shortcodes folder to your website:
```shell
$ # From your hugo website root
$ cd layouts
$ mkdir shortcodes
$ cd shortcodes
```

Now you will create the shortcode file. The filename you choose is important as it will determine the shortcode name used in your markdown:
```shell
$ # From your ./layouts/shortcodes folder
$ echo '<div style="text-align: center;">' > center.html
$ echo '{{.Inner}}' >> center.html
$ echo '</div>' >> center.html
```

Now we can center text using markdown like this:
```markdown
{{% center %}}
# This Heading text is centered!
This shortcode called `center` will use the center.html file
{{% /center %}}
```

For more information on shortcodes, please check the [HUGO Documentation](https://gohugo.io/content-management/shortcodes/).

### Adding custom CSS and Javascript files

We will need to add a custom CSS file in order to be able to align images in our posts.

For this we will use the followin CSS and put it on the file *`./static/css/blog.css`*:
```css
img[src$='#center']
{
    display: block;
    margin: 0.7rem auto; /* you can replace the
     vertical '0.7rem' by whatever floats your boat,
     but keep the horizontal 'auto' for this to work */

    /* whatever else styles you fancy here */
}

img[src$='#floatleft']
{
    float:left;
    margin: 0.7rem; /* this margin is totally up to you */

    /* whatever else styles you fancy here */
}

img[src$='#floatright']
{
    float:right;
    margin: 0.7rem; /* this margin is totally up to you */

    /* whatever else styles you fancy here */
}
```

The reason we use the name blog.css is because that's the filename used in the [soho theme recommended](https://github.com/alexandrevicenzi/soho/blob/master/README.md) *`config.toml`* settings for the custom css file:
```
## Set custom CSS and/or JS to override site defaults.
customCss = ["css/blog.css"]
customJs = ["js/blog.js"]
```

Now let's insert an image using markdown:
```markdown
This is how we normally insert an image:
![Swift-Logo](/images/some_image.png)

# With the custom CSS we can:

* Insert an centered image:
![Swift-Logo](/images/some_image.png#center)

* Insert an image floating to the left of your text:
![Swift-Logo](/images/some_image.png#floatleft)

* Insert an image floating to the right of your text:
![Swift-Logo](/images/some_image.png#floatright)
```

**Note:** The *some_image.png* file should be located at *`./static/images/some_image.png`*

Credits for this custom CSS goes to this [Ebadf.net blog post](http://www.ebadf.net/2016/10/19/centering-images-in-hugo/#the-solution)
