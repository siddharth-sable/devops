import os

upgrade = "sudo apt-get upgrade"
os.system(upgrade)
docker_install_cmds = "curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh ./get-docker.sh"
os.system(docker_install_cmds)
os.system("sudo systemctl start docker.service")
