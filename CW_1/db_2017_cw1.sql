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
SELECT DISTINCT name
FROM person AS mothers
WHERE NOT EXISTS (SELECT gender
                  FROM person
                  EXCEPT
                  SELECT gender
                  FROM person
                  WHERE person.mother = mothers.name)
ORDER BY name
;
/*
-- Q4 returns (name,father,mother)
SELECT name, father, mother
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY name, father, mother
ORDER BY father, mother
;

SELECT name, father, mother
FROM person
WHERE dob, father, mother IN
                  (SELECT DISTINCT MIN(dob), father, mother
                   FROM person
                   WHERE father IS NOT NULL
                   AND mother IS NOT NULL
                   GROUP BY father, mother) AS eldest
*/
;


-- Q5 returns (name,popularity)
/*
SELECT SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' '))) AS name,
       COUNT(name) AS popularity
FROM person
GROUP BY SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' ')))
HAVING COUNT(name) > 1
ORDER BY popularity DESC
;*/

SELECT SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' '))) AS name,
       RANK() OVER (ORDER BY COUNT(name) DESC) AS popularity
FROM person
GROUP BY SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' ')))
HAVING COUNT(name) > 1
;

-- Q6 returns (name,forties,fifties,sixties)
SELECT name,
       COUNT(CASE WHEN date_part('year', dob)='1940' THEN name ELSE NULL END) AS forties,
       COUNT(CASE WHEN date_part('year', dob)='1950' THEN name ELSE NULL END) AS fifties,
       COUNT(CASE WHEN date_part('year', dob)='1960' THEN name ELSE NULL END) AS sixties
FROM person
GROUP BY name
ORDER BY name

;


-- Q7 returns (father,mother,child,born)

;

-- Q8 returns (father,mother,male)

;
