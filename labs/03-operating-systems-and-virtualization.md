# LABS: Operating systems and virtualization

<!-- TOC depthFrom:1 depthTo:3 -->
- [LAB: Linux Fundamentals and WSL2](#lab-linux-fundamentals-and-wsl2)
  - [Step 1: System Identification and the Kernel](#step-1-system-identification-and-the-kernel)
    - [Check the Kernel Version](#check-the-kernel-version)
    - [Check your User Identity](#check-your-user-identity)
    - [Check the Hostname](#check-the-hostname)
  - [Step 2: Filesystem Navigation](#step-2-filesystem-navigation)
    - [Where am I?](#where-am-i)
    - [Listing Files](#listing-files)
    - [Changing Directories](#changing-directories)
  - [Step 3: File Manipulation](#step-3-file-manipulation)
  - [Step 4: The WSL2 Integration (Virtualization Context)](#step-4-the-wsl2-integration-virtualization-context)
    - [Accessing Windows Files from Linux](#accessing-windows-files-from-linux)
  - [Step 5: Permissions](#step-5-permissions)
  - [Step 6: Process Management](#step-6-process-management)
  - [Step 7: Advanced Piping and Redirection](#step-7-advanced-piping-and-redirection)
  - [Step 8: Package Management (Installing Software)](#step-8-package-management-installing-software)
  - [Lab Cleanup](#lab-cleanup)
- [LAB: Cross-Platform CLI and Package Management](#lab-cross-platform-cli-and-package-management)
  - [Part 1: The Linux Workflow (WSL2)](#part-1-the-linux-workflow-wsl2)
  - [Part 2: The Windows Workflow (PowerShell)](#part-2-the-windows-workflow-powershell)
- [LAB: Scripting and Automation (The Batch Image Processor)](#lab-scripting-and-automation-the-batch-image-processor)
  - [Part 1: The Linux Implementation (Bash)](#part-1-the-linux-implementation-bash)
  - [Part 2: The Windows Implementation (PowerShell)](#part-2-the-windows-implementation-powershell)
  - [Technical Summary: Scripting Differences](#technical-summary-scripting-differences)
- [LAB: Process Management and Observation](#lab-process-management-and-observation)
  - [Part 1: The Linux Environment (WSL)](#part-1-the-linux-environment-wsl)
  - [Part 2: The Windows Environment (PowerShell)](#part-2-the-windows-environment-powershell)
  - [Comparison Summary](#comparison-summary-1)
<!-- /TOC -->
---

## LAB: Linux Fundamentals and WSL2

This lab is designed to guide you through the basics of interacting with a Linux system. Since you are using WSL2 (Windows Subsystem for Linux), you are working with a real Linux Kernel running alongside your Windows environment.

By the end of this lab, you will be able to navigate the file system, manipulate files, manage processes, and understand the integration between Linux and Windows.

You must have WSL2 installed and a terminal open (e.g., Ubuntu).

---

### Step 1: System Identification and the Kernel

First, we need to verify what system we are actually operating on. In a graphical interface, you check "System Settings," but in the terminal, we ask the Kernel directly.

#### Check the Kernel Version

Type the following command and press Enter:

```bash
uname -r

```

- `uname` stands for "Unix Name". The `-r` flag asks for the **Release** of the kernel.
- You will likely see a version number followed by `microsoft-standard-WSL2`. This confirms that you are running a genuine Linux Kernel that has been optimized by Microsoft for virtualization.

#### Check your User Identity

Linux is a multi-user system. It is critical to know who you are logged in as, because your identity determines your permissions.

```bash
whoami

```

This should output the username you created during installation. If it says `root`, you are running with administrator privileges (which is generally dangerous for daily tasks).

#### Check the Hostname

The hostname is the network name of your "virtual" machine.

```bash
hostname

```

---

### Step 2: Filesystem Navigation

In Windows, you are used to Drive Letters (C:, D:). In Linux, there is only one "Root" directory represented by a forward slash `/`. Everything else hangs off this single tree.

#### Where am I?

One of the most common issues for beginners is getting "lost" in the command line.

```bash
pwd

```

- `pwd` stands for **Print Working Directory**.
- Expected output: `/home/<your_username>` (your personal directory, similar to `C:\Users\Name`).

#### Listing Files

To see what is in your current directory:

```bash
ls

```

- **Note:** If your directory is new, this might return nothing.
- **Try this:** List the files in the "Root" directory to see the top-level structure of Linux.

```bash
ls /

```

- You will see standard directorys like `bin` (binaries/programs), `etc` (configuration), and `var` (variable data).
- In Windows PowerShell, you can also use `ls` (an alias for `Get-ChildItem`).

#### Changing Directories

Let's move around.

```bash
cd /etc
pwd

```

Now, try to go back to your home directory. In Linux, the tilde symbol `~` is a shortcut for "My Home Directory".

```bash
cd ~
pwd

```

---

### Step 3: File Manipulation

Now we will create and organize files.

<!-- omit from toc -->
#### Creating Directories

Create a playground directory for this lab.

```bash
mkdir lab_basics
cd lab_basics

```

<!-- omit from toc -->
#### Creating Empty Files

The `touch` command is used to create an empty file (or update the timestamp of an existing one).

```bash
touch file1.txt
touch file2.txt
ls

```

<!-- omit from toc -->
#### Adding Content

We will use a simple redirection operator `>` to put text into a file.

```bash
echo "Hello Linux" > file1.txt

```

`echo` prints text to the screen. The `>` symbol redirects that output into `file1.txt` instead.

<!-- omit from toc -->
#### Reading Content

To check what is inside a file without opening a text editor:

```bash
cat file1.txt

```

(`cat` also works in PowerShell as an alias for `Get-Content`.)

<!-- omit from toc -->
#### Copying and Moving

Let's copy `file1.txt` to a backup, and then rename `file2.txt`.

```bash
cp file1.txt file1_backup.txt
mv file2.txt notes.txt
ls

```

`cp` is Copy. `mv` is Move. In Linux, renaming a file is moving it to a new name in the same directory.

<!-- omit from toc -->
#### Deleting

**Warning:** The command line has no trash bin. Deleted files are gone immediately.

```bash
rm file1_backup.txt

```

---

### Step 4: The WSL2 Integration (Virtualization Context)

This section demonstrates why WSL2 is unique. It is not just an isolated Virtual Machine; it can talk to Windows.

#### Accessing Windows Files from Linux

In WSL2, your Windows C: drive is automatically "mounted" (made available) at `/mnt/c`.

```bash
ls /mnt/c

```

You should see your Windows directorys like `Program Files`, `Users`, and `Windows`.

<!-- omit from toc -->
#### Accessing Linux Files from Windows

You can also do the reverse: open your current Linux directory in the Windows File Explorer.

```bash
explorer.exe .

```

This calls a Windows executable from inside Linux. The `.` represents the current directory. A Windows Explorer window should pop up showing your `file1.txt` and `notes.txt`.

---

### Step 5: Permissions

Linux permissions are critical for security.

<!-- omit from toc -->
#### View Permissions

Run the detailed list command:

```bash
ls -l

```

You will see output similar to: `-rw-r--r--`.

- Character 1 (`-`): It is a file (d means directory).
- Characters 2-4 (`rw-`): **Owner** (You) can Read and Write, but not Execute.
- Characters 5-7 (`r--`): **Group** can only Read.
- Characters 8-10 (`r--`): **Others** can only Read.

<!-- omit from toc -->
#### Modifying Permissions

Let's make `file1.txt` a "secret" file that only you can read. We will remove read permission for Group and Others.

```bash
chmod go-r file1.txt
ls -l file1.txt

```

`chmod` (Change Mode). `go-r` means Group and Others Minus Read.

---

### Step 6: Process Management

In this step, we will create a "misbehaving" process and learn how to stop it.

<!-- omit from toc -->
#### create a dummy process

We will use the `sleep` command, which does nothing but wait. We will run it for 1000 seconds.

**Crucially**, we add `&` at the end. This tells Linux to run the command in the **background**, so we get our terminal prompt back immediately.

```bash
sleep 1000 &

```

You will see a number, e.g., `[1] 12345`. The number `12345` is the PID (Process ID).

<!-- omit from toc -->
#### Find the process

Pretend you don't know the PID. Let's find it using `ps` (Process Status).

```bash
ps

```

You should see `sleep` in the list.

<!-- omit from toc -->
#### Kill the process

Now, use the PID you found to terminate the process.

```bash
kill <PID>

```

Replace `<PID>` with the actual number you saw.

<!-- omit from toc -->
#### Verify

Run `ps` again. The `sleep` process should be gone (or marked as "Terminated").

<!-- omit from toc -->
#### Real-time Monitoring

For a view of the whole system (like Task Manager), use `top`.

```bash
top

```

Press `q` to exit `top`.

---

### Step 7: Advanced Piping and Redirection

A core philosophy of Linux is creating complex behaviors by chaining small, simple commands together using the pipe `|`.

<!-- omit from toc -->
#### The Grep Command

`grep` is a powerful search tool. It looks for patterns in text.

Let's list all processes, but filter the list to only show "init" processes.

```bash
ps aux | grep init

```

- `ps aux` generates a massive list of all running processes.
- The Pipe `|` takes that list and passes it to the next command.
- `grep init` filters the input and prints only lines containing "init".

<!-- omit from toc -->
#### Saving Command Output

Usually, commands print to the screen. We can save that output to a file for later analysis (e.g., logging).

```bash
ps aux > running_processes.log

```

Check the file content:

```bash
cat running_processes.log

```

---

### Step 8: Package Management (Installing Software)

In Linux, we rarely download `.exe` files from websites. We use a **Package Manager**. On Ubuntu (WSL), this is `apt`.

<!-- omit from toc -->
#### Update the Catalog

Before installing anything, we update our local list of available software.

- **Note:** This requires `sudo` (SuperUser Do) because it changes system files. You will need to type your password (characters will not appear as you type).

```bash
sudo apt update

```

<!-- omit from toc -->
#### Install a Tool

We will install `tree`, a small utility that visualizes directory structures.

```bash
sudo apt install tree

```

<!-- omit from toc -->
#### Use the Tool

Go back to your home directory and run it.

```bash
cd ~
tree

```

Install the tool `htop` and use it.

---

### Lab Cleanup

To keep your system clean, you may remove the practice directory we created.

```bash
cd ~
rm -r lab_basics

```

The `-r` (Recursive) flag is required because `rm` refuses to delete a directory unless you explicitly tell it to delete the directory and everything inside it.

---

## LAB: Cross-Platform CLI and Package Management

In the previous lab, you learned that Linux relies heavily on the command line and uses a "Package Manager" (`apt`) to install software.

Historically, Windows required you to download `.exe` files manually. However, modern Windows administration has evolved. With **PowerShell** and the official Microsoft package manager `winget` and third-party package managers like `scoop`, you can manage a Windows machine almost exactly like a Linux server.

We will perform an identical workflow on both operating systems:

- Update the software catalog.
- Install a command-line system information tool (`fastfetch`).
- Download a file from the internet via command line.
- Archive (zip) and extract files.

### Part 1: The Linux Workflow (WSL2)

<!-- omit from toc -->
#### Install Fastfetch

We will use `apt` (Advanced Package Tool). However, `fastfetch` is a newer tool and might not be in the default catalog for older Ubuntu versions used by WSL. We will add a "PPA" (Personal Package Archive) to teach the system where to find it.

Open your **Ubuntu** terminal.

Update your package lists to ensure you have the latest catalog:

 ```bash
 sudo apt update
 sudo apt install software-properties-common -y
 sudo add-apt-repository ppa:zhangsongcui3371/fastfetch -y
 
 ```

Update the catalog again to see the new files:

 ```bash
 sudo apt update
 
 ```

Install `screenfetch` and `zip`:

 ```bash
 sudo apt install screenfetch zip unzip -y
 
 ```

<!-- omit from toc -->
#### Run the Tool

Run the tool you just installed.

```bash
screenfetch

```

You should see the Ubuntu logo and details about your Kernel, CPU, and RAM.

<!-- omit from toc -->
#### Downloading Files (The CLI way)

Instead of opening a browser, we use `curl` (Client URL).

Make a directory for this lab:

```bash
mkdir ~/linux_lab
cd ~/linux_lab
 
```

Download a sample text file from the web:

```bash
curl -o robot.txt https://www.robots.txt

```

- `-o` tells curl to "output" the downloaded data to a file named `robot.txt`.
- Run `cat robot.txt` to see the content.

<!-- omit from toc -->
#### Compressing Files (Zipping)

We will compress this file to save space.

```bash
zip archive.zip robot.txt

```

- **Syntax:** `zip [name_of_new_zip] [file_to_put_inside]`
- Run `ls -l`. You will see `archive.zip` is created.

### Part 2: The Windows Workflow (PowerShell)

Now we will replicate this exact workflow in Windows. By default, Windows has the package manager like [`winget`](https://winget.run) installed.

For this exercise we will install [**Scoop**](https://scoop.sh/), a popular command-line installer for Windows that gives you easy access to many linux-cli tools, natively recompiled/ported to Windows.

<!-- omit from toc -->
#### Open PowerShell correctly

- Right-click the Start button and select "Terminal" to open Windows Terminal.
- Make sure it says "Powershell" in the Terminal tab title.
- **Important:** For Scoop, you must **NOT** be Administrator. Open a normal PowerShell window.

<!-- omit from toc -->
#### Install Scoop

PowerShell blocks running scripts by default for security. We must allow it first.

Allow script execution for your user:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

```

*(Type `Y` and press Enter if prompted)*.

Download and install Scoop:

```powershell
irm get.scoop.sh | iex

```

- `irm` (Invoke-RestMethod) is the PowerShell version of `curl`.
- It downloads the installer script.
- The pipe `|` passes that script to `iex` (Invoke-Expression), which runs it.

<!-- omit from toc -->
#### Install the same tools

Now that Scoop is installed, Windows behaves more like Linux. We will install `fastfetch` and `curl`.

> **Note:** Windows has a built-in command called `curl`, but it is actually just an alias for a different PowerShell command (`Invoke-WebRequest`). By installing `curl` via Scoop, we get the *real* curl tool that behaves exactly like the Linux version.

```powershell
scoop install fastfetch curl

```

<!-- omit from toc -->
#### Run the Tool

Just like in Linux:

```powershell
fastfetch

```

You should see the Windows logo, but the format is identical to what you saw in Ubuntu.

<!-- omit from toc -->
#### Downloading Files

We will perform the exact same download operation.

Create a directory (PowerShell uses the same `mkdir` and `cd` commands as Linux):

```powershell
mkdir windows_lab
cd windows_lab

```

Download the file using the `curl` tool we installed via Scoop:

```powershell
curl -o robot.txt https://www.robots.txt

```

<!-- omit from toc -->
#### Compressing Files

We will install the `zip` tool via Scoop to match the Linux experience.

Install zip:

```powershell
scoop install zip

```

Run the command:

```powershell
zip archive.zip robot.txt

```

<!-- omit from toc -->
#### Comparison Summary

| Action | Linux (Bash) | Windows (PowerShell + Scoop) |
| --- | --- | --- |
| **Install Software** | `sudo apt install <name>` | `scoop install <name>` |
| **System Info** | `screenfetch` | `fastfetch` |
| **Change Directory** | `cd directory` | `cd directory` |
| **List Files** | `ls` | `ls` |
| **Download File** | `curl -o file url` | `curl -o file url` |

While the Kernels (NT vs. Linux) are very different, the **User Space** experience is converging. By using tools like winget, Scoop and PowerShell, you can manage a Windows machine with the same speed and scriptability as a Linux machine.

---

## LAB: Scripting and Automation (The Batch Image Processor)

In this advanced lab, we will move beyond running single commands. We will build a **Batch Image Processor**.

**The Scenario:** You have hundreds of high-resolution images that need to be converted to grayscale for a project. Doing this manually in Photoshop would take hours. Instead, we will write a script to do it in seconds.

---

### Part 1: The Linux Implementation (Bash)

In the Linux ecosystem, automation is built on "Shell Scripts" (`.sh` or no extension). These are executable text files containing a list of commands.

<!-- omit from toc -->
#### Install the Engine

We need a CLI tool to manipulate images. We will use **ImageMagick**, the industry standard for server-side image processing.

```bash
sudo apt update
sudo apt install imagemagick -y

```

<!-- omit from toc -->
#### Prepare the Workspace

We need a clean environment and some "raw" data to process. We will create a directory and use `curl` to download three random placeholder images from the internet.

```bash
mkdir ~/img_lab
cd ~/img_lab

# Download 3 random images
curl -L -o img1.jpg https://picsum.photos/300/300
curl -L -o img2.jpg https://picsum.photos/400/400
curl -L -o img3.jpg https://picsum.photos/500/500

# Verify they are there
ls -l

```

<!-- omit from toc -->
#### The Editor (`nano`)

On a graphical desktop, you use VS Code. On a remote Linux server, you often only have terminal-based editors. We will use `nano`, which is beginner-friendly.

Create and open a file named `process.sh`:

```bash
nano process.sh

```

<!-- omit from toc -->
#### Write the Script

Type the following code exactly into the editor.

> The first line `#!/bin/bash` is called the **Shebang** (`#`: haSH, `!`: bang).
>
> This tells the Linux Kernel: "This is not just text; use the Bash interpreter to execute this." Linux uses the first line of text here do denote the file type. In windows suffix extensions are used instead.

```bash
#!/bin/bash

echo "Starting Batch Process..."

# Create a directory for output if it doesn't exist
# -p means 'no error if existing'
mkdir -p processed

# Loop through every .jpg file in the current directory
for image in *.jpg
do
    echo "Converting $image to Grayscale..."
    
    # The 'convert' command comes from ImageMagick.
    # We take the input '$image', make it gray, and save it to the new directory.
    convert "$image" -colorspace Gray "processed/bw_$image"
done

echo "Job Done. Check the 'processed' directory."

```

- **To Save:** Press `Ctrl + O`, then `Enter`.
- **To Exit:** Press `Ctrl + X`.

<!-- omit from toc -->
#### Execution and Permissions (Critical Concept)

Try to run the script simply by calling its name:

```bash
process.sh

```

**Result:** `command not found`.

**The PATH environment variable:** Linux does *not* look in the current directory for commands for security reasons. You must specify the path explicitly: `./` means "here".

Try running it with the path:

```bash
./process.sh

```

**Result:** `Permission denied`.

Linux has a safety lock. A file cannot be executed as a program unless the **Execute (x)** permission bit is set. This prevents you from accidentally running a text document as a virus.

Grant permission: we use `chmod` (Change Mode) to add `+x` (Execute) rights.

```bash
chmod +x process.sh

```

*(Check `ls -l` afterwards. You will see the file has turned green or has `x` in the permissions).*

Run the script:

```bash
./process.sh

```

Check if the script actually worked. You should see a new directory containing grayscale versions of your images.

```bash
ls processed

```

---

### Part 2: The Windows Implementation (PowerShell)

We will now replicate this workflow in Windows. While the logic is similar, the **syntax** and **safety mechanisms** differ significantly.

<!-- omit from toc -->
#### Install the Engine

We need ImageMagick for Windows. Use Scoop (which you installed in the previous lab).

```powershell
scoop install imagemagick

```

> On Windows, the ImageMagick command is `magick` instead of `convert` to avoid conflicts with a built-in Windows tool.

<!-- omit from toc -->
#### Prepare the Workspace

Open PowerShell and create a directory on your Desktop.

```powershell
mkdir windows_img_lab
cd windows_img_lab

```

Download the images (using `curl`).

```powershell
curl -o img1.jpg https://picsum.photos/300/300
curl -o img2.jpg https://picsum.photos/400/400

```

<!-- omit from toc -->
#### The Editor

PowerShell scripts must have the `.ps1` extension. We can use the Visual Studio Code to write it.

```powershell
code process.ps1

```

<!-- omit from toc -->
#### Write the Script

Paste the following PowerShell code into vscode and save it (do not forget to save it. Ctrl-S works here, as in most Windows applications).

**Crucial Detail:** PowerShell uses objects. `$f` isn't just a filename text string; it's a file object with properties like `$f.Name` and `$f.FullName`.

```powershell
Write-Host "Starting Windows Batch Process..." -ForegroundColor Cyan

# Create Output Directory
New-Item -ItemType Directory -Force processed

# Get list of files
$files = Get-ChildItem *.jpg

# Process the list
foreach ($f in $files) {
    Write-Host "Processing $($f.Name)..."
    
    # Call the 'magick' command (ImageMagick v7)
    # We use the full path ($f.FullName) to be safe
    magick $f.FullName -colorspace Gray "processed\bw_$($f.Name)"
}

Write-Host "Done!" -ForegroundColor Green

```

<!-- omit from toc -->
#### Execution Policy (The Windows Safety Lock)

Try to run the script.

- **Note:** Like Linux, you must specify the path (`.\`).

```powershell
.\process.ps1

```

**Likely Result:** `File ... cannot be loaded because running scripts is disabled on this system.`

Windows defaults to a "Restricted" policy where `.ps1` files cannot run at all. This is a massive security feature to prevent ransomware from running scripts without your knowledge.

<!-- omit from toc -->
#### Fix and Run

Check Policy:

```powershell
Get-ExecutionPolicy

```

If it says `Restricted`, scripts are blocked.

Unblock (if needed): we allow scripts that we write locally (`RemoteSigned`).

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

```

Run the script:

```powershell
.\process.ps1

```

Open the directory in Explorer to see your work.

```powershell
ii processed

```

> The Powershell command "Invoke-Item" (the full name for the `ii` alias), opens or executes the item at the specified path, using its associated default application.

---

### Technical Summary: Scripting Differences

| Feature | Linux (Bash) | Windows (PowerShell) |
| --- | --- | --- |
| **File Extension** | `.sh` (convention, not required) | `.ps1` (required) |
| **Interpreter** | Defined by Shebang `#!/bin/bash` | Defined by file extension |
| **Variables** | `$variable` inside text strings | `$variable` inside text strings |
| **The "Safety Lock"** | **File Permission:** `chmod +x` (The file itself must be marked executable) | **Execution Policy:** `Set-ExecutionPolicy` (The system execution rules) |
| **Calling the script** | `./script.sh` (Current directory must be explicit) | `.\script.ps1` (Current directory must be explicit) |
| **Image Tool** | `convert` (ImageMagick v6 default) | `magick` (ImageMagick v7 default) |

---

## LAB: Process Management and Observation

In this lab, you will learn how to monitor the "heartbeat" of your Operating System. A **Process** is a program in execution. As an administrator, you must be able to identify which processes are consuming resources (CPU/RAM) and terminate them if they become unresponsive.

We will simulate a "high load" scenario on both Linux and Windows and use system tools to diagnose and resolve it.

---

### Part 1: The Linux Environment (WSL)

In Linux, process management is almost exclusively done via the command line on servers. We will look at both "Static" snapshots and "Dynamic" real-time views.

<!-- omit from toc -->
#### Install a Monitoring Tool

While Linux comes with `top`, a more user-friendly standard tool is `htop`. It provides colors, mouse support, and bar graphs.

```bash
sudo apt update
sudo apt install htop -y

```

<!-- omit from toc -->
#### Create "Artificial Load"

We need a safe way to stress the CPU so we have something interesting to look at. We will use the `yes` command. This command simply prints the letter "y" forever as fast as it can. It is harmless but computationally intensive.

Run the following command to send `yes` to the "black hole" (`/dev/null`) in the background (`&`):

```bash
yes > /dev/null &

```

Run it two more times to create multiple resource-hungry processes:

```bash
yes > /dev/null &
yes > /dev/null &

```

Check the job list to confirm they are running:

```bash
jobs

```

<!-- omit from toc -->
#### The Static View (`ps`)

The `ps` (Process Status) command takes a photo of the current state.

Standard View:

```bash
ps

```

You will likely only see `bash` and your `ps` command. This is because `ps` by default only shows processes attached to *this specific terminal window*.

The "All" View (The standard admin command):

```bash
ps aux

```

- **a:** All users.
- **u:** User/owner format (shows CPU/RAM).
- **x:** Processes not attached to a terminal (background daemons).

Filtering with Grep: the list from `ps aux` is too long. Let's find our `yes` processes using a pipe.

```bash
ps aux | grep yes

```

Look at the **PID** (Process ID) column (usually the 2nd column) and the **%CPU** column.

<!-- omit from toc -->
#### The Dynamic View (`htop`)

Now we want to see the system update live.

Install

```bash
sudo apt update
sudo apt install htop -y

```

Launch the tool:

```bash
htop

```

**Analyze the Display:**

- **Top Bars:** These represent your CPU Cores. You should see 3 of them at 100% usage (because we launched 3 `yes` loops).
- **Main List:** Look for the command `yes`.
- **PID:** Note the unique ID number for one of them.

**Interaction:**

- Press **F6** to change the sorting (select `%CPU`).
- Press **F10** or `q` to quit.

<!-- omit from toc -->
#### Termination (`kill`)

We need to stop these processes before they drain your laptop battery.

**Kill by PID:**
Use the PID you saw in `ps` or `htop` (e.g., 12345).

```bash
sudo kill 12345

```

**The "Nuclear" Option (`pkill`):**
Killing one by one is tedious. `pkill` allows you to kill by *name*.

```bash
sudo pkill yes

```

Run `htop` again. The CPU usage should drop to near zero, and the `yes` processes should be gone.

---

### Part 2: The Windows Environment (PowerShell)

Windows has a powerful GUI (Task Manager), but as an admin, you need to know how to manage processes via PowerShell, especially for automated scripts or remote management.

<!-- omit from toc -->
#### Create "Artificial Load"

We will create a PowerShell infinite loop.

Open a **NEW** PowerShell window (do not use your main one, as it will freeze while running the loop).

Type this command and press Enter:

```powershell
while ($true) {}

```

*(The cursor will blink and the prompt will vanish. This window is now consuming 100% of one CPU core).*

Minimize this window.

<!-- omit from toc -->
#### The Object View (`Get-Process`)

Go back to your **main** PowerShell window.

List Processes:

```powershell
Get-Process

```

- Unlike Linux text, these are .NET Objects.
- **Key Columns:**
  - `Id`: The PID (Process ID).
  - `CPU(s)`: The amount of processor time used.
  - `WorkingSet`: The amount of RAM used.

We are looking for a PowerShell process using a lot of CPU.

```powershell
Get-Process powershell

```

You will likely see two or more entries. One is your current window, the other is the "frozen" high-load window.

Let's verify which one is working hardest.

```powershell
Get-Process powershell | Sort-Object CPU -Descending

```

The one at the top is our target. Note its **Id**.

<!-- omit from toc -->
#### The GUI View (Task Manager)

It is important to correlate CLI data with the GUI.

- Press `Ctrl + Shift + Esc` to open Task Manager.
- Go to the **Details** tab.
- Right-click the column headers and choose "Select Columns". Ensure **PID** is checked.
- Find `pwsh.exe` or `powershell.exe`. Match the PID you saw in your terminal. You should see high CPU usage for that specific ID.

<!-- omit from toc -->
#### Termination (`Stop-Process`)

Let's kill the frozen window from our main window.

**The Safe Way (By ID):**

Replace `1234` with the ID you found in Step 2.

```powershell
Stop-Process -Id 1234

```

- *Result:* The other PowerShell window should instantly close.

**The Dangerous Way (By Name):**

**Do not run this now!**

`Stop-Process -Name powershell` would kill **every** PowerShell window instantly, including the one you are working in. This highlights why identifying by PID is safer.

<!-- omit from toc -->
#### Advanced Filtering (Where-Object)

In a complex system, you often need to find processes based on criteria, not just names.

Let's find all processes using more than 100MB of RAM.

```powershell
Get-Process | Where-Object { $_.WorkingSet -gt 100MB }

```

- `$_`: The current object (process) being checked.
- `.WorkingSet`: property with a weird name, representing used RAM for this process.
- `-gt`: "Greater Than".

---

### Comparison Summary

| Task | Linux (Bash) | Windows (PowerShell) |
| --- | --- | --- |
| **List All** | `ps aux` | `Get-Process` |
| **Real-time View** | `top` or `htop` | Task Manager (GUI) or `Get-Process` loops |
| **Filter by Name** | `ps aux | grep name` | `Get-Process -Name name` |
| **Filter by Resource** | Complex (requires awk/sort) | `Where-Object { $_.Property -gt Value }` |
| **Kill Process** | `kill <PID>` | `Stop-Process -Id <PID>` |
| **Kill by Name** | `pkill <name>` | `Stop-Process -Name <name>` |
