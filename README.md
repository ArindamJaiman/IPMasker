# IPMasker
🔄 IP Address Changer Script (Bash)
This script automatically changes the IP address of a specified network interface (eth0 by default) every second for a defined number of iterations. Useful for testing, simulations, or any task requiring frequent IP changes.

📜 Script Overview
Language: Bash

Purpose: Change IP address dynamically

Interface Used: eth0 (can be modified)

Frequency: Every 1 second

IP Range: 10.0.2.1 – 10.0.2.254

Change Limit: MAX_CHANGES=10 (modifiable)

🧠 How It Works
change_ip Function:
Randomly generates a new IP address in the 10.0.2.x range and applies it to the interface.

Looping with Sleep:
A for loop runs the change function every second until it hits the maximum defined changes.

⚙️ Usage Instructions
1. Save the Script
Save the following code as change_ip.sh (file type: .sh)

bash
Copy
Edit
#!/bin/bash

INTERFACE="eth0"  # Network interface
MAX_CHANGES=10    # Number of IP changes

change_ip() {
    NEW_IP="10.0.2.$((RANDOM % 254 + 1))"
    sudo ifconfig $INTERFACE down
    sudo ifconfig $INTERFACE $NEW_IP
    sudo ifconfig $INTERFACE up
    echo "IP address changed to $NEW_IP"
}

for ((i=0; i<MAX_CHANGES; i++)); do
    change_ip
    sleep 1
done
2. Make it Executable
bash
Copy
Edit
chmod +x change_ip.sh
3. Run the Script
bash
Copy
Edit
sudo ./change_ip.sh
⚠️ Warnings
This script disrupts your current network connection each time it runs.

Use with caution and ensure it’s suitable for your test environment.

To run indefinitely, change the loop to:

bash
Copy
Edit
while true; do
    change_ip
    sleep 1
done
Stop the script manually with CTRL+C.

👤 Author
Arindam Jaiman

git hub - https://github.com/ArindamJaiman
linkedin - https://www.linkedin.com/in/arindam-jaiman-6149a82ab/
instagram account - https://www.instagram.com/thearindamjaiman