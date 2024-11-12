
-- Customer definition
CREATE TABLE [Customer]
(
    [CustomerId] INTEGER PRIMARY KEY,
    [FirstName] NVARCHAR(40)  NOT NULL,
    [LastName] NVARCHAR(20)  NOT NULL,
    [Company] NVARCHAR(80),
    [Address] NVARCHAR(70),
    [City] NVARCHAR(40),
    [State] NVARCHAR(40),
    [Country] NVARCHAR(40),
    [PostalCode] NVARCHAR(10),
    [Phone] NVARCHAR(24),
    [Fax] NVARCHAR(24),
    [Email] NVARCHAR(60) NOT NULL,
    [LastUpdate] DATETIME DEFAULT CURRENT_TIMESTAMP 
);

-- Product definition
CREATE TABLE [Product]
(
    [ProductId] INTEGER PRIMARY KEY,
    [Name] NVARCHAR(40) NOT NULL,
    [Price] NUMERIC(10, 2) NOT NULL,
    [WholesalePrice] NUMERIC(10, 2) NOT NULL,
    [ListPrice] NUMERIC(10, 2) NOT NULL,
    [LastUpdate] DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Product definition
CREATE TABLE [Inventory]
(
    [InventoryId] INTEGER PRIMARY KEY,
    [ProductID] INTEGER NOT NULL,
    [Quantity] INTEGER NOT NULL,
    [LastUpdate] DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductId])
);

-- Invoice definition
CREATE TABLE [Invoice]
(
    [InvoiceId] INTEGER PRIMARY KEY,
    [CustomerId] INTEGER NOT NULL,
    [InvoiceDate] DATETIME NOT NULL,
    [BillingAddress] NVARCHAR(70),
    [BillingCity] NVARCHAR(40),
    [BillingState] NVARCHAR(40),
    [BillingCountry] NVARCHAR(40),
    [BillingPostalCode] NVARCHAR(10),
    [Total] NUMERIC(10,2) NOT NULL,
    FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) 
);

-- InvoiceLine definition
CREATE TABLE [InvoiceLine]
(
    [InvoiceLineId] INTEGER PRIMARY KEY,
    [InvoiceId] INTEGER  NOT NULL,
    [ProductId] INTEGER  NOT NULL,
    [UnitPrice] NUMERIC(10,2)  NOT NULL,
    [Quantity] INTEGER  NOT NULL,
    FOREIGN KEY ([InvoiceId]) REFERENCES [Invoice] ([InvoiceId]) 
    FOREIGN KEY ([ProductId]) REFERENCES [Product] ([ProductId]) 
);