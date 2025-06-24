SELECT
  f.SaleID,
  f.OrderID,
  f.OrderDate,
  f.Sales,
  f.Quantity,
  f.Discount,
  f.Profit,

  c.CustomerName,
  c.Segment,
  p.ProductName,
  p.Category,
  p.SubCategory
FROM superstore.fcFactSales f
JOIN superstore.fcDimCustomer c ON f.CustomerID = c.CustomerID
JOIN superstore.fcDimProduct p ON f.ProductID = p.ProductID
LIMIT 10;


SELECT
  f.ShipEventID,
  f.OrderID,
  f.OrderDate,
  f.ShipDate,
  f.ShipDurationDays,

  c.CustomerName,
  p.ProductName,
  s.ShipMode,
  l.City,
  l.State,
  l.Region,
  l.Country,
  l.PostalCode
FROM superstore.fcFactShipping f
JOIN superstore.fcDimCustomer c ON f.CustomerID = c.CustomerID
JOIN superstore.fcDimProduct p ON f.ProductID = p.ProductID
JOIN superstore.fcDimShipping s ON f.ShipMode = s.ShipMode
JOIN superstore.fcDimLocation l ON f.LocationID = l.LocationID
LIMIT 10;
