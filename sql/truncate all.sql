-- Star Schema tables
TRUNCATE TABLE superstore.StarDimCustomer;
TRUNCATE TABLE superstore.StarDimProduct;
TRUNCATE TABLE superstore.StarDimDate;
TRUNCATE TABLE superstore.StarDimLocation;
TRUNCATE TABLE superstore.StarDimShipping;
TRUNCATE TABLE superstore.StarFactSales;

-- Snowflake Schema tables
TRUNCATE TABLE superstore.SnowDimSegment;
TRUNCATE TABLE superstore.SnowDimCustomer;
TRUNCATE TABLE superstore.SnowDimCategory;
TRUNCATE TABLE superstore.SnowDimSubCategory;
TRUNCATE TABLE superstore.SnowDimProduct;
TRUNCATE TABLE superstore.SnowDimRegion;
TRUNCATE TABLE superstore.SnowDimState;
TRUNCATE TABLE superstore.SnowDimCity;
TRUNCATE TABLE superstore.SnowDimLocation;
TRUNCATE TABLE superstore.SnowDimDate;
TRUNCATE TABLE superstore.SnowDimShipping;
TRUNCATE TABLE superstore.SnowFactSales;

-- Fact Constellation Schema tables
TRUNCATE TABLE superstore.fcDimCustomer;
TRUNCATE TABLE superstore.fcDimProduct;
TRUNCATE TABLE superstore.fcDimLocation;
TRUNCATE TABLE superstore.fcDimDate;
TRUNCATE TABLE superstore.fcDimShipping;
TRUNCATE TABLE superstore.fcFactSales;
TRUNCATE TABLE superstore.fcFactShipping;
-- Note: No fcFactReturns since you excluded returns

-- Any views or the original source table are untouched
