-- Dimension Tables

CREATE TABLE superstore.StarDimCustomer (
    CustomerID STRING NOT NULL,
    CustomerName STRING,
    Segment STRING
);

CREATE TABLE superstore.StarDimProduct (
    ProductID STRING NOT NULL,
    ProductName STRING,
    Category STRING,
    SubCategory STRING
);

CREATE TABLE superstore.StarDimDate (
    DateID DATE NOT NULL,
    Day INT64,
    Month INT64,
    Year INT64,
    Quarter INT64
);

CREATE TABLE superstore.StarDimLocation (
    LocationID STRING NOT NULL,
    Country STRING,
    City STRING,
    State STRING,
    PostalCode STRING,
    Region STRING
);

CREATE TABLE superstore.StarDimShipping (
    ShipMode STRING NOT NULL
);

-- Fact Table

CREATE TABLE superstore.StarFactSales (
    RowID STRING NOT NULL,
    OrderID STRING,
    OrderDate DATE,
    ShipDate DATE,
    Sales NUMERIC,
    Quantity INT64,
    Discount NUMERIC,
    Profit NUMERIC,

    -- Foreign Keys (BigQuery does not enforce FK constraints, but you can document them)
    CustomerID STRING,
    ProductID STRING,
    ShipMode STRING,
    LocationID STRING
);
