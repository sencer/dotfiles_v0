if [[ `w -h|wc -l` -lt 2 ]]; then
  while read line;do
    if [ -d ~/$line ]; then
      server $line
    fi
  done < <(cat $PBSSERVERFILE|cut -d' ' -f1)
fi
# ps aux|grep '[d]bus-launch'|tr -s ' '|cut -d' ' -f2|xargs kill 2>/dev/null
