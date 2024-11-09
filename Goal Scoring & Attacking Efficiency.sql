-- Questions for Goal Scoring & Attacking Efficiency
-- 1. Comparing Goal Scoring Efficiency
-- Who are the top players in terms of goal conversion rate? (i.e., which players score the most often relative to their total shots taken?)
SELECT t1.*
	,t2.Goals
	,t2.penalties
FROM player_total_scoring_attempts t1
LEFT JOIN player_top_scorers t2 ON t1.player = t2.player
	AND t1.team = t2.team
ORDER BY Shot_Conversion_Rate DESC limit 10;

-- Who scores the most goals per 90 minutes? Are there any "super-subs" who have high goals per 90 despite limited playing time?
SELECT *
	,Matches * 90 AS total_match_time
FROM player_goals_per_90
ORDER BY Goals_per_90 DESC;

SELECT *
	,Matches * 90 AS total_match_time
FROM player_goals_per_90
ORDER BY minutes ASC
	,Goals_per_90 DESC
	,total_match_time DESC;-- super_subs

-- 2. Expected vs Actual Goals
-- Which players consistently outperform their expected goals (xG)? (indicating they’re either exceptionally clinical or perhaps lucky in front of goal)
SELECT *
	,actual_goals - expected_goals_xg AS Goal_diff
FROM player_expected_goals
WHERE expected_goals_xg < actual_goals
ORDER BY Goal_diff DESC;

-- Who are the players underperforming relative to their xG? (suggesting they may be wasteful or unlucky)
SELECT *
	,expected_goals_xg - actual_goals AS Goals_behind
FROM player_expected_goals
WHERE expected_goals_xg > actual_goals
ORDER BY goals_behind DESC;

-- Is there a pattern between players with high xG and their actual goal tally? Are they in line, or do some players have a significant gap between xG and actual goals?
SELECT *
	,expected_goals_xg - actual_goals AS Goals_behind
FROM player_expected_goals
WHERE expected_goals_xg > 15
ORDER BY goals_behind DESC;

-- 3. Shooting Accuracy and Conversion Rates
-- Which players have the highest shot accuracy (% of shots on target)?
WITH shot_stats
AS (
	SELECT t1.player
		,t1.team
		,t1.Shots_per_90
		,t2.shots_on_target_per_90
		,t1.Country
	FROM player_total_scoring_attempts t1
	LEFT JOIN player_on_target_scoring_attempts t2 ON t1.player = t2.player
		AND t1.team = t2.team
	)
SELECT *
	,ROUND(CASE 
			WHEN Shots_per_90 > 0
				THEN (shots_on_target_per_90 / Shots_per_90) * 100
			ELSE 0
			END, 2) AS shots_on_target_perct
FROM shot_stats
WHERE Shots_per_90 > 1 -- Considering players with at least 1 shot per 90
ORDER BY shots_on_target_perct DESC;

-- Is there a relationship between shot accuracy and conversion rate? Do players with higher shot accuracy also have higher conversion rates?
SELECT t1.player
	,t1.team
	,t1.shot_conversion_rate
	,t2.shot_accuracy
FROM player_total_scoring_attempts t1
LEFT JOIN player_on_target_scoring_attempts t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE t1.shot_conversion_rate > 0
	AND t2.shot_accuracy > 0
ORDER BY Shot_Accuracy DESC;

-- How does shot accuracy differ among players with high total shots versus those with fewer attempts? (Does quantity of attempts impact quality?)
SELECT t1.player
	,t1.team
	,t1.Shots_per_90
	,t2.Shot_Accuracy
FROM player_total_scoring_attempts t1
LEFT JOIN player_on_target_scoring_attempts t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE t1.Shots_per_90 IS NOT NULL
	AND t2.Shot_Accuracy IS NOT NULL
ORDER BY Shots_per_90 ASC;-- order by asc to find players with fewer shots

-- 4. Impact of Big Chances
-- Who misses the most "big chances"? Do these players still score a lot, or do big misses seem to impact their overall performance?
SELECT t1.player
	,t1.team
	,t1.Big_Chances_Missed
	,t3.expected_goals_xg
	,t2.goals
	,t2.goals - t3.expected_goals_xg AS Goal_diff
	,ROUND((t2.Goals / t3.Expected_Goals_xG), 2) AS Goal_to_xG_Ratio
	,-- Added to see the player's goal conversion efficiency
	ROUND((t1.Big_Chances_Missed / t2.Goals), 2) AS Missed_Chances_per_Goal -- Added to show how many big chances are missed per goal scored 
FROM player_big_chances_missed t1
LEFT JOIN player_top_scorers t2 ON t1.player = t2.player
	AND t1.team = t2.team
INNER JOIN player_expected_goals t3 ON t1.player = t3.player
	AND t1.team = t3.team
WHERE t1.rank < 10;-- Goal_to_xG_Ratio: >1 indicate overperformaer <1 indicate under performer
	-- Missed_Chances_per_Goal: higher value means player missing lot of chances compared to goals scored

-- Which players create the most big chances for others, and how many of these result in assists?
SELECT t1.player
	,t1.team
	,t1.big_chances_created
	,t2.assists
	,t2.secondary_assists
	,t2.Assists + t2.Secondary_Assists AS total_impact
	,round(((t2.assists + t2.secondary_assists) / t1.Big_Chances_Created) * 100, 2) AS Conversion_Rate_percent
FROM player_big_chances_created t1
LEFT JOIN player_top_assists t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE t1.Big_Chances_Created > 0
ORDER BY t1.Big_Chances_Created DESC;

-- Are there players with high big-chance creation but low assists? (indicating that their teammates may struggle to convert their chances)
SELECT t1.player
	,t1.team
	,t1.big_chances_created
	,t2.assists
	,t2.secondary_assists
	,t2.Assists + t2.Secondary_Assists AS total_impact
	,round(((t2.assists + t2.secondary_assists) / t1.Big_Chances_Created) * 100, 2) AS Conversion_Rate_percent
FROM player_big_chances_created t1
LEFT JOIN player_top_assists t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE t1.Big_Chances_Created > 10
ORDER BY Conversion_rate_percent ASC;

-- 5. Impact of Penalties
-- What proportion of goals for top scorers comes from penalties? Are certain players overly reliant on penalties for their goal tally?
SELECT player
	,team
	,goals
	,penalties
	,round((penalties / goals) * 100, 2) AS penalty_perct
FROM player_top_scorers
ORDER BY penalty_perct DESC;

-- How does excluding penalty goals affect the ranking of top scorers? Are there players who score fewer goals overall but excel in open play?
SELECT player
	,team
	,`rank` AS old_rank
	,goals
	,penalties
	,goals - penalties AS Open_play_goals
	,rank() OVER (
		ORDER BY goals - penalties DESC
		) AS new_rank
FROM player_top_scorers
ORDER BY old_rank;

-- players who score fewer goals overall but excel in open play
WITH new_ranks
AS (
	SELECT player
		,team
		,`rank` AS old_rank
		,goals
		,penalties
		,goals - penalties AS Open_play_goals
		,rank() OVER (
			ORDER BY goals - penalties DESC
			) AS new_rank
	FROM player_top_scorers
	ORDER BY old_rank
	)
SELECT *
FROM new_ranks
WHERE goals = open_play_goals
ORDER BY old_rank;-- Identifying players who excel in open play (all goals from open play, no penalties)

-- 6. Minutes Played vs Goal Output
-- Are there players with low total minutes who still manage high goal outputs? This could indicate players who make a strong impact in limited time.
WITH player_playtime
AS (
	SELECT player
		,team
		,goals
		,minutes
		,round((Goals / nullif(minutes, 0)) * 100, 2) AS Goals_per_min
		,CASE 
			WHEN minutes BETWEEN 1
					AND 1000
				THEN 'Low_Playtime'
			WHEN minutes BETWEEN 1000
					AND 2000
				THEN 'Moderate_Playtime'
			ELSE 'High_Playtime'
			END AS playtime
	FROM player_top_scorers
	WHERE goals >= 3 -- Focus on players with at least 3 goals
	)
SELECT player
	,team
	,playtime
	,goals
	,minutes
	,Goals_per_min
	,row_number() OVER (
		PARTITION BY playtime ORDER BY Goals_per_min DESC
		) AS ranks
FROM player_playtime
WHERE playtime = 'Low_Playtime'
	AND goals > 0
ORDER BY ranks;

-- Who scores the most goals per minute played? This might highlight players who are highly efficient even if they don’t play full games.
SELECT player
	,team
	,goals
	,minutes
	,round((goals / minutes) * 100, 2) AS goals_per_min
	,CASE 
		WHEN minutes BETWEEN 1
				AND 1000
			THEN 'Low_Playtime'
		WHEN minutes BETWEEN 1000
				AND 2000
			THEN 'Moderate_Playtime'
		ELSE 'High_Playtime'
		END AS playtime
FROM player_top_scorers
WHERE goals > 3
ORDER BY goals_per_min DESC;

-- 7. Assists and Goal-Scoring Partnerships
-- Who has the most assists specifically to a high-scoring player? Are there notable partnerships (e.g., a specific player consistently assisting another)?
-- Which teams have multiple high scorers or goal contributors? Do teams with several scorers tend to score more or share the goal-scoring load?
WITH goal_contribution
AS (
	SELECT team
		,count(Player) AS NoOf_Goal_Contributers
		,sum(goals) AS total_goal_contribution
	FROM player_top_scorers
	WHERE goals > 10 -- Threshold for high scorers
	GROUP BY team
	)
	,assist_contribution
AS (
	SELECT team
		,count(Player) AS NoOf_Assists_Contributers
		,sum(Assists) AS total_Assists_contribution
	FROM player_top_assists
	WHERE Assists > 8 -- Threshold for high assist providers
	GROUP BY team
	)
SELECT g.team
	,g.NoOf_Goal_Contributers
	,a.NoOf_Assists_Contributers
	,g.NoOf_Goal_Contributers + a.NoOf_Assists_Contributers AS total_contributers
	,g.total_goal_contribution AS total_goals
	,total_Assists_contribution AS total_assists
	,total_goal_contribution + total_Assists_contribution AS total_contributions
	,ROUND((g.total_goal_contribution / NULLIF(g.total_goal_contribution + a.total_assists_contribution, 0)) * 100, 2) AS goal_contrib_percentage
	,ROUND((a.total_assists_contribution / NULLIF(g.total_goal_contribution + a.total_assists_contribution, 0)) * 100, 2) AS assist_contrib_percentage
FROM goal_contribution g
INNER JOIN assist_contribution a ON g.team = a.team
ORDER BY total_contributers DESC
	,total_contributions DESC;

-- 8. Shot Attempts and Shooting Tendencies
-- Who takes the most shots per 90 minutes? Are these players also the top scorers, or do they have lower efficiency?
SELECT t1.player
	,t1.team
	,t1.shots_per_90
	,t2.goals
	,t2.minutes
	,t2.matches
	,round((t2.Minutes / t2.Matches), 2) AS avg_min_played_per_match
	,round((t2.Goals / nullif(t1.Shots_per_90 * t1.Matches, 0)) * 100, 2) AS Shot_conversion_rate
FROM player_total_scoring_attempts t1
INNER JOIN player_top_scorers t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE t2.Minutes > 450 -- player played atleast 5 matches
ORDER BY Shots_per_90 DESC
	,Shot_conversion_rate DESC;

-- Are there players who have a high shot volume but lower conversion rate? (This could suggest players who take many lower-quality shots)
WITH player_stats
AS (
	SELECT t1.player
		,t1.team
		,t1.shots_per_90
		,t2.goals
		,t2.minutes
		,t2.matches
		,round((t2.Minutes / t2.Matches), 2) AS avg_min_played_per_match
		,round((t2.Goals / nullif(t1.Shots_per_90 * t1.Matches, 0)) * 100, 2) AS Shot_conversion_rate
	FROM player_total_scoring_attempts t1
	INNER JOIN player_top_scorers t2 ON t1.player = t2.player
		AND t1.team = t2.team
	WHERE t2.Minutes > 450 -- player played atleast 5 matches
	ORDER BY Shots_per_90 DESC
		,Shot_conversion_rate DESC
	)
SELECT *
FROM player_stats
WHERE shots_per_90 > 4.0
	AND shot_conversion_rate < 3.0;

-- 9. Dribble Success and Goal Creation
-- Are there players who combine high dribble success with high goal output? This would highlight players who can create their own shooting opportunities.
SELECT t1.player
	,t1.team
	,t1.Successful_Dribbles_per_90
	,t1.Dribble_Success_Rate
	,t2.goals
FROM player_contests_won t1
INNER JOIN player_top_scorers t2 ON t1.player = t2.player
	AND t1.team = t2.team
WHERE Successful_Dribbles_per_90 >= 2.5
	AND goals > 5
ORDER BY t1.Successful_Dribbles_per_90 DESC
	,t2.goals DESC;

-- Who is most effective at dribbling in the final third and getting a shot on target?
SELECT t1.player
	,t1.team
	,t1.Possessions_Won_in_Final_3rd_per_90
	,t2.Shots_on_Target_per_90
FROM player_possessions_won_attacking_third t1
INNER JOIN player_on_target_scoring_attempts t2 ON t1.player = t2.player
	AND t1.team = t2.team
ORDER BY Possessions_Won_in_Final_3rd_per_90 DESC
	,Shots_on_Target_per_90 DESC;
