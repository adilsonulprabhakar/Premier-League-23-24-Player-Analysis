
# Football Attacking Performance Analysis

## Project Brief

This project provides an in-depth analysis of football players' attacking performances, focusing on key metrics such as goal-scoring efficiency, shot accuracy, big chances created, assists, and dribbling impact. Through a series of SQL queries, the project explores how different players and teams contribute to attacking play and evaluates the effectiveness of their offensive actions.

The analysis investigates multiple aspects of attacking play, including:
- **Shot Accuracy and Conversion Rates**: How accurate are players' shots, and do higher accuracy rates correlate with better goal conversion?
- **Efficiency in Goal Scoring**: Identifying players who score most efficiently, such as those who score many goals in limited minutes.
- **Big Chances Missed**: Examining players who miss the most significant scoring opportunities and how it impacts their overall goal tally.
- **Dribbling and Goal Creation**: Analyzing the connection between dribbling success and goal-scoring, highlighting players who create their own scoring opportunities.

The results offer valuable insights for coaches, analysts, and fans interested in understanding player strengths and weaknesses in the attacking phase of the game.

## DataSet Used : https://www.kaggle.com/datasets/whisperingkahuna/premier-league-2324-team-and-player-insights

--

### Questions for Goal Scoring & Attacking Efficiency

#### 1. **Comparing Goal Scoring Efficiency**
   - **Who are the top players in terms of goal conversion rate?** (i.e., which players score the most often relative to their total shots taken?)
   - **Who scores the most goals per 90 minutes?** Are there any "super-subs" who have high goals per 90 despite limited playing time?
   - **What is the average time (minutes) between each goal scored for top scorers?**

#### 2. **Expected vs Actual Goals**
   - **Which players consistently outperform their expected goals (xG)?** (indicating they’re either exceptionally clinical or perhaps lucky in front of goal)
   - **Who are the players underperforming relative to their xG?** (suggesting they may be wasteful or unlucky)
   - **Is there a pattern between players with high xG and their actual goal tally?** Are they in line, or do some players have a significant gap between xG and actual goals?

#### 3. **Shooting Accuracy and Conversion Rates**
   - **Which players have the highest shot accuracy (% of shots on target)?**
   - **Is there a relationship between shot accuracy and conversion rate?** Do players with higher shot accuracy also have higher conversion rates?
   - **How does shot accuracy differ among players with high total shots versus those with fewer attempts?** (Does quantity of attempts impact quality?)

#### 4. **Impact of Big Chances**
   - **Who misses the most "big chances"?** Do these players still score a lot, or do big misses seem to impact their overall performance?
   - **Which players create the most big chances for others, and how many of these result in assists?**
   - **Are there players with high big-chance creation but low assists?** (indicating that their teammates may struggle to convert their chances)

#### 5. **Impact of Penalties**
   - **What proportion of goals for top scorers comes from penalties?** Are certain players overly reliant on penalties for their goal tally?
   - **How does excluding penalty goals affect the ranking of top scorers?** Are there players who score fewer goals overall but excel in open play?

#### 6. **Minutes Played vs Goal Output**
   - **Are there players with low total minutes who still manage high goal outputs?** This could indicate players who make a strong impact in limited time.
   - **Who scores the most goals per minute played?** This might highlight players who are highly efficient even if they don’t play full games.

#### 7. **Assists and Goal-Scoring Partnerships**
   - **Who has the most assists specifically to a high-scoring player?** Are there notable partnerships (e.g., a specific player consistently assisting another)?
   - **Which teams have multiple high scorers or goal contributors?** Do teams with several scorers tend to score more or share the goal-scoring load?

#### 8. **Shot Attempts and Shooting Tendencies**
   - **Who takes the most shots per 90 minutes?** Are these players also the top scorers, or do they have lower efficiency?
   - **Are there players who have a high shot volume but lower conversion rate?** (This could suggest players who take many lower-quality shots)
   - **What is the ratio of shots taken inside vs outside the box?** Do players who shoot more from outside the box have lower conversion rates?

#### 9. **Dribble Success and Goal Creation**
   - **Are there players who combine high dribble success with high goal output?** This would highlight players who can create their own shooting opportunities.
   - **Who is most effective at dribbling in the final third and getting a shot on target?**

