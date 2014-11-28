### Useful Commands
```bash
$ sudo !!
Run the last command as root when you forget to use sudo for a command

$ cd -
# Go back to last directory

$ > filename.log
Delete content of filename.log

$ ^old^new
Run previous command replacing first occurence "old" with "new". Arguments default to empty string.
E.g.
    Correct user
    $ ssh usar@host
    $ ^usar^user
    Remove extra "z"
    $ ssh user@hostz
    $ ^z

Copy the content of the web page to clipboard
Mac:
$ curl https://news.ycombinator.com | pbcopy
Linux:
$ curl https://news.ycombinator.com | xclip

Open file with default appliaction base on file extention
Mac:
$ open doc.pdf
Linux:
$ xdg-open doc.pdf

mrt, better than traceroute and ping combined
$ mtr google.com

Download all mp4's listed in an html page
$ wget -r -l1 -H -t1 -nd -N -np -A.mp3 -erobots=off [url of website]

Hold/unhold a package using apt-mark
$ sudo apt-mark hold package_name
$ sudo apt-mark unhold package_name

```

#### References
* http://www.commandlinefu.com
* http://askubuntu.com/questions/18654/how-to-prevent-updating-of-a-specific-package
