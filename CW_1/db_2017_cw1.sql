-- Q1 returns (name,dod)
SELECT personb.name, persona.dod
FROM person AS persona
JOIN person AS personb
ON persona.name=personb.mother
AND persona.dod IS NOT NULL
;

-- Q2 returns (name)
SELECT name
FROM person as fathers
WHERE gender='M'
AND name NOT IN (SELECT DISTINCT father
                 FROM person
                 WHERE father IS NOT NULL)
ORDER BY name
;

-- Q3 returns (name)
SELECT DISTINCT mother as name
FROM person AS mothers
WHERE mother IS NOT NULL
ORDER BY mother
;

SELECT COUNT(gender = 'M') as sons,
       COUNT(gender = 'F') as daughters,
       mother as name
FROM person as offspring
WHERE mother IS NOT NULL
GROUP BY mother
ORDER BY name
;

SELECT DISTINCT mother.name
FROM person AS offspring
JOIN person AS mother
ON offspring.mother=mother.name
ORDER BY mother.name

-- Q4 returns (name,father,mother)

;

-- Q5 returns (name,popularity)

;

-- Q6 returns (name,forties,fifties,sixties)

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;
