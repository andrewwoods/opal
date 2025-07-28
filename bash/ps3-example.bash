#!/bin/bash

#
# This is a test script for when you want to experiment with
# changing the value of PS3 prompt, which is used in choosing
# a value from a list.
#

set +x
select option in "Client" "Server" "Exit"; do
    case $option in
        "Exit")
            echo "Quitting"
            break
            ;;
        "Client")
            echo "Client configuring.."
            ;;
        "Server")
            echo "Server configuring.."
            ;;
        *)
            echo "Invalid"
            ;;
    esac
done
set -x

