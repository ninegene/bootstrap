## Installation

```bash
git clone https://github.com/ninegene/dotfiles.git && cd dotfiles 
```

To install for desktop which will create soft link for .profile:

```bash
./bootstrap.sh 
```

To install for server which will create soft link for .bash_profile:

```bash
./bootstrap.sh server 
```
To update, do `git pull` and execute `bootstrap.sh`

## Notes
https://github.com/rupa/z is added as submodule using the following
commands:
```bash
cd dotfiles
git submodule add git://github.com/rupa/z.git
git submodle init
```
