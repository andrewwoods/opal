"--[[
"	Date Formats
"	============
"--]]

:iab <expr> now_date strftime('%Y %b %d %a')
:iab <expr> now_time strftime('%H:%M')
:iab <expr> now_unix strftime('%s')

:iab <expr> iso_date strftime('%Y-%m-%d')
:iab <expr> iso_datetime strftime('%Y-%m-%dT%H:%M%z')
:iab <expr> iso_timestamp strftime('%Y-%m-%dT%H:%M:%S%z')

:iab <expr> opal_date strftime('%Y %b %d %a')
:iab <expr> opal_datetime strftime('%Y %b %d %a %H:%M')
:iab <expr> opal_timestamp strftime('%Y %b %d %a %H:%M:%S%z')

:iab <expr> world_date strftime('%d/%m/%Y')
:iab <expr> world_datetime strftime('%d/%m/%Y %H:%M')
:iab <expr> world_timestamp strftime('%d/%m/%Y %H:%M:%S%z')

:iab <expr> us_date strftime('%m/%d/%Y')
:iab <expr> us_datetime strftime('%m/%d/%Y %l:%M%p')
:iab <expr> us_timestamp strftime('%m/%d/%Y %l:%M:%S%p %z')

:iab <expr> cmos_date strftime('%e %B %Y')
:iab <expr> cmos_datetime strftime('%e %B %Y %l:%M %p')
:iab <expr> cmos_timestamp strftime('%e %B %Y %l:%M:%S %p (%Z)')

:iab <expr> filename_date strftime('%Y-%m-%d')
:iab <expr> filename_datetime strftime('%Y-%m-%d-%H-%M')
:iab <expr> filename_timestamp strftime('%Y-%m-%d-%H-%M-%S')

