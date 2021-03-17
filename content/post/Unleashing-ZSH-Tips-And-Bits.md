---
title: "Unleashing ZSH - Tips & Bits"
#description: <descriptive text here>
date: 2021-03-17T11:01:40-04:00
draft: false
toc: false
image: ""
tags: [zsh, oh-my-zsh, powerlevel10k, terminal]
categories: []
---

![ZSH-Terminal](/images/ZSH.png#floatleft)

The adoption of Z-Shell (ZSH) as the default on macOS Catalina may seem a letdown for most bash supporters. But I digress, ZSH brings with it some nice features, and more importantly you can use Oh-My-Zsh which is a framework with plugins for a lot of languages, programs and platforms. 

---

Keep reading to know more about ZSH and see some usefull links to get you started on this new shell features...
<!--more-->

# Introducing Z-SHell

Z-Shell is the program that runs when you start a terminal session on your Mac. It's called a command interpreter and let's you run programs from a terminal window.

It can also be used to make scripts. If you are a bash user you probably know your way arround doing scripting. But maybe you are a not a poweruser and just want to get the best out of your terminal.

Well, even if you are not an expert at shell programming, you can take advantage of ZSH powerful scripting capabilities by installing a framework called [Oh-My-Zsh](https://ohmyz.sh). This framework moto is actually _**"Unleash Your terminal like never before"**_. As you may suspect, Oh-My-Zsh will be the focus of this article.

---

## Installing iTerm 2

The first thing you want to do is [install iTerm2](https://iterm2.com/index.html). The best and more powerful free terminal replacement (IMHO). It's great for a lot of things, and Oh-My-Zsh looks great on it!

Go to [iTerm2 home page](https://iterm2.com/index.html) and click the download button for the latest stable version. You then just need to move it to your Applications Folder and launch from there. Also you may click on the icon and select _**Options -> Keep in Dock**_ to make the icon stay permanently on your dock.

---

## Making ZSH your default shell

If you are on macOS Catalina, your default shell is most likely zsh but to make sure, run the following commands:

```shell
# Check your default shell:
echo $SHELL

# Check your current shell:
ps -o comm= $$
```
{{< linebreak >}}



If the $SHELL variable shows a different shell, run the following command:

```shell
# Copy and paste this
chsh -s /bin/zsh
```
{{< linebreak >}}


After this, close and reopen your terminal program, then run **`ps -o comm= $$`** to make sure your terminal is using ZSH as your shell. If the output is not **`-zsh`**, then you probably have overrided your shell on your terminal program preferences and need to specify /bin/zsh as your shell in your app preferences. 

---

## Installing Oh-My-Zsh

At the time of this writing, installing ohmyzsh on macOS is as simple as running this command:

```shell
sh -c "$(curl -fsSL \
https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

In case the repository or install instructions change in the future, you can go to [Oh-My-Zsh home](https://ohmyz.sh/#install) page and check current install instructions.

**Note:** Read the output of the installation. If you see warning like file permissions not set properly (usually the /usr/local/share/zsh folder) the correct permission for zsh folders is 755 (run the command `chmod 755 <foldername>` in the corresponding reported folders).

Now exit your terminal session and start a new one to make sure all Oh-My-Zsh environment variables are set properly.

---

## Setting up your Oh-My-Zsh Theme

Now that you have Oh-My-Zsh installed, the next step is to customize it to your liking. The theme I use and recommend is called [Powerlevel10k](https://github.com/romkatv/powerlevel10k). It can be installed with or without Oh-My-Zsh. We will of course use the Oh-My-Zsh install method.

#### Installing Powerlevel10k

Since we are using Oh-My-Zsh, we just need to use the following command to install Powerlevel10K:

```shell
git clone --depth=1 \
https://github.com/romkatv/powerlevel10k.git \
${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

After running this command you'll have the Powerlevel10k theme downloaded into your custom themes folder. Now all you need to do is edit your *`~/.zshrc`* file and specify your theme. You'll need to change the value of *ZSH_THEME* variable, which normally is set to *robbyrussell* theme. Comment the default value and add Powerlevel10k like this:
```shell
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
```

Save your *`~/.zshrc`* file, exit your current session and open a new terminal window. Powerlevel10k configuration utility will be run automatically, you will be asked a few questions about how you want Powerlevel10k to be configured. These are my recommended settings but feel free to experiment (you can re-confifure your setup by executing the command `p10k configure` later on):

* **Prompt Style:** Rainbow
* **Show Current Time?:** No
* **Prompt Separator:** Angled
* **Prompt Head:** Sharp
* **Prompt Tails:** Slanted
* **Prompt Height:** Two Lines
* **Prompt Connection:** Disconnected
* **Prompt Frame:** No Frame
* **Prompt Spacing:** Sparse
* **Icons:** Many Icons
* **Prompt Flow:** Fluent

----

## Where to Go From Here?

After all the previous steps are completed you will be able to take advantage of a host of features and [built-in plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins). Let's see a few of my favorites:

#### [Dircycle](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dircycle)

With [dircycle](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dircycle/README.md) you will be able to cycle between your directory folders history. Here is a short overview of how it works:

* **List Directory Stack:** Type `dirs -v` command.
* **Back on Directory Stack:** Ctrl+Shift + LeftArrow
* **Forward on Directory Stack:** Ctrl+Shift + LeftArrow

{{< linebreak >}}

#### [Warp Directory](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/wd)

Warp directory lets you move to your most commonly used folders using warp points that you define using commands or modifying a configuration file directly:
{{< linebreak >}}

* **Adding a Warp Point:**

   ```shell
   $ cd ~/go/src/golang.org/x/tools/playground
   $ wd add goplay
    * Warp point added
   $ cd ~/go/src/github.com/google/uuid
   $ wd add uuid
    * Warp point added
   ```
{{< linebreak >}}

* **Moving to a Warp Point:**

   ```shell
   $ wd goplay
   $ pwd
   /Users/macuser/go/src/golang.org/x/tools/playground
   $ wd uuid
   $ pwd
   /Users/macuser/go/src/github.com/google/uuid
   ```
{{< linebreak >}}

* **List your current Warp Points:**

   ```shell
   $ wd list
    * All warp points:
   goplay  ->  ~/go/src/golang.org/x/tools/playground
     uuis  ->  ~/go/src/github.com/google/uuid
   ```
{{< linebreak >}}

* **Add Warp Point manually to config:** Modify directly the file *~/.warprc* which would now contain the warp points as follow:

   ```shell
   goplay:~/go/src/golang.org/x/tools/playground
   uuid:~/go/src/github.com/google/uuid
   ```
{{< linebreak >}}

#### [Other plugins you may like](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)

* **[git](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/README.md):** Adds some aliases for git command.
* **[golang](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/golang/README.md):** Adds some aliases for go command.
* **[iTerm2](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/iterm2/README.md):** Adds `iterm2_profile` command (among others).
* **[tmux](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/tmux/README.md):** Adds some aliases for tmux command. 

----

### How to add these plugins:

Adding plugins to Oh-My-Zsh is really easy, just edit the file ~/.zshrc and change the line that says `plugins=()`. To add the previously listed plugins it should read as follows:

```shell
plugins=(dircycle wd git golang iterm2 tmux)
```



