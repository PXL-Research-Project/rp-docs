# Lab Module: CPU Internals and the Datapath

- [Introduction \& Setup](#introduction--setup)
  - [Open the Simulator](#open-the-simulator)
- [Mini-Lab: The "Visual" Datapath](#mini-lab-the-visual-datapath)
  - [Input the Code](#input-the-code)
  - [The Datapath Walkthrough](#the-datapath-walkthrough)
- [Mini-Lab: Painting on Silicon (Memory Mapped I/O)](#mini-lab-painting-on-silicon-memory-mapped-io)
  - [Configure the LED Matrix (Online Version)](#configure-the-led-matrix-online-version)
  - [The Color Code](#the-color-code)
  - [The Task](#the-task)
  - [Execute and Observe](#execute-and-observe)
  - [The Student Challenge](#the-student-challenge)

## Introduction & Setup

In the lecture, we discussed the **Von Neumann Architecture**, where instructions and data live in the same memory. We also discussed how the **Datapath** (ALU, Registers) executes instructions.

In this lab, we will use the online simulator **Ripes.me**.

### Open the Simulator

1. Open your web browser (Chrome or Edge recommended).

2. Navigate to <https://ripes.me>.

3. You will see the main interface with "Editor", "Processor", and "I/O" tabs on the left vertical bar.

4. **CRITICAL SETUP:**

   - Click the **Processor** tab (the Chip icon).

   - Click the **"Select Processor"** button ( top-left chip icon).

   - Choose `Single-cycle processor` from the `RISC-V`, `32-bit` list. This layout is best for visualizing data flow.

   - Ensure the **Layout** is set to `Standard`.

## Mini-Lab: The "Visual" Datapath

![ripes screenshot|size=60%|align=center](images/ripes.png "Visualize how an instruction flows through the Fetch-Decode-Execute cycle.")

### Input the Code

1. Click the **Editor** tab (Code/Script icon on the left sidebar).

2. Delete any existing code.

3. Paste this simple arithmetic program in the Source code editor on the left:

```asm
.data
    # No data section needed yet

.text
main:
    li  t0, 5       # Load Immediate: t0 = 5
    li  t1, 3       # Load Immediate: t1 = 3
    add t2, t0, t1  # Add: t2 = 5 + 3
    
    # Infinite loop to stop the program falling off the edge
    j   main
```

### The Datapath Walkthrough

1.  Click the **Processor** tab (Chip icon).

2.  Locate the **Control Panel** at the top (Play, Pause, Step buttons).

3.  **Click the green Run button** to make sure it assembles, then click **Pause** and **Reset** (button with recycle arrows).

4.  **Click the "Step" (Clock with a single "\>" Arrow) button ONCE.**

      - Look at the **Instruction Memory** block on the bottom right. You will see the instruction `addi x5 x0 5` (which is the real version of `li`) being highlighted.

      - Follow the red/green wires. See how the value `5` exits the instruction and heads toward the Register File.

5.  **Click the "Step" button AGAIN.**

      - Look at the **Register File** (large block in the middle/right). Find register `x5` (t0). It now holds `0x5`.

6.  **Click until you reach the `add` instruction.**

      - **Observe the ALU:** You should see two wires going *into* the ALU carrying `5` and `3`.

      - You should see one wire coming *out* of the ALU carrying `8`.

      - *This is the physical manifestation of your code.*

## Mini-Lab: Painting on Silicon (Memory Mapped I/O)

*Understand how writing to specific memory addresses can control hardware peripherals (a display).*

In a Von Neumann machine, "talking to a screen" is often the exact same thing as "writing a number to memory." If we write a specific color code to a specific magic address, a pixel lights up.

### Configure the LED Matrix (Online Version)

1.  Click the **I/O** tab (the Plug icon on the left sidebar).

2.  You will see a list of available peripherals (LED Matrix, Swords, D-Pad, etc.).

3.  **Double-click "LED Matrix"**. This will open a new parameter window.

4.  **Configuration settings:**

      - **Height:** 10

      - **Width:** 10

      - **Base Address:** is `0xF0000000` (Make a note of this\!)

      - *Note: The LED Matrix should now be visible in the I/O panel.*

### The Color Code

Ripes uses 32-bit color codes (RGB): `0x00RRGGBB`.

- Red: `0x00FF0000`

- Green: `0x0000FF00`

- Blue: `0x000000FF`

### The Task

1.  Return to the **Editor** tab.

2.  Delete any existing code. Copy the following code into the Source code window. Read the comments carefully.

<!-- end list -->

```asm
.text
main:
    # 1. Load the Base Address of the LED Matrix
    # We use 'li' (Load Immediate) to put the magic address into t0
    li t0, 0xF0000000

    # 2. Pick a Color (Red)
    # We put the hex code for Red into t1
    li t1, 0x00FF0000

    # 3. Light up the FIRST pixel (Top-Left)
    # 'sw' (Store Word) takes the value in t1 (Color) 
    # and writes it to the memory address inside t0 (The Screen)
    sw t1, 0(t0)

    # 4. Pick a new Color (Green)
    li t2, 0x0000FF00

    # 5. Light up the SECOND pixel
    # CHALLENGE: Computers use byte-addressing. 
    # A word is 4 bytes. So the next pixel is at offset 4, not 1.
    sw t2, 4(t0)

    # Infinite loop to freeze the state
stop:
    j stop
```

### Execute and Observe

1.  Click the **I/O** tab again so you can see the LED Matrix.

2.  Press **Run** (Fast Forward button) in the top control bar.

3.  Look at the **LED Matrix**.

      - Did two pixels light up?

      - Why is the second pixel next to the first one, even though we added `4` to the address?

### The Student Challenge

Now, modify the code to do the following:

1.  **Light up the 3rd pixel** with the color **Blue**.

2.  **Calculate the offset:** If the 2nd pixel was at offset `4`, what is the offset for the 3rd pixel?

3.  **Experimental:** Try writing to offset `40` (decimal). Where does the pixel appear? (Hint: The width of the screen is 10 pixels).

**Checklist:**

- [ ] Red pixel at (0,0)

- [ ] Green pixel at (1,0)

- [ ] Blue pixel at (2,0)

- [ ] Experimental pixel at (0,1)
