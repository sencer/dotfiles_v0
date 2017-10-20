#!/bin/bash
a=""
a="$a $(grep -qi 'X-Keywords:.*A Thing of Beauty'  "$1" && echo -n '+athing ')"
a="$a $(grep -qi 'X-Keywords:.*Diger/Kimyasanal'   "$1" && echo -n '+kimyasanal ')"
a="$a $(grep -qi 'X-Keywords:.*Diger/SCL'          "$1" && echo -n '+scl ')"
a="$a $(grep -qi 'X-Keywords:.*Diger/SU-GSivil'    "$1" && echo -n '+gsivil ')"
a="$a $(grep -qi 'X-Keywords:.*Draft'              "$1" && echo -n '+draft ')"
a="$a $(grep -qi 'X-Keywords:.*Important'          "$1" && echo -n '+important ')"
a="$a $(grep -qi 'X-Keywords:.*Inbox'              "$1" && echo -n '+inbox ')"
a="$a $(grep -qi 'X-Keywords:.*Muted'              "$1" && echo -n '+muted ')"
a="$a $(grep -qi 'X-Keywords:.*Psi K'              "$1" && echo -n '+psik ')"
a="$a $(grep -qi 'X-Keywords:.*S&ATE-n&ATE-f'      "$1" && echo -n '+sinif ')"
a="$a $(grep -qi 'X-Keywords:.*Sent'               "$1" && echo -n '+sent ')"
a="$a $(grep -qi 'X-Keywords:.*Starred'            "$1" && echo -n '+starred ')"
a="$a $(grep -qi 'X-Keywords:.*Yamanlar'           "$1" && echo -n '+yamanlar ')"
a="$a $(grep -qi 'X-Keywords:.*Yamanlar/04'        "$1" && echo -n '+04 ')"
a="$a $(grep -qi 'X-Keywords:.*Yamanlar/Olimpiyat' "$1" && echo -n '+olimpiyat ')"
a="$a $(grep -qi 'X-Keywords:.*Yamanlar/USA'       "$1" && echo -n '+usa ')"
a="$a $(grep -qi 'X-Keywords:.*[Imap]/Trash'       "$1" && echo -n '+trash ')"

if [[ ! -z ${a// } ]]; then
  id=$(sed -n '/^message-id/I{s/^.*<//;s/>.*$//;p;q}' "$1")

  if [[ -z "$id" ]]; then
    id=notmuch-sha1-$(sha1sum "$1"|cut -d' ' -f1)
  fi

  echo "${a} -- id:$id"|tr -s ' '
fi
