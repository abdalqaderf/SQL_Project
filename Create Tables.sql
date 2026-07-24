create table USERS (
UserID int identity(1,1) Primary Key ,
Name nvarchar(20) not null,
Email nvarchar(50) not null unique, 
Phone nvarchar(20),
Role nvarchar(20 ) not null,
PasswordHash nvarchar(50) not null,
CreatedAt DateTime2 default SYSDATETIME() not null,
UpdatedAt DateTime2 default null,

constraint CHK_Role CHECK (Role in ('Admin', 'User'))
); 


create table ADDRESS (
AddressID int identity(1,1) Primary Key,
UserID int not null,
Street nvarchar(100) not null,
City nvarchar(50) not null,
buildingNumber nvarchar(50) not null,

constraint FK_UserAddress FOREIGN KEY (UserID) REFERENCES USERS(UserID),
constraint Ck_Address CHECK (buildingNumber > 0)
);

create table PRODUCT(
    ProductID int identity(1,1) Primary Key,
    productName nvarchar(100) not null,
    Description nvarchar(255) not null,
    Price decimal(10,2) not null,
    quantity int not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,
    UpdatedAt DateTime2 default null,
    isDeleted bit default 0 not null,
    constraint Ck_Price CHECK (Price > 0),
    constraint Ck_Quantity CHECK (quantity >= 0)

);
create table CARTITEM(
    CartItemID int identity(1,1) Primary Key,
    ProductID int not null,
    UserID int not null,
    Quantity int not null,
    addAt DateTime2 default SYSDATETIME() not null,
    updateAt DateTime2 default null,
    constraint FK_UserCartItem FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    constraint FK_ProductCartItem FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    constraint CK_CartItem_Quantity CHECK (Quantity > 0)
);


create table PRODUCTIMAGE(
    ImageID int identity(1,1) Primary Key,
    ProductID int not null,
    ImageURL nvarchar(255) not null,
    isMainImage bit default 0 not null,
    displayOrder int default 0 not null,
    constraint FK_ProductImage FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

create table ORDERS(
    OrderID int identity(1,1) Primary Key,
    UserID int not null,
    addressID int not null,
    OrderDate DateTime2 default SYSDATETIME() not null,
    TotalAmount decimal(10,2) not null,
    subTotalAmount decimal(10,2) not null,
    Status nvarchar(20) default 'Pending' not null,
    updatedAt DateTime2 default null,
    discount decimal(10,2) default 0 not null,

    constraint FK_UserOrder FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    constraint FK_AddressOrder FOREIGN KEY (addressID) REFERENCES ADDRESS(AddressID),
    constraint CK_Orders_Status CHECK (Status in ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    constraint CK_Orders_TotalAmount CHECK (TotalAmount >= 0)
);

create table ORDERITEM(
    OrderItemID int identity(1,1) Primary Key,
    OrderID int not null,
    ProductID int not null,
    Quantity int not null,
    unitPrice decimal(10,2) not null,
    total_price decimal(10,2) not null,
    constraint FK_OrderOrderItem FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    constraint FK_ProductOrderItem FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    constraint CK_OrderItem_Quantity CHECK (Quantity > 0),
    constraint CK_OrderItem_Price CHECK (unitPrice >= 0),
    constraint CK_OrderItem_TotalPrice CHECK (total_price = unitPrice * Quantity)
);

create table PAYMENT(
    PaymentID int identity(1,1) Primary Key,
    OrderID int not null,
    PaymentDate DateTime2 default SYSDATETIME() not null,
    Amount decimal(10,2) not null,
    PaymentMethod nvarchar(20) not null,
    Status nvarchar(20) default 'Pending' not null,

    constraint FK_OrderPayment FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    constraint CK_Payment_Method CHECK (PaymentMethod in ('Credit Card', 'PayPal', 'Bank Transfer')),
    constraint CK_Payment_Status CHECK (Status in ('Pending', 'Completed', 'Failed')),
    constraint CK_Payment_Amount CHECK (Amount >= 0)
);

create table REVIEW(
    ReviewID int identity(1,1) Primary Key,
    ProductID int not null,
    UserID int not null,
    Rating int not null,
    Comment nvarchar(255) default null,
    ReviewDate DateTime2 default SYSDATETIME() not null,
    updatedAt DateTime2 default null,

    constraint FK_ProductReview FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID),
    constraint FK_UserReview FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    constraint CK_Rating CHECK (Rating >= 1 AND Rating <= 5)
);

create table WISHLIST(
    WishlistID int identity(1,1) Primary Key,
    UserID int not null,
    ProductID int not null,
    addedAt DateTime2 default SYSDATETIME() not null,

    constraint FK_UserWishlist FOREIGN KEY (UserID) REFERENCES USERS(UserID),
    constraint FK_ProductWishlist FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
);

