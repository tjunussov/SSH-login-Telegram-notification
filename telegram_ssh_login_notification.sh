#!/bin/sh
telegrambot="947358966:HAAFFcoa7YkxTpXyrS08So4IwxhU9geiISIk"
telegramchatid="-376658291"

url="https://api.telegram.org/bot"$telegrambot"/sendMessage"

date="$(date "+%F %T")"

if [ -n "$SSH_CLIENT" ] ; then
	ip_address=$(echo $SSH_CLIENT | awk '{print $1}')
	
	reverse_dns=`dig -x $ip_address +short`
	
	if [ -z "$reverse_dns" ] ; then
		reverse_dns=$ip_address
	fi

	message="New remote SSH connection : "$USER"@"$(hostname)" from ["$reverse_dns"](http://whatismyipaddress.com/ip/"$ip_address"#General-IP-Information)
"$date

	curl -s -d "chat_id="$telegramchatid"&text=$message&parse_mode=markdown&disable_web_page_preview=1" $url > /dev/null 2>&1
fi
