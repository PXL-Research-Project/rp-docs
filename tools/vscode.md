# Visual Studio Code

We do not use Microsoft Word to write code. We use an **IDE (Integrated Development Environment)**.

VS Code is the industry standard - it is lightweight, fast, and infinitely customizable.

The most used and loved editor in the world right now.

---

- [Install](#install)
- [Essential Extensions (The Starter Pack)](#essential-extensions-the-starter-pack)
- [Configuration for Success](#configuration-for-success)
- [Cheat Sheet (Memorize These)](#cheat-sheet-memorize-these)

## Install

Official VS-Code install guide:
<https://code.visualstudio.com/docs/setup/windows>

> Only Windows x86/x64 PCs will be targeted in this course.

**Crucial Installation Step:**
During installation, you will see a screen with checkboxes. You **MUST** check these two boxes (they are unchecked by default):

* [x] Add "Open with Code" action to Windows Explorer file context menu
* [x] Add "Open with Code" action to Windows Explorer directory context menu

This allows you to right-click any directory on your computer and select **Open with Code**, instantly setting up your workspace in that directory.

## Essential Extensions (The Starter Pack)

VS Code is just a skeleton. Extensions are the muscles. Click the **Extensions** icon (Blocks on the left) and install these:

1. **PowerShell (Microsoft):**
   * Essential for our quick scripting. It gives you syntax highlighting and safe-guards for your scripts.
2. **Python (Microsoft):**
   * Even if you are new to Python, you will need this for the AI/Data labs. It includes the "IntelliSense" (autocomplete) engine.
3. **Prettier - Code formatter:**
   * It automatically cleans up your messy code every time you save.
4. **Markdown All in One:**
   * You will be reading and writing documentation (`README.md`, `AGENTS.md`). This makes them look like actual documents while you edit.

## Configuration for Success

Do not rely on the defaults. Engineers customize their tools to prevent errors.
1. **Turn on Auto-Save:**
   * *File > Auto Save*. (Never lose work again).
2. **The Integrated Terminal:**
   * VS Code has a built-in terminal so you don't need to `Alt-Tab` to PowerShell.
   * **Shortcut:** `Ctrl + '` (The backtick key, usually under Esc).
   * *Tip:* This terminal opens exactly in the directory you are working in.
3. **The command palette**
   * Type *any* command here (e.g., "Format Document", "Change Color Theme").

## Cheat Sheet (Memorize These)

Stop using the mouse. It slows you down.

| Shortcut | Action | Why use it? |
| --- | --- | --- |
| `Ctrl + P` | **Quick Open** | Type a filename (e.g., `main.py`) to jump to it instantly. |
| `Ctrl + Shift + P` | **Command Palette** | The "God Mode" bar. Type *any* command here (e.g., "Format Document", "Change Color Theme"). |
| `Ctrl + /` | **Toggle Comment** | Turns the selected line into a comment (ignores code). Great for testing. |
| `Ctrl + B` | **Toggle Sidebar** | Hides the file explorer to give you more screen space for code. |
| `Alt + Click` | **Multi-Cursor** | Spawns multiple cursors so you can type on 5 different lines at the same time. |

---

For a visual guide on setting up these extensions and understanding why they matter, check out this walkthrough:
[The Best VSCode Extensions 2025](https://www.youtube.com/watch?v=YjhkcvS1xKU)
