---
title: "Fix Stalled iCloud Sync"
#description: <descriptive text here>
date: 2024-06-25T10:00:00-04:00
draft: false 
toc: false
image: ""
tags: [mac, macOS, iCloud, Bug, Fix]
categories: []
---

![iCloud-Logo](/images/hero_icloud_logo.png#floatleft)

Is your iCloud Drive Synchronization stalled and it always shows files pending upload or download? Follow these instructions to get the problem solved.

<!--more-->

### Preparations

It is likely that you have your Desktop & Documents folders being Synced to iCloud. While the following process is simple and unlikely to produce any problem, it is important that you backup the files located on these folders.

If you selected "Optimize Mac Storage" in your iCloud Settings, some of your files may not be local in your machine. By making a backup (copy) you will make sure all are downloaded to your mac (they'll be downloaded to your Documents/Desktop folder and then copied to the backup folder/disk). Be aware that sometimes your available storage may not be enought to do this. In that case you can move your files to an external disk/memory stick, instead of copying them. 

If you have enough space, just copy them into another local folder on your machine (don't move them as they'll be downloaded again and this may take a lot of time).

### Delete CloudDocs Folder

Open Finder and Press SHIFT+CMD+G and type `~/Library/Application Support/`, this will take you to the Application Support Folder.
You can then delete the folder name CloudDocs inside this folder.

At this point you will see the iCloud entry in your Finder Sidebar to show the progress indicator, you can click on it and see that sync is working again. In case this doesn't happen you can force this by executing the following command on terminal:

```shell
killall bird
```

Now check your sync progress and it should be working again.
