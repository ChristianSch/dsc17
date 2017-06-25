ships_sql = """
select total.month as month, total.turnover as total, shuttle.turnover as shuttles, frigate.turnover as frigates, cruiser.turnover as cruisers, destroyer.turnover as destroyers, bc.turnover as battlecruisers, bs.turnover as battleships, cap.turnover as capital_ships, indy.turnover as industrial_ships, mining.turnover as mining_barges, sped.turnover as special_edition_ships, rookie.turnover as rookie_ships

from

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=4
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
group by 1
order by 1) as total left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=391
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
group by 1
order by 1) as shuttle On (total.month= shuttle.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1361
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
group by 1
order by 1) as frigate on (total.month= frigate.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1367
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
group by 1
order by 1) as cruiser  on (total.month= cruiser.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1372
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
group by 1
order by 1) as destroyer  on (total.month= destroyer.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1374
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
group by 1
order by 1) as bc on (total.month= bc.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1376
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
group by 1
order by 1) as bs on (total.month= bs.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1381
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
group by 1
order by 1) as cap on (total.month= cap.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1382
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
group by 1
order by 1) as indy on (total.month= indy.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1384
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
group by 1
order by 1) as mining on (total.month= mining.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1612
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
group by 1
order by 1) as sped on (total.month= sped.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1815
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
group by 1
order by 1) as rookie on (total.month= rookie.month)
"""

missile_launchers_sql = """
select total.month as month, total.turnover as total, rocket.turnover as rocket_launchers, light.turnover as light_missile_launchers, rlml.turnover as rapid_missile_launchers, heavy.turnover as heavy_launchers, cruise.turnover as cruise_launchers, torpedo.turnover as torpedo_launchers, xl.turnover as xl_launchers, hal.turnover as heavy_assault_launchers, rhml.turnover as rapid_heavy_missile_launchers, rapidTorp.turnover as rapid_torpedo_launchers

from

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=140
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
group by 1
order by 1) as total left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=639
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
group by 1
order by 1) as rocket On (total.month= rocket.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=640
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
group by 1
order by 1) as light on (total.month= light.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=641
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
group by 1
order by 1) as rlml on (total.month= rlml.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=642
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
group by 1
order by 1) as heavy  on (total.month= heavy.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=643
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
group by 1
order by 1) as cruise on (total.month= cruise.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=644
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
group by 1
order by 1) as torpedo on (total.month= torpedo.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=777
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
group by 1
order by 1) as xl on (total.month= xl.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=974
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
group by 1
order by 1) as hal on (total.month= hal.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1827
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
group by 1
order by 1) as rhml on (total.month= rhml.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=2247
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
group by 1
order by 1) as rapidTorp on (total.month= rapidTorp.month)
"""

materials_sql = """
select total.month as month, total.turnover as total, raw.turnover as raw_materials, gas.turnover as gas_clouds_materials, ice.turnover as ice_products, reaction.turnover as reaction_materials, planetary.turnover as planetary_materials, mineral.turnover as minerals, salvage.turnover as salvage_materials, faction.turnover as faction_materials

from

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=533
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
group by 1
order by 1) as total left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1031
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
group by 1
order by 1) as raw On (total.month= raw.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1032
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
group by 1
order by 1) as gas on (total.month= gas.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1033
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
group by 1
order by 1) as ice on (total.month= ice.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1034
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
group by 1
order by 1) as reaction  on (total.month= reaction.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1332
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
group by 1
order by 1) as planetary on (total.month= planetary.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
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
group by 1
order by 1) as mineral on (total.month= mineral.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1861
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
group by 1
order by 1) as salvage on (total.month= salvage.month)

left outer join

(select date_trunc('month', "time") as "month", sum(sales_units*avgprice) turnover
from items i
where i.typeid in (
 (WITH RECURSIVE product_hierarchy(marketgroupid, marketgroupname, parentgroupid, test) AS (
  select marketgroupid, marketgroupname, parentgroupid, 1 as test FROM invmarketgroups WHERE marketgroupid=1897
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
group by 1
order by 1) as faction on (total.month= faction.month)
"""

