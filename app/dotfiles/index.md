# Dotfiles

Those hidden configuration files for your 

- Customize your working environment
- I keep mine here: [Batchelor Pad](https://github.com/will-ob/bachelor-pad)
- Personalized

### Installer

One line install

```bash
git clone git@github.com/user/dotfiles && cd dotfiles && ./install.sh

```

### Aliases

Shortcuts for the terminal.

- Pipe to clipboard
  `alias xclip="xclip -selection c"` to copy things to your clipboard
- Git shorthand
  `alias gs="git status"`
- View image
  `alias img="eog"` Launch gnome image viewer
- Whats my ip
  `alias whats-my-ip="curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'"` what is my ip
- Checkout PRs from URL
- Kill process on port

- `alias git="hub"` hub is the new git _see #bin section_


### Bash Functions
When aliases are too cobomplicated.

- killp

### Vim

Editor of choice.

- Vundle
- Syntax highlighting
- Two spaces, non-negotiable

```vim
    " Softtabs, 2 spaces
    set tabstop=2
    set shiftwidth=2
    set expandtab

```

- ruler
- No swap file
- pave the cowpaths
  map ; :


### Tmux

Break away terminal session.

- Restore lost ssh session (`tmux attach`)
- Directional mappings
  Panes can be split using `<control> + %` and `<control> + "`. Navigating these panes is annoying until you add directional bindings (left, right, down, up) instead of the default.

```
etw -g mode-keys vi
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
```

Navigate between windows the same way.

```
bind-key -r C-h select-window -t :-
bind-key -r C-l select-window -t :+
```

### Git

- Compare branches via github
- Checkout PR from URL

[hub](http://hub.github.com)
  - check out a pr directly with `hub checkout https://github.com/github/hub/pull/134`
  - open compare view `hub compare v0.1..v0.9`
  - passes through all git commands so you can `alias git="hub"` and use the above like it was a part of git all along

```
git checkout
```

### Xmodmap

- Set your standard keyboard
- Rebind keys

### Bash Profile && Bashrc

- Load login shell from terminal

### Bins

- custom binaries / shell scripts
- make sure you add them to your path
- killp - prefer here because they are easier to track down
  eg. `which killp`

### Crontab

- On run on startup


Just dont forget to take it slow. Pick a few new tools to learn at a time. See what you like and keep your environment crud free.
