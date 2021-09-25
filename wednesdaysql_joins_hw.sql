-- Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)
SELECT *
FROM customer;

SELECT * 
FROM address;

SELECT customer_id, first_name, last_name
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE district = 'Texas';

--Answer: customer_id 6, 118, 305, 400, 561 live in Texas

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT *
FROM customer;

SELECT * 
FROM payment;

SELECT first_name, last_name, amount
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- Answer: 1406 payments above $6.99

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT *
FROM customer;

SELECT * 
FROM payment;

SELECT first_name, last_name, SUM(amount)
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY first_name, last_name;

-- Answer: 6 customers made payments over $175

-- 4. List all customers that live in Nepal (use the city table)
SELECT *
FROM customer;

SELECT *
FROM address;

SELECT *
FROM city;

SELECT *
FROM country;

SELECT customer_id, first_name, last_name, country
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- Answer: Kevin Schuler is from Nepal

-- 5. Which staff member had the most transactions?
SELECT *
FROM payment;

SELECT COUNT(payment_id)
FROM payment; --14596

SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id;
-- Staff 1: 7292, Staff 2: 7304

SELECT staff_id, first_name, last_name
FROM staff
WHERE staff_id = 2;

-- Answer: 2, Jon Stephens

-- 6. How many movies of each rating are there?
SELECT *
FROM film;

SELECT DISTINCT rating
FROM film;

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;
-- Verifying how many total movies there are
SELECT COUNT(film_id)
FROM film;
-- Answer: {R:195, NC-17:210, G:178, PG:194, PG-13:223}

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
);

-- Answer: 539 customers made a single payment above 6.99

-- 8. How many free rentals did our store give away?
SELECT * 
FROM payment;

SELECT COUNT(payment_id)
FROM payment
WHERE payment_id IN(
	SELECT payment_id
	FROM payment
	WHERE amount = 0
);

-- Answer = 24
