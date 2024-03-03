#!/bin/sh

## INFO
user="$(whoami)"
host="$(hostname)"
os="Debian $(cat /etc/debian_version)"
kernel="$(uname -sr)"
docker="$(docker -v | awk '{gsub(/,/, "", $3); print $3}')"
shell="$(grep "^$(id -un):" /etc/passwd | awk -F: '{print $7}')"
tunnel="$(/usr/local/bin/tunnel.sh)"
address="$(curl --no-progress-meter ip.y1f.de 2>/dev/null)"
if [ -z "$address" ]; then
    address="localhost"
fi

## DEFINE COLORS
bold='\033[1m'
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;93m'
blue='\033[0;34m'
purple='\033[0;95m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'
ul_link='\033[4;36m'
reset='\033[0m'

## COMBINED STYLE
yc="${reset}${yellow}"
cc="${reset}${cyan}"
bc="${reset}${blue}"
wc="${reset}${white}"
rc="${reset}${red}"
gc="${reset}${green}"
tun="${reset}${ul_link}"

## OUTPUT
printf "
              ${yc}${user}${reset}@${yc}${host}
${rc}     ,---._   ${cc}OS:        ${reset}${os}
${rc}   /\`  __  \\  ${cc}KERNEL:    ${reset}${kernel}
${rc}  |   /    |  ${cc}DOCKER:    ${yc}${docker}
${rc}  |   ${wc}\`.__.\`  ${cc}SHELL:     ${reset}${shell}
${rc}   \          ${cc}ADDRESS:   ${reset}${address}
${rc}    \`-,_      ${cc}TUNNEL:    ${tun}${tunnel}${reset}

${rc}> ${wc}Use ${yc}'tunnel'${wc} to display the current tunnel URL.
${rc}> ${wc}Use ${yc}'tunnel <PORT>'${wc} to generate a new tunnel to another port.

" > /etc/motd