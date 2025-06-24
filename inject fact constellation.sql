INSERT INTO superstore.fcDimCustomer (CustomerID, CustomerName, Segment)
SELECT DISTINCT `Customer ID`, `Customer Name`, Segment
FROM superstore.superstore;

INSERT INTO superstore.fcFactSales (
    SaleID, OrderID, OrderDate, ShipDate,
    Sales, Quantity, Discount, Profit,
    CustomerID, ProductID, ShipMode, LocationID
)
SELECT
    GENERATE_UUID() AS SaleID,
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
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING)))) AS LocationID
FROM superstore.superstore;

INSERT INTO superstore.fcFactShipping (
    ShipEventID,
    OrderID,
    OrderDate,
    ShipDate,
    ShipDurationDays,
    CustomerID,
    ProductID,
    ShipMode,
    LocationID
)
SELECT
    GENERATE_UUID() AS ShipEventID,
    `Order ID`,
    `Order Date`,
    `Ship Date`,
    DATE_DIFF(`Ship Date`, `Order Date`, DAY) AS ShipDurationDays,
    `Customer ID`,
    `Product ID`,
    `Ship Mode`,
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING), Region))) AS LocationID
FROM superstore.superstore
WHERE `Order Date` IS NOT NULL
  AND `Ship Date` IS NOT NULL;


INSERT INTO superstore.fcDimProduct (
    ProductID,
    ProductName,
    Category,
    SubCategory
)
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore.superstore;


INSERT INTO superstore.fcDimShipping (
    ShipMode
)
SELECT DISTINCT
    `Ship Mode`
FROM superstore.superstore;


INSERT INTO superstore.fcDimLocation (
    LocationID,
    Country,
    City,
    State,
    PostalCode,
    Region
)
SELECT
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING), Region))) AS LocationID,
    Country,
    City,
    State,
    CAST(`Postal Code` AS STRING) AS PostalCode,
    Region
FROM (
    SELECT DISTINCT
        Country, City, State, `Postal Code`, Region
    FROM superstore.superstore
);


-- Order Date entries
INSERT INTO `superstore.fcDimDate` (
    DateID,
    Day,
    Month,
    Year,
    Quarter
)
SELECT DISTINCT
    `Order Date` AS DateID,
    EXTRACT(DAY FROM `Order Date`),
    EXTRACT(MONTH FROM `Order Date`),
    EXTRACT(YEAR FROM `Order Date`),
    EXTRACT(QUARTER FROM `Order Date`)
FROM superstore.superstore
WHERE `Order Date` IS NOT NULL;

-- Ship Date entries not already inserted
INSERT INTO `superstore.fcDimDate` (
    DateID,
    Day,
    Month,
    Year,
    Quarter
)
SELECT DISTINCT
    `Ship Date` AS DateID,
    EXTRACT(DAY FROM `Ship Date`),
    EXTRACT(MONTH FROM `Ship Date`),
    EXTRACT(YEAR FROM `Ship Date`),
    EXTRACT(QUARTER FROM `Ship Date`)
FROM superstore.superstore
WHERE `Ship Date` IS NOT NULL
  AND `Ship Date` NOT IN (SELECT DateID FROM `superstore.fcDimDate`);
