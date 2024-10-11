---
layout: post
title:  "Migrating from svbtle.com to Jekyll"
date:   2024-10-11 16:00:18 +0300
categories: personal
---
I have been blogging very irregularly for several years. In 2019 I found out
about [svbtle.com](https://svbtle.com/) and liked it a lot: it supports
Markdown, it's very simple and
lightweight, it costs very little and comes with a "forever promise".

Forever, though, did not last. It is late 2024, I posted a short blog and found
out that Chrome marks Svbtle as "unsafe". This happened to me (on my corporate
laptop, which might have something to do with it) and to one other person
who was kind enough to inform me of that.

Normally I wouldn't mind that so much but svbtle.com is clearly stale. In fact that was
somewhat apparent even when I joined... But it's very clear now. And so if
something bad happens and the site is blocklisted, I cannot be sure
that there's a human behind the scenes who cares enough to deal with the situation.

Unfortunately blogging has become so esoteric that there are few if any
well known platforms that are likely to stay viable for the foreseeable
future. Luckily more technical people have the alternative of self-hosting
a blog. (You don't need to be a Web/JavaScript wizard, which I'm clearly not,
but you need basic Linux and Web background; otherwise, I guess [Medium](https://medium.com/) is
your friend).

I had an embarrassingly old personal web site hosted on GitHub Pages.
I was able to add a sufficient (for my admittedly low standards) blog
environment while keeping the old web site intact. All it took
was a [Jekyll](https://jekyllrb.com/) web site located elsewhere
in the repo's directory tree. And then some heavy handed copying of files
once Jekyll builds the site. All in all, a few hours of work for someone
with zero prior knowledge of Jekyll.

I did learn a few things along the way:

* I was basically unable to install Jekyll on the Mac. It's actually
crazy that in order to install the latest Ruby, you *also* need
to install Rust. Eventually this was too much.
* So I switched to my Linux VM and the whole thing completed in 2 minutes.
* I was hoping for some minimal flexibility with colors, fonts etc.
I was shocked to find out that Jekyll's default them is itself stale.
Its [GitHub repo](https://github.com/jekyll/minima)
is all about v3 of the theme, but alas, there are no official releases yet
and everybody is on v2.5. And I would need to spend too much CSS energy
to tweak than one. 
* And eventually I had to tweak the default theme, to correct a link in the page
header that couldn't be fixed otherwise. A bit of [Stack Overflow](https://stackoverflow.com/questions/64694511/how-to-change-the-url-of-the-title-in-jekyll) did it, but
I wish I didn't have to copy a file straight from the theme and modify it.

