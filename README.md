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

This KernelSU module is designed to counteract the recent unexpected updates to Tencent's kernel-level anti-cheat system on Android. It works by unloading the `inte` kernel module after boot.

## 🎯 Targeted Component

The module targets the `inte` kernel module that exposes the related proc nodes used by the Oplus/Tencent kernel security check path.

## 🚀 Installation

1.  Ensure you have **KernelSU** installed on your device.
2.  You can directly download the zip of the source code to obtain the installable KSU module
3.  Open KernelSU Manager -> Modules -> Install from Local Storage.
4.  Select the zip file and flash it.
5.  **Reboot** your device.

## 🔍 Verification

After rebooting, you can verify the module is working by checking whether the `inte` module is no longer loaded:

```bash
su
rmmod inte
```

**Expected Output:**
*   No output if the module is already unloaded.
*   If you see an error, the module may not be loaded or the current shell may not have sufficient permissions.

## 🛡️ How It Works

1.  **Detection**: The script waits for boot completion.
2.  **Action**: It runs `rmmod inte` to unload the kernel module.
3.  **Result**: The proc nodes exposed by that module disappear with it.

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
