-- Customer Dimension
INSERT INTO superstore.StarDimCustomer (CustomerID, CustomerName, Segment)
SELECT DISTINCT `Customer ID`, `Customer Name`, Segment
FROM superstore.superstore;

-- Product Dimension
INSERT INTO superstore.StarDimProduct (ProductID, ProductName, Category, SubCategory)
SELECT DISTINCT `Product ID`, `Product Name`, Category, `Sub-Category`
FROM superstore.superstore;

-- Shipping Dimension
INSERT INTO superstore.StarDimShipping (ShipMode)
SELECT DISTINCT `Ship Mode`
FROM superstore.superstore;

-- Corrected Location Dimension Insert
INSERT INTO superstore.StarDimLocation (
    LocationID, Country, City, State, PostalCode, Region
)
SELECT
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING), Region))) AS LocationID,
    Country,
    City,
    State,
    CAST(`Postal Code` AS STRING) AS PostalCode,
    Region
FROM (
    SELECT DISTINCT Country, City, State, `Postal Code`, Region
    FROM superstore.superstore
);


-- Order Date
INSERT INTO superstore.StarDimDate (DateID, Day, Month, Year, Quarter)
SELECT DISTINCT
    `Order Date` AS DateID,
    EXTRACT(DAY FROM `Order Date`),
    EXTRACT(MONTH FROM `Order Date`),
    EXTRACT(YEAR FROM `Order Date`),
    EXTRACT(QUARTER FROM `Order Date`)
FROM superstore.superstore
WHERE `Order Date` IS NOT NULL;

-- Ship Date
INSERT INTO superstore.StarDimDate (DateID, Day, Month, Year, Quarter)
SELECT DISTINCT
    `Ship Date` AS DateID,
    EXTRACT(DAY FROM `Ship Date`),
    EXTRACT(MONTH FROM `Ship Date`),
    EXTRACT(YEAR FROM `Ship Date`),
    EXTRACT(QUARTER FROM `Ship Date`)
FROM superstore.superstore
WHERE `Ship Date` IS NOT NULL
  AND `Ship Date` NOT IN (SELECT DateID FROM `superstore.StarDimDate`);

-- Fact Table Insert
INSERT INTO superstore.StarFactSales (
    RowID, OrderID, OrderDate, ShipDate,
    Sales, Quantity, Discount, Profit,
    CustomerID, ProductID, ShipMode, LocationID
)
SELECT
    CAST(`Row ID` AS STRING) AS RowID,
    `Order ID`,
    `Order Date`,
    `Ship Date`,
    CAST(Sales AS NUMERIC),
    Quantity,
    CAST(Discount AS NUMERIC),
    CAST(Profit AS NUMERIC),
    `Customer ID`,
    `Product ID`,
    `Ship Mode`,
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING), Region))) AS LocationID
FROM superstore.superstore;

