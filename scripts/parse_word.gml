minus = 1-2*((argument0 & $8000) == $8000);
xpn = round(argument0 & $7FFF);
//show_message(string(argument0)+" "+string(minus)+" "+string(xpn))
return (xpn*minus);
