use premierChawlaB;

-- 4. 
SELECT matchNum, team1 AS homeTeam, team2 AS awayTeam
FROM premierChawlaB.match
WHERE matchDay = 1 AND fullTimeScoreTeam1 > fullTimeScoreTeam2;

-- 5.
SELECT team, COUNT(name) AS numOfManagers
FROM premierChawlaB.manager
GROUP BY team
HAVING COUNT(name) > 1;

-- 6.
SELECT name, COUNT(team) AS numOfTeams
FROM premierChawlaB.manager
GROUP BY name
HAVING COUNT(team) > 1;

-- 7. 
SELECT em.name, em.team, SUM(fullTimeScoreTeam1) AS noOfGoals
FROM premierChawlaB.manager em
INNER JOIN premierChawlaB.match ema ON ema.team1 = em.team
WHERE em.status = 'Active'
GROUP BY em.name, em.team
ORDER BY noOfGoals DESC;

-- 8.
SELECT em.name, home.homeWins + away.awayWins AS totalWins
FROM premierChawlaB.manager em
JOIN (SELECT ema.team1, COUNT(*) AS homeWins 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2
      GROUP BY ema.team1) AS home ON em.team = home.team1
JOIN (SELECT ema.team2, COUNT(*) AS awayWins 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam2 > ema.fullTimeScoreTeam1
	  GROUP BY ema.team2) AS away ON em.team = away.team2 
WHERE em.status = 'Active' 
ORDER BY totalWins DESC;

-- 9. 
WITH goals_table AS (
SELECT es.venue, SUM(ema.fullTimeScoreTeam1 + ema.fullTimeScoreTeam2) as totalGoals
		FROM premierChawlaB.match ema
		INNER JOIN premierChawlaB.stadium es ON es.team = ema.team1 OR es.team = ema.team2
        GROUP BY es.venue 
)
SELECT goals_table.venue
FROM goals_table
WHERE totalGoals = ( SELECT MAX(totalGoals) FROM goals_table );

-- 10. 
SELECT home.team1, home.homeDraws + away.awayDraws AS drawMatches
FROM  (SELECT ema.team1, COUNT(*) AS homeDraws 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam1 = ema.fullTimeScoreTeam2
      GROUP BY ema.team1) AS home 	
	  JOIN (SELECT ema.team2, COUNT(*) AS awayDraws 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam2 = ema.fullTimeScoreTeam1
	  GROUP BY ema.team2) AS away ON home.team1 = away.team2 
GROUP BY home.team1
ORDER BY drawMatches DESC;

-- 11.
SELECT home.team1, home.homeCleans + away.awayCleans AS cleanMatches
FROM  (SELECT ema.team1, COUNT(*) AS homeCleans 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam2 = 0
      GROUP BY ema.team1) AS home 	
	  JOIN (SELECT ema.team2, COUNT(*) AS awayCleans
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam1 = 0
	  GROUP BY ema.team2) AS away ON home.team1 = away.team2 
GROUP BY home.team1
ORDER BY cleanMatches DESC
LIMIT 5;

-- 12. 
SELECT ema.*
FROM premierChawlaB.match ema
WHERE ema.fullTimeScoreTeam1 >= 3 
	AND ((month(date) = 12 AND dayOfMonth(date) >= 25)
    OR (month(date) = 01 AND dayOfMonth(date) <= 03));

-- 13. 
SELECT ema.*
FROM premierChawlaB.match ema
WHERE (ema.halfTimeScoreTeam1 < ema.halfTimeScoreTeam2 AND ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2) 
	OR (ema.halfTimeScoreTeam1 > ema.halfTimeScoreTeam2 AND ema.fullTimeScoreTeam1 < ema.fullTimeScoreTeam2); 

-- 14. 
SELECT home.team1
FROM (SELECT ema.team1, COUNT(*) AS homeWins 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam1 > ema.fullTimeScoreTeam2
      GROUP BY ema.team1) AS home
	  JOIN (SELECT ema.team2, COUNT(*) AS awayWins 
	  FROM premierChawlaB.match ema 
	  WHERE ema.fullTimeScoreTeam2 > ema.fullTimeScoreTeam1
	  GROUP BY ema.team2) AS away ON home.team1 = away.team2
ORDER BY home.homeWins + away.awayWins DESC
LIMIT 5;

-- 15.
WITH home_goals AS (
	SELECT es.team, AVG(ema.fullTimeScoreTeam1) AS homeGoals, AVG(ema.fullTimeScoreTeam2) AS homeConceded
	FROM premierChawlaB.match ema
	JOIN premierChawlaB.stadium es ON es.team = ema.team1
	GROUP by es.team
),
away_goals AS (
	SELECT es.team, AVG(ema.fullTimeScoreTeam2) AS awayGoals, AVG(ema.fullTimeScoreTeam1) AS awayConceded
	FROM premierChawlaB.match ema
	JOIN premierChawlaB.stadium es ON es.team = ema.team2
	GROUP by es.team
)

SELECT hg.team, hg.homeGoals, hg.homeConceded, ag.awayGoals, ag.awayConceded
FROM home_goals AS hg
JOIN premierChawlaB.stadium AS es ON es.team = hg.team
JOIN away_goals AS ag ON ag.team = es.team
GROUP by hg.team, hg.homeGoals, hg.homeConceded, ag.awayGoals, ag.awayConceded;

