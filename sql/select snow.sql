SELECT
  f.RowID,
  f.OrderID,
  f.OrderDate,
  f.ShipDate,
  f.Sales,
  f.Quantity,
  f.Discount,
  f.Profit,

  -- Customer
  cust.CustomerID,
  cust.CustomerName,
  seg.SegmentName,

  -- Product
  prod.ProductID,
  prod.ProductName,
  sub.SubCategoryName,
  cat.CategoryName,

  -- Shipping
  ship.ShipMode,

  -- Location
  loc.LocationID,
  city.CityName,
  state.StateName,
  reg.RegionName,
  loc.PostalCode,
  loc.Country,

  -- Dates
  f.OrderDate AS OrderDateID,
  f.ShipDate AS ShipDateID

FROM superstore.SnowFactSales f

-- Customer dimension chain
JOIN superstore.SnowDimCustomer cust ON f.CustomerID = cust.CustomerID
JOIN superstore.SnowDimSegment seg ON cust.SegmentID = seg.SegmentID

-- Product dimension chain
JOIN superstore.SnowDimProduct prod ON f.ProductID = prod.ProductID
JOIN superstore.SnowDimSubCategory sub ON prod.SubCategoryID = sub.SubCategoryID
JOIN superstore.SnowDimCategory cat ON sub.CategoryID = cat.CategoryID

-- Shipping
JOIN superstore.SnowDimShipping ship ON f.ShipMode = ship.ShipMode

-- Location dimension chain
JOIN superstore.SnowDimLocation loc ON f.LocationID = loc.LocationID
JOIN superstore.SnowDimCity city ON loc.CityID = city.CityID
JOIN superstore.SnowDimState state ON city.StateID = state.StateID
JOIN superstore.SnowDimRegion reg ON state.RegionID = reg.RegionID

-- Date dimension (optional if you use OrderDate/ShipDate directly)
-- Can be joined on f.OrderDate = date.DateID etc.

LIMIT 10;
