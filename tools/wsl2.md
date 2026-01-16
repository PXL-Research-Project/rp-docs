# WSL2 (Windows Subsystem for Linux)

*The Best of Both Worlds*

In the professional world, servers run **Linux**. However, your laptop runs **Windows**.
Historically, this caused massive headaches ("It works on my machine but breaks on the server").
**WSL2** allows you to run a full Linux kernel *inside* Windows. You get the professional terminal tools of Linux (Ubuntu) while keeping your comfortable Windows UI for Spotify and Chrome.

## Install

Official WSL install guide:
<https://learn.microsoft.com/en-us/windows/wsl/install>

> Only Windows x86/x64 PCs will be targeted in this course.

## The Architecture (Mental Model)

You now have two computers in one box.

1. **The Host (Windows):** Your C: drive. Where your Games, Office, and Browser live.
2. **The Subsystem (Linux/Ubuntu):** A separate file system. Where your Code, Python, and Servers live.

**The Golden Rule of WSL:**

* Store your code inside the Linux file system (`/home/yourname/`), **NOT** on your Windows Desktop.
* *Why?* It is significantly faster (10x-100x) for file operations like `git status` or `npm install`.

## Integration with VS Code

This is the "Magic Moment." You do not edit files inside the black terminal using `nano` or `vim`. You use VS Code.

1. Open your **Ubuntu** terminal.
2. Install the VS Code integration (if not already there):
   * *Note:* Just open VS Code in Windows first and install the **"WSL"** extension by Microsoft.
3. In the Ubuntu terminal, create a project directory:

   ```bash
   mkdir my-project
   cd my-project
   
   ```
4. **The Magic Command:**
   ```bash
   code .
   
   ```

   *(Note the space and the dot. "." means "current directory")*

5. **Result:** VS Code will open on your Windows desktop, but it is "connected" to the Linux system. You can use the Linux terminal inside VS Code, but use the Windows mouse to click files.

## Basic Linux Cheat Sheet

You are now a Linux user. Here are the 5 commands you need to survive day one.

| Command | Definition | Example |
| --- | --- | --- |
| `pwd` | **P**rint **W**orking **D**irectory. "Where am I?" | `/home/student/project` |
| `ls` | **L**i**s**t. Show me files in this directory. | `ls` (or `ls -la` for hidden files) |
| `cd` | **C**hange **D**irectory. Move to a directory. | `cd my-project` (or `cd ..` to go back) |
| `mkdir` | **M**a**k**e **Dir**ectory. Create a directory. | `mkdir lab-01` |
| `sudo` | **S**uper**u**ser **Do**. "Run as Admin." | `sudo apt update` |

### Sanity Check (Lab Activity)

Verify your installation is correct.

1. Open your Ubuntu Terminal.
2. Type `explorer.exe .` (Yes, you can run Windows commands from Linux!).
3. A Windows File Explorer window should pop up showing your Linux files.
   * Notice the network path is `\\wsl.localhost\Ubuntu`. This is the bridge between your two worlds.
