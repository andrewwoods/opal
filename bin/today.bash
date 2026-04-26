#!/usr/bin/env bash
#  _____         _
# |_   _|__   __| | __ _ _   _
#   | |/ _ \ / _` |/ _` | | | |
#   | | (_) | (_| | (_| | |_| |
#   |_|\___/ \__,_|\__,_|\__, |
#                        |___/
# Display the various formats to display the current moment.
#
source ~/opal/opal.bash

#
# NOTE: the date formats were designed on MacOS.
#
echo ''
echo 'unix='$(opal:today unix)
echo 'opal-date='$(opal:today opal-date)
echo 'opal-datetime='$(opal:today opal-datetime)
echo 'opal-timestamp='$(opal:today opal-timestamp)
echo 'iso-date='$(opal:today iso-date)
echo 'iso-datetime='$(opal:today iso-datetime)
echo 'iso-timestamp='$(opal:today iso-timestamp)
echo 'world-date='$(opal:today world-date)
echo 'world-datetime='$(opal:today world-datetime)
echo 'world-timestamp='$(opal:today world-timestamp)
echo 'us-date='$(opal:today us-date)
echo 'us-datetime='$(opal:today us-datetime)
echo 'us-timestamp='$(opal:today us-timestamp)
echo 'usa-date='$(opal:today usa-date)
echo 'usa-datetime='$(opal:today usa-datetime)
echo 'usa-timestamp='$(opal:today usa-timestamp)
echo 'filename-date='$(opal:today filename-date)
echo 'filename-datetime='$(opal:today filename-datetime)
echo 'filename-timestamp='$(opal:today filename-timestamp)


#
# ====< Example Output >====
#

# unix=1753726837
# opal-date=2025 Jul 28 Mon
# opal-datetime=2025 Jul 28 Mon 14:20
# opal-timestamp=2025 Jul 28 Mon 14:20:37-0400
# iso-date=2025-07-28
# iso-datetime=2025-07-28T14:20-0400
# iso-timestamp=2025-07-28T14:20:37-0400
# world-date=28/07/2025
# world-datetime=28/07/2025 14:20
# world-timestamp=28/07/2025 14:20:37-0400
# national-timestamp=Mon Jul 28 14:20:37 2025
# us-date=07/28/2025
# us-datetime=07/28/2025 2:20PM
# us-timestamp=07/28/2025 2:20:37PM -0400
# cmos-date=28 July 2025
# cmos-datetime=28 July 2025 2:20 PM
# cmos-timestamp=28 July 2025 2:20:37 PM (EDT)
# filename-date=2025-07-28
# filename-datetime=2025-07-28-14-20
# filename-timestamp=2025-07-28-14-20-37

