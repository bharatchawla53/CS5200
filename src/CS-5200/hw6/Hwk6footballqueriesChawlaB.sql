use EPL;

-- 4. 
SELECT matchNum, team1 AS homeTeam, team2 AS awayTeam
FROM EPL.match
WHERE matchDay = 1 AND fullTimeScoreTeam1 > fullTimeScoreTeam2;

-- 5.
SELECT team, COUNT(name) AS numOfManagers
FROM EPL.manager
GROUP BY team
HAVING COUNT(name) > 1;

-- 6.
SELECT name, COUNT(team) AS numOfTeams
FROM EPL.manager
GROUP BY name
HAVING COUNT(team) > 1;

-- 7. 
SELECT em.name, em.team, SUM(fullTimeScoreTeam1) AS noOfGoals
FROM EPL.manager em
INNER JOIN EPL.stadium es ON es.team = em.team
INNER JOIN EPL.match ema ON ema.team1 = es.team
WHERE em.status = 'Active'
GROUP BY em.name, em.team
ORDER BY noOfGoals DESC;

-- 8.
SELECT em.name, COUNT(ema.matchNum) AS totalMatches
FROM EPL.manager em
JOIN EPL.match ema ON ema.team1 = em.team OR ema.team2 = em.team
WHERE em.status = 'Active' AND ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2 OR ema.fullTimeScoreTeam2 > ema.fullTimeScoreTeam1
GROUP BY em.name
ORDER BY totalMatches DESC;

-- 9. 
WITH goals_table AS (
SELECT es.venue, SUM(ema.fullTimeScoreTeam1 + ema.fullTimeScoreTeam2) as totalGoals
		FROM EPL.match ema
		INNER JOIN EPL.stadium es ON es.team = ema.team1 OR es.team = ema.team2
        GROUP BY es.venue 
)
SELECT goals_table.venue
FROM goals_table
WHERE totalGoals = ( SELECT MAX(totalGoals) FROM goals_table );

-- 10. 
SELECT es.team, count(ema.matchNum) AS drawMatches
FROM EPL.match ema
JOIN EPL.stadium es ON es.team = ema.team1 OR es.team = ema.team2
WHERE ema.fullTimeScoreTeam1 = 0 AND ema.fullTimeScoreTeam2 = 0
GROUP BY es.team
ORDER BY drawMatches DESC;

-- 11.
SELECT es.team, COUNT(ema.matchNum) AS totalCleanSheets
FROM EPL.stadium es
JOIN EPL.match ema ON ema.team1 = es.team OR ema.team2 = es.team
WHERE (ema.fullTimeScoreTeam1 > 0 AND ema.fullTimeScoreTeam2 = 0) OR (ema.fullTimeScoreTeam1 = 0 AND ema.fullTimeScoreTeam2 > 0)
GROUP BY es.team
ORDER BY totalCleanSheets DESC
LIMIT 5;

-- 12. 
SELECT ema.*
FROM EPL.match ema
JOIN EPL.stadium es ON es.team = ema.team1
WHERE ema.fullTimeScoreTeam1 > 3 AND ema.date BETWEEN '2017-12-25' AND '2018-01-03';

-- 13. 
SELECT ema.*
FROM EPL.match ema
WHERE (ema.halfTimeScoreTeam1 < ema.halfTimeScoreTeam2 AND ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2) 
	OR (ema.halfTimeScoreTeam1 > ema.halfTimeScoreTeam2 AND ema.fullTimeScoreTeam1 < ema.fullTimeScoreTeam2); 

-- 14. 
SELECT es.team, COUNT(ema.matchNum) AS wins
FROM EPL.stadium es
JOIN EPL.match ema ON ema.team1 = es.team OR ema.team2 = es.team
WHERE (ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2) OR (ema.fullTimeScoreTeam2 > ema.fullTimeScoreTeam1)
GROUP BY es.team
ORDER BY wins DESC
LIMIT 5;

-- 15. TODO
WITH home_goals AS (
	SELECT es.team, SUM(ema.fullTimeScoreTeam1) as goals
	FROM EPL.match ema
	JOIN EPL.stadium es ON es.team = ema.team1
	GROUP by es.team
),
away_goals AS (
	SELECT es.team, SUM(ema.fullTimeScoreTeam2) as goals
	FROM EPL.match ema
	JOIN EPL.stadium es ON es.team = ema.team2
	GROUP by es.team
)

SELECT hg.team, AVG(hg.goals), ag.team, AVG(ag.goals)
FROM home_goals hg, away_goals ag
JOIN EPL.stadium es ON es.team = hg.team AND es.team = ag.team
GROUP BY hg.team, ag.team


