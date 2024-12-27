### To set up sshfs on windows
First install the software on windows the applications are called winfsp and sshfs-win and can be downloaded from git.
```
winget install SSHFS-Win.SSHFS-Win
```
To create a new netowrk drive go to My PC and map network drive and use the following template
```
\\sshfs\REMUSER@HOST[\PATH]
```


# Switch on allow SSH password as it is set to not accept passwords at multiple locations
```
grep -r PasswordAuthentication /etc/ssh -l | xargs -n 1 sed -i 's/#\s*PasswordAuthentication\s.*$/PasswordAuthentication yes/; s/^PasswordAuthentication\s*no$/PasswordAuthentication yes/'
```
