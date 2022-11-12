#/bin/bash
problem_id=$1 #ex) abc123_c
language=$2
file=$3

# split problem_id with '_'
IFS='_' read -r -a array <<< "$problem_id"
contest_id=${array[0]}

TOKEN=`curl -sS -c cookie -b cookie https://atcoder.jp | grep -oP 'csrf_token" value=\"(.+=)\"' | sed -r 's/csrf_token\" value=\"(.+=)\"/\1/g' | sed -e 's/+/\+/g' | awk NR==1`
curl -sS -i -c cookie -b cookie https://atcoder.jp/contests/${contest_id}/submit -X POST -F "data.TaskScreenName=${problem_id}" -F "data.LanguageId=${language}" -F "sourceCode=<${file}" -F "csrf_token=${TOKEN}"
