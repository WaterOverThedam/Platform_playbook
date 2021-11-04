rand_str=$(< /dev/urandom tr -dc '0-9A-Za-z'|head -c ${1:-10};echo)
echo -n "win.${rand_str}"
