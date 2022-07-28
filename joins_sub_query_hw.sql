-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT customer.first_name, customer.last_name, address.district
FROM customer
JOIN "address"
ON customer_id = "address".address_id
WHERE "address".district = 'Texas'

-- 2. Get all payments above $6.99 with the Customers Full
-- Name

SELECT CONCAT (customer.first_name, ' ', customer.last_name) as full_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount ASC

-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT CONCAT (customer.first_name, ' ', customer.last_name) as full_name
FROM customer
WHERE customer_id in(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) >= 175
    ORDER BY SUM(amount)
);

-- 4. List all customers that live in Nepal (use the city
-- table)

SELECT CONCAT (customer.first_name, ' ', customer.last_name) as full_name, country
FROM customer
JOIN "address"
ON customer.customer_id = "address".address_id
JOIN city
ON "address".address_id = city.city_id 
JOIN country
ON city.city_id = country.country_id
WHERE country = 'Nepal'

-- 5. Which staff member had the most
-- transactions?

SELECT CONCAT(staff.first_name, ' ', staff.last_name) as full_name, COUNT(payment.rental_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY full_name
ORDER BY COUNT(payment.rental_id) DESC;

-- 6. How many movies of each rating are
-- there?

SELECT film.rating, COUNT(film.rating)
FROM film
GROUP BY rating

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT CONCAT(customer.first_name, ' ', customer.last_name) as full_name
FROM customer
WHERE customer.customer_id IN(
    SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id, payment.amount
    HAVING payment.amount >6.99
)

-- 8. How man free rentals did our stores give away?

SELECT COUNT(rental.rental_id)
FROM rental
JOIN payment
ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0

