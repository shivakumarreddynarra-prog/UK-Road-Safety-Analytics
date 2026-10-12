-- ============================================================
-- UK ROAD SAFETY ANALYTICS
-- SQL Exploratory Analysis
-- ============================================================

USE uk_road_safety;

-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM collisions_clean) AS total_collisions,
    (SELECT COUNT(*) FROM vehicles_clean) AS total_vehicles,
    (SELECT COUNT(*) FROM casualties_clean) AS total_casualties;

-- ============================================================
-- 2. COLLISIONS BY SEVERITY
-- ============================================================

SELECT
    severity_label,
    COUNT(*) AS collision_count,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM collisions_clean),
        2
    ) AS percentage
FROM collisions_clean
GROUP BY severity_label
ORDER BY collision_count DESC;


-- ============================================================
-- 3. KILLED OR SERIOUS COLLISION SHARE: URBAN VS RURAL
-- ============================================================

SELECT
    area_type,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY area_type
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 4. KILLED OR SERIOUS COLLISION SHARE BY ROAD TYPE
-- ============================================================

SELECT
    road_type_label,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY road_type_label
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 5. KILLED OR SERIOUS COLLISION SHARE BY LIGHT CONDITION
-- ============================================================

SELECT
    light_group,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY light_group
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 6. KILLED OR SERIOUS COLLISION SHARE BY PEAK PERIOD
-- ============================================================

SELECT
    peak_period,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY peak_period
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 7. KILLED OR SERIOUS COLLISION SHARE: WEEKDAY VS WEEKEND
-- ============================================================

SELECT
    day_type,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY day_type
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 8. KILLED OR SERIOUS COLLISION SHARE BY ROAD SURFACE
-- ============================================================

SELECT
    road_surface_label,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY road_surface_label
ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 9. KILLED OR SERIOUS COLLISION SHARE BY HOUR OF DAY
-- ============================================================

SELECT
    hour,
    COUNT(*) AS total_collisions,
    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,
    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM collisions_clean
GROUP BY hour
ORDER BY hour;

-- ============================================================
-- 10. CASUALTY SEVERITY DISTRIBUTION
-- ============================================================

SELECT
    casualty_severity_label,
    COUNT(*) AS casualty_count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM casualties_clean),
        2
    ) AS percentage
FROM casualties_clean
GROUP BY casualty_severity_label
ORDER BY casualty_count DESC;

-- ============================================================
-- 11. FATAL OR SERIOUS CASUALTIES BY AGE GROUP
-- ============================================================

SELECT
    casualty_age_group,
    COUNT(*) AS total_casualties,
    SUM(
        CASE
            WHEN casualty_severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_casualties,
    ROUND(
        SUM(
            CASE
                WHEN casualty_severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent
FROM casualties_clean
WHERE casualty_age_group IS NOT NULL
  AND TRIM(casualty_age_group) <> ''
GROUP BY casualty_age_group
ORDER BY killed_or_serious_percent DESC;

SELECT
    CASE
        WHEN sex_of_casualty = 1 THEN 'Male'
        WHEN sex_of_casualty = 2 THEN 'Female'
        WHEN sex_of_casualty = 9 THEN 'Unknown'
        WHEN sex_of_casualty = -1 THEN 'Missing / Out of range'
        ELSE 'Other'
    END AS casualty_sex,

    COUNT(*) AS total_casualties,

    SUM(
        CASE
            WHEN casualty_severity_label IN ('Fatal', 'Serious')
            THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_casualties,

    ROUND(
        SUM(
            CASE
                WHEN casualty_severity_label IN ('Fatal', 'Serious')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM casualties_clean

WHERE sex_of_casualty IN (1, 2)

GROUP BY sex_of_casualty

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 13. FATAL OR SERIOUS INJURY SHARE BY CASUALTY CLASS
-- ============================================================

SELECT
    casualty_class_label,
    COUNT(*) AS total_casualties,

    SUM(
        CASE
            WHEN casualty_severity_label IN ('Fatal', 'Serious')
            THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_casualties,

    ROUND(
        SUM(
            CASE
                WHEN casualty_severity_label IN ('Fatal', 'Serious')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM casualties_clean

GROUP BY casualty_class_label

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 14. FATAL OR SERIOUS INJURY SHARE BY ROAD USER TYPE
--     Minimum 500 casualties for more stable comparison
-- ============================================================

SELECT
    CASE casualty_type
        WHEN 0 THEN 'Pedestrian'
        WHEN 1 THEN 'Pedal cycle'
        WHEN 2 THEN 'Motorcycle <=50cc'
        WHEN 3 THEN 'Motorcycle 51-125cc'
        WHEN 4 THEN 'Motorcycle 126-500cc'
        WHEN 5 THEN 'Motorcycle >500cc'
        WHEN 8 THEN 'Taxi / Private hire'
        WHEN 9 THEN 'Car occupant'
        WHEN 10 THEN 'Minibus occupant'
        WHEN 11 THEN 'Bus / Coach occupant'
        WHEN 16 THEN 'Horse rider'
        WHEN 17 THEN 'Agricultural vehicle occupant'
        WHEN 18 THEN 'Tram / Light rail occupant'
        WHEN 19 THEN 'Van / Goods <=3.5t occupant'
        WHEN 20 THEN 'Goods 3.5-7.5t occupant'
        WHEN 21 THEN 'Goods >=7.5t occupant'
        WHEN 22 THEN 'Mobility scooter rider'
        WHEN 23 THEN 'Electric motorcycle rider'
        WHEN 33 THEN 'Personal powered transporter'
        WHEN 90 THEN 'Other vehicle occupant'
        WHEN 97 THEN 'Motorcycle - cc unknown'
        WHEN 98 THEN 'Goods vehicle - weight unknown'
        WHEN 99 THEN 'Unknown'
        WHEN -1 THEN 'Missing / Out of range'
        ELSE 'Other'
    END AS road_user_type,

    COUNT(*) AS total_casualties,

    SUM(
        CASE
            WHEN casualty_severity_label IN ('Fatal', 'Serious')
            THEN 1 ELSE 0
        END
    ) AS killed_or_serious_casualties,

    ROUND(
        SUM(
            CASE
                WHEN casualty_severity_label IN ('Fatal', 'Serious')
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM casualties_clean

GROUP BY casualty_type

HAVING COUNT(*) >= 500

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 15. COLLISION SEVERITY SHARE BY DRIVER AGE GROUP
-- ============================================================

SELECT
    v.driver_age_group,
    COUNT(*) AS vehicle_records,

    SUM(
        CASE
            WHEN c.severity_label IN ('Fatal', 'Serious')
            THEN 1
            ELSE 0
        END
    ) AS vehicles_in_killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN c.severity_label IN ('Fatal', 'Serious')
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM vehicles_clean AS v

INNER JOIN collisions_clean AS c
    ON v.collision_index = c.collision_index

WHERE v.driver_age_group IS NOT NULL

GROUP BY v.driver_age_group

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 16. COLLISION SEVERITY SHARE BY VEHICLE TYPE
--     Minimum 500 vehicle records
-- ============================================================

SELECT
    CASE v.vehicle_type
        WHEN 1 THEN 'Pedal cycle'
        WHEN 2 THEN 'Motorcycle <=50cc'
        WHEN 3 THEN 'Motorcycle 51-125cc'
        WHEN 4 THEN 'Motorcycle 126-500cc'
        WHEN 5 THEN 'Motorcycle >500cc'
        WHEN 8 THEN 'Taxi / Private hire'
        WHEN 9 THEN 'Car'
        WHEN 10 THEN 'Minibus'
        WHEN 11 THEN 'Bus / Coach'
        WHEN 16 THEN 'Ridden horse'
        WHEN 17 THEN 'Agricultural vehicle'
        WHEN 18 THEN 'Tram / Light rail'
        WHEN 19 THEN 'Van / Goods <=3.5t'
        WHEN 20 THEN 'Goods 3.5-7.5t'
        WHEN 21 THEN 'Goods >=7.5t'
        WHEN 22 THEN 'Mobility scooter'
        WHEN 23 THEN 'Electric motorcycle'
        WHEN 33 THEN 'Personal powered transporter'
        WHEN 90 THEN 'Other vehicle'
        WHEN 97 THEN 'Motorcycle - cc unknown'
        WHEN 98 THEN 'Goods vehicle - weight unknown'
        WHEN 99 THEN 'Unknown'
        WHEN -1 THEN 'Missing / Out of range'
        ELSE 'Other'
    END AS vehicle_type,

    COUNT(*) AS vehicle_records,

    SUM(
        CASE
            WHEN c.severity_label IN ('Fatal', 'Serious')
            THEN 1 ELSE 0
        END
    ) AS vehicles_in_killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN c.severity_label IN ('Fatal', 'Serious')
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM vehicles_clean AS v

INNER JOIN collisions_clean AS c
    ON v.collision_index = c.collision_index

GROUP BY v.vehicle_type

HAVING COUNT(*) >= 500

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 17. DATABASE RELATIONSHIP / JOIN VALIDATION
-- ============================================================

SELECT
    COUNT(*) AS vehicle_records,
    COUNT(DISTINCT v.collision_index) AS collisions_with_vehicles,
    COUNT(DISTINCT c.collision_index) AS matched_collisions
FROM vehicles_clean AS v
INNER JOIN collisions_clean AS c
    ON v.collision_index = c.collision_index;

    -- ============================================================
-- 18. COLLISION-CASUALTY JOIN VALIDATION
-- ============================================================

SELECT
    COUNT(*) AS casualty_records,
    COUNT(DISTINCT ca.collision_index) AS collisions_with_casualties,
    COUNT(DISTINCT c.collision_index) AS matched_collisions
FROM casualties_clean AS ca
INNER JOIN collisions_clean AS c
    ON ca.collision_index = c.collision_index;

-- ============================================================
-- 19. AVERAGE VEHICLES AND CASUALTIES BY COLLISION SEVERITY
-- ============================================================

SELECT
    severity_label,
    COUNT(*) AS total_collisions,
    ROUND(AVG(number_of_vehicles), 2) AS avg_vehicles,
    ROUND(AVG(number_of_casualties), 2) AS avg_casualties
FROM collisions_clean
GROUP BY severity_label
ORDER BY
    CASE severity_label
        WHEN 'Fatal' THEN 1
        WHEN 'Serious' THEN 2
        WHEN 'Slight' THEN 3
    END;

-- ============================================================
-- 20. KILLED OR SERIOUS COLLISION SHARE BY SPEED LIMIT
-- ============================================================

SELECT
    speed_limit,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

GROUP BY speed_limit

ORDER BY speed_limit;

-- ============================================================
-- 21. KSI SHARE BY AREA TYPE AND SPEED LIMIT
-- ============================================================

SELECT
    area_type,
    speed_limit,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE area_type IN ('Urban', 'Rural')

GROUP BY
    area_type,
    speed_limit

ORDER BY
    area_type,
    speed_limit;

-- ============================================================
-- 22. KSI SHARE BY WEATHER CONDITION
-- ============================================================

SELECT
    weather_label,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

GROUP BY weather_label

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 23. KSI SHARE BY LIGHT AND WEATHER CONDITIONS
-- ============================================================

SELECT
    light_group,
    weather_label,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE light_group IN ('Daylight', 'Darkness')

GROUP BY
    light_group,
    weather_label

HAVING COUNT(*) >= 100

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 24. KSI SHARE BY ROAD SURFACE AND LIGHT CONDITIONS
-- ============================================================

SELECT
    light_group,
    road_surface_label,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE light_group IN ('Daylight', 'Darkness')

GROUP BY
    light_group,
    road_surface_label

HAVING COUNT(*) >= 100

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 25. KSI SHARE BY DAY TYPE AND TIME OF DAY
-- ============================================================

SELECT
    day_type,
    time_of_day,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE day_type IS NOT NULL
  AND time_of_day IS NOT NULL

GROUP BY
    day_type,
    time_of_day

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 26. KSI SHARE BY ROAD TYPE AND SPEED LIMIT
-- ============================================================

SELECT
    road_type_label,
    speed_limit,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE road_type_label IS NOT NULL
  AND speed_limit IS NOT NULL

GROUP BY
    road_type_label,
    speed_limit

HAVING COUNT(*) >= 100

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 27. KSI SHARE BY AREA TYPE AND LIGHT CONDITION
-- ============================================================

SELECT
    area_type,
    light_group,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE area_type IN ('Urban', 'Rural')
  AND light_group IN ('Daylight', 'Darkness')

GROUP BY
    area_type,
    light_group

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 28. KSI SHARE BY SPEED LIMIT AND LIGHT CONDITION
-- ============================================================

SELECT
    speed_limit,
    light_group,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE speed_limit IS NOT NULL
  AND light_group IN ('Daylight', 'Darkness')

GROUP BY
    speed_limit,
    light_group

ORDER BY
    speed_limit,
    light_group;

-- ============================================================
-- 29. KSI SHARE BY AREA TYPE AND TIME OF DAY
-- ============================================================

SELECT
    area_type,
    time_of_day,
    COUNT(*) AS total_collisions,

    SUM(
        CASE
            WHEN severity_label IN ('Fatal', 'Serious') THEN 1
            ELSE 0
        END
    ) AS killed_or_serious_collisions,

    ROUND(
        SUM(
            CASE
                WHEN severity_label IN ('Fatal', 'Serious') THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS killed_or_serious_percent

FROM collisions_clean

WHERE area_type IN ('Urban', 'Rural')
  AND time_of_day IS NOT NULL

GROUP BY
    area_type,
    time_of_day

ORDER BY killed_or_serious_percent DESC;

-- ============================================================
-- 30. FINAL DATASET SUMMARY
-- ============================================================

SELECT
    (SELECT COUNT(*)
     FROM collisions_clean) AS total_collisions,

    (SELECT COUNT(*)
     FROM vehicles_clean) AS total_vehicle_records,

    (SELECT COUNT(*)
     FROM casualties_clean) AS total_casualties,

    (SELECT COUNT(*)
     FROM collisions_clean
     WHERE severity_label = 'Fatal') AS fatal_collisions,

    (SELECT COUNT(*)
     FROM collisions_clean
     WHERE severity_label = 'Serious') AS serious_collisions,

    (SELECT COUNT(*)
     FROM casualties_clean
     WHERE casualty_severity_label = 'Fatal') AS fatalities,

    (SELECT COUNT(*)
     FROM casualties_clean
     WHERE casualty_severity_label = 'Serious') AS serious_casualties;