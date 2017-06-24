---------------------------------------------------------------
--	create tables
---------------------------------------------------------------
CREATE TABLE attributes
(
  attributeid integer NOT NULL,
  attributename character varying(100),
  description character varying(1000),
  defaultvalue integer,
  displayname character varying(150),
  unitid integer,
  stackable integer,
  highisgood integer,
  categorid integer,
  patch character varying(32) NOT NULL,
  patchversion character varying(32) NOT NULL,
  patchbuild character varying(32),
  -- CONSTRAINT "primaryKeyAttributes" PRIMARY KEY (attributeid, patch, patchversion)
);

CREATE TABLE invmarketgroups
(
  marketgroupid integer NOT NULL,
  parentgroupid integer,
  marketgroupname character varying(100) DEFAULT NULL::character varying,
  description character varying(3000) DEFAULT NULL::character varying,
  iconid integer,
  hastypes integer,
  -- CONSTRAINT invmarketgroups_pkey PRIMARY KEY (marketgroupid)
);

CREATE TABLE items
(
  typeid integer NOT NULL,
  stationid bigint NOT NULL,
  "time" date NOT NULL,
  sales_units double precision,
  avgprice double precision,
  minprice double precision,
  maxprice double precision,
  orders integer,
  -- CONSTRAINT items_pkey PRIMARY KEY (typeid, stationid, "time")
);

CREATE TABLE mapconstellations
(
  regionid integer,
  constellationid integer NOT NULL,
  constellationname character varying(100) DEFAULT NULL::character varying,
  x double precision,
  y double precision,
  z double precision,
  x_min double precision,
  x_max double precision,
  y_min double precision,
  y_max double precision,
  z_min double precision,
  z_max double precision,
  factionid integer,
  radius double precision,
  -- CONSTRAINT "mapConstellations_pkey" PRIMARY KEY (constellationid)
);

CREATE TABLE mapsolarsystems
(
  regionid integer,
  constellationid integer,
  solarsystemid integer NOT NULL,
  solarsystemname character varying(100) DEFAULT NULL::character varying,
  x double precision,
  y double precision,
  z double precision,
  x_min double precision,
  x_max double precision,
  y_min double precision,
  y_max double precision,
  z_min double precision,
  z_max double precision,
  luminosity double precision,
  border smallint,
  fringe smallint,
  corridor smallint,
  hub smallint,
  international smallint,
  regional smallint,
  constellation smallint,
  security double precision,
  factionid integer,
  radius double precision,
  suntypeid integer,
  securityclass character varying(2) DEFAULT NULL::character varying,
  -- CONSTRAINT "mapSolarSystems_pkey" PRIMARY KEY (solarsystemid)
);

CREATE TABLE patches
(
  patch character varying(32) NOT NULL,
  patchversion character varying(32) NOT NULL,
  patchbuild character varying(32),
  fromdate date,
  todate date,
  -- CONSTRAINT "patches_pkey" PRIMARY KEY (patch, patchversion)
);

CREATE TABLE regions
(
  regionid integer NOT NULL,
  regionname character varying(100) DEFAULT NULL::character varying,
  x double precision,
  y double precision,
  z double precision,
  x_min double precision,
  x_max double precision,
  y_min double precision,
  y_max double precision,
  z_min double precision,
  z_max double precision,
  factionid integer,
  radius double precision,
  -- CONSTRAINT "regions_pkey" PRIMARY KEY (regionid)
);

CREATE TABLE stastations
(
  stationid integer NOT NULL,
  security integer,
  dockingcostpervolume double precision,
  maxshipvolumedockable double precision,
  officerentalcost integer,
  operationid integer,
  stationtypeid integer,
  corporationid integer,
  solarsystemid integer,
  constellationid integer,
  regionid integer,
  stationname character varying(100) DEFAULT NULL::character varying,
  x double precision,
  y double precision,
  z double precision,
  reprocessingefficiency double precision,
  reprocessingstationstake double precision,
  reprocessinghangarflag integer,
  -- CONSTRAINT "staStations_pkey" PRIMARY KEY (stationid)
);

CREATE TABLE supply_and_demand
(
  typeid integer NOT NULL,
  stationid bigint NOT NULL,
  "time" date NOT NULL,
  supply bigint,
  supp_bids bigint,
  supp_avg_p double precision,
  supp_min_p real,
  supp_max_p real,
  demand bigint,
  dem_bids bigint,
  dem_avg_p double precision,
  dem_min_p real,
  dem_max_p real,
  -- CONSTRAINT sad_pkey PRIMARY KEY (typeid, stationid, "time")
);

CREATE TABLE types
(
  typeid integer NOT NULL,
  typename character varying(100),
  description text,
  mass double precision,
  volume double precision,
  capacity double precision,
  raceid integer,
  baseprice numeric(19,4),
  marketgroupid integer,
  patch character varying(32) NOT NULL,
  patchversion character varying(32) NOT NULL,
  patchbuild character varying(32),
  -- CONSTRAINT "primaryKeyTypes" PRIMARY KEY (typeid, patch, patchversion)
);

CREATE TABLE typesattributes
(
  typeid integer NOT NULL,
  attributeid integer NOT NULL,
  valueint integer,
  valuefloat double precision,
  patch character varying(32) NOT NULL,
  patchversion character varying(32) NOT NULL,
  patchbuild character varying(32),
  -- CONSTRAINT "typeAttributeFacts" PRIMARY KEY (typeid, attributeid, patch, patchversion),
  -- CONSTRAINT "foreignKeyAttributes" FOREIGN KEY (attributeid, patch, patchversion)
  --     REFERENCES attributes (attributeid, patch, patchversion) MATCH SIMPLE
  --     ON UPDATE NO ACTION ON DELETE NO ACTION,
  -- CONSTRAINT "foreignKeyTypes" FOREIGN KEY (typeid, patch, patchversion)
  --     REFERENCES types (typeid, patch, patchversion) MATCH SIMPLE
  --     ON UPDATE NO ACTION ON DELETE NO ACTION
);

---------------------------------------------------------------
--	create price index views
---------------------------------------------------------------
create view CPI as
select time, sum(avgprice) price
from items i
where i.typeid in (
--ammunition
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=11
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--consumer products
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=492
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--drones
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=157
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--implants
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=27
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--skills
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=150
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--ships
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=4
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	--tech I ships
	(select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t, 
	(select typeid from typesattributes where attributeid=633 AND (valuefloat<5 or valueint<5) group by typeid) ta --attributeid 633 is metaLevel
	where t.marketgroupid=p.marketgroupid AND t.typeid=ta.typeid)
	UNION
	--tech II ships
	(select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t, 
	(select typeid from typesattributes where attributeid=633 AND (valuefloat=5 or valueint=5) group by typeid) ta --attributeid 633 is metaLevel
	where t.marketgroupid=p.marketgroupid AND t.typeid=ta.typeid))
UNION
--modules
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=9
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	--tech I modules
	(select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t, 
	(select typeid from typesattributes where attributeid=633 AND (valuefloat<5 or valueint<5) group by typeid) ta --attributeid 633 is metaLevel
	where t.marketgroupid=p.marketgroupid AND t.typeid=ta.typeid)
	UNION
	--tech II modules
	(select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t, 
	(select typeid from typesattributes where attributeid=633 AND (valuefloat=5 or valueint=5) group by typeid) ta --attributeid 633 is metaLevel
	where t.marketgroupid=p.marketgroupid AND t.typeid=ta.typeid))
)
group by time
order by time;


create view MPI as
select time, sum(avgprice) price
from items i
where i.typeid in (
--ore
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=54
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--minerals
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1857
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
)
group by time
order by time;


create view PPPI as
select time, sum(avgprice) price
from items i
where i.typeid in (
--ore
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=54
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Processed Planetary Materials
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1334
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Refined Planetary Materials
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1335
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Specialized Planetary Materials
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1336
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Raw Moon Materials
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=501
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Processed Moon Materials
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=500
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
)
group by time
order by time;


create view SPPI as
select time, sum(avgprice) price
from items i
where i.typeid in (
--blueprints
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=2
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Advanced Capital Components
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1883
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
-- Standard Capital Components
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=781
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--R.A.M.
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1908
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Advanced Components
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1591
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
UNION
--Rigs
	(WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
		select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1111
	UNION
		SELECT im.marketgroupid, im.marketgroupname, im.parentgroupid, ph.test+1
		FROM product_hierarchy ph,invmarketgroups im
		WHERE ph.marketgroupid = im.parentgroupid
	)
	select distinct(t.typeid)
	from product_hierarchy p, 
	(select typeid, typename, marketgroupid from types group by typeid, typename, marketgroupid) t
	where t.marketgroupid=p.marketgroupid)
)
group by time
order by time;
