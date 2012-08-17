## Installation

### Using Git and the bootstrap script

```bash
git clone --recursive https://github.com/genealo/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
./bootstrap.sh -f
```

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/genealo/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

To update later on, just run that command again.

