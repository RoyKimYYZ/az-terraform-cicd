

# Terraform installation in Ubuntu (windows subsystem for linux)
sudo apt-get install wget unzip
export VER="1.10.5" # look up latest version at https://www.terraform.io/downloads.html
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
unzip terraform_${VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# May need to add "export PATH=$PATH:/usr/local/bin" into .bashrc file in $HOME 
which terraform
terraform -v


# OPTIONAL: change prompt relative to home directory
PS1='\[\e[0;32m\]~${PWD/#$HOME/}\[\e[m\]$ '