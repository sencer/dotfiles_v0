#!/usr/bin/env bash

next=($(namaz next))
kalan=($(namaz kalan))
echo "${kalan[0]:-_}"
echo "---"

FILE="$HOME/.dotfiles/tmp/namaz"
isim=( Sabah Imsak Ogle Ikindi Aksam Yatsi Sabah Imsak Ogle Ikindi Aksam Yatsi )
i=0
first=0
last=7
# isim=( Sabah İmsak Öğle İkindi Akşam Yatsı )
if [[ ${next[1]} == 7 ]]; then
  first=7
  last=14
fi

while read line; do
  let i++
  if [[ $i -lt $first ]]; then
    continue
  elif [[ $i -eq $last ]]; then
    break
  fi
  if [[ $i -eq ${next[1]} ]]; then
    color="#FFFFAA"
  elif [[ $i -eq $((${next[1]}-1)) && ${kalan[1]} -lt 900 ]]; then
    color="#FF0000"
  else
    color="#FFFFFF"
  fi
  echo "$(printf "%-6s: %s|font=monospace color=$color" ${isim[$(($i-1))]} $(date --date=@$line '+%H:%M'))"
done < $FILE
