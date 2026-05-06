################################################################################
#
#                               String Functions
#
################################################################################

##
## Convert a string to lower case.
##
## @param string $value
##
## @return string
##
function opal:str_lower {
    if opal:is_unset "$1"; then
        opal:message "Please specify a string to convert to lower case"
    fi

    echo "$1" | tr 'A-Z' 'a-z'
}

##
## Convert a string to upper case.
##
## @param string $value
##
## @return string
##
function opal:str_upper {
    if opal:is_unset "$1"; then
        opal:message "Please specify the string to make UPPER CASE"
    fi

    echo "$1" | tr 'a-z' 'A-Z'
}

##
## Remove all spaces and tabs from the start and end of the string
##
## @param string $value
##
## @return string
##
function opal:str_trim {
    local trimmed

    trimmed=$(echo "$1" | iconv -t ascii//TRANSLIT )
    # Remove leading white spaces
    trimmed="$(echo "$trimmed" | sed -E 's/^[[:blank:]]+//g')"
    # Remove trailing white spaces
    trimmed="$(echo "$trimmed" | sed -E 's/[[:blank:]]+$//g')"

    echo "$trimmed"
}

##
## Remove a string of all extraneous white space
##
## @param string $value
##
## @return string
##
function opal:str_trimmer {
    echo "$(opal:str_trim "$1")" | sed -E 's/[[:blank:]]+/ /g'
}

##
## Convert a string to a path friendly slug.
##
## @param string $value
##
## @return string
##
function opal:str_slug {
    echo "$@" | iconv -t ascii//TRANSLIT \
        | sed -E 's/[^a-zA-Z0-9-]+/-/g' \
        | sed -E 's/^-+|-+$//g' \
        | tr A-Z a-z
}

##
## Get the length of a string.
##
## @param string
##
## @return int
##
function opal:str_length {
    echo ${#1}
}

##
## Create a SHA1 digest of a file.
##
## @param String $filename
##   The file for which you want to know/generate a sha1.
##
## @return string
##
function opal:str_sha1 {
    if opal:is_set "$(which openssl)"; then
        openssl sha1 "$@"
    else
        opal:std_error "openssl is required, but not installed"
    fi
}

