# https://gis.stackexchange.com/questions/32418/python-script-to-convert-lat-long-to-itm-irish-transverse-mercator

Here is a sample code for reprojecting WGS-84 long/lat to ITM (EPSG:2157) x,y:

<pre><code>
from pyproj import Proj, transform


def reproject_wgs_to_itm(longitude, latitude):
    prj_wgs = Proj(init='epsg:4326')
    prj_itm = Proj(init='epsg:2157')
    x, y = transform(prj_wgs, prj_itm, longitude, latitude)
    return x, y


print( reproject_wgs_to_itm(-7.748108, 53.431628) )
</code></pre>
