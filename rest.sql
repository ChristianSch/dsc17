ALTER TABLE mapconstellations
	ADD CONSTRAINT "mapConstellations_pkey" PRIMARY KEY (constellationid);
ALTER TABLE mapsolarsystems
	ADD CONSTRAINT "mapSolarSystems_pkey" PRIMARY KEY (solarsystemid);
ALTER TABLE patches
	ADD CONSTRAINT "patches_pkey" PRIMARY KEY (patch, patchversion);
ALTER TABLE regions
	ADD CONSTRAINT "regions_pkey" PRIMARY KEY (regionid);
ALTER TABLE stastations
	ADD CONSTRAINT "staStations_pkey" PRIMARY KEY (stationid);
ALTER TABLE supply_and_demand
	ADD CONSTRAINT sad_pkey PRIMARY KEY (typeid, stationid, "time");
ALTER TABLE types
	ADD CONSTRAINT "primaryKeyTypes" PRIMARY KEY (typeid, patch, patchversion);
ALTER TABLE typesattributes
	ADD CONSTRAINT "typeAttributeFacts" PRIMARY KEY (typeid, attributeid, patch, patchversion);
ALTER TABLE typesattributes
	ADD CONSTRAINT "foreignKeyAttributes" FOREIGN KEY (attributeid, patch, patchversion)
    	REFERENCES attributes (attributeid, patch, patchversion) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE typesattributes
	ADD CONSTRAINT "foreignKeyTypes" FOREIGN KEY (typeid, patch, patchversion)
		REFERENCES types (typeid, patch, patchversion) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION;
        
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