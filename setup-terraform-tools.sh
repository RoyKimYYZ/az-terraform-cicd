
sudo apt-get install wget unzip
export VER="0.12.24"
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
unzip terraform_${VER}_linux_amd64.zip

sudo mv terraform /usr/local/bin/
# May need to add "export PATH=$PATH:/usr/local/bin" into .bashrc file in $HOME 
which terraform
terraform -v

