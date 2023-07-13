DELIMITER //
CREATE PROCEDURE sp_Absent(
  IN dateParam DATE,
  IN deptIdParam INT,
  IN semIdParam INT,
  IN yearParam INT
)
BEGIN
  SELECT A.*, S.deptid, S.semester, S.year
  FROM (
    SELECT *
    FROM tblattendance
    GROUP BY regno
    HAVING SUM(CASE WHEN IsAbsent = 1 THEN 1 ELSE 0 END) = 5
  ) AS A
  INNER JOIN tblstudent S ON A.regno = S.regNo
  WHERE A.date = dateParam
    AND S.deptid = deptIdParam
    AND S.semester = semIdParam
    AND S.year = yearParam
  GROUP BY A.regno;
END //
DELIMITER ;



-- Fetch Absent
SELECT A.*
FROM (
SELECT *
FROM tblattendance
GROUP BY regno
HAVING SUM(CASE WHEN IsAbsent = 1 THEN 1 ELSE 0 END) = 5;
) AS A
GROUP BY A.regno;

-- Fetch Present
SELECT P.*
FROM (
SELECT *
FROM tblattendance
GROUP BY regno
HAVING SUM(CASE WHEN IsAbsent = 0 THEN 1 ELSE 0 END) = 5) AS P
GROUP BY P.regno;

-- Fetch P/A
SELECT PA.*
FROM (
SELECT *
FROM tblattendance
WHERE subjectHour IN (1, 2, 3)
  AND isAbsent = 0
  AND regno NOT IN (
    SELECT regno
    FROM tblattendance
    GROUP BY regno
    HAVING SUM(CASE WHEN isAbsent = 0 THEN 1 ELSE 0 END) = 5
  )
  AND regno NOT IN (
    SELECT regno
    FROM tblattendance
    WHERE subjectHour IN (1, 2, 3)
    GROUP BY regno
    HAVING SUM(CASE WHEN isAbsent = 1 THEN 1 ELSE 0 END) >= 1
  );
) AS PA
GROUP BY PA.regno;
-- A/P
SELECT AP.*
FROM (
  SELECT *
  FROM tblattendance
  WHERE subjectHour IN (4, 5)
    AND isAbsent = 0
    AND regno NOT IN (
      SELECT regno
      FROM tblattendance
      GROUP BY regno
      HAVING SUM(CASE WHEN isAbsent = 0 THEN 1 ELSE 0 END) = 5
    )
) AS AP
GROUP BY AP.regno;




