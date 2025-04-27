-- Which Pokémon have the highest total base stats?

SELECT name, status, type_1, type_2, total_points FROM pokemon
WHERE status != 'Legendary' AND status != 'Sub Legendary'
ORDER BY total_points DESC
limit 10;

-- Which Pokémon have the highest total base stats?
SELECT name, total_points, status
FROM pokemon
ORDER BY total_points DESC
LIMIT 10;

-- Which Pokémon excel in specific stats (e.g., fastest)?
SELECT name, type_1, speed
FROM pokemon
ORDER BY speed DESC
LIMIT 10;

-- Which types produce the strongest Pokémon on average?
SELECT type_1, AVG(total_points) AS avg_total_points
FROM pokemon
GROUP BY type_1
ORDER BY avg_total_points DESC;

-- How do average stats change across generations?
SELECT generation, 
       AVG(total_points) AS avg_total, 
       AVG(hp) AS avg_hp, 
       AVG(attack) AS avg_attack, 
       AVG(defense) AS avg_defense
FROM pokemon
GROUP BY generation
ORDER BY generation;

-- Which generation has the most legendary Pokémon?
SELECT generation, COUNT(*) AS legendary_count
FROM pokemon
WHERE status = 'Legendary'
GROUP BY generation
ORDER BY legendary_count DESC;

-- Are newer generations more diverse in types?
SELECT generation, 
       COUNT(DISTINCT CONCAT(type_1, '-', COALESCE(type_2, ''))) AS unique_type_combos
FROM pokemon
GROUP BY generation
ORDER BY generation;

