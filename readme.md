# tegola-cluster-points

Example on how to cluster point data on different zoom levels.

## Idea

Following a discussion on tegola issue [#753](https://github.com/go-spatial/tegola/issues/753)

> Say you have a bunch of points in your provider. You create two layers.
> First layer uses the center point of a cluster as geometry field.
> Second layer uses the default geometry field of your points.
> Then building your map, you use the first layer with the center points of the clusters from zoom level x to y and the second layer from y to z.

## Usage

```
docker compose up
```

Generate 10.000 random points in a definied bounding box (here, Berlin).
See `sql/init.sql`.

```
PGPASSWORD=password psql \
    -u user \
    -h localhost \
    -p 5433 \
    -d points \
    -a \
    -f /sql/init.sql \
```

Open the tegola viewer at `http://localhost/8080` and see the result.

## Gotcha

The example clusters points in a proximity of 0.001 degree to each other. This is appoximately 111m, depending on where you are at in the world. For better results use another CRS and change the `eps` distance value of the provider sql to your liking.

## License

MIT

## Maintainer

Benjamin Ramser - [@iwpnd](https://github.com/iwpnd). 
Project Link: [https://github.com/iwpnd/tegola-cluster-points](https://github.com/iwpnd/tegola-cluster-points)

## Acknowledgements

Ying Wang - [Generating random test data in PostGIS](https://bytes.yingw787.com/posts/2019/01/10/generating_randomized_postgis_data/)

Tegola - [tegola.io](https://tegola.io/)
