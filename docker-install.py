import os, subprocess

try:
    output = subprocess.check_output("lsb_release -is", shell=True).decode().strip()
except subprocess.CalledProcessError:
    output = "Unknown"
#host = os.system("lsb_release -is")


if(output == "Ubuntu"):
    os.system("sudo apt-get update && sudo apt-get upgrade -y")
if(output == "Debian"):
    os.system("sudo apt update && sudo apt upgrade -y")


docker_install_cmds = "curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh ./get-docker.sh"
os.system(docker_install_cmds)
os.system("sudo systemctl start docker.service")
