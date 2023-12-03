CREATE TABLE IF NOT EXISTS raw_data (
	vendorId INT,
	trep_pickup_datetime VARCHAR(32),
	trep_dropoff_datetime VARCHAR(32),
	passanger_count INT,
	trip_distance FLOAT,
	ratecodeid INT,
	store_and_fwd_flag VARCHAR(4),
	pulocationId INT,
	dolocationid INT,
	payment_type INT,
	fare_amount FLOAT,
	extra FLOAT,
	mta_tax FLOAT,
	tip_amount FLOAT,
	tools_amount FLOAT,
	improvement_surchange FLOAT,
	total_amount FLOAT,
	congestion_surchange FLOAT
);

COPY raw_data
FROM '/raw_data/yellow_tripdata_2020-01.csv'
DELIMITER ','
ENCODING 'UTF8'
CSV HEADER;