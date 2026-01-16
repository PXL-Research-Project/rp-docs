# LABS: Inside the computer

- [LAB: Know Your Machine (Hardware Audit)](#lab-know-your-machine-hardware-audit)
  - [Part 1: The Processor](#part-1-the-processor)
  - [Part 2: The Memory](#part-2-the-memory)
  - [Part 3: Storage](#part-3-storage)
- [LAB: The Silicon Race (Benchmarking \& Economics)](#lab-the-silicon-race-benchmarking--economics)
  - [Part 1: Disk Speed Benchmark (PowerShell)](#part-1-disk-speed-benchmark-powershell)
  - [Part 2: CPU Benchmark (Geekbench 6)](#part-2-cpu-benchmark-geekbench-6)
  - [Part 3: The Class Analysis (Cost/Performance)](#part-3-the-class-analysis-costperformance)
- [LAB: Benchmarks Everywhere](#lab-benchmarks-everywhere)
  - [Part 1: The Hall of Fame (Famous Tools)](#part-1-the-hall-of-fame-famous-tools)
  - [Part 2: Lab Activity A: Storage Verification (CrystalDiskMark)](#part-2-lab-activity-a-storage-verification-crystaldiskmark)
  - [Part 3: Lab Activity B: The GPU Stress Test (FurMark)](#part-3-lab-activity-b-the-gpu-stress-test-furmark)
  - [Reference: Is my computer fast?](#reference-is-my-computer-fast)
- [LAB: Scripting Your Own Benchmark](#lab-scripting-your-own-benchmark)
  - [Part 1: The Logic (The For-Loop)](#part-1-the-logic-the-for-loop)
  - [Part 2: The CPU Benchmark (The Number Cruncher)](#part-2-the-cpu-benchmark-the-number-cruncher)
  - [Part 3: The Disk Benchmark (The Latency Trap)](#part-3-the-disk-benchmark-the-latency-trap)
  - [Part 4: The Analysis (The "Order of Magnitude")](#part-4-the-analysis-the-order-of-magnitude)

---

[IN PROGRESS] mini-ISA simulator, RISC-V examples including Minecraft demonstrations

## LAB: Know Your Machine (Hardware Audit)

Most users only know they have a "Dell" or a "Lenovo." Engineers must know the silicon. In this lab, you will use PowerShell to query the WMI (Windows Management Instrumentation) database and extract your exact engineering specifications.

**Prerequisites:**

- Windows 11
- PowerShell (Admin)

### Part 1: The Processor

We will stop looking at marketing names ("Core Ultra Max HUV i9 3D") and look at the actual core architecture.

Open PowerShell as Administrator.

Type this command to get the raw CPU data:

```powershell
Get-CimInstance CIM_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed

```

**Record:**

- **Name:** (e.g., `12th Gen Intel(R) Core(TM) i7-12700H`)
- **Cores (Physical):** The actual silicon processing units.
- **Logical Processors:** If this number is roughly double your Core count, your CPU uses **Hyper-Threading** (Intel) or **SMT** (AMD).
- **MaxClockSpeed:** The top speed in MHz.

### Part 2: The Memory

RAM speed (MHz) is often more important than capacity for gaming and heavy workloads.

Type this command to inspect the physical RAM sticks:

```powershell
Get-CimInstance CIM_PhysicalMemory | Select-Object Capacity, Speed, Manufacturer, PartNumber

```

**Record:**

- **Capacity:** You will see a large number in Bytes (e.g., `17179869184`). Divide by  to get GB (approx 16GB).
- **Speed:** (e.g., `4800` or `3200`). This is your speed in MT/s.
- **Count:** How many lines appeared? If you see two lines, you are running in **Dual-Channel** mode (which doubles bandwidth).

### Part 3: Storage

Is your drive fast (SSD) or ancient (HDD)?

Type this command:

```powershell
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, Size

```

**Record:**

- **FriendlyName:** The actual model of your drive (e.g., `Samsung SSD 980 PRO`).
- **MediaType:**
  - `SSD`: Solid State Drive (Good).
  - `HDD`: Hard Disk Drive (Slow, spinning glass).
  - *Note:* If it says `Unspecified` but you have an NVMe drive, that is normal in Windows 11.

---

## LAB: The Silicon Race (Benchmarking & Economics)

**Objective:**
Manufacturers lie about battery life and speed. In this lab, you will stress-test your machine to find its *actual* top speed and compare it with your classmates to understand **Variance** and **Price-to-Performance**.

**Prerequisites:**

- Close all apps (Edge, Teams, Spotify).
- **Plug in your power cable.** (Windows laptops drastically throttle speed on battery).

### Part 1: Disk Speed Benchmark (PowerShell)

A fast CPU is useless if it takes 2 minutes to load Windows. We will use the built-in **Windows System Assessment Tool (`winsat`)**.

Open PowerShell as **Administrator** (Crucial).

Run the disk assessment:

```powershell
winsat disk -drive c

```

Wait 30-60 seconds for the "Running" text to finish.

**Record these two numbers:**

- **Sequential Read:** (Look for `Disk  Sequential 64.0 Read`). This is your speed for copying large video files.
- **Random Read:** (Look for `Disk  Random 16.0 Read`). This is your speed for booting Windows and launching apps.

### Part 2: CPU Benchmark (Geekbench 6)

We need a standardized score to compare different brands (HP vs. Surface vs. Custom PC).

- Download **Geekbench 6** for Windows (Search "Geekbench download").
- Run the installer and launch the app.
- Click **Run CPU Benchmark**. (This takes 2-5 minutes).
- **Record your Scores:**
  - **Single-Core Score:** Speed for standard apps (Word, Browsing, Python).
  - **Multi-Core Score:** Speed for heavy engineering (Video Editing, Compiling Code, VMs).

### Part 3: The Class Analysis (Cost/Performance)

*Share your data with the class.*

**The "Bang for Buck" Calculation**

Is a €1800 laptop actually twice as fast as a €900 one? Usually not really.

- **Formula:** `100 * (Price Paid (€) / Multi-Core Score) = Cost per Performance in Eurocent`
  - **Example:**
    - **Student A (Gaming Laptop):** 100*(€1200 / 11,000 points) = **11 eurocent per performance point**. (Great value).
    - **Student B (Slim Ultrabook):** 100*(€1600 / 9,000 points) = **18 eurocent per performance point**. (Paying for thinness, not speed).

**The Variance Check**

- Find a student with a similar CPU generation (e.g., both have "14th Gen Intel").
- Compare your **Geekbench Scores**.
- **Question:** Why might one laptop be 15% slower even with the same CPU?
- *Hint:* Thermal Throttling. One laptop might have better fans (cooling) allowing it to run faster for longer.

---

## LAB: Benchmarks Everywhere

*The Landscape: How the Industry Measures Speed*

Benchmarks fall into two categories: **Synthetic** (pure math calculations) and **Real-World** (simulating actual tasks like rendering video). You just ran `winsat` (Synthetic) and `Geekbench` (Synthetic). Now we will look at the tools professional reviewers use.

### Part 1: The Hall of Fame (Famous Tools)

You don't need to run these today, but you should know their names to read a tech review.

- **Cinebench (CPU):** The gold standard for creative work. It renders a photorealistic 3D scene using *only* the CPU. If you buy a laptop for video editing or 3D modeling, you look at this score.
- **3DMark (GPU):** The standard for gamers. It runs a fake video game cutscene to score your graphics card. Famous tests include *Time Spy* and *Fire Strike*.
- **PCMark 10 (Productivity):** Simulates "Office Work." It opens spreadsheets, starts video calls, and browses the web to see how fast a business computer feels.
- **Prime95 (Stability):** It calculates prime numbers to push the CPU to 100% heat. Used by engineers to check if a computer will crash under extreme load.

### Part 2: Lab Activity A: Storage Verification (CrystalDiskMark)

`winsat` is great for scripts, but **CrystalDiskMark** is the industry standard visualizer for storage speed. Let's see if the Windows command line told the truth.

Search for "CrystalDiskMark Standard Edition" (Zip or Installer) online, download and install/run it.

You will see rows like `SEQ1M Q8T1` and `RND4K`:

- **SEQ (Sequential):** Reading a huge continuous file (Movie).
- **RND (Random):** Reading thousands of tiny files scattered on the drive (Windows Boot).

Click the **All** button to run the test.

Look at the **Read [MB/s]** column in the first row (`SEQ1M`). Compare it to your `winsat` result from Part 1.

*Are they identical?*

### Part 3: Lab Activity B: The GPU Stress Test (FurMark)

We have tested the CPU and the Disk. Now we test the Graphics Processing Unit (GPU). We will use **FurMark**, famously known as the "GPU Burner."

> **Warning:** This tool intentionally pushes your GPU to its thermal limit. Your fans will spin up loudly.

Search for "Geeks3D FurMark" online and install it.

Open FurMark and click the **Preset: 1080p FHD** button.

A hairy, spinning donut will appear. This renders millions of hairs to stress the geometry engine.

Look at the graph at the bottom:

- **Temperature:** Watch it climb (e.g., from 40°C to 70°C).
- **Throttling:** If the temperature hits a limit (usually 85°C+ on laptops), does the **FPS** (Frames Per Second) suddenly drop? That is your hardware protecting itself from melting.

**Record:** Your average **FPS** score.

### Reference: Is my computer fast?

Use this rough guide to judge your scores for 2025 hardware.

| Component | Metric | Slow (Budget) | Good (Mid-Range) | Fast (High-End) |
| --- | --- | --- | --- | --- |
| **Disk (Seq Read)** | CrystalDiskMark | < 500 MB/s (SATA) | 3,000 MB/s (Gen3 NVMe) | > 7,000 MB/s (Gen4 NVMe) |
| **CPU (Single Core)** | Geekbench 6 | < 1,500 | 2,000 - 2,500 | > 2,800 |
| **CPU (Multi Core)** | Geekbench 6 | < 6,000 | 9,000 - 12,000 | > 16,000 |
| **GPU (1080p)** | FurMark | < 30 FPS | 60 - 90 FPS | > 140 FPS |

---

## LAB: Scripting Your Own Benchmark

Commercial benchmarks (like Geekbench) are "Black Boxes" - you don't know what they are doing. In this lab, you will write a "White Box" benchmark. You will write a script to measure the two fundamental bottlenecks of computing:

- **CPU Speed:** Pure mathematical throughput.
- **Disk Latency:** The cost of asking the Operating System to create a file.

**Prerequisites:**

- Windows 11
- PowerShell (standard user is fine).
- **Warning:** This lab will create (and then delete) temporary files.

### Part 1: The Logic (The For-Loop)

All benchmarks rely on a simple concept: **The Loop**. We do a small task `N` times and measure how long it takes.

- **The Command:** `Measure-Command { ... }`
- **The Loop:** `1..$N | ForEach-Object { ... }`

### Part 2: The CPU Benchmark (The Number Cruncher)

We will test your processor's **Floating Point Unit (FPU)**. We will ask it to calculate the square root of 2 million numbers. This happens entirely inside the CPU cache and RAM; it touches the disk zero times.

Open PowerShell.

Copy and paste this code block (it calculates  for numbers 1 to 2,000,000):

  ```powershell
  Write-Host "Starting CPU Stress Test..."
  $cpuTime = Measure-Command {
      1..2000000 | ForEach-Object {
          [Math]::Sqrt($_)
      }
  }
  Write-Host "CPU Time: $($cpuTime.TotalSeconds) seconds"
  Write-Host ""
 
  ```

**Record the Result:** **Time:** ________ seconds.

*Engineering Note:* If your time is under 10 seconds, your Single-Core performance is excellent.

### Part 3: The Disk Benchmark (The Latency Trap)

Now we will do *significantly less* work, but we will involve the **File System**. We will ask the computer to create just **10,000** empty text files.

This forces the CPU to stop, talk to the OS Kernel, update the Master File Table (MFT), and physically write to the SSD.

Create a junk directory so we don't clutter your desktop:

  ```powershell
  mkdir benchtest
  
  ```

Copy and paste this code (Creates 10,000 files):

  ```powershell
  Write-Host "Starting Disk Latency Test..."
  $diskTime = Measure-Command {
      1..10000 | ForEach-Object {
          New-Item -ItemType File -Path ".\benchtest\testfile_$_.txt" | Out-Null
      }
  }
  Write-Host "Disk Time: $($diskTime.TotalSeconds) seconds"
  Write-Host ""
  
  ```

Now clean up and delete the junk files.

  ```powershell
  Remove-Item -Path ".\benchtest" -Recurse -Force

  ```

**Record the Result:** **Time:** ________ seconds.

### Part 4: The Analysis (The "Order of Magnitude")

Compare your two experiments:

- **Experiment A (CPU):** 2,000,000 operations.
- **Experiment B (Disk):** 10,000 operations.

**Discussion Question:**
Your CPU calculated **2 million** square roots in (approx) 8 seconds.
But creating only **10 thousand** files likely took roughly the same time (or longer).

---
