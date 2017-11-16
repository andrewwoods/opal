
BEGIN { 
	country = toupper(country);
	printf "Looking up %s ...\n", country; 
} 

/\t/ {  # Only the data has tabs in it.
	gsub(/ *$/,"", $2);
	gsub(/ *$/,"", $3);
	if ( country == $2 || country == $3 ){
		gsub(/ *$/,"", $1);
		print $1;  
	}
}


