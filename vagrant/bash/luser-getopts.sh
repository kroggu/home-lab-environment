#!/bin/bash

usage() {
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password'
    echo ' -l LENGHT Specify the password lenght.'
    echo ' -s        Append a spacial character to password.'
    echo ' -v        Increase verbosity.'
    exit 1
}

log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
       echo "${MESSAGE}"
    fi
}
#Generate random password
LENGTH=48

while getopts vs:s OPTION
do
  case ${OPTION} in
   v)
     VERBOSE='true'
     log 'Verbose mode on.'
     ;;
   l)
     LENGTH="${OPTARG}"
     ;;
   s)
     USE_SPECIAL_CHARACTER='true'
     ;;
   ?)
     usage
     ;;
  esac
done

echo "Number of args: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg ${2}"
echo "Third args ${3}"

echo "OPTIND: ${OPTIND}"

shift "$(( OPTIND -1 ))"

echo 'After the shift:'
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg ${2}"
echo "Third args ${3}"


log 'Generatin a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
    log 'Selecting a random special character.'
    USE_SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done'
log 'Here is the password:'

echo "${PASSWORD}"

exit 0