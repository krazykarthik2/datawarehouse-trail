INSERT INTO superstore.SnowDimSegment (SegmentID, SegmentName)
SELECT
    FORMAT('%x', FARM_FINGERPRINT(Segment)) AS SegmentID,
    Segment
FROM (
    SELECT DISTINCT Segment FROM superstore.superstore
);
INSERT INTO superstore.SnowDimCustomer (CustomerID, CustomerName, SegmentID)
SELECT DISTINCT
    `Customer ID`,
    `Customer Name`,
    FORMAT('%x', FARM_FINGERPRINT(Segment)) AS SegmentID
FROM superstore.superstore;
INSERT INTO superstore.SnowDimCategory (CategoryID, CategoryName)
SELECT
    FORMAT('%x', FARM_FINGERPRINT(Category)) AS CategoryID,
    Category
FROM (
    SELECT DISTINCT Category FROM superstore.superstore
);
INSERT INTO superstore.SnowDimSubCategory (SubCategoryID, SubCategoryName, CategoryID)
SELECT DISTINCT
    FORMAT('%x', FARM_FINGERPRINT(`Sub-Category`)) AS SubCategoryID,
    `Sub-Category`,
    FORMAT('%x', FARM_FINGERPRINT(Category)) AS CategoryID
FROM superstore.superstore;
INSERT INTO superstore.SnowDimProduct (ProductID, ProductName, SubCategoryID)
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    FORMAT('%x', FARM_FINGERPRINT(`Sub-Category`)) AS SubCategoryID
FROM superstore.superstore;
INSERT INTO superstore.SnowDimRegion (RegionID, RegionName)
SELECT
    FORMAT('%x', FARM_FINGERPRINT(Region)) AS RegionID,
    Region
FROM (
    SELECT DISTINCT Region FROM superstore.superstore
);
INSERT INTO superstore.SnowDimState (StateID, StateName, RegionID)
SELECT DISTINCT
    FORMAT('%x', FARM_FINGERPRINT(State)) AS StateID,
    State,
    FORMAT('%x', FARM_FINGERPRINT(Region)) AS RegionID
FROM superstore.superstore;
INSERT INTO superstore.SnowDimCity (CityID, CityName, StateID)
SELECT DISTINCT
    FORMAT('%x', FARM_FINGERPRINT(City)) AS CityID,
    City,
    FORMAT('%x', FARM_FINGERPRINT(State)) AS StateID
FROM superstore.superstore;

INSERT INTO superstore.SnowDimLocation (LocationID, Country, CityID, PostalCode)
SELECT DISTINCT
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING)))) AS LocationID,
    Country,
    FORMAT('%x', FARM_FINGERPRINT(City)) AS CityID,
    CAST(`Postal Code` AS STRING) AS PostalCode
FROM superstore.superstore;

INSERT INTO superstore.SnowDimShipping (ShipMode)
SELECT DISTINCT `Ship Mode` FROM superstore.superstore;
-- Order Date

INSERT INTO superstore.SnowDimDate (DateID, Day, Month, Year, Quarter)
SELECT DISTINCT
    `Order Date`,
    EXTRACT(DAY FROM `Order Date`),
    EXTRACT(MONTH FROM `Order Date`),
    EXTRACT(YEAR FROM `Order Date`),
    EXTRACT(QUARTER FROM `Order Date`)
FROM superstore.superstore
WHERE `Order Date` IS NOT NULL;

-- Ship Date
INSERT INTO superstore.SnowDimDate (DateID, Day, Month, Year, Quarter)
SELECT DISTINCT
    `Ship Date`,
    EXTRACT(DAY FROM `Ship Date`),
    EXTRACT(MONTH FROM `Ship Date`),
    EXTRACT(YEAR FROM `Ship Date`),
    EXTRACT(QUARTER FROM `Ship Date`)
FROM superstore.superstore
WHERE `Ship Date` IS NOT NULL
  AND `Ship Date` NOT IN (SELECT DateID FROM `superstore.SnowDimDate`);

INSERT INTO superstore.SnowFactSales (
    RowID, OrderID, OrderDate, ShipDate,
    Sales, Quantity, Discount, Profit,
    CustomerID, ProductID, ShipMode, LocationID
)
SELECT
    CAST(`Row ID` AS STRING),
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
    FORMAT('%x', FARM_FINGERPRINT(CONCAT(Country, City, State, CAST(`Postal Code` AS STRING))))
FROM superstore.superstore;

