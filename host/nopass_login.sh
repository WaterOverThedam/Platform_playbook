if [ -f /root/.ssh/id_ecdsa.pub ];then
  file="/root/.ssh/id_ecdsa.pub"
else 
  file="/root/.ssh/id_rsa.pub"
fi

ansible-playbook  -i hosts2  nopass_login.yml -e "key_file=$file" --ask-vault-pass


