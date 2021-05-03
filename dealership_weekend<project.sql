-- Salesperson Table
CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

-- Customer Table
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(100),
	billing_info VARCHAR(100)
);

-- Mechanic Table
CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

-- Parts Table
CREATE TABLE parts(
	part_id SERIAL PRIMARY KEY
);

-- Car Table
CREATE TABLE car(
	vin SERIAL PRIMARY KEY,
	car_make VARCHAR(50),
	car_model VARCHAR(50),
	car_year NUMERIC(4),
	car_condition VARCHAR(20),
	salesperson_id INTEGER,
	customer_id INTEGER,
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);	

-- Service Ticket Table
CREATE TABLE service(
	service_id SERIAL PRIMARY KEY,
	mechanic_id INTEGER,
	customer_id INTEGER,
	part_id INTEGER,
	vin INTEGER,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(part_id) REFERENCES parts(part_id),
	FOREIGN KEY(vin) REFERENCES car(vin)
);	
	
-- Invoice Table
CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	amount NUMERIC (6,2),
	invoice_date DATE,
	salesperson_id INTEGER,
	customer_id INTEGER,
	service_id INTEGER,
	vin INTEGER,
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(service_id) REFERENCES service(service_id),
	FOREIGN KEY(vin) REFERENCES car(vin)
);	
	
-- Insert into Salesperson table
INSERT INTO salesperson(
	salesperson_id,
	first_name,
	last_name
) VALUES(
	1,
	'Tony',
	'Stark'
),
(	2,
	'Steve',
	'Rogers'
);	

-- Insert into Customer table
INSERT INTO customer(
	customer_id,
	first_name,
	last_name,
	address,
	billing_info
) VALUES(
	1,
	'Luke',
	'Skywalker',
	'1 Degobah Way 00101',
	'1234-5678-9012-3456 789 01/24'
),
(	2,
	'Darth',
	'Vader',
 	'1993 Death Star Circle 11010',
 	'9234-5678-9012-3456 789 09/99'
);

-- Insert into Mechanic table
INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name
) VALUES(
	1,
	'R2',
	'D2'
),
(	2,
	'C3',
	'PO'
);

-- Insert into Parts table
INSERT INTO parts(
	part_id
) VALUES(
	123456
),
(	654321
);

-- Insert into Car table
INSERT INTO car(
	vin,
	car_make,
	car_model,
	car_year,
	car_condition,
	salesperson_id,
	customer_id
) VALUES(
	1010101010,
	'Millennium',
	'Falcon',
	'1977',
	'Fair',
	1,
	1
),
(	0101010101,
	'Naboo',
	'Starfighter',
	'2020',
	'New',
	2,
	2
);

-- Insert into Service Ticket table
INSERT INTO service(
	service_id,
	mechanic_id,
	customer_id,
	part_id,
	vin
) VALUES(
	100,
	1,
	1,
	123456,
	1010101010
),
(	200,
	2,
	2,
	654321,
	0101010101
);

-- Insert into Service Ticket table
INSERT INTO invoice(
	invoice_id,
	amount,
	invoice_date,
	salesperson_id,
	customer_id,
	service_id,
	vin
) VALUES(
	1,
	1000,
	'01/22/1993',
	1,
	1,
	100,
	1010101010
),
(	2,
	5000,
	'05/29/1987',
	2,
	2,
	200,
	0101010101
);

CREATE OR REPLACE FUNCTION add_vehicle(
	_vin INTEGER, 
	_car_make VARCHAR, 
	_car_model VARCHAR, 
	_car_year NUMERIC,
	_car_condition VARCHAR
) RETURNS VOID

LANGUAGE plpgsql

AS $$

BEGIN

	INSERT INTO car(vin,car_make,car_model,car_year,car_condition)
	VALUES(_vin,_car_make,_car_model,_car_year,_car_condition);

END;

$$;

-- Call stored function
SELECT add_vehicle(2020202020, 'Rebel', 'X-Wing', '1977', 'Great')
SELECT add_vehicle(3030, 'Imperial', 'Tie Fighter', '1977', 'About to explode...')

select *
from car