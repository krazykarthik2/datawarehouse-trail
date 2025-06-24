-- Dimension Tables

CREATE TABLE superstore.fcDimCustomer (
    CustomerID STRING NOT NULL,
    CustomerName STRING,
    Segment STRING
);

CREATE TABLE superstore.fcDimProduct (
    ProductID STRING NOT NULL,
    ProductName STRING,
    Category STRING,
    SubCategory STRING
);

CREATE TABLE superstore.fcDimShipping (
    ShipMode STRING NOT NULL
);

CREATE TABLE superstore.fcDimLocation (
    LocationID STRING NOT NULL,
    Country STRING,
    City STRING,
    State STRING,
    PostalCode STRING,
    Region STRING
);

CREATE TABLE superstore.fcDimDate (
    DateID DATE NOT NULL,
    Day INT64,
    Month INT64,
    Year INT64,
    Quarter INT64
);

-- Sales Fact Table

CREATE TABLE superstore.fcFactSales (
    SaleID STRING NOT NULL,
    OrderID STRING,
    OrderDate DATE,
    ShipDate DATE,
    Sales NUMERIC,
    Quantity INT64,
    Discount NUMERIC,
    Profit NUMERIC,

    CustomerID STRING,
    ProductID STRING,
    ShipMode STRING,
    LocationID STRING
);

CREATE TABLE superstore.fcDimShipping (
    ShipMode STRING NOT NULL
);

CREATE TABLE superstore.fcFactShipping (
    ShipEventID STRING NOT NULL,
    OrderID STRING,
    OrderDate DATE,
    ShipDate DATE,
    ShipDurationDays INT64,
    
    CustomerID STRING,
    ProductID STRING,
    ShipMode STRING,
    LocationID STRING
);

