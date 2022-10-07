use sharkdb;

-- 1. 
SELECT name, sid, detections AS sightings
FROM shark; 

-- 2. 
SELECT bayside, SUM(detections) AS totalDetections
FROM receiver
GROUP BY bayside
ORDER BY SUM(detections) DESC; 

-- 3. 
SELECT area, town, state, detections
FROM receiver
JOIN township on tid = location
ORDER BY detections DESC;

-- 4.
CREATE TABLE bayside_encounters AS 
SELECT *
FROM receiver
WHERE bayside IS NOT NULL; 

-- 5. 
SELECT *
FROM shark
JOIN attack on attack.shark = sid;

-- 6. 


-- 7. 
SELECT name 
FROM shark
WHERE length = (SELECT MAX(length) FROM shark);

-- 8.
SELECT ta.town, ta.state, SUM(r.detections) AS totalSightings
FROM township ta 
JOIN receiver r on r.location = ta.tid
GROUP BY ta.town, ta.state
ORDER BY ta.town;

-- 9.
SELECT *
FROM shark
WHERE sex = 'Female' AND length < 8
ORDER BY length;

-- 10. TODO
SELECT sponsor, count(rid) AS NoOfReceivers
FROM receiver 
JOIN sponsor s on s.sponsor_name = sponsor
GROUP BY sponsor;

-- 11. TOFO
SELECT sponsor, count(individual_sharks_detected)
FROM receiver
GROUP BY sponsor;

-- 12. 
SELECT s.name, a.fatal, a.description, a.date, a.activity, l.town, l.state, v.name, v.age
FROM attack a 
JOIN township l on l.tid = a.location 
JOIN victim v on v.vid = a.victim
JOIN shark s on s.sid = a.shark;

-- 13. 
SELECT min(r.deployed), t.town, t.state
FROM township t
JOIN receiver r on r.location = t.tid
GROUP BY t.town, t.state;

-- 14. 


-- 15. 
SELECT t.town, t.state
FROM township t
JOIN receiver r on r.location = t.tid
JOIN attack a on a.location = t.tid
WHERE r.location IS NULL AND  a.location IS NULL;




