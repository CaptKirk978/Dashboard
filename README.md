# Marion County Incidents Dashboard

This is a web app written in R. It displays the reported "Incidents" for Marion County Indiana over the course of a little over a year currently. The app includes a dashboard that provides a graphical representation of the incidents that have occurred in Marion County.

## Data Source

The data for this dashboard is sourced from http://cityprotect.com/. This website reports incidents from police stations that participate in data sharing. However, the data available for download from this website does not include geographic data. Hence, why a support script was created to scrape the data from this website. This website only keeps incidents for the past year so the script must be ran on a schedule to maintain a complete history of incidents. The data source includes all participating police agencies within Marion County.

## Support Web Scraping Script

The support script was created to scrape the data from the http://cityprotect.com/ website. The support script for scraping this data is also written in R. The script utilizes a modified POST method for retrieving a JSON that encapsulates Marion County in a single response and converts the data into a datatable that can be easily used by the dashboard. The script must be manually ran separate or scheduled to run by the maintainer.

## Dashboard

In short the dashboard provides a geographic representation of the incidents that have occurred in Marion County. It includes the following data and features:

1. **Crime:** This visualization displays not only noteworthy incidents but also reported crime that has occurred in Marion County. 

2. **Incidents:** This visualization displays incidents that have occurred for each day since Sep 2021. Each incident has additional information regarding its type, the date and time, and where it happened.

3. **Date Filtering:** This visualization displays the number of incidents that have occurred on each day since Sep 2021. You are able to pick a custom time frame via the filter at the top right.

4. **Incident Type Filtering:** This visualization displays the types of incidents that have occurred. You are able to use the filters in the sidebar to narrow down Incident types.

5. **Heat Map:** This visualization displays the locations where the incidents have occurred over the selected date frame and groups them together by density. 
