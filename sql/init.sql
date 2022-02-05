CREATE OR REPLACE FUNCTION generate_random_point()
    RETURNS GEOMETRY AS
$func$
DECLARE
    x_min FLOAT := 13.091992716067702;
    x_max FLOAT := 13.742786470433;
    y_min FLOAT := 52.33488609760638;
    y_max FLOAT := 52.67626223889507;
    srid INTEGER := 4326;
BEGIN
    RETURN (
        ST_SetSRID(
            ST_MakePoint(
                random()*(x_max - x_min) + x_min,
                random()*(y_max - y_min) + y_min
            ),
            srid
        )
    );
END;
$func$
LANGUAGE 'plpgsql' VOLATILE;

CREATE OR REPLACE FUNCTION generate_random_points()
    RETURNS VOID AS
$func$
DECLARE
    -- Change this as needed to suit your test dataset size requirements.
    num_records INTEGER := 10000;
BEGIN
    SET seed TO 0.5;
    DROP TABLE IF EXISTS temp_postgis_points_random;
    CREATE TABLE temp_postgis_points_random (geom)
    AS SELECT generate_random_point();

    FOR idx IN 1 .. num_records - 1 LOOP
        INSERT INTO temp_postgis_points_random SELECT generate_random_point();
    END LOOP;

    DROP TABLE IF EXISTS points;
    CREATE TABLE points (
        gid SERIAL PRIMARY KEY,
        geom GEOMETRY
    );
    INSERT INTO points (geom)
    SELECT geom FROM temp_postgis_points_random;
    DROP TABLE temp_postgis_points_random;
END;
$func$
LANGUAGE 'plpgsql' VOLATILE;

SELECT generate_random_points();
