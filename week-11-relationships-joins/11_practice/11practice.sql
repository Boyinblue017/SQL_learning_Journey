DROP DATABASE IF EXISTS ds120_week11_practice;
CREATE DATABASE ds120_week11_practice;
USE ds120_week11_practice;

-- Parent table: each region has one unique region_id.
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL UNIQUE
);

-- Parent table: each service type has one unique service_type_id.
CREATE TABLE service_types (
    service_type_id INT PRIMARY KEY,
    service_type_name VARCHAR(100) NOT NULL UNIQUE
);

-- Parent table: each water source type has one unique source_type_id.
CREATE TABLE water_source_types (
    source_type_id INT PRIMARY KEY,
    source_type_name VARCHAR(100) NOT NULL UNIQUE
);

-- Child table: villages belong to regions.
CREATE TABLE villages (
    village_id INT PRIMARY KEY,
    village_name VARCHAR(100) NOT NULL,
    region_id INT NOT NULL,
    population INT NOT NULL,
    CONSTRAINT fk_villages_regions
      FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- Child table: one water access record per village and survey year.
-- The UNIQUE constraint prevents duplicate survey records for the same village and year.
CREATE TABLE water_access_records (
    access_id INT PRIMARY KEY,
    village_id INT NOT NULL,
    source_type_id INT NOT NULL,
    survey_year INT NOT NULL,
    people_with_basic_access INT NOT NULL,
    CONSTRAINT fk_access_villages
      FOREIGN KEY (village_id) REFERENCES villages(village_id),
    CONSTRAINT fk_access_source_types
      FOREIGN KEY (source_type_id) REFERENCES water_source_types(source_type_id),
    CONSTRAINT uq_village_year UNIQUE (village_id, survey_year)
);

-- Child table: service requests belong to villages.
CREATE TABLE service_requests (
    request_id INT PRIMARY KEY,
    village_id INT NOT NULL,
    request_date DATE NOT NULL,
    issue_type VARCHAR(100) NOT NULL,
    status VARCHAR(30) NOT NULL,
    households_affected INT NOT NULL,
    CONSTRAINT fk_requests_villages
      FOREIGN KEY (village_id) REFERENCES villages(village_id)
);

-- Junction table with a composite primary key.
-- A village can have many service types, and a service type can appear in many villages.
CREATE TABLE village_services (
    village_id INT NOT NULL,
    service_type_id INT NOT NULL,
    coverage_percent DECIMAL(5,2) NOT NULL,
    last_updated DATE NOT NULL,
    PRIMARY KEY (village_id, service_type_id),
    CONSTRAINT fk_vs_villages
      FOREIGN KEY (village_id) REFERENCES villages(village_id),
    CONSTRAINT fk_vs_service_types
      FOREIGN KEY (service_type_id) REFERENCES service_types(service_type_id)
);

-- External sample table for set-operation practice.
CREATE TABLE adb_country_access (
    country_code CHAR(3) PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    survey_year INT NOT NULL,
    basic_water_access_percent DECIMAL(5,2) NOT NULL
);

INSERT INTO regions (region_id, region_name) VALUES
(1, 'Northern Highlands'),
(2, 'Eastern Plains'),
(3, 'Southern Coast'),
(4, 'Western Valley'),
(5, 'Central Plateau');

INSERT INTO service_types (service_type_id, service_type_name) VALUES
(1, 'Water'),
(2, 'Sanitation'),
(3, 'Electricity'),
(4, 'Road Access');

INSERT INTO water_source_types (source_type_id, source_type_name) VALUES
(1, 'Community Tap'),
(2, 'Borehole'),
(3, 'River'),
(4, 'Well'),
(5, 'Tanker Delivery');

INSERT INTO villages (village_id, village_name, region_id, population) VALUES
(101, 'Amani', 1, 1200),
(102, 'Baraka', 1, 950),
(103, 'Chisomo', 2, 1600),
(104, 'Dara', 2, 800),
(105, 'Elimu', 3, 2300),
(106, 'Furaha', 3, 1100),
(107, 'Goba', 4, 700),
(108, 'Heshima', 4, 1450),
(109, 'Imani', 5, 2000),
(110, 'Jabali', 5, 650),
(111, 'Kijiji', 2, 900),
(112, 'Lengo', 1, 500);

INSERT INTO water_access_records (access_id, village_id, source_type_id, survey_year, people_with_basic_access) VALUES
(1, 101, 1, 2025, 780),
(2, 102, 2, 2025, 520),
(3, 103, 3, 2025, 640),
(4, 104, 2, 2025, 600),
(5, 105, 1, 2025, 1955),
(6, 106, 4, 2025, 605),
(7, 107, 3, 2025, 210),
(8, 108, 5, 2025, 870),
(9, 109, 1, 2025, 1600),
(10, 110, 4, 2025, 260),
(11, 111, 3, 2025, 315),
(12, 112, 2, 2025, 425);

INSERT INTO service_requests (request_id, village_id, request_date, issue_type, status, households_affected) VALUES
(1001, 101, '2026-02-10', 'Low pressure', 'Open', 90),
(1002, 103, '2026-02-12', 'Unsafe source', 'Open', 210),
(1003, 107, '2026-02-20', 'Dry source', 'In Progress', 130),
(1004, 105, '2026-03-01', 'Pipe damage', 'Closed', 70),
(1005, 110, '2026-03-03', 'Contamination', 'Open', 80),
(1006, 108, '2026-03-05', 'Delivery delay', 'In Progress', 115),
(1007, 111, '2026-03-10', 'Unsafe source', 'Open', 140),
(1008, 102, '2026-03-12', 'Low pressure', 'Closed', 45),
(1009, 104, '2026-03-14', 'Pump failure', 'Open', 105),
(1010, 109, '2026-03-20', 'Pipe damage', 'Closed', 60);

INSERT INTO village_services (village_id, service_type_id, coverage_percent, last_updated) VALUES
(101, 1, 65.00, '2026-01-15'),
(101, 2, 52.00, '2026-01-15'),
(102, 1, 54.74, '2026-01-20'),
(103, 1, 40.00, '2026-01-20'),
(103, 2, 31.00, '2026-01-20'),
(104, 1, 75.00, '2026-01-22'),
(105, 1, 85.00, '2026-02-01'),
(105, 3, 70.00, '2026-02-01'),
(106, 1, 55.00, '2026-02-02'),
(107, 1, 30.00, '2026-02-02'),
(108, 1, 60.00, '2026-02-05'),
(109, 1, 80.00, '2026-02-07'),
(110, 1, 40.00, '2026-02-07'),
(111, 1, 35.00, '2026-02-08'),
(112, 1, 85.00, '2026-02-08');

INSERT INTO adb_country_access (country_code, country_name, survey_year, basic_water_access_percent) VALUES
('ETH', 'Ethiopia', 2025, 64.30),
('KEN', 'Kenya', 2025, 71.20),
('NGA', 'Nigeria', 2025, 68.40),
('GHA', 'Ghana', 2025, 84.10),
('RWA', 'Rwanda', 2025, 76.00),
('TZA', 'Tanzania', 2025, 62.80),
('UGA', 'Uganda', 2025, 59.90),
('ZAF', 'South Africa', 2025, 92.50);

-- Quick checks
SELECT 'regions' AS table_name, COUNT(*) AS rows_loaded FROM regions
UNION ALL SELECT 'villages', COUNT(*) FROM villages
UNION ALL SELECT 'water_access_records', COUNT(*) FROM water_access_records
UNION ALL SELECT 'service_requests', COUNT(*) FROM service_requests
UNION ALL SELECT 'village_services', COUNT(*) FROM village_services
UNION ALL SELECT 'adb_country_access', COUNT(*) FROM adb_country_access;
