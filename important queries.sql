--I have a table containing the following data. I want to update all nulls in salary columns with previous value without taking null value.
id  name    salary
1   A       4000
2   B   
3   C   
4   C   
5   D       2000
6   E   
7   E   
8   F       1000
9   G       2000
10  G       3000
11  G       5000
12  G   

Solution:

SELECT
  a.*,
  FIRST_VALUE(a.salary)OVER(PARTITION BY a.value ORDER BY a.id) AS abc
FROM (
  SELECT
    *,
    SUM(CASE
        WHEN salary IS NULL THEN 0
        ELSE 1 END)OVER(ORDER BY id) AS value
  FROM
    test)a
	
id  name    salary  Value   abc
1   A       4000    1     4000
2   B               1     4000
3   C               1     4000
4   C               1     4000
5   D       2000    2     2000
6   E               2     2000
7   E               2     2000
8   F       1000    3     1000
9   G       2000    4     2000
10  G       3000    5     3000
11  G       5000    6     5000
12  G               6     5000

-- Delete duplicate and keep only one record either with min id or max id
+----+--------+
| id | name   |
+----+--------+
| 1  | google |
| 2  | yahoo  |
| 3  | msn    |
| 4  | google |
| 5  | google |
| 6  | yahoo  |
+----+--------+

Solution:
If you want to keep the row with the lowest id value:

DELETE n1 FROM names n1, names n2 WHERE n1.id > n2.id AND n1.name = n2.name

If you want to keep the row with the highest id value:

DELETE n1 FROM names n1, names n2 WHERE n1.id < n2.id AND n1.name = n2.name