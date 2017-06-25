import psycopg2
import pandas as pd
import numpy as np
from tqdm import tqdm
from sql_commands import ships_sql, materials_sql, missile_launchers_sql

conn = psycopg2.connect('dbname=eveonline user=nexus')
cur = conn.cursor()

dfs = {}

cmds = {
        'ships': ships_sql,
        'materials': materials_sql,
        'missile_launchers': missile_launchers_sql
    }


def fix_datetime(series):
    return list(map(lambda v: pd.to_datetime(str(v).split(' ')[0]), series.values))


for k in tqdm(cmds.keys()):
    cur.execute(cmds[k])
    data = cur.fetchall()

    if k == 'ships':
        df = pd.DataFrame(data,
                          columns=['month', 'total', 'shuttles', 'frigates', 'cruisers',
                                   'destroyers', 'battlecruisers', 'battleships',
                                   'capital', 'industrial', 'mining', 'special_edition',
                                   'rookie'])

    elif k == 'missile_launchers':
        df = pd.DataFrame(data,
                          columns=['month', 'total', 'rocket', 'light', 'rapid',
                                   'heavy', 'cruise', 'torpedo', 'xl', 'heavy_assault',
                                   'rapid_heavy', 'rapid_torpedo'])

    else:
        df = pd.DataFrame(data,
                          columns=['month', 'total', 'raw', 'gas_clouds', 'ice',
                                   'reaction', 'planetary', 'mineral', 'salvage',
                                   'fraction'])

    dfs[k] = df
    df.index = pd.DatetimeIndex(fix_datetime(df['month']))

print('data is read')


def softmax(x):
    """Compute softmax values for each sets of scores in x."""
    e_x = np.exp(x - np.max(x))
    return e_x / e_x.sum()


for k in tqdm(dfs.keys()):
    df = dfs[k].fillna(0)

    with open('../output/aufgabe_3_softmaxed_{0}.csv'.format(k)) as f:
        f.write(','.join(df.columns.values))

        for i, row in df.iterrows():
            x = row.drop('month').values
            # normalized by the biggest value as they are way too big
            # and result in bogus softmax values
            sx = softmax(x / max(x))
            f.write(','.join(list(map(str, sx))))

