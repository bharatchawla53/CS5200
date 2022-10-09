use sharkdb;

-- 1. 
SELECT DISTINCT name, sid, detections AS sightings
FROM shark
ORDER BY sightings DESC; 

-- 2. 
SELECT bayside, SUM(detections) AS totalDetections
FROM receiver
GROUP BY bayside
ORDER BY SUM(detections) DESC; 

-- 3. 
SELECT r.area, t.town, t.state, r.detections
FROM receiver r
JOIN township t on t.tid = r.location
WHERE r.detections IN (SELECT max(detections) FROM receiver)
ORDER BY r.detections DESC;

-- 4.
CREATE TABLE bayside_encounters AS 
SELECT *
FROM receiver
WHERE bayside IS NOT NULL; 

-- 5. 
SELECT *
FROM shark s
JOIN attack a on a.shark = s.sid;

-- 6.
SELECT r.bayside, r.area
FROM receiver r
JOIN bay b on b.name = r.bayside
GROUP BY r.bayside, r.area;

-- 7. 
SELECT name 
FROM shark
WHERE length = (SELECT MAX(length) FROM shark);

-- 8.
SELECT t.town, t.state, SUM(r.detections) AS totalSightings
FROM township t 
JOIN receiver r on r.location = t.tid
GROUP BY t.town, t.state
ORDER BY t.town;

-- 9.
SELECT *
FROM shark
WHERE sex = 'Female' AND length < 8
ORDER BY length;

-- 10. TODO
SELECT s.sponsor_name, count(rid) AS NoOfReceivers
FROM sponsor s 
RIGHT JOIN receiver r on s.sponsor_name = r.sponsor
GROUP BY s.sponsor_name;

-- 11.
SELECT r.sponsor, count(individual_sharks_detected) AS NoOfDetections
FROM receiver r
LEFT JOIN sponsor s on s.sponsor_name = r.sponsor 
GROUP BY sponsor
ORDER BY NoOfDetections DESC;

-- 12. 
SELECT s.name, a.fatal, a.description, a.date, a.activity, t.town, t.state, v.name, v.age
FROM attack a 
JOIN township t on t.tid = a.location 
JOIN victim v on v.vid = a.victim
JOIN shark s on s.sid = a.shark;

-- 13. 
SELECT r.deployed, t.town, t.state
FROM receiver r 
JOIN township t on t.tid = r.location
WHERE deployed in (SELECT min(deployed) FROM receiver);

-- 14. 
SELECT COUNT(r.rid) AS num_receivers, t.town
FROM receiver r
RIGHT JOIN township t on t.tid = r.location
GROUP BY t.town
ORDER BY num_receivers DESC;

-- 15. 
SELECT t.town, t.state
FROM township t
WHERE NOT EXISTS(SELECT * FROM receiver r WHERE t.tid = r.location ) AND NOT EXISTS(SELECT * FROM attack a WHERE t.tid = a.location )
