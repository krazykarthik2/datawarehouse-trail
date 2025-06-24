SELECT
  f.RowID,
  f.OrderID,
  f.OrderDate,
  f.ShipDate,
  f.Sales,
  f.Quantity,
  f.Discount,
  f.Profit,

  c.CustomerID,
  c.CustomerName,
  c.Segment,

  p.ProductID,
  p.ProductName,
  p.Category,
  p.SubCategory,

  s.ShipMode,

  l.Country,
  l.City,
  l.State,
  l.PostalCode,
  l.Region

FROM superstore.StarFactSales f
JOIN superstore.StarDimCustomer c ON f.CustomerID = c.CustomerID
JOIN superstore.StarDimProduct p ON f.ProductID = p.ProductID
JOIN superstore.StarDimShipping s ON f.ShipMode = s.ShipMode
JOIN superstore.StarDimLocation l ON f.LocationID = l.LocationID

ORDER BY f.OrderDate
LIMIT 10;
