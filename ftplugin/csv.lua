require('lang.csv')
-- ftplugin runs per buffer, so this enables csvview for every csv/tsv buffer
-- (the require above is module-cached and only runs setup once).
require('csvview').enable()
