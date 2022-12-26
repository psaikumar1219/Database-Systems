-- Table creation
CREATE TABLE geometrics(name varchar, geom geometry);

-- Inserting coordinates data
INSERT INTO geometrics VALUES
('USC Gateway','POINT(-118.2842718 34.0253252)'),
('At-T Gateway','POINT(-118.29177634 34.0222763)'),
('Museum Entrance','POINT(-118.2887445 34.017587)'),
('Black Fountain','POINT(-118.2835631 34.0223087)'),
('Doheny Fountain','POINT(-118.2844524 34.020494)'),
('Viterbi Fountain','POINT(-118.2889796 34.0204612)'),
('Leavey Library','POINT(-118.2827704 34.0213601)'),
('Donheny Library','POINT(-118.2845113 34.0203903)'),
('Topping Library','POINT(-118.2877003 34.0194272)'),
('Starbucks','POINT(-118.2825904 34.021899)'),
('Panda Express','POINT(-118.2864075 34.0202746)'),
('Taco bell','POINT(-118.2918626 34.02250031)');

SELECT name,ST_AsText(geom) FROM geometrics;

-- Script to compute convex hull coordinates
SELECT ST_AsText(ST_ConvexHull(
ST_Collect(
ST_GeomFromText('MULTIPOINT(
-118.2842718 34.0253252,
-118.29177634 34.0222763,
-118.2887445 34.017587,
-118.2835631 34.0223087,
-118.2844524 34.020494,
-118.2889796 34.0204612,
-118.2827704 34.0213601,
-118.2845113 34.0203903,
-118.2877003 34.0194272,
-118.2825904 34.021899,
-118.2864075 34.0202746,
-118.2918626 34.02250031
)
')
)));

-- Script to compute 4 nearest neighbours
SELECT name, ST_AsText(geom)
FROM geometrics
ORDER BY geom <-> st_setsrid(st_makepoint(-118.2799699,34.0282653),0)
LIMIT 4;