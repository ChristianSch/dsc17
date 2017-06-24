pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/attributes.csv' \
    | psql -d eveonline -c "COPY attributes FROM STDIN WITH (FORMAT CSV, delimiter ';');"
echo "attributes done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/invmarketgroups.csv' \
    | psql -d eveonline -c "COPY invmarketgroups FROM STDIN WITH (FORMAT CSV, delimiter ';');"
echo "invmarketgroups done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/items.csv' \
    | psql -d eveonline -c "COPY items FROM STDIN WITH (FORMAT CSV, delimiter
';');"
echo "items done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/mapconstellations.csv' \
    | psql -d eveonline -c "COPY mapconstellations FROM STDIN WITH (FORMAT CSV,
delimiter ';');"
echo "mapconstellations done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/mapsolarsystems.csv' \
    | psql -d eveonline -c "COPY mapsolarsystems FROM STDIN WITH (FORMAT CSV,
delimiter ';');"
echo "mapsolarsystems done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/patches.csv' \
    | psql -d eveonline -c "COPY patches FROM STDIN WITH (FORMAT CSV, delimiter
';');"
echo "patches done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/regions.csv' \
    | psql -d eveonline -c "COPY regions FROM STDIN WITH (FORMAT CSV, delimiter
';');"
echo "regions done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/stastations.csv' \
    | psql -d eveonline -c "COPY stastations FROM STDIN WITH (FORMAT CSV,
delimiter ';');"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/supply_and_demand.csv' \
    | psql -d eveonline -c "COPY supply_and_demand FROM STDIN WITH (FORMAT
CSV, delimiter ';');"
echo "supply_and_demand done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/types.csv' \
    | psql -d eveonline -c "COPY types FROM STDIN WITH (FORMAT CSV, delimiter ';');"
echo "types done"

pv '/Volumes/MediaSlave/BVM-DatScienceCup/Data/typesattributes.csv' \
    | psql -d eveonline -c "COPY typesattributes FROM STDIN WITH (FORMAT CSV, delimiter ';');"
echo "typesattribute done"
