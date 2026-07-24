--1
select * from ORDERS
 inner join USERS on ORDERS.UserID = USERS.UserID
 where USERS.IsDeleted = 0;


--2
select ProductID, ProductName from PRODUCT
 where IsDeleted = 0
 order by Price desc;


--3
select PRODUCT.ProductName, AVG(cast(REVIEW.Rating as decimal(10,2))) as AverageRating from PRODUCT
left join REVIEW on PRODUCT.ProductID = REVIEW.ProductID
group by PRODUCT.ProductID, PRODUCT.ProductName


--4
select PRODUCT.PRODUCTNAME from PRODUCT
inner join WISHLIST on PRODUCT.ProductID = WISHLIST.ProductID
where WISHLIST.UserID = 1


--5 
select ORDERS.UserID , sum(ORDERS.TotalAmount) as TotalSpent from ORDERS
inner join Payment on ORDERS.OrderID = Payment.OrderID
where Payment.Status = 'Completed'
group by ORDERS.UserID


--6
select ProductName from PRODUCT
where price  between 100 and 500

--7
select top 5  OrderID,  OrderDate from ORDERS
order by ORDERS.OrderDate desc

