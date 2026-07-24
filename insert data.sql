insert into USERS
(Name, Email, Phone, Role, PasswordHash)
values
(N'Ahmed Ali', N'ahmed@gmail.com', N'0791111111', N'User', N'hash_ahmed_123'),
(N'Sara Ahmad', N'sara@gmail.com', N'0792222222', N'User', N'hash_sara_123'),
(N'Omar Khaled', N'omar@gmail.com', N'0793333333', N'User', N'hash_omar_123'),
(N'Lina Mohammad', N'lina@gmail.com', N'0794444444', N'User', N'hash_lina_123'),
(N'Khaled Salem', N'khaled@gmail.com', N'0795555555', N'Admin', N'hash_khaled_123'),
(N'Noor Hassan', N'noor@gmail.com', N'0796666666', N'User', N'hash_noor_123');


insert into ADDRESS
(UserID, Street, City, BuildingNumber, IsDefault)
values
(1, N'University Street', N'Amman', 10, 1),
(2, N'Airport Road', N'Amman', 25, 1),
(3, N'King Abdullah Street', N'Zarqa', 15, 1),
(4, N'Petra Street', N'Irbid', 30, 1),
(5, N'Mecca Street', N'Amman', 44, 1),
(6, N'Jerash Street', N'Jerash', 12, 1);


insert into PRODUCT
(ProductName, Description, Price, Quantity)
values
(N'Laptop Stand', N'Adjustable aluminum laptop stand', 25.00, 30),
(N'Wireless Mouse', N'Wireless mouse with USB receiver', 18.50, 50),
(N'Mechanical Keyboard', N'Mechanical keyboard with backlight', 45.00, 25),
(N'USB-C Hub', N'USB-C hub with multiple ports', 32.00, 40),
(N'Webcam', N'Full HD webcam with microphone', 55.00, 20),
(N'Headphones', N'Wireless headphones with microphone', 60.00, 35);


insert into CARTITEM
(ProductID, UserID, Quantity)
values
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2),
(5, 4, 1),
(6, 6, 1);


insert into PRODUCTIMAGE
(ProductID, ImageURL, IsMainImage, DisplayOrder)
values
(1, N'https://example.com/images/laptop-stand.jpg', 1, 1),
(2, N'https://example.com/images/wireless-mouse.jpg', 1, 1),
(3, N'https://example.com/images/keyboard.jpg', 1, 1),
(4, N'https://example.com/images/usb-hub.jpg', 1, 1),
(5, N'https://example.com/images/webcam.jpg', 1, 1),
(6, N'https://example.com/images/headphones.jpg', 1, 1);


insert into ORDERS
(UserID, AddressID, SubTotalAmount, DiscountAmount, Status)
values
(1, 1, 50.00, 5.00, N'Delivered'),
(2, 2, 37.00, 0.00, N'Shipped'),
(3, 3, 45.00, 5.00, N'Processing'),
(4, 4, 64.00, 4.00, N'Delivered'),
(6, 6, 55.00, 0.00, N'Pending'),
(1, 1, 60.00, 10.00, N'Cancelled');


insert into ORDERITEM
(OrderID, ProductID, ProductName, Quantity, UnitPrice)
values
(1, 1, N'Laptop Stand', 2, 25.00),
(2, 2, N'Wireless Mouse', 2, 18.50),
(3, 3, N'Mechanical Keyboard', 1, 45.00),
(4, 4, N'USB-C Hub', 2, 32.00),
(5, 5, N'Webcam', 1, 55.00),
(6, 6, N'Headphones', 1, 60.00);


insert into PAYMENT
(
    OrderID,
    PaymentDate,
    Amount,
    PaymentMethod,
    Status,
    TransactionReference
)
values
(1, SYSDATETIME(), 45.00, N'Credit Card', N'Completed', N'TXN-1001'),
(2, SYSDATETIME(), 37.00, N'PayPal', N'Completed', N'TXN-1002'),
(3, SYSDATETIME(), 40.00, N'Bank Transfer', N'Completed', N'TXN-1003'),
(4, SYSDATETIME(), 60.00, N'Credit Card', N'Completed', N'TXN-1004'),
(5, null, 55.00, N'Cash', N'Pending', null),
(6, null, 50.00, N'Credit Card', N'Failed', N'TXN-1006');


insert into REVIEW
(ProductID, UserID, Rating, Comment)
values
(1, 1, 5, N'Excellent product and good quality'),
(2, 2, 4, N'Good mouse for daily use'),
(3, 3, 5, N'Comfortable keyboard and fast response'),
(4, 4, 4, N'Useful hub with multiple ports'),
(5, 6, 3, N'Good image quality but average microphone'),
(6, 1, 5, N'Clear sound and comfortable design');


insert into WISHLIST
(UserID, ProductID)
values
(1, 3),
(2, 4),
(3, 5),
(4, 6),
(6, 1),
(6, 2);