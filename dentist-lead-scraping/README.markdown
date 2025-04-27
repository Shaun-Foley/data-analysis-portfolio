# Dentist Lead Scraping Analysis

This project was used for a client demonstration of lead scraping and analysis. This project scrapes dentist data from Google Maps for Vienna, Berlin, and Zurich, analyses the data, and visualises key metrics in an interactive Power BI dashboard. The goal is to identify potential leads for a dental service by forecasting revenue and mapping dentist distribution. The project demonstrates skills in web scraping, API integration, data consolidation, DAX for forecasting, and interactive visualisation.

## Objective
- Scrape dentist data from Google Maps in Vienna, Berlin, and Zurich.
- Analyse dentist metrics (e.g., total count, ratings, business status).
- Forecast potential revenue from a 10% conversion rate.
- Visualise findings in an interactive dashboard.

## Tools
- **Python**: Web scraping with `requests` and `folium` for map visualisation.
- **Google Maps API**: Data extraction via Places API.
- **Excel**: Data consolidation and preparation.
- **Power BI**: Interactive dashboard with DAX measures.

## Data
The dataset was scraped from Google Maps using a forked repository, covering dentists in Vienna, Berlin, and Zurich. It includes columns: `place_key`, `city`, `name`, `lat`, `lng`, `business_status`, `rating`, `user_ratings_total`. 

## Process
1. **Repository Setup**:
   - Forked [google-maps-grid-search](https://github.com/adriansprk/google-maps-grid-search) to [Shaun-Foley/google-maps-grid-search](https://github.com/Shaun-Foley/google-maps-grid-search).
   - Cloned the repo, set up a virtual environment, and installed dependencies (`requests`, `python-dotenv`, `folium`).
   - Created a `.env` file with `GOOGLE_MAPS_API_KEY`.
2. **API Configuration**:
   - Set up a Google Cloud trial with billing, enabled the Places API, and generated an API key.
3. **Scraping Adjustments**:
   - Modified the script to target dentists in Vienna, Berlin, and Zurich.
   - Used [boundingbox.klokantech.com](https://boundingbox.klokantech.com/) to draw square boundaries around each city for fixed coordinates.
   - Tested the API with a smaller sample (20 results) and verified coverage on [Google My Maps](https://www.google.com/maps/d/u/0/edit?mid=1r3z5ia2FHvyV9GyvZRpeBhU7tVKCsTA&ll=48.21193176390293%2C16.21490009658825&z=10).
   - Noted incomplete `folium` visualisation (half map displayed) but prioritised Google My Maps for validation.
4. **Data Consolidation**:
   - Combined scraped data in Excel, adding a `city` column and keeping relevant columns: `place_key`, `city`, `name`, `lat`, `lng`, `business_status`, `rating`, `user_ratings_total`.
   - Exported as `dentists_german_cities.csv`.
5. **Power BI Analysis**:
   - Imported data into Power BI, mapping `city` as place, `lat` as latitude, and `lng` as longitude.
   - Created DAX measures:
     - `DynamicTitle2.txt`: Dynamic chart titles based on selected cities.
     - `ProportionTempClosed.txt`: Calculated the proportion of temporarily closed dentists.
     - `ForecastedRevenue.txt`: Forecasted revenue assuming a 10% conversion rate, with 70% subscribing to a 129-unit plan and 30% to a 199-unit plan.
   - Built an interactive dashboard (`dentists_visualisation_total.pdf`, `dentists_visualisation_zurich.pdf`, `dentists_visualisation_vienna.pdf`, `dentists_visualisation_berlin.pdf`) showing:
     - Total dentists, average rating, temporarily closed count, and user ratings.
     - Dentist distribution by city and a map of locations.
     - Revenue forecast per city.

## Folder Structure
```
dentist-lead-scraping/
├── scripts/
│   ├── Dax-DynamicTitle2.txt
│   ├── Dax-ProportionTempClosed.txt
│   └── Dax-ForecastedRevenue.txt
├── documentation/
│   ├── dentists_visualisation_zurich.pdf
│   ├── dentists_visualisation_vienna.pdf
│   └── dentists_visualisation_berlin.pdf
└── README.md
```

## Setup
1. **Dependencies**:
   - Python: Install `requests`, `python-dotenv`, `folium` (`pip install requests python-dotenv folium`).
   - Google Maps API key: Set up via Google Cloud and add to `.env`.
   - Power BI Desktop for visualisations.
2. **Scraping**:
   - Clone the forked repo: `git clone https://github.com/Shaun-Foley/google-maps-grid-search`.
   - Run the scraping script with coordinates for Vienna, Berlin, and Zurich.
3. **Analysis**:
   - Combine data in Excel and export as `dentists_german_cities.csv`.
   - Import into Power BI, apply DAX measures (`scripts/`), and recreate the dashboard using the PDFs as a guide.

## Results
- **Total Dentists**: 5394 across all cities (Berlin: 3448, Zurich: 660, Vienna: 1286).
- **Average Rating**: 4.54 overall (Vienna: 4.50, Berlin: 4.54, Zurich: 4.61).
- **Temporarily Closed**: 7 total (Zurich: 2, Vienna: 2, Berlin: 3).
- **Revenue Forecast**: 136K total (Berlin: 51.7K, Zurich: 9.9K, Vienna: 19.2K).
- **Visualisations**: Interactive dashboard shows dentist distribution and metrics by city (`documentation/`).

## Future Work
- Expand scraping to additional cities for broader market analysis.
- Use scraping for market research and other client work.
