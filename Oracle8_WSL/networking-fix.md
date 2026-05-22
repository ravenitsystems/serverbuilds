WSL2 access to a Windows host service on localhost
Problem
You run an API server on Windows (for example OpenAPI on port 1234) and it works from the host:

http://127.0.0.1:1234
From WSL2, the same URL fails (connection refused or timeout).

That is expected with WSL2’s default NAT networking:

Environment	What 127.0.0.1 means
Windows
The Windows host
WSL2 (NAT)
The Linux VM only
If the server listens only on 127.0.0.1 on Windows, WSL cannot reach it via the WSL gateway IP (172.x.x.1) either, because nothing is listening on that interface.

Solution (recommended)
Enable mirrored networking in WSL so Windows and WSL share the same network view. Then 127.0.0.1 in WSL is the Windows host for services bound on Windows localhost.

Requirements:

Windows 11 (22H2 or later; mirrored mode is supported on current releases)
WSL 2 (recent version; 2.4+ recommended)
Benefits:

Server can stay on 127.0.0.1 (not exposed to the LAN)
Same URL in Windows and WSL: http://127.0.0.1:1234
No extra firewall rules or port forwarding for this case
How to set it up (any machine)
1. Confirm the service on Windows
On Windows PowerShell:

netstat -ano | findstr ":1234"
You should see something like:

TCP    127.0.0.1:1234    ...    LISTENING
Test from Windows:

curl.exe http://127.0.0.1:1234/
2. Create or edit .wslconfig
File location (per user):

%USERPROFILE%\.wslconfig
Example: C:\Users\<YourUser>\.wslconfig

Contents:

[wsl2]
networkingMode=mirrored
Save the file. There must be no typo in networkingMode or section name [wsl2].

3. Restart WSL
From PowerShell or CMD:

wsl --shutdown
Wait a few seconds, then start WSL again (open a distro terminal or run wsl).

This stops all running WSL distros briefly so the new config loads.

4. Verify mirrored mode
Inside WSL:

wslinfo --networking-mode
Expected output:

mirrored
If wslinfo is missing, test connectivity directly (step 5).

5. Verify access to the Windows service
From WSL:

curl -v http://127.0.0.1:1234/
You should get a normal HTTP response (for example 200), same as from Windows.

Optional env var for tools/scripts:

export OPENAPI_BASE_URL=http://127.0.0.1:1234
Quick reference
Step	Action
1
Confirm service listens on Windows 127.0.0.1:PORT
2
Add networkingMode=mirrored to %USERPROFILE%\.wslconfig
3
Run wsl --shutdown
4
Confirm wslinfo --networking-mode → mirrored
5
From WSL: curl http://127.0.0.1:PORT/
Troubleshooting
Still cannot connect after mirrored mode

Run wsl --shutdown again and reopen the distro.
Confirm the Windows service is still running: netstat -ano | findstr ":1234".
Use 127.0.0.1, not localhost if IPv6 causes issues (::1 is not supported for this path in some setups).
VPN or Docker DNS problems after enabling mirrored

Add to .wslconfig:

[wsl2]
networkingMode=mirrored
dnsProxy=false
Then wsl --shutdown again.

Corporate policy blocks .wslconfig

Use the alternative below (bind + firewall), or ask IT to allow mirrored mode.

Alternative (without mirrored networking)
Use only if you cannot use mirrored mode:

Configure the server to listen on 0.0.0.0:1234 (or the WSL virtual switch IP), not only 127.0.0.1.

From WSL, use the Windows host IP on the WSL interface (often the default gateway):

ip route show default
# use the gateway IP, e.g. curl http://172.19.96.1:1234/
Add a Windows Firewall inbound rule allowing only the WSL subnet (e.g. 172.19.96.0/20) to TCP port 1234.

This works but is less ideal if the service binds to 0.0.0.0, because exposure depends on firewall rules and bind address.

What we did on this machine
Host: Windows 11, WSL 2.6.x, distro OracleLinux_8_10
OpenAPI server on 127.0.0.1:1234
Created C:\Users\raven\.wslconfig with networkingMode=mirrored
Ran wsl --shutdown
Confirmed from WSL: curl http://127.0.0.1:1234/ → HTTP 200
Summary
Cause: WSL2 NAT gives Linux its own loopback; Windows 127.0.0.1 is not WSL’s localhost.

Fix: Mirrored networking in .wslconfig plus wsl --shutdown, then use http://127.0.0.1:<port> from WSL the same way as on Windows.

Recreate elsewhere: Same .wslconfig, same restart, same verification commands—no change to the OpenAPI server bind address required.

You can paste this into a wiki, README, or ticket. If you want it saved as a file (for example docs/wsl-host-api.md in a project), say where and I can add it.
