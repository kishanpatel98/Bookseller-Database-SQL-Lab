/*#1
Customers with Specific Names
List customer ID, name, and city for the members whose name’s second character is ‘a’ as the last one is ‘e’. 
Sample Result:

CID NAME CITY
------ -------------------- ---------------
11 Sally Mae Richmond
12 Fanny Mae Roanoke
13 Garp Google Williamsburg
25 Margaret Mitchie Richmond */

select * from yrb_customer where name like '_a%e';

/*#2
Most popular category
Show the most popular category and the number of books sold in that category. 
Sample Result:

CAT QNTY_SOLD
---------- -----------
romance 57*/

select b.cat AS CAT, sum(p.qnty) AS QNTY_SOLD from yrb_purchase p inner join yrb_book b on p.title = b.title AND p.year=b.year group by b.cat having sum(p.qnty)=(select max(qnty) from (select SUM(p.qnty) AS qnty from yrb_purchase p inner join yrb_book b on p.title = b.title AND p.year=b.year group by b.cat) AS table1);

/*#3
Customer with at most Two Membership
Show customer ID, customer name, and the club name for customers who are the member of at most two clubs. Sort the result by customer id.
Sample result:

CID NAME CLUB
------ -------------------- ---------------
 11 Sally Mae Basic
 11 Sally Mae YRB Silver
 14 Kathy Lee Gifford Basic
 14 Kathy Lee Gifford Oprah
 17 George Gush Basic
 18 Al Bore Basic
 23 Lux Luthor Basic
 23 Lux Luthor Oprah
 24 Clark Kent Basic
 24 Clark Kent Readers Digest
 40 Walter Wynn Basic
 40 Walter Wynn VaTech Club
 41 Xia Xu AAA
 41 Xia Xu Basic 
*/

select m.cid, c.name, m.club from yrb_member m, yrb_customer c where c.cid = m.cid and m.cid in (select cid from yrb_member group by cid having count(cid) <= 2) order by m.cid asc;

/*#4
Disfavored Categories
Show the categories that customer with ID 9 has not purchased any books from those categories. 
Sample result:

CAT
----------
children
drama
guide
horror
humor
mystery
*/
select cat.cat as CAT from yrb_customer cus, yrb_category cat where cus.cid=9 except select b.cat from yrb_customer c join yrb_purchase p on c.cid=p.cid join yrb_book b on p.title=b.title and p.year=b.year where c.cid=9 order by CAT asc;

/*#5
Most Expensive and Cheapest Books
List title and year of most expensive and cheapest books and the clubs that offers these books. 
Sample result:

CLUB TITLE YEAR PRICE
--------------- ------------------------- ------ -------
Oprah Flibber Gibber 2000 1.20
Basic Transmorgifacation 2000 288.73 
*/

select o.club, b.title, b.year, o.price from yrb_book b join yrb_offer o on b.title=o.title and b.year=o.year where o.price = (select max(o.price) from yrb_book b join yrb_offer o on b.title=o.title and b.year=o.year) union select o.club, b.title, b.year, o.price from yrb_book b join yrb_offer o on b.title=o.title and b.year=o.year where o.price = (select min(o.price) from yrb_book b join yrb_offer o on b.title=o.title and b.year=o.year);

/*#6
Shipping Cost
For each customer calculate the shipping cost of each of their orders. All purchases made on the same time (when) by the same customer are in one order. Sort the result based on the customer number and the purchase time (when)
Sample result:

CID WHEN TOTALWEIGHT COST TOTALCOST
------ -------------------------- ----------- ------- ------------------
 1 1999-04-20-12.12.00.000000 459 2.00 918.00
 1 2001-12-01-11.59.00.000000 772 3.00 2316.00
 2 1998-08-08-17.33.00.000000 290 2.00 580.00
 2 1999-02-13-15.13.00.000000 119 2.00 238.00
 2 1999-04-16-11.46.00.000000 461 2.00 922.00
 2 2001-02-23-12.37.00.000000 393 2.00 786.00
 2 2001-04-24-17.02.00.000000 942 3.00 2826.00
 2 2001-10-21-11.05.00.000000 959 3.00 2877.00
 2 2001-12-01-15.39.00.000000 79 2.00 158.00
 3 1998-01-27-09.19.00.000000 1290 5.00 6450.00
 3 2001-10-06-11.12.00.000000 883 3.00 2649.00
 4 2000-06-13-09.45.00.000000 147 2.00 294.00
 4 2001-06-30-13.58.00.000000 806 3.00 2418.00
 4 2001-08-11-17.40.00.000000 659 3.00 1977.00
 5 2001-07-17-16.27.00.000000 3776 8.00 30208.00 
*/

--select p.cid, p.when, b.weight, s.cost from yrb_purchase p join yrb_book b on p.title=b.title and p.year=b.year join yrb_offer o on b.title=o.title and b.year=o.year join yrb_shipping s on b.weight=s.weight;

--select * from yrb_purchase p join yrb_offer o on p.title=o.title and p.year=o.year join yrb_book b on o.title=b.title and o.year=b.year join yrb_shipping s on b.weight=s.weight;

/*#7
Different Books with the Same Title
Show the title of books that have the same title but different years.
Sample result:

TITLE YEAR1 YEAR2
------------------------- ------ ------
Are my feet too big? 1989 1993 
*/

select b1.title as TITLE, b1.year as YEAR1, b2.year as YEAR2 from yrb_book b1 join yrb_book b2 on b1.title=b2.title where b1.year<b2.year;

/*#8
Active and Inactive Members
List customer ID, customer name, and number of purchases for each customer. First, list the active customers sorted by the number of purchases from low to high and then inactive customers sorted by their names in a descending order.  
Sample result:

CID NAME number of purchase
------ -------------------- ------------------
 27 Jorge Lobo 2
 34 Quency Quark 2
 18 Al Bore 3
 24 Clark Kent 3
 7 Cary Cizek 4
 12 Fanny Mae 4
 25 Margaret Mitchie 4
 35 Renee Riztp 4
 45 Jack Daniels 4
 1 Tracy Turnip 5
 4 Suzy Sedwick 5
 10 Egbert Engles 5
 11 Sally Mae 5
 13 Garp Google 5
 15 Henrietta Hogg 5
 17 George Gush 5
 20 Finwick Cooper 5
 6 Boswell Biddles 6
 22 Klive Kittlehart 6
 29 Nigel Nerd 6
 36 Steve Songheim 6 
*/

select uni.cid, uni.name, uni.number_of_purchase as "number of purchase" from ((select c.cid, c.name, count(p.cid) as number_of_purchase, 1 as filter from yrb_customer c, yrb_purchase p where c.cid=p.cid group by c.cid, c.name order by count(p.cid)) union (select cid, name, 0 as number_of_purchase, 2 as filter from yrb_customer where cid not in (select cid from yrb_purchase))) as uni order by filter, uni.number_of_purchase;


/*#9
Clubs with Offers over Average
Show club name, total number of offers and the total prices for each club that its average price is over the average price of all available offers. 
Sample result:

CLUB Number of Offers Total Price
--------------- ---------------- ---------------------------------
Basic 100 3617.07
CNU Club 98 3316.94
UVA Club 97 3285.93
VaTech Club 98 3286.25
W&M Club 100 3346.92
YRB Bronze 100 3504.47
YRB Silver 100 3391.87 
*/

select o.club, count(o.title) as "Number of Offers", sum(o.price) as "Total Price" from yrb_offer o group by o.club having sum(o.price) > (select avg(tp) from (select sum(o.price) as tp from yrb_offer o group by o.club));

/*#10
Loyal Customers (1 point)
List customer ID, name, and total purchase amount for the customers who have total purchase amount over $300. Sort the result from the highest amount of purchase to the lowest.
Sample result:

CID NAME TOTALPRICE
------ -------------------- ---------------------------------
 21 Jackie Johassen 715.50
 19 Ekksdwl Qjksynn 597.60
 32 Mark Dogfurry 547.59
 44 Zebulon Zilio 511.93
 25 Margaret Mitchie 510.85
 37 Trixie Trudeau 468.65
 40 Walter Wynn 466.19
 41 Xia Xu 425.20
 5 Andy Aardverk 363.70
 28 Phil Regis 341.10
 9 Doris Daniels 334.50
 23 Lux Luthor 310.95 
*/

select p.cid, c.name, sum(o.price) as TOTALPRICE from yrb_purchase p, yrb_customer c, yrb_offer o where p.club=o.club and o.title = p.title and c.cid=p.cid group by p.cid, c.name having sum(o.price) > 300 order by sum(o.price) desc;
