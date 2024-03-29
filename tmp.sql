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

-- Q4 returns (name,father,mother)

SELECT name, dob, father, mother
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY name, father, mother
ORDER BY father, mother, dob
;

SELECT name, father, mother
FROM person
WHERE dob IN (SELECT DISTINCT MIN(dob)
		      FROM person
		      WHERE father IS NOT NULL
		      AND mother IS NOT NULL
		      GROUP BY father, mother)
AND father IN (SELECT DISTINCT father
			   FROM person
			   WHERE father IS NOT NULL
			   AND mother IS NOT NULL
			   GROUP BY father, mother)
AND mother IN (SELECT DISTINCT mother
			   FROM person
			   WHERE father IS NOT NULL
			   AND mother IS NOT NULL
			   GROUP BY father, mother)			   
;


-- Q5 returns (name,popularity)

SELECT SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' '))) AS name,
       COUNT(name) AS popularity
FROM person
GROUP BY SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' ')))
HAVING COUNT(name) > 1
ORDER BY popularity DESC
;

SELECT SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' '))) AS name,
       RANK() OVER (ORDER BY COUNT(name) DESC) AS popularity
FROM person
GROUP BY SUBSTRING((name || ' ') FROM 1 FOR POSITION(' ' IN (name || ' ')))
HAVING COUNT(name) > 1
;

-- Q6 returns (name,forties,fifties,sixties)
SELECT name,
	   dob,
       COUNT(CASE WHEN date_part('year', dob)='1940' THEN name ELSE NULL END) AS forties,
       COUNT(CASE WHEN date_part('year', dob)='1950' THEN name ELSE NULL END) AS fifties,
       COUNT(CASE WHEN date_part('year', dob)='1960' THEN name ELSE NULL END) AS sixties
FROM person
GROUP BY name
ORDER BY dob
;

-- Q7 returns (father,mother,child,born)
SELECT dob, father, mother, name AS child, COUNT(DISTINCT father) AS born
FROM person
WHERE father IS NOT NULL
AND mother IS NOT NULL
GROUP BY name, father, mother
ORDER BY father, mother, dob
;

-- Q8 returns (father,mother,male)
SELECT father, mother,
	   --COUNT(gender) AS children,
	   --COUNT(CASE WHEN gender='M' THEN name ELSE NULL END) AS sons,
	   (((COUNT(CASE WHEN gender='M' THEN name ELSE NULL END))*100) / (COUNT(gender))) AS male
FROM person as person1
WHERE father IS NOT NULL
--OR mother IS NOT NULL		-- includes single parents
AND mother IS NOT NULL		-- only full couples in database
GROUP BY father, mother
ORDER BY father, mother
;
