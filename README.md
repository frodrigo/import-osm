# Import OSM into PostGIS using imposm3
[![Docker Automated build](https://img.shields.io/docker/automated/sophox/import-osm.svg)](https://hub.docker.com/r/sophox/import-osm/) [![](https://images.microbadger.com/badges/image/sophox/import-osm.svg)](https://microbadger.com/images/sophox/import-osm "Get your own image badge on microbadger.com")

**Note**
This is an updated version of the unmaintained [openmaptiles/import-osm](https://github.com/openmaptiles/import-osm).
We will try to merge pull requests much quicker, and will continue pushing openmaptiles to merge contributions.


This Docker image will import an OSM PBF file using [imposm3](https://github.com/omniscale/imposm3) and
a [custom mapping configuration](https://imposm.org/docs/imposm3/latest/mapping.html).

## Usage

### Download PBF File

Use [Geofabrik](http://download.geofabrik.de/index.html) and choose the extract
of your country or region. Download it and put it into the directory.

### Import

The **import-osm** Docker container will take the first PBF file in the volume mounted to the `/import` folder and import it using imposm3 using the mapping file from the `$MAPPING_YAML` (default `/mapping/mapping.yaml`).

Volumes:
 - Mount your PBFs into the `/import` folder
 - Mount your `mapping.yaml` into the `/mapping` folder
 - If you want to use diff mode mount a persistent location to the `/cache` folder for later reuse

```bash
docker run --rm \
    -v $(pwd):/import \
    -v $(pwd):/mapping \
    -e PGUSER="osm" \
    -e PGPASSWORD="osm" \
    -e PGHOST="127.0.0.1" \
    -e PGDATABASE="osm" \
    openmaptiles/import-osm
```

Use standard Postgres [environment variables](https://www.postgresql.org/docs/current/libpq-envars.html) to connect,
such as `PGHOST`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`, `PGPORT`.  All are required except for `PGPORT`.

For backward compatibility the script also supports `POSTGRES_HOST`, `POSTGRES_DB`, `POSTGRES_USER`,
`POSTGRES_PASSWORD`, and `POSTGRES_PORT`, but they are not recommended.
