# christma.sh
a small, shell script christmas greeting inspired by [keroserene's rickrollrc](https://github.com/keroserene/rickrollrc). this script is meant to be more simple, displaying a simple ascii art animation over some background music.

quick run: wget -O https://raw.githubusercontent.com/ercas/christma.sh/master/christma.sh | bash

short url: wget -O goo.gl/VleqpU | bash

(always inspect urls before doing things like piping them to an interpreter! better yet, download them, inspect them, and then run them after you're sure they're safe.)

files
=====

* christma.sh: this is the main animation script. this is all you need to run christma.sh; just run ./christma.sh.
* snow.lua: this replaces all spaces in the specified text with "snow" characters and displays the modified text.
* build.sh: this uses snow.lua to create new frames with random "snow", changing the base frame every other frame.
* frames-src: this is where the original frames are stored before being processed by build.sh.

how to make your own animations
===============================
remember, all you need is christma.sh!

* upload a compatible audio file (.ogg recommended) to somewhere and set this as audioUrl.
* create the ascii art frames. the frames should be numbered 0, 1, 2, 3, etc; do not prepend zeroes to the numbers (ex. 00, 01, 02, 03, etc).
* compress the frames into a .tar.xz and upload this to somewhere. set this as framesUrl
* done! distribute the edited christma.sh. you might want to do some rebranding to make it less festive, too.
