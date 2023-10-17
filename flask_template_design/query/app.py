#https://www.enmu.edu/robots.txt   --> Scraping guidlines via ENMU 
#10/15/2023
# Version 1.0
# Author@ Noah Caulfield
# API for enmu query results 

#TEST Query "Computer Science"
#http://127.0.0.1:5000/search?query=computer+science


#pip install chalice

################################################

from flask import Flask, request, jsonify
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

# Function to scrape search results from https://enmu.edu/
def scrape_enmu(query):
    """
    Scrapes search results from https://enmu.edu/ for a given query.

    Args:
        query (str): The search query.

    Returns:
        list: A list of search results, each containing a title, description, and URL.
              Example: [{'title': 'Result Title', 'description': 'Result Description', 'url': 'Result URL'}, ...]
              Returns None if unable to fetch results.
    """
    base_url = "https://enmu.edu/"
    search_url = f"{base_url}/search"
    params = {"q": query}

    # Define headers to mimic a web browser's user-agent
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
    }

    # Send an HTTP GET request with headers
    response = requests.get(search_url, params=params, headers=headers)

    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')

        # Extract the search results from the specific HTML structure
        results = []
        result_elements = soup.find_all('li')

        for result_element in result_elements:
            title_element = result_element.find('h4')
            description_element = result_element.find('p')
            link_element = result_element.find('a')

            if title_element and description_element and link_element:
                title = title_element.text.strip()
                description = description_element.text.strip()
                url = base_url + link_element['href']
                results.append({'title': title, 'description': description, 'url': url})

        return results
    else:
        return None

@app.route('/search', methods=['GET'])
def search():
    """
    Retrieves search results based on a query and returns them as JSON.

    Example Usage:
    To search for "Computer Science," visit http://127.0.0.1:5000/search?query=computer+science

    Returns:
        JSON: A JSON response containing the search results, each including title, description, and URL.
              Returns an error message if unable to fetch results.
    """
    query = request.args.get('query')

    # Scrape search results from https://enmu.edu/
    results = scrape_enmu(query)

    if results:
        return jsonify(results)  # Return the data as JSON
    else:
        return "Error: Unable to fetch results."

if __name__ == '__main__':
    app.run(debug=True)
