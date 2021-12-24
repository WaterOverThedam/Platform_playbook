 ansible-playbook -i ../hosts_db  init_windows.yml  -t 'param,prepare,time_sync' --limit "$1"
 