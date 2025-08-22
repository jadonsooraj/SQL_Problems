----Table:
-- 1. earning: Movie_id, Domestic, Worldwide
-- 2. genre: movie_id, genre
-- 3. IMDB: Movie_id, Title, Rating, TotalVotes, MetaCritic, Budget, Runtime, CVotes10, CVotes09, CVotes08, CVotes07, CVotes06, CVotes05, CVotes04, CVotes03, CVotes02, CVotes01, CVotesMale, CVotesFemale, CVotesU18, CVotesU18M, CVotesU18F, CVotes1829, CVotes1829M, CVotes1829F, CVotes3044, CVotes3044M, CVotes3044F, CVotes45A, CVotes45AM, CVotes45AF, CVotes1000, CVotesUS, CVotesnUS, VotesM, VotesF, VotesU18, VotesU18M, VotesU18F, Votes1829, Votes1829M, Votes1829F, Votes3044, Votes3044M, Votes3044F, Votes45A, Votes45AM, Votes45AF, VotesIMDB, Votes1000, VotesUS, VotesnUS

--Print the title and ratings of the movies released in 2012 whose metacritic rating is more than 60 and Domestic collections exceed 10 Crores.

select
i.title,
i.rating

from imdb i
join earning e
on i.movie_id =e.movie_id
where i.title like '%2012%'
and i.metacritic >60
and domestic> 100000000