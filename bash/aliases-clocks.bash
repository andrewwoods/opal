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
alias utc="TZ=UTC date '+%+ -- Universal Time'"
alias gmt="TZ=GMT date '+%+ -- Greenwich Mean Time'"


#
# North America
#
alias eastern="TZ=US/Eastern date '+%+ -- US Eastern'"
alias central="TZ=US/Central date '+%+ -- US Central'"
alias mountain="TZ=US/Mountain date '+%+ -- US Mountain'"
alias arizona="TZ=US/Arizona date '+%+ -- US Arizona'"
alias pacific="TZ=US/Pacific date '+%+ -- US Pacific'"
alias toronto="TZ=America/Toronto date '+%+ -- Canada, Toronto'"
alias vancouver="TZ=America/Vancouver date '+%+ -- Canada, Vancouver'"
alias winnipeg="TZ=America/Winnipeg date '+%+ -- Canada, Winnipeg'"
alias mexico_city="TZ=America/Mexico_City date '+%+ -- Mexico, Mexico City'"

alias us_clocks="eastern; central; mountain; arizona; pacific"
alias na_clocks="eastern; central; mountain; arizona; pacific; toronto; winnipeg; vancouver; mexico_city"

#
# South America
#
alias bogota="TZ=America/Bogota date '+%+ -- Bogota'"
alias santiago="TZ=America/Santiago date '+%+ -- Santiago'"
alias buenos_aires="TZ=America/Argentina/Buenos_Aires date '+%+ -- Buenos Aires'"
alias sao_paulo="TZ=America/Sao_Paulo date '+%+ -- Sao Paulo'"

alias sa_clocks="santiago; bogota; buenos_aires; sao_paulo"

#
# Europe
#
alias paris="TZ=Europe/Paris date '+%+ -- Paris'"
alias madrid="TZ=Europe/Madrid date '+%+ -- Madrid'"
alias berlin="TZ=Europe/Berlin date '+%+ -- Berlin'"
alias rome="TZ=Europe/Rome date '+%+ -- Rome'"
alias zurich="TZ=Europe/Zurich date '+%+ -- Zurich'"
alias london="TZ=Europe/London date '+%+ -- London'"

alias eu_clocks="london; paris; berlin; rome; zurich; madrid"

#
# Asia
#
alias tokyo="TZ=Asia/Tokyo date '+%+ -- Tokyo'"
alias hong_kong="TZ=Asia/Hong_Kong date '+%+ -- Hong Kong'"
alias bangkok="TZ=Asia/Bangkok date '+%+ -- Bangkok'"
alias shanghai="TZ=Asia/Shanghai date '+%+ -- Shanghai'"
alias saigon="TZ=Asia/Saigon date '+%+ -- Saigon'"
alias jerusalem="TZ=Asia/jerusalem date '+%+ -- Jerusalem'"
alias baghdad="TZ=Asia/Baghdad date '+%+ -- Baghdad'"

alias asia_clocks="hong_kong; shanghai; jerusalem; baghdad"

#
# Pacific
#
alias auckland="TZ=Pacific/Auckland date '+%+ -- Auckland'"
alias tahiti="TZ=Pacific/Tahiti date '+%+ -- Tahiti'"
alias guam="TZ=Pacific/Guam date '+%+ -- Guam'"

alias pac_clocks="auckland; tahiti; guam"

