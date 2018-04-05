---
author: jamison
layout: post-no-feature
title: Vim Plugins I Forgot I Had Installed
description: ""
published: true
---

I use vim (a hush falls over the crowd). The main purpose of vim is to make people watching me code think I'm smart. Sometimes I forget which plugins I have installed, which makes people think I am less smart. In an attempt to remember what plugins I have installed and impress more people, here are some plugins I have installed but sometimes forget about.


## [youcompleteme](https://github.com/Valloric/YouCompleteMe)
This plugin's job is to crash python every time I start vim. This used to be my job but this plugin is more efficient at it than I am. Sometimes when it doesn't crash python it does a pretty nice job at smart autocompletion.

## [vim-easymotion](https://github.com/easymotion/vim-easymotion)

![someone trying to put a lid on a weird food dish like in an infomercial][infomercial]

Are you FED UP with hitting arrow keys all the time? How much of your programming time is spent getting your cursor to the right spot? 10%? 40%? 99%? If you're like me and the main bottleneck to getting actual programming done is putting your cursor in the right spot, boy howdy will this plugin change your life.

vim has [motions](http://vim.wikia.com/wiki/Moving_around), which among other things, help you move your cursor around and operate on chunks of text. If you want to jump ahead three words you can do `3w`. If you want to delete from the cursor location until the next semicolon you can do `df;`. It isn't important to know this. What is important is that you think I'm smart.

With vim motions you have to count a lot, and counting higher than three slows me down and makes me look less smart. easymotion makes it easier to jump around. It looks really impressive. Watch this!

![demo of easymotion plugin][easymotion]

Some of you have ignored what is happening in this gif and are getting ready to ask ask what font that is and also what editor I'm using. I have accepted this as the cost of showing pictures of code on the internet. The editor is emacs and the font is Times New Roman.

I hope to someday be the kind of person for whom this plugin makes a difference. I have spent 20 minutes reading about it and it takes me a few seconds every time I use it to remember how it works which means so far it has saved me negative 25 minutes.

## [vim-test](https://github.com/janko-m/vim-test)

This one is actually pretty cool. You can run `:TestNearest` to run the test that your cursor is closest to, `:TestLast` to re-run the last test, and a few other helpful commands. If I ever remember it is installed, it can lead to some really nice feedback loops of quickly tweaking and re-running tests. Sometimes the test runners have watchers that make this mostly obsolete, but in some environments without those or where your tests don't play nice with watchers this plugin can make your life better.

## Conclusion
Here concludes the brief overview of some random plugins I forgot I had in my `.vimrc`. If you want to see it and remind me of other things I've forgotten, check it out [on GitHub](https://github.com/jergason/dotfiles/blob/master/.vimrc).

[infomercial]: /images/infomercial.gif
[easymotion]: /images/easymotion.gif
