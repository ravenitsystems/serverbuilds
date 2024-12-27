
# Switch on allow SSH password as it is set to not accept passwords at multiple locations
grep -r PasswordAuthentication /etc/ssh -l | xargs -n 1 sed -i 's/#\s*PasswordAuthentication\s.*$/PasswordAuthentication yes/; s/^PasswordAuthentication\s*no$/PasswordAuthentication yes/'
