#
# Developer related functions
#
################################################################################



#
# check_site - determine if a website is available yet. keep checking until it is
#
# @param String $url the address of the website you want to check
# @param Integer $interval the number of seconds to wait
#
function check_site()
{
	declare -i i=0

	if [ -z "$2" ]
	then
		# set the default interval, in seconds
		interval=10
	else
		interval=$2
	fi

	while ! curl -m 5 $1 2>/dev/null;
	do
		sleep $interval;
		ans=$(( i % 30 ))
		if [ $ans == 0 ]; then
			ts=$( date )
			echo "Still down at $ts "
		fi
		i=$(( i +  1  ))
		echo -n ".";
	done;

	say_done 'OK! The site is up now!' ;
}


#
# htstatus - lookup the http status code by number to refresh your memory
#
# @param Integer $code the numeric status code. e.g. 200
#
# Examples:
#
# $ htstatus 200
#
# $ htstatus 416
#
function htstatus()
{
	grep -A 1 ^$1 $OPAL_DIR/data/http-status-codes.txt
	echo " "
	echo "see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information"
}



#
# parse_git_branch - get the current git branch your on
#
function parse_git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}



#
# sha1 - Create a SHA1 digest of a file
#
# @param String $filename the filename for which you want to know/generate it's sha1
#
function sha1()
{
	if [[ -n $(which openssl) ]]; then
		openssl sha1 $@
	else
		echo "openssl is required, but not installed"
	fi
}




#
# traceurl - decode/unfurl a short url recursively to it's final destination
#
# @param String $url the address of the website you want to check
#
function traceurl()
{
	if [[ -n $1 ]]
	then
		curl --location --head $1
	else
		echo 'Whoops! You forgot to specify a short URL'
	fi
}


