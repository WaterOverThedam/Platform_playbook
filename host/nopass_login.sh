if [ -f /root/.ssh/id_ecdsa.pub ];then
  file="/root/.ssh/id_ecdsa.pub"
else 
  file="/root/.ssh/id_rsa.pub"
fi

ansible 'all' -i hosts2 -m authorized_key -a "user=root key=\"{{ lookup('file',\"$file\")}}\"" --ask-vault-pass


