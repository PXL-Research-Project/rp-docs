# LABS: Global IT overview

- [LAB: The Anatomy of a Web Request](#lab-the-anatomy-of-a-web-request)
  - [Step 1: Open the Terminal](#step-1-open-the-terminal)
  - [Step 2: DNS Lookup (The Contacts List)](#step-2-dns-lookup-the-contacts-list)
  - [Step 3: Traceroute (The Path)](#step-3-traceroute-the-path)
  - [Step 4: Open the Hood](#step-4-open-the-hood)
  - [Step 5: Analyze the Waterfall](#step-5-analyze-the-waterfall)
  - [Step 6: Caching (The "Data Saved" Test)](#step-6-caching-the-data-saved-test)
  - [Step 7: Protocol Analysis (The Reality Check)](#step-7-protocol-analysis-the-reality-check)
  - [Lab Deliverable (Blackboard Submission)](#lab-deliverable-blackboard-submission)

---

## LAB: The Anatomy of a Web Request

**Case Study: Google Maps**

**Objective:**
In this lab, you will stop being a user and start being an engineer. You will use the standard tools built into Windows 11 to dissect exactly what happens between typing a URL and seeing a map appear. You will explore **DNS** (the contacts list), **Routing** (the path), and **HTTP/Caching** (the delivery).

**Prerequisites:**

- A PC running **Windows 11**.
- **Windows Terminal** (Pre-installed).
- **Microsoft Edge** or **Google Chrome** or a similar chrome-based browser.

---

**Part 1: The Plumbing**

*Before the webpage loads, your computer must find where the server is.*

### Step 1: Open the Terminal

- Right-click the **Start Button** (Windows Logo).
- Select **Terminal** (or *Terminal (Admin)* - either works).
- Ensure the tab at the top says "PowerShell".

### Step 2: DNS Lookup (The Contacts List)

Computers don't know what "google.com" is; they only know IP addresses. We will use the `nslookup` tool inside PowerShell to find it.

Type the following command and hit **Enter**:

```powershell
nslookup google.com

```

*(Note: Linux uses `dig`)*

**Analyze the Output:**

- You will see a "Non-authoritative answer" followed by multiple `Address` lines.
- **Question 1:** Why are there multiple IP addresses listed for a single website? (Hint: What happens if one server crashes?)

### Step 3: Traceroute (The Path)

How does data travel from your laptop to Google? It hops across multiple routers.

1. Type the following command:

    ```powershell
    tracert google.com

    ```

    *(Note: Linux uses `traceroute`)*

2. **Watch the Hops:**
   - Each line represents a router (a physical box) somewhere in the world.
   - The time (in `ms`) is the latency.
   - If you see `* * * Request timed out`, it simply means that specific router is configured to ignore tracking packets for security. This is normal.

3. **Analyze the Output:**
   - **Question 2:** How many "hops" did it take to reach the destination?

   While `tracert` is a classic tool, PowerShell has a modern command that tests connectivity and port access. Try this:

   ```powershell
   Test-NetConnection google.com -TraceRoute

   ```

---

**Part 2: The Inspection (Edge DevTools)**

*Now we analyze the actual application using the browser engine.*

### Step 4: Open the Hood

1. Open **Microsoft Edge** (or Chrome).
2. Navigate to [https://www.google.com/maps](https://www.google.com/maps).
3. Press **F12** on your keyboard (or Right-click anywhere  **Inspect**).
4. Click on the **Network** tab in the panel that appears.

>Tip: If you don't see "Network", click the `+` or `>>` icon in the DevTools menu.*

### Step 5: Analyze the Waterfall

1. With the Network tab open, press **F5 (Refresh)** to reload the page.
2. Watch the "Waterfall" graph on the right. Each bar is a single file being downloaded.
3. **Filter the Traffic:**
   - Google Maps is massive. At the top of the Network tab, click **Img** (Images) to see only image files.
   - **Action:** Click and drag the map to move to a new area.
   - **Observation:** Notice new requests popping up at the bottom of the list? That is **Fetch/XHR** in action. The page doesn't reload; it just asks the server for *new* data for the area you just looked at.

---

### Step 6: Caching (The "Data Saved" Test)

1. In the Network tab, look for the checkbox labeled **Disable cache** (near the top, under the "Network" label). **Make sure it is UNCHECKED.**
2. **The Cached Load:**
   - Press the **Refresh** button (or F5).
   - Look at the bottom status bar of the DevTools window.
   - Find the text that says something like: `Transferred: 50 KB` (or a low number).
   - *Note:* The "Resources" number might be huge (e.g., 5 MB), but "Transferred" is small. This proves the browser retrieved almost everything from your hard drive.
3. **The Uncached Load:**
   - **Check** the **Disable cache** box. (This forces the browser to act like a new visitor).
   - Press **Refresh** (F5) again.
   - Look at the "Transferred" number at the bottom.
   - **Observation:** It should jump massively (e.g., from `50 KB` to `5 MB`).
   - **Lesson:** The speed difference depends on your internet, but the **data difference** proves the cache saved you from downloading 5 MB of data unnecessarily.

---

**Part 3: Protocol Analysis**

*Deep dive into the data headers.*

### Step 7: Protocol Analysis (The Reality Check)

1. In the Network tab, ensure the **Disable cache** box is still **Checked** and refresh one last time.
2. Scroll to the very top of the list (usually named `maps.google.com` or `?cid=...`). Click it.
3. Click the **Headers** tab on the right.
4. **The Truth About Headers:**
   - **Status Code:** You should see `200 OK` (Green).
     - *Check:* If you uncheck "Disable cache" and refresh, this often turns into `304 Not Modified` (Grey).
   - **content-encoding:** Look for `br`.
     - *Context:* This stands for **Brotli**, a compression algorithm invented by Google that is more efficient than the older `gzip`.
   - **content-type:** This will likely be `text/html`. This tells the browser "I am sending you a webpage structure."

---

### Lab Deliverable (Blackboard Submission)

TODO: make into a BB Test.

**1. The Plumbing**

- Paste a screenshot of your `nslookup` output.
- Paste a screenshot of your `tracert` output.
- *Questions:*
  - Why does `nslookup` return multiple IP addresses?

**2. The Traffic (DevTools):**

- Paste a screenshot of your **Network Tab** showing the "Waterfall".
- *Questions:*
  - When you dragged the map, did the URL in the address bar change? (Yes/No)
  - Did the page reload? (Yes/No).

**3. The Speed:**

- Time for Standard Reload: _______ ms.
- Time for Hard Reload: _______ ms.
- *Questions:*
  - Why is the Hard Reload slower? (Use the word "Cache" in your answer).

**4. Challenge Question:**

- In the Headers tab, find the `server` header (it might say `gws` or `sffe`).
- *Questions*
  - What do you think this stands for? (Feel free to Google it).
