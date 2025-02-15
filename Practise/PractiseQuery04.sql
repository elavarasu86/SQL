Question4:

Write SQL query to find OUT
1. Number of matches "Played" by each team.
2. Number of matches "Won" by each team.
3. Number of matches "Lost" by each team.

CREATE TABLE cricket
  (
     match_no NUMBER,
     team_a   VARCHAR2(30),
     team_b   VARCHAR2(30),
     winner   VARCHAR2(30)
  ); 
  
insert into cricket values(1,'WestIndies','Srilanka','WestIndies');
insert into cricket values(2,'India','Srilanka','India');
insert into cricket values(3,'Australia','Srilanka','Australia');
insert into cricket values(4,'WestIndies','Srilanka','Srilanka');
insert into cricket values(5,'Australia','India','Australia');
insert into cricket values(6,'WestIndies','Srilanka','WestIndies');
insert into cricket values(7,'India','WestIndies','WestIndies');
insert into cricket values(8,'WestIndies','Australia','Australia');
insert into cricket values(9,'WestIndies','India','India');
insert into cricket values(10,'Australia','WestIndies','WestIndies');
insert into cricket values(11,'WestIndies','Srilanka','WestIndies');
insert into cricket values(12,'India','Australia','India');
insert into cricket values(13,'Srilanka','Newzealand','Srilanka');
insert into cricket values(14,'Newzealand','India','India');



WITH matches_played
     AS (SELECT team_name,
                Count(*) cnt
         FROM   (SELECT team_a team_name
                 FROM   cricket
                 UNION ALL
                 SELECT team_b
                 FROM   cricket)
         GROUP  BY team_name),
     matches_won
     AS (SELECT winner,
                Count(*) cnt
         FROM   cricket
         GROUP  BY winner)
SELECT team_name,
       matches_played.cnt                           total_matches,
       Nvl(matches_won.cnt, 0)                      matches_won,
       matches_played.cnt - Nvl(matches_won.cnt, 0) matches_lost
FROM   matches_played
       FULL OUTER JOIN matches_won
                    ON matches_played.team_name = matches_won.winner;
					
					
WITH FUNCTION fn_get_matches_played(p_team_name varchar2)RETURN number IS lv_count number;BEGIN
  SELECT Count(*)
  INTO   lv_count
  FROM   cricket
  WHERE  team_a=p_team_name
  OR     team_b=p_team_name;
  
  RETURN lv_count;
END;FUNCTION fn_get_matches_won(p_team_name varchar2)RETURN number IS lv_count number;BEGIN
  SELECT Count(*)
  INTO   lv_count
  FROM   cricket
  WHERE  winner= p_team_name;
  
  RETURN lv_count;
END;SELECT team_name,
       Fn_get_matches_played(team_name)                                matches_played,
       Fn_get_matches_won(team_name)                                   matches_won,
       Fn_get_matches_played(team_name) -Fn_get_matches_won(team_name) matches_lost
FROM  (
              SELECT team_a team_name
              FROM   cricket
              UNION
              SELECT team_b
              FROM   cricket);