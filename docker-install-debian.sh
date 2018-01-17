sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg -o docker-repository-key
sudo apt-key add docker-repository-key && rm docker-repository-key
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
sudo usermod -aG docker vagrant
