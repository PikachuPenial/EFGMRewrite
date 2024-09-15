
sql = sql or {}

sql.Cached = {}

function sql:CacheQuery( query )

    table.insert( sql.Cached, query )

end

function sql:RunCachedQueries( query, type )

    -- take all the stored query strings and run them somehow, idk man i forgot how sql works and ive got an essay due like holy fucking shit 18 days

end