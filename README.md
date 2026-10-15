# Hide ACE Kernel Interfaces

> **Tencent has unexpectedly updated the kernel anti-cheat system for Android today, with the purpose of this module being to conceal the file API interfaces exposed by the anti-cheat module.**

## ⚠️ Important Legal Notice: AGPLv3 License

This project is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0)**.

### What does this mean for you?
1.  **Freedom to Use**: You are free to use, study, and modify this module for personal use.
2.  **Mandatory Source Disclosure**: If you distribute this software, or if you use it to interact with users over a network (e.g., in a modified game client or server-side validation tool), **you MUST make your complete source code available to all users**.
3.  **No Closed-Source Derivatives**: You cannot take this code, modify it, and use it in a closed-source commercial product or service without releasing your modifications. This includes any entity attempting to integrate this logic into proprietary anti-cheat bypass services.

**We reserve the right to pursue legal action against any violation of the AGPLv3 terms.** Do not test our resolve.

---

## 📌 Overview

This KernelSU module is designed to counteract the recent unexpected updates to Tencent's kernel-level anti-cheat system on Android. It works by concealing the specific `/proc` file API interfaces that the anti-cheat kernel module exposes to user space.

By bind-mounting empty files over these interfaces, the module ensures that any user-space application (including games and anti-cheat clients) reading these nodes receives an "empty" response, effectively simulating a "clean" system state where no integrity violations are reported.

## 🎯 Targeted Interfaces

The module hides the following proc nodes identified in the Oplus/Tencent kernel security check module (`oplus_kernel_security_check.c`):

-   `/proc/inte_ko`: Reports integrity issues with loaded Kernel Objects (KO).
-   `/proc/inte_systbl`: Reports tampering with the System Call Table.
-   `/proc/inte_status`: Used for internal boot stage signaling.

## 🚀 Installation

1.  Ensure you have **KernelSU** installed on your device.
2.  You can directly download the zip of the source code to obtain the installable KSU module
3.  Open KernelSU Manager -> Modules -> Install from Local Storage.
4.  Select the zip file and flash it.
5.  **Reboot** your device.

## 🔍 Verification

After rebooting, you can verify the module is working by checking if the target files return empty content:

```bash
su
cat /proc/inte_ko
cat /proc/inte_systbl
cat /proc/inte_status
```

**Expected Output:**
*   No output (empty string).
*   If you see error messages like "No such file or directory," ensure the kernel module is actually loaded on your device. The module safely skips non-existent files.

## 🛡️ How It Works

1.  **Detection**: The script identifies the target `/proc` files.
2.  **Preparation**: It creates empty dummy files in `/data/local/tmp/.ksu_hide_ace/`.
3.  **Mounting**: It uses `mount --bind` to overlay the empty dummy files onto the real proc nodes.
4.  **Result**: User-space processes reading these nodes see an empty file, interpreting it as "no anomalies detected."

## ⚖️ Disclaimer

-   This tool is provided for **educational and research purposes only**.
-   The author is not responsible for any account bans, device bricking, or other consequences resulting from the use of this module.
-   Using this module may violate the Terms of Service of certain games. Use at your own risk.
-   **Respect the License**: Violations of the AGPLv3 license will be dealt with strictly.

## 📄 License

Copyright (C) 2026 stuffed-cat

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
