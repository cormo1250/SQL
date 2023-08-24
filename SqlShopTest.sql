show databases;
use shop;
select * from categories;
-- Wyświetlenie dostępnych baz danych
SHOW DATABASES;

-- Ustawienie domyślnej bazy danych
USE shop;

-- -- -- Wyświetlanie danych -- -- --
-- 1. Wszystkie kolumny oraz wiersze
SELECT * FROM suppliers;
SELECT * FROM categories;

-- 2. Wybrane kolumny
SELECT name, id FROM product_details;
SELECT payment_date, id, order_date FROM orders;

-- 3. Wyświetlenie unikatowych wierszy z SELECTa
SELECT DISTINCT category FROM product_details;
SELECT DISTINCT category, name FROM product_details;

-- 4. Aliasy
SELECT
    ord         AS id_zamowienia,
    prd         AS id_produktu,
    quantity    AS ilosc,
    cost        AS koszt_calkowity
FROM 
    order_details;
    
-- 5. Ograniczenie ilości wierszy
SELECT *  FROM order_details LIMIT 100;

/*
    1. Wyświetlić wszystko z tabeli orders
    2. Wyświetlić imię, nazwisko i język klientów
    3. Wyświetlić name jako nazwa_produktu, period jako okres z tabeli product_details
    4. Wyświetlić tylko 10 zamówień (nie szczegóły)
    5. Wyświetlić supplier jako dostawca, prd_details jako produkt, cost jako koszt z tabeli products
    6. Którzy dostawcy dostarczają nam produkty (musi dostarczać chociaż 1 produkt).
*/
select * from orders;
select first_name, last_name, language from clients;
select name as nazwa_produktu, period as okres from product_details;
select id from orders limit 10;
select supplier as dostawca, prd_details as produkt, cost as koszt from products;
select DISTINCT supplier from products;

-- -- -- Sortowanie danych -- -- --
-- 1. Domyślne sortowanie
SELECT * FROM suppliers ORDER BY id;
SELECT * FROM orders ORDER BY order_date;

-- 2. Sortowanie, a LIMIT
SELECT name FROM product_details LIMIT 5;
SELECT * FROM suppliers LIMIT 5;
SELECT * FROM suppliers ORDER BY id LIMIT 5;

-- 3. Sortowanie po wielu kolumnach
SELECT * FROM product_details ORDER BY category, name;

-- 4. Odwórocenie sortowania
SELECT * FROM product_details ORDER BY category DESC, name;
SELECT * FROM product_details ORDER BY category DESC, name DESC;

/*
    1. Wyświetlić szczegóły zamówień od najdroższego
    2. 3 najmłodsze zamówienia
    3. Klientów posortowanych po imieniu A-Z, a nazwisku Z-A
*/
select * from orders order by clt desc;
select * from orders order by order_date desc limit 3;
select * from clients order by first_name, last_name desc;
select 1 + 1 as dodwania;

-- -- -- Funkcje -- -- --
-- 1. Operacje matematyczne
SELECT 1 + 1 AS dodawanie;
SELECT id, cost, cost + 0.99 AS cost_with_tax FROM products;

-- 2. Funkcje tekstowe: concat, length, upper, lower, substr
SELECT name, upper(name), lower(name) FROM product_details;
SELECT name, length(name) AS name_length FROM product_details;
SELECT concat('zamowienie nr: ', ord, '; dla produktu: ', prd) AS konkatenacja FROM order_details;

SELECT 
    '1234567890' AS wzor,
    substr('1234567890', 3),
    substr('1234567890', 4, 2),
    'ord456' AS wzor2,
    substr('ord456', 4);
    
SELECT
    name,
    substr(name, length(name) - 2) AS 3_ostatnie_znaki
FROM 
    product_details;
    
    /*
    1. Wyświetlić imie i nazwisko klienta jako pojedyncza kolumna.
    2. Długość każdego hasła klienta.
    3. Nazwę dostawcy z samych wielkich oraz z samych małych (2 kolumny)
    4. Doliczyć do każdego zamówionego produktu 23% podatku
    5. Wykonali konkatencje na podstawie wzoru: ord;prd;cost - id, 
        a następnie wyciągnąć od pierwsze 7 znaków
*/
select concat(first_name,' ', last_name )from clients;
select length(password) from clients;
select upper(name) from suppliers;
select cost*1.23 from order_details as AfterTax;
select substr(concat(ord,';', prd,';', cost,';','-', id), 1, 7) from order_details;

-- 3. Daty i czasu: now, current_date, current_time
--      datediff, date_add, date_sub
SELECT now(), current_date(), current_time();

SELECT datediff('2023-08-01', '2023-01-01');
SELECT date_add('2023-08-23 17:30', INTERVAL 3 HOUR);
SELECT date_add('2023-08-23 17:30', INTERVAL 7 DAY);
SELECT date_add('2023-08-23 17:30', INTERVAL 90 MINUTE) AS przerwa;

SELECT 
    year('2023-08-23 17:30'), 
    month('2023-08-23 17:30'), 
    day('2023-08-23 17:30'),
    hour('2023-08-23 17:30'),
    minute('2023-08-23 17:30');
    
    /*
    1. Wyświetl różnicę pomiędzy datą zapłaty, a datą zamówienia
    2. Wyświetl miesiąc z dzisiejszej daty
    3. Wyświetl datę, która będzię od dzisiaj za 30 dni i 12h
    4. Wyświetl rok z daty zamówienia
*/

select datediff (payment_date, order_date) from orders;
select month (current_date());
select date_add(current_date, interval 43920 minute);
select year(order_date) from orders;alter


-- -- -- Filtrowanie -- -- --
-- 1. Warunki matematyczne
SELECT * FROM products WHERE cost > 300;
SELECT * FROM orders WHERE month(order_date) = 5;
SELECT * FROM products WHERE supplier = 5;
SELECT * FROM clients WHERE first_name = 'Evan';

-- 2. Łączenie warunków: AND/OR
SELECT * FROM products WHERE supplier = 3 AND cost <= 50;
SELECT * FROM orders WHERE year(order_date) < 2021 AND datediff(payment_date, order_date) <= 1;
SELECT * FROM products WHERE supplier = 2 OR supplier = 4;
SELECT * FROM product_details WHERE period = 3 OR category = 2;

/*
    1. Wyświetl produkty, których koszt jest mniejszy bądz rowny 100
    2. Wyświetl zamowienia z 2021 roku
    3. Wyświetl klientów o imieniu Evan lub Jerry
    4. Wyświetl szczególy zamowien klientów o id: 3, 5, 11
    5. Wyświetl opisy produktów z 2 kategorii.
*/
select * from products where cost <= 100;
select * from orders where year(order_date)=2021;
select * from clients where first_name = 'Evan' or first_name = 'Jerry';
select * from orders where id =3 or id=5 or id=11;
select * from product_details where category =2;

-- 3. IN/NOT IN
SELECT * FROM orders WHERE clt = 3 OR clt = 5 OR clt = 11;
-- =
SELECT * FROM orders WHERE clt IN (3,5,11);
​
-- 4. BETWEEN ... AND ...
SELECT * FROM products WHERE cost >= 100 AND cost <= 200;
-- =
SELECT * FROM products WHERE cost BETWEEN 100 AND 200;
​
-- 5. IS NULL/IS NOT NULL
SELECT * FROM orders WHERE payment_date IS NULL;
SELECT * FROM orders WHERE payment_date IS NOT NULL;
​
SELECT 
    categories.name,
    product_details.name
FROM 
    product_details
JOIN
    categories ON categories.id = product_details.category;
​
SELECT
    products.id,
    product_details.name,
    suppliers.name,
    products.cost
FROM
    products
JOIN
    product_details ON product_details.id = products.prd_details
JOIN
    suppliers ON products.supplier = suppliers.id;

