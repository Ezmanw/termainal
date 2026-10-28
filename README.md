# termainal

A fake Linux terminal run by a local LLM through [Ollama](https://ollama.com). You type commands and the model makes up what a Pop!_OS box would print. Nothing actually runs, so you can `sudo rm -rf / --no-preserve-root` without consequences.

```
ethan@whatever:~$ neofetch
             /////////////                ethan@whatever
         /////////////////////            --------------
      ///////*767////////////////         OS: Pop!_OS 24.04 LTS x86_64
...
ethan@whatever:~$ sudo rm -rf / --no-preserve-root
ethan@whatever:~$ ls
bash: ls: command not found
```

## Install

You need `python3` (the script has no other dependencies), Ollama, and at least one model, e.g. `ollama pull qwen2.5:3b`.

```bash
curl -fsSL https://raw.githubusercontent.com/Ezmanw/termainal/main/install.sh | bash
```

This puts `termainal` in `~/.local/bin`.

## Usage

```bash
termainal
```

The first time you launch it, it asks:

- **which model** to use (picked from `ollama list`)
- **machine name** and username (these set the prompt, e.g. `ethan@whatever:~$`)
- **specs**: *real* reads this PC's actual OS, CPU, GPU, RAM and so on. That data stays local and only goes to Ollama. *fake* lets you type in any specs you like.
- **memory** (off by default): when it's off, each command is answered on its own, which is fast but the model forgets what you made. When it's on, the model sees the whole session, so files you create stick around.

The current directory, `pwd`, `neofetch` and the aftermath of `rm -rf /` are tracked by termainal itself, so they work even with memory off.

After that:

| Command  | What it does                                             |
|----------|----------------------------------------------------------|
| `config` | Change the model, machine name or username               |
| `reset`  | Wipe the simulated machine (useful after `rm -rf /`)     |
| `clear`  | Clear the screen                                         |
| `exit`   | Quit                                                     |

Everything else goes to the model. Small models like 3B to 9B are fine for messing around; bigger ones stay consistent for longer when memory is on.

Settings are stored in `~/.config/termainal/config.json`. To use Ollama on another machine, set `OLLAMA_HOST=http://box:11434`.

## Uninstall

```bash
rm ~/.local/bin/termainal && rm -rf ~/.config/termainal
```
