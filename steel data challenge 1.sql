-- 1. What are the details of all cars purchased in the year 2022?
select *
from sales
    join cars on sales.car_id = cars.car_id
where purchase_date like "2022%";

/*
| sale_id | car_id | salesman_id | purchase_date | car_id | make     | type     | style     | cost_$ |
| ------- | ------ | ----------- | ------------- | ------ | -------- | -------- | --------- | ------ |
| 9       | 2      | 4           | 2022-01-01    | 2      | Toyota   | Corolla  | Hatchback | 25000  |
| 10      | 1      | 3           | 2022-02-03    | 1      | Honda    | Civic    | Sedan     | 30000  |
| 11      | 8      | 2           | 2022-02-10    | 8      | Nissan   | Altima   | Sedan     | 26000  |
| 12      | 7      | 2           | 2022-03-01    | 7      | Mercedes | C-Class  | Coupe     | 60000  |
| 13      | 5      | 3           | 2022-04-02    | 5      | BMW      | X5       | SUV       | 55000  |
| 14      | 3      | 1           | 2022-05-05    | 3      | Ford     | Explorer | SUV       | 40000  |
| 15      | 5      | 4           | 2022-06-07    | 5      | BMW      | X5       | SUV       | 55000  |
| 16      | 1      | 2           | 2022-07-09    | 1      | Honda    | Civic    | Sedan     | 30000  |
*/

-- 2. What is the total number of cars sold by each salesperson?
select sales.salesman_id as "id",
    salespersons.name as "name",
    count(salespersons.salesman_id) as "total cars sold"
from sales
    join salespersons on sales.salesman_id = salespersons.salesman_id
group by salespersons.salesman_id;

/*
| id  | name       | total cars sold |
| --- | ---------- | --------------- |
| 1   | John Smith | 5               |
| 2   | Emily Wong | 5               |
| 3   | Tom Lee    | 6               |
| 4   | Lucy Chen  | 4               |
*/

-- 3. What is the total revenue generated by each salesperson?
select sales.salesman_id as "id", salespersons.name as "name", sum(cost_$) as "total revenue"
from sales
	join salespersons
	on sales.salesman_id = salespersons.salesman_id
    join cars
    on sales.car_id = cars.car_id
group by salespersons.salesman_id;

/*
| id  | name       | total revenue |
| --- | ---------- | ------------- |
| 1   | John Smith | 181000        |
| 2   | Emily Wong | 177000        |
| 3   | Tom Lee    | 253000        |
| 4   | Lucy Chen  | 171000        |
*/

-- 4. What are the details of the cars sold by each salesperson?
select salespersons.name as "sold by",
	sales.purchase_date as "date of purchase",
    concat(make," ",type) as "car",
    style,
    cost_$
from sales
	join salespersons
	on sales.salesman_id = salespersons.salesman_id
    join cars
    on sales.car_id = cars.car_id
order by salespersons.salesman_id;

/*
| sold by    | date of purchase | car              | style     | cost_$ |
| ---------- | ---------------- | ---------------- | --------- | ------ |
| John Smith | 2021-01-01       | Honda Civic      | Sedan     | 30000  |
| John Smith | 2023-02-10       | Mercedes C-Class | Coupe     | 60000  |
| John Smith | 2022-05-05       | Ford Explorer    | SUV       | 40000  |
| John Smith | 2021-05-05       | Toyota Corolla   | Hatchback | 25000  |
| John Smith | 2021-04-02       | Nissan Altima    | Sedan     | 26000  |
| Emily Wong | 2022-03-01       | Mercedes C-Class | Coupe     | 60000  |
| Emily Wong | 2022-02-10       | Nissan Altima    | Sedan     | 26000  |
| Emily Wong | 2021-06-07       | Chevrolet Camaro | Coupe     | 36000  |
| Emily Wong | 2021-02-10       | Toyota Corolla   | Hatchback | 25000  |
| Emily Wong | 2022-07-09       | Honda Civic      | Sedan     | 30000  |
| Tom Lee    | 2023-02-03       | Audi A4          | Sedan     | 48000  |
| Tom Lee    | 2023-01-01       | Toyota Corolla   | Hatchback | 25000  |
| Tom Lee    | 2022-04-02       | BMW X5           | SUV       | 55000  |
| Tom Lee    | 2022-02-03       | Honda Civic      | Sedan     | 30000  |
| Tom Lee    | 2021-07-09       | BMW X5           | SUV       | 55000  |
| Tom Lee    | 2021-02-03       | Ford Explorer    | SUV       | 40000  |
| Lucy Chen  | 2021-03-01       | BMW X5           | SUV       | 55000  |
| Lucy Chen  | 2023-03-01       | Chevrolet Camaro | Coupe     | 36000  |
| Lucy Chen  | 2022-06-07       | BMW X5           | SUV       | 55000  |
| Lucy Chen  | 2022-01-01       | Toyota Corolla   | Hatchback | 25000  |
*/

-- 5. What is the total revenue generated by each car type?
select cars.type,
    sum(cost_$) as "total revenue"
from sales
    join cars
    on sales.car_id = cars.car_id
group by cars.type;

/*
| type     | total revenue |
| -------- | ------------- |
| A4       | 48000         |
| Altima   | 52000         |
| C-Class  | 120000        |
| Camaro   | 72000         |
| Civic    | 90000         |
| Corolla  | 100000        |
| Explorer | 80000         |
| X5       | 220000        |
*/

-- 6. What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong'?
select purchase_date, 
	make,
    type,
    style,
    cost_$
from sales
	join salespersons
	on sales.salesman_id = salespersons.salesman_id
    join cars
    on sales.car_id = cars.car_id
where purchase_date like "2021%"
	AND salespersons.name = "Emily Wong";

/*
| purchase_date | make      | type    | style     | cost_$ |
| ------------- | --------- | ------- | --------- | ------ |
| 2021-02-10    | Toyota    | Corolla | Hatchback | 25000  |
| 2021-06-07    | Chevrolet | Camaro  | Coupe     | 36000  |
*/

-- 7. What is the total revenue generated by the sales of hatchback cars?

select style, sum(cost_$) as "total revenue"
from sales
    join cars
    on sales.car_id = cars.car_id
where style = "Hatchback"
group by style;

/*
| style     | total revenue |
| --------- | ------------- |
| Hatchback | 100000        |
*/

-- 8. What is the total revenue generated by the sales of SUV cars in the year 2022?

select style sum(cost_$) as "total revenue"
from sales
    join cars
    on sales.car_id = cars.car_id
where style = "SUV" and purchase_date like "2022%"
group by style;

/*
| style     | total revenue |
| --------- | ------------- |
| SUV       | 150000        |
*/

-- 9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
select salespersons.name,
	count(salespersons.name) as "total cars sold",
    salespersons.city
from sales
	join salespersons
	on sales.salesman_id = salespersons.salesman_id
    join cars
    on sales.car_id = cars.car_id
where purchase_date like "2023%"
group by salespersons.name, salespersons.city
order by count(salespersons.name) desc
limit 1;

/*
| name    | city    | total cars sold |
| ------- | ------- | --------------- |
| Tom Lee | Seattle | 2               |
*/

-- 10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?
select salespersons.name,
	sum(cars.cost_$) as "total revenue",
    salespersons.age
from sales
	join salespersons
	on sales.salesman_id = salespersons.salesman_id
    join cars
    on sales.car_id = cars.car_id
where purchase_date like "2022%"
group by salespersons.name, salespersons.age
order by sum(cars.cost_$) desc
limit 1;

/*
| name       | age | total revenue |
| ---------- | --- | ------------- |
| Emily Wong | 35  | 116000        |
*/