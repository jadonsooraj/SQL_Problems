with all_matches as (
select
    home_team_id as team_id,
    home_team_goals as goals_for,
    away_team_goals as goals_against,
    case
        when home_team_goals > away_team_goals then 3
        when home_team_goals = away_team_goals then 1
        else 0
    end as points
from matches

union all

select
    away_team_id as team_id,
    away_team_goals as goals_for,
    home_team_goals as goals_against,
    case
        when away_team_goals > home_team_goals then 3
        when away_team_goals = home_team_goals then 1
        else 0
    end as points
from matches
)

select 
    t.team_name,
    count(am.team_id) as matches_played,
    sum(am.points) as points,
    sum(am.goals_for) as goal_for,
    sum(am.goals_against) as goal_against,
    sum(am.goals_for) - sum(am.goals_against) as goal_diff
from teams t
left join all_matches am
 on t.team_id = am.team_id
group by t.team_id,1
order by 3 desc, 6 desc, 1