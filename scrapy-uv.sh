#!/usr/bin/env bash 
qjs -e \
"$(\
	curl -s \
	https://archivos.meteochile.gob.cl/portaldmc/meteochile/js/indice_radiacion.js \
	| sed -e 's/&Aacute;/Á/g'\
	-e 's/&Eacute;/É/g'\
	-e 's/&Iacute;/Í/g'\
	-e 's/&Oacute;/Ó/g'\
	-e 's/&Uacute;/Ú/g'\
	-e 's/&aacute;/á/g'\
	-e 's/&eacute;/é/g'\
	-e 's/&iacute;/í/g'\
	-e 's/&oacute;/ó/g'\
	-e 's/&uacute;/ú/g'\
	-e 's/&ntilde;/ñ/g'\
	-e 's/&Ntilde;/Ñ/g'\
	-e 's/&amp;/\&/g'\
	-e 's/&#039;/\'"'"'/g'\

);\
print(JSON.stringify(RadiacionUVB,null,2));" | \
jq '[.[] | select(.enservicio == true) | { indice_num:(.indiceobs | split(":")[0] | tonumber ),name:.nombre}]' \
> www/data/uv.json