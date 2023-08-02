############################################################
#
#  Clocks
#
############################################################

#
# @see http://www.timeanddate.com/time/map/
# @see /usr/share/zoneinfo
#
# Show the time in different timezones
#
alias utc="TZ=UTC date '+%c -- Universal Time'"
alias gmt="TZ=GMT date '+%c -- Greenwich Mean Time'"

#
# North America
#
alias eastern="TZ=US/Eastern date '+%c -- US Eastern'"
alias central="TZ=US/Central date '+%c -- US Central'"
alias mountain="TZ=US/Mountain date '+%c -- US Mountain'"
alias arizona="TZ=US/Arizona date '+%c -- US Arizona'"
alias pacific="TZ=US/Pacific date '+%c -- US Pacific'"
alias toronto="TZ=America/Toronto date '+%c -- Canada, Toronto'"
alias vancouver="TZ=America/Vancouver date '+%c -- Canada, Vancouver'"
alias winnipeg="TZ=America/Winnipeg date '+%c -- Canada, Winnipeg'"
alias mexico_city="TZ=America/Mexico_City date '+%c -- Mexico, Mexico City'"

alias us_clocks="eastern; central; mountain; arizona; pacific"
alias na_clocks="eastern; central; mountain; arizona; pacific; _n; toronto; mexico_city; winnipeg; vancouver
"

#
# South America
#
alias bogota="TZ=America/Bogota date '+%c -- Bogota'"
alias santiago="TZ=America/Santiago date '+%c -- Santiago'"
alias buenos_aires="TZ=America/Argentina/Buenos_Aires date '+%c -- Buenos Aires'"
alias sao_paulo="TZ=America/Sao_Paulo date '+%c -- Sao Paulo'"

alias sa_clocks="santiago; bogota; buenos_aires; sao_paulo"

#
# Europe
#
alias paris="TZ=Europe/Paris date '+%c -- Paris'"
alias madrid="TZ=Europe/Madrid date '+%c -- Madrid'"
alias berlin="TZ=Europe/Berlin date '+%c -- Berlin'"
alias rome="TZ=Europe/Rome date '+%c -- Rome'"
alias zurich="TZ=Europe/Zurich date '+%c -- Zurich'"
alias london="TZ=Europe/London date '+%c -- London'"

alias eu_clocks="london; paris; berlin; rome; zurich; madrid"

#
# Asia
#
alias tokyo="TZ=Asia/Tokyo date '+%c -- Tokyo'"
alias hong_kong="TZ=Asia/Hong_Kong date '+%c -- Hong Kong'"
alias bangkok="TZ=Asia/Bangkok date '+%c -- Bangkok'"
alias shanghai="TZ=Asia/Shanghai date '+%c -- Shanghai'"
alias saigon="TZ=Asia/Saigon date '+%c -- Saigon'"
alias jerusalem="TZ=Asia/jerusalem date '+%c -- Jerusalem'"
alias baghdad="TZ=Asia/Baghdad date '+%c -- Baghdad'"

alias asia_clocks="hong_kong; shanghai; jerusalem; baghdad"

#
# Pacific
#
alias auckland="TZ=Pacific/Auckland date '+%c -- Auckland'"
alias tahiti="TZ=Pacific/Tahiti date '+%c -- Tahiti'"
alias guam="TZ=Pacific/Guam date '+%c -- Guam'"
alias honolulu="TZ=Pacific/Honolulu date '+%c -- Honolulu'"

alias pac_clocks="auckland; tahiti; guam; honolulu"
