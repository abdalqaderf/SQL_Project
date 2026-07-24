create table USERS (
    UserID int identity(1,1) Primary Key,
    Name nvarchar(100) not null,
    Email nvarchar(150) not null unique,
    Phone nvarchar(20),
    Role nvarchar(20) default 'User' not null,
    PasswordHash nvarchar(255) not null,
    IsDeleted bit default 0 not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,
    UpdatedAt DateTime2 default null,

    constraint CHK_Users_Role CHECK (Role in ('Admin', 'User'))
);


create table ADDRESS (
    AddressID int identity(1,1) Primary Key,
    UserID int not null,
    Street nvarchar(100) not null,
    City nvarchar(50) not null,
    BuildingNumber int not null,
    IsDefault bit default 0 not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,

    constraint FK_UserAddress FOREIGN KEY (UserID)
        REFERENCES USERS(UserID),

    constraint CK_Address_BuildingNumber
        CHECK (BuildingNumber > 0)
);


create table PRODUCT (
    ProductID int identity(1,1) Primary Key,
    ProductName nvarchar(100) not null,
    Description nvarchar(500),
    Price decimal(10,2) not null,
    Quantity int not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,
    UpdatedAt DateTime2 default null,
    IsDeleted bit default 0 not null,

    constraint CK_Product_Price CHECK (Price > 0),
    constraint CK_Product_Quantity CHECK (Quantity >= 0)
);


create table CARTITEM (
    CartItemID int identity(1,1) Primary Key,
    ProductID int not null,
    UserID int not null,
    Quantity int not null,
    AddedAt DateTime2 default SYSDATETIME() not null,
    UpdatedAt DateTime2 default null,

    constraint FK_UserCartItem FOREIGN KEY (UserID)
        REFERENCES USERS(UserID),

    constraint FK_ProductCartItem FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),

    constraint CK_CartItem_Quantity CHECK (Quantity > 0),

    constraint UQ_CartItem_User_Product
        UNIQUE (UserID, ProductID)
);


create table PRODUCTIMAGE (
    ImageID int identity(1,1) Primary Key,
    ProductID int not null,
    ImageURL nvarchar(500) not null,
    IsMainImage bit default 0 not null,
    DisplayOrder int default 0 not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,

    constraint FK_ProductImage FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),

    constraint CK_ProductImage_DisplayOrder
        CHECK (DisplayOrder >= 0)
);

create table ORDERS (
    OrderID int identity(1,1) Primary Key,
    UserID int not null,
    AddressID int not null,
    OrderDate DateTime2 default SYSDATETIME() not null,
    SubTotalAmount decimal(12,2) not null,
    DiscountAmount decimal(12,2) default 0 not null,

    TotalAmount AS (
        CAST(
            SubTotalAmount - DiscountAmount
            AS decimal(12,2)
        )
    ) PERSISTED,

    Status nvarchar(20) default 'Pending' not null,
    UpdatedAt DateTime2 default null,

    constraint FK_UserOrder FOREIGN KEY (UserID)
        REFERENCES USERS(UserID),

    constraint FK_AddressOrder FOREIGN KEY (AddressID)
        REFERENCES ADDRESS(AddressID),

    constraint CK_Orders_Status CHECK (
        Status in (
            'Pending',
            'Processing',
            'Shipped',
            'Delivered',
            'Cancelled'
        )
    ),

    constraint CK_Orders_SubTotalAmount
        CHECK (SubTotalAmount >= 0),

    constraint CK_Orders_DiscountAmount CHECK (
        DiscountAmount >= 0
        AND DiscountAmount <= SubTotalAmount
    )
);

create table ORDERITEM (
    OrderItemID int identity(1,1) Primary Key,
    OrderID int not null,
    ProductID int not null,
    ProductName nvarchar(100) not null,
    Quantity int not null,
    UnitPrice decimal(10,2) not null,

    TotalPrice AS (
        CAST(
            UnitPrice * Quantity
            AS decimal(12,2)
        )
    ) PERSISTED,

    constraint FK_OrderOrderItem FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID),

    constraint FK_ProductOrderItem FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),

    constraint CK_OrderItem_Quantity CHECK (Quantity > 0),

    constraint CK_OrderItem_UnitPrice CHECK (UnitPrice > 0),

    constraint UQ_OrderItem_Order_Product
        UNIQUE (OrderID, ProductID)
);

create table PAYMENT (
    PaymentID int identity(1,1) Primary Key,
    OrderID int not null,
    CreatedAt DateTime2 default SYSDATETIME() not null,
    PaymentDate DateTime2 default null,
    Amount decimal(12,2) not null,
    PaymentMethod nvarchar(30) not null,
    Status nvarchar(20) default 'Pending' not null,
    TransactionReference nvarchar(150) default null,

    constraint FK_OrderPayment FOREIGN KEY (OrderID)
        REFERENCES ORDERS(OrderID),

    constraint CK_Payment_Method CHECK (
        PaymentMethod in (
            'Credit Card',
            'PayPal',
            'Bank Transfer',
            'Cash'
        )
    ),

    constraint CK_Payment_Status CHECK (
        Status in (
            'Pending',
            'Completed',
            'Failed',
            'Refunded'
        )
    ),

    constraint CK_Payment_Amount CHECK (Amount > 0),

    constraint CK_Payment_Date CHECK (
        (
            Status in ('Completed', 'Refunded')
            AND PaymentDate is not null
        )
        OR
        (
            Status in ('Pending', 'Failed')
            AND PaymentDate is null
        )
    )
);

create table REVIEW (
    ReviewID int identity(1,1) Primary Key,
    ProductID int not null,
    UserID int not null,
    Rating int not null,
    Comment nvarchar(500) default null,
    ReviewDate DateTime2 default SYSDATETIME() not null,
    UpdatedAt DateTime2 default null,

    constraint FK_ProductReview FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),

    constraint FK_UserReview FOREIGN KEY (UserID)
        REFERENCES USERS(UserID),

    constraint CK_Review_Rating
        CHECK (Rating between 1 and 5),

    constraint UQ_Review_User_Product
        UNIQUE (UserID, ProductID)
);

create table WISHLIST (
    WishlistID int identity(1,1) Primary Key,
    UserID int not null,
    ProductID int not null,
    AddedAt DateTime2 default SYSDATETIME() not null,

    constraint FK_UserWishlist FOREIGN KEY (UserID)
        REFERENCES USERS(UserID),

    constraint FK_ProductWishlist FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID),

    constraint UQ_Wishlist_User_Product
        UNIQUE (UserID, ProductID)
);