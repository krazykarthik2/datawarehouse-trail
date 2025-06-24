-- Normalized Dimensions

CREATE TABLE superstore.SnowDimSegment (
    SegmentID STRING NOT NULL,
    SegmentName STRING
);

CREATE TABLE superstore.SnowDimCustomer (
    CustomerID STRING NOT NULL,
    CustomerName STRING,
    SegmentID STRING
);

CREATE TABLE superstore.SnowDimCategory (
    CategoryID STRING NOT NULL,
    CategoryName STRING
);

CREATE TABLE superstore.SnowDimSubCategory (
    SubCategoryID STRING NOT NULL,
    SubCategoryName STRING,
    CategoryID STRING
);

CREATE TABLE superstore.SnowDimProduct (
    ProductID STRING NOT NULL,
    ProductName STRING,
    SubCategoryID STRING
);

CREATE TABLE superstore.SnowDimRegion (
    RegionID STRING NOT NULL,
    RegionName STRING
);

CREATE TABLE superstore.SnowDimState (
    StateID STRING NOT NULL,
    StateName STRING,
    RegionID STRING
);

CREATE TABLE superstore.SnowDimCity (
    CityID STRING NOT NULL,
    CityName STRING,
    StateID STRING
);

CREATE TABLE superstore.SnowDimLocation (
    LocationID STRING NOT NULL,
    Country STRING,
    CityID STRING,
    PostalCode STRING
);

CREATE TABLE superstore.SnowDimShipping (
    ShipMode STRING NOT NULL
);

CREATE TABLE superstore.SnowDimDate (
    DateID DATE NOT NULL,
    Day INT64,
    Month INT64,
    Year INT64,
    Quarter INT64
);

-- Fact Table

CREATE TABLE superstore.SnowFactSales (
    RowID STRING NOT NULL,
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
