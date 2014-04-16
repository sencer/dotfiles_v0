if [[ `w -h|wc -l` -lt 2 ]]; then
  for i in $PBS_SERVER_LIST; do 
    if [ -d ~/$i ]; then
      server $i
    fi
  done
fi
# ps aux|grep '[d]bus-launch'|tr -s ' '|cut -d' ' -f2|xargs kill 2>/dev/null
