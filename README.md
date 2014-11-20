docker-php-light
================

# What ?

A tool to generate small (~55Mo) docker images for php, based on a `busybox` or `scratch` base image.

    docker run --rm -it docteurklein/php5.6:busybox
    docker run --rm -it docteurklein/php5.6:latest # scratch

# Why ?

All the php docker images that I know of out there are between 350Mo and 1Go!  
350Mo is quite correct, so why ?  
For fun. The way I did it was very geeky :)

# How ?

How could a busybox or scratch image be used, when php cannot be statically compiled ?

First of all, most of the **extensions** can be compiled without using the `shared` option.  
Some (like xdebug) can't, maybe because they are **zend** extensions.

The `CHH/php-build` project compiles php and all of its extensions using non-shared options, which results in a bigger php binary (80Mo in my case).

The usual distributions (archlinux's one at least) provide php binaries with shared compiled extensions, resulting in a ~8Mo php binary.

Even if what I say may be totally wrong :), it doesn't change the facts: php relies on shared libraries (.so).

    ldd /usr/bin/php will tell you which of these libs **must** be present.


What I've done is simply copied (ADDed in fact) those files inside the final image.  
I also respected the prefix which I compiled php with (inside another container).

