#!/bin/sh

function helptext {
  echo "./new_post some-post-title creates a draft in _posts/CURRENT_DATE-some-post-title.md"
}

if [ "$#" -ne 1 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
  helptext
  exit
fi

POST_DATE=`date +"%Y-%m-%d"`
TITLE=$1
FILENAME="_posts/${POST_DATE}-${1}.md"

cat <<EOF > ${FILENAME}
---
author: jamison
layout: post-no-feature
title: ${TITLE}
description: ""
published: false
---

${TITLE}
Computers are super neat.

EOF

vim $FILENAME
