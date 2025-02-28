
CREATE DATABASE universe;

\c universe;

CREATE TABLE galaxy (
  galaxy_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  galaxy_type VARCHAR(50) NOT NULL,
  distance_from_earth NUMERIC NOT NULL,
  description TEXT
);

CREATE TABLE star (
  star_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  age_in_millions_of_years INT NOT NULL
);

CREATE TABLE planet (
  planet_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  star_id INT REFERENCES star(star_id) NOT NULL,
  has_life BOOLEAN NOT NULL,
  mass NUMERIC NOT NULL,
  planet_type VARCHAR(50) NOT NULL
);

CREATE TABLE moon (
  moon_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  planet_id INT REFERENCES planet(planet_id) NOT NULL,
  is_spherical BOOLEAN NOT NULL,
  diameter_in_km INT NOT NULL
);

CREATE TABLE comet (
  comet_id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL,
  origin_galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
  has_tail BOOLEAN NOT NULL,
  speed_km_per_sec NUMERIC NOT NULL
);

INSERT INTO galaxy (name, galaxy_type, distance_from_earth, description) VALUES
('Milky Way', 'Spiral', 0, 'Our home galaxy'),
('Andromeda', 'Spiral', 2537000, 'Nearest spiral galaxy'),
('Triangulum', 'Spiral', 3000000, 'Part of the Local Group'),
('Whirlpool', 'Spiral', 23000000, 'Known for its prominent spiral arms'),
('Sombrero', 'Elliptical', 29000000, 'Bright central bulge'),
('Large Magellanic Cloud', 'Irregular', 163000, 'Satellite galaxy of Milky Way');

INSERT INTO star (name, galaxy_id, is_spherical, age_in_millions_of_years) VALUES
('Sun', 1, TRUE, 4600),
('Sirius', 1, TRUE, 300),
('Betelgeuse', 1, TRUE, 8000),
('Alpha Centauri', 1, TRUE, 6000),
('Vega', 1, TRUE, 455),
('Proxima Centauri', 1, TRUE, 4800);

INSERT INTO planet (name, star_id, has_life, mass, planet_type) VALUES
('Earth', 1, TRUE, 1.0, 'Terrestrial'),
('Mars', 1, FALSE, 0.107, 'Terrestrial'),
('Venus', 1, FALSE, 0.815, 'Terrestrial'),
('Jupiter', 1, FALSE, 317.8, 'Gas Giant'),
('Saturn', 1, FALSE, 95.2, 'Gas Giant'),
('Neptune', 1, FALSE, 17.1, 'Ice Giant'),
('Proxima b', 6, MAYBE, 1.27, 'Exoplanet'),
('Kepler-442b', 2, UNKNOWN, 2.34, 'Exoplanet'),
('Kepler-22b', 2, UNKNOWN, 5.36, 'Exoplanet'),
('TRAPPIST-1e', 3, MAYBE, 0.69, 'Exoplanet'),
('TRAPPIST-1f', 3, MAYBE, 0.68, 'Exoplanet'),
('Gliese 581g', 4, MAYBE, 3.1, 'Super-Earth');

INSERT INTO moon (name, planet_id, is_spherical, diameter_in_km) VALUES
('Moon', 1, TRUE, 3474),
('Phobos', 2, FALSE, 22),
('Deimos', 2, FALSE, 12),
('Io', 4, TRUE, 3660),
('Europa', 4, TRUE, 3121),
('Ganymede', 4, TRUE, 5262),
('Callisto', 4, TRUE, 4821),
('Titan', 5, TRUE, 5150),
('Enceladus', 5, TRUE, 504),
('Mimas', 5, TRUE, 396),
('Triton', 6, TRUE, 2706),
('Charon', 7, TRUE, 1212),
('Kepler Moon 1', 8, FALSE, 500),
('Kepler Moon 2', 8, FALSE, 300),
('TRAPPIST-1e Moon', 10, FALSE, 250),
('TRAPPIST-1f Moon', 11, FALSE, 200),
('Gliese Moon 1', 12, FALSE, 700),
('Gliese Moon 2', 12, FALSE, 600),
('Gliese Moon 3', 12, FALSE, 500),
('Gliese Moon 4', 12, FALSE, 450);

INSERT INTO comet (name, origin_galaxy_id, has_tail, speed_km_per_sec) VALUES
('Halley', 1, TRUE, 70.6),
('Hale-Bopp', 1, TRUE, 52.5),
('Shoemaker-Levy 9', 1, TRUE, 60.3);
