---------------------------------------------------------------
--	create tables
---------------------------------------------------------------
COPY attributes FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/attributes.csv' WITH (FORMAT CSV, delimiter ';');

COPY invmarketgroups FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/invmarketgroups.csv' WITH (FORMAT CSV, delimiter ';');

COPY items FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/items.csv' WITH (FORMAT CSV, delimiter ';');

COPY mapconstellations FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/mapconstellations.csv' WITH (FORMAT CSV, delimiter ';');

COPY mapsolarsystems FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/mapsolarsystems.csv' WITH (FORMAT CSV, delimiter ';');

COPY patches FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/patches.csv' WITH (FORMAT CSV, delimiter ';');

COPY regions FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/regions.csv' WITH (FORMAT CSV, delimiter ';');

COPY stastations FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/stastations.csv' WITH (FORMAT CSV, delimiter ';');

COPY supply_and_demand FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/supply_and_demand.csv' WITH (FORMAT CSV, delimiter ';');

COPY types FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/types.csv' WITH (FORMAT CSV, delimiter ';');

COPY typesattributes FROM '/Volumes/MediaSlave/BVM-DatScienceCup/Data/typesattributes.csv' WITH (FORMAT CSV, delimiter ';');