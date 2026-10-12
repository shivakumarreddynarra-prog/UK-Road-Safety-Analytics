USE uk_road_safety;

DROP TABLE IF EXISTS casualties_clean;

CREATE TABLE casualties_clean (
`collision_index` TEXT,
`collision_year` BIGINT,
`collision_ref_no` TEXT,
`vehicle_reference` BIGINT,
`casualty_reference` BIGINT,
`casualty_class` BIGINT,
`sex_of_casualty` BIGINT,
`age_of_casualty` BIGINT,
`age_band_of_casualty` BIGINT,
`casualty_severity` BIGINT,
`pedestrian_location` BIGINT,
`pedestrian_movement` BIGINT,
`car_passenger` BIGINT,
`bus_or_coach_passenger` BIGINT,
`pedestrian_road_maintenance_worker` BIGINT,
`casualty_type` BIGINT,
`casualty_imd_decile` BIGINT,
`lsoa_of_casualty` TEXT,
`enhanced_casualty_severity` BIGINT,
`casualty_injury_based` BIGINT,
`casualty_adjusted_severity_serious` DOUBLE,
`casualty_adjusted_severity_slight` DOUBLE,
`casualty_distance_banding` BIGINT,
`escooter_flag` BIGINT,
`age_of_casualty_clean` DOUBLE,
`casualty_age_group` TEXT,
`casualty_severity_label` TEXT,
`casualty_class_label` TEXT,
`casualty_sex_label` TEXT
);
