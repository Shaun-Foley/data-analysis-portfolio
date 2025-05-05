# Pokémon Strength Analysis

This project analyses Pokémon attributes to identify the strongest Pokémon and best team match-ups. I have always been interested in Pokemon as a game and series so I was interested in exploring which pokemon matchups worked best, stat trends across generations, and assess type effectiveness using a comprehensive dataset. The process involves data cleaning, database integration, and interactive visualisations in Power BI and Metabase. I share this project here as an example of work. The project demonstrates proficiency in data cleaning, SQL querying, DAX for dynamic visualisations, and dashboard creation.

## Objective
Uncover insights into Pokémon performance by:
- Ranking Pokémon by total base stats (excluding legendaries for balanced teams).
- Analysing average stats across generations and types.
- Visualising key metrics like attack, defense, health, and total points.

## Tools
- **Python**: Pandas for data cleaning (Jupyter Notebook).
- **MySQL**: Database for structured queries.
- **Metabase**: SQL-based dashboards and exploratory analysis (docker hosted).
- **Power BI**: Interactive visualisations with DAX measures.
- **Kaggle**: Source of the Pokémon dataset.

## Data
The dataset, sourced from [Kaggle](https://www.kaggle.com/datasets/mariotormo/complete-pokemon-dataset-updated-090420), contains 1045 Pokémon with attributes like total points, HP, attack, defense, types, and generation. A cleaned version (`cleaned_pokedex.csv`) is included in the `data/` folder.

## Process
1. **Data Acquisition**: Downloaded the Pokémon dataset from Kaggle (`pokedex.csv`).
2. **Data Cleaning** (`pokemon_cleaning.ipynb`):
   - Renamed columns (e.g., `Unnamed: 0` to `id`).
   - Dropped irrelevant columns (e.g., `german_name`, `japanese_name`, `egg_type`).
   - Cleaned `species` column by removing "Pokémon" suffix.
   - Handled missing values in `type_2`, `ability_1`, `ability_2`, and `ability_hidden` by filling with "None".
   - Exported cleaned data to `cleaned_pokedex.csv`.
3. **Database Setup** (`Create_Pokemon_Table.sql`):
   - Created a MySQL table (`pokemon`) in the `metabase_db` database to store the cleaned dataset.
   - Defined columns for stats, types, and type effectiveness (e.g., `against_normal`, `against_fire`).
4. **SQL Analysis** (`MetabaseSQL.sql`):
   - Wrote queries in Metabase to explore:
     - Top 10 Pokémon by total points (overall and non-legendary).
     - Fastest Pokémon by speed.
     - Average stats by type and generation.
     - Legendary Pokémon count per generation.
     - Type diversity across generations.
5. **Power BI Visualisations** (`Dax-DynamicYAxisTitle.txt`, `Dax-SelectedStatAverage.txt`, `PokemonBI.pdf`):
   - Connected MySQL to Power BI for interactive dashboards.
   - Created DAX measures to dynamically calculate average stats (e.g., total points, HP, attack) and update chart titles based on user selections.
   - Visualised top Pokémon and stat trends (see `images/PokemonBI.pdf`).
6. **Metabase Dashboards** (`PokemonMetabase.pdf`):
   - Built dashboards to display query results, such as top Pokémon by total points with type and status details.

## Folder Structure
```
pokemon-analysis/
├── data/
│   └── cleaned_pokedex.csv
├── images/
│   └── PokemonBI.pdf
|   └── PokemonMetabase.pdf
├── scripts/
│   ├── pokemon_cleaning.ipynb
│   ├── Create_Pokemon_Table.sql
│   ├── MetabaseSQL.sql
│   ├── Dax-DynamicYAxisTitle.txt
│   └── Dax-SelectedStatAverage.txt
└── README.md
```

## Setup
1. **Dependencies**:
   - Python: Install requirements e.g. Jupyter Notebook, Pandas (`pip install pandas`). 
   - MySQL: Set up a local server and create a database for querying and storing data.
   - Power BI Desktop and Metabase for visualisations.
2. **Database**:
   - Run `Create_Pokemon_Table.sql` to create the `pokemon` table.
   - Import `cleaned_pokedex.csv` into MySQL.
3. **Analysis**:
   - Open `pokemon_cleaning.ipynb` in Jupyter to review cleaning steps.
   - Connect MySQL to your software of choice. I used Metabase and PowerBI.
   - Use `MetabaseSQL.sql` queries in Metabase for exploration.
   - Load DAX measures (`Dax-DynamicYAxisTitle.txt`, `Dax-SelectedStatAverage.txt`) in Power BI and connect to MySQL for visualisations.
   - Metabase:
      - Which Pokémon have the highest total base stats? (filtered out legendary)
      - Which Pokémon excel in specific stats (e.g., fastest)?
      - Which types produce the strongest Pokémon on average?
      - How do average stats change across generations?
      - Which generation has the most legendary Pokémon?
      - Are newer generations more diverse in types?
   - PowerBI
      - Top 10 Pokemon by Total Points (filter)
      - Stat's (filter: attack, defense, HP, and Total Points) accross generations
      - Attack vs Health points
      - Top 6 Non-Legendary Team (filterable by species type)

## Results
- **Top Pokémon**: Arceus (720 points, Mythical) leads the non-legendary in Mythical, while Slaking (670 points, Normal) tops non-legendary (when ignoring Mega evolutions) Pokémon (see `PokemonMetabase.pdf`).
- **Top Team**: The top 6 team was a mix of Dragon, Water, Steel, and Rock (based on sum of total_points). This team focused on non-legendary pokemon: Ash-Greninja, Mega-Garchomp, Mega Gyradados, Mega Metagross, Mega Salamence, and Mega Tyranitar. 
- **Stat Trends**: Dragon types have the highest average total points (see `MetabaseSQL.sql` and `PokemonMetabase.pdf`).
- **Visualisations**: Power BI dashboards allow dynamic stat comparisons (e.g., HP vs. Attack) across generations (see `PokemonBI.pdf`).

## Insights
- Non-legendary Pokémon like Mega Garchomp and Mega Metagross are viable for competitive teams due to high total points (700).

## Future Work
- Add predictive modeling to estimate Pokémon performance in battles.
- Incorporate additional datasets (e.g., move sets) for deeper analysis.