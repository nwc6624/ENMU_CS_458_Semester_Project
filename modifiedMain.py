
#https://www.enmu.edu/robots.txt   --> Scraping guidlines via ENMU 
#10/15/2023
# Version 1.1
# Author@ Noah Caulfield
# API for enmu query results 

#TEST Query "Computer Science"
#http://127.0.0.1:5000/search?query=computer+science


#pip install chalice

################################################
# pip install chalice flask requests BeautifulSoup4

from flask import Flask, request, jsonify
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

BASE_URL = "https://enmu.edu/"


def fetch_web_content(url, params=None):
    """
    Fetch content from a given URL.

    Args:
        url (str): The URL to fetch content from.
        params (dict, optional): Parameters to be added to the request.

    Returns:
        str: The response content if successful. None otherwise.
    """
    HEADERS = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
    }

    try:
        response = requests.get(url, params=params, headers=HEADERS)

        if response.status_code == 200:
            return response.text

    except requests.RequestException:
        pass

    return None


def scrape_enmu(query):
    """
    Scrapes search results from https://enmu.edu/ for a given query.

    Args:
        query (str): The search query.

    Returns:
        list: A list of search results. Returns None if unable to fetch results.
    """
    search_url = f"{BASE_URL}/search"
    content = fetch_web_content(search_url, {"q": query})

    if content:
        soup = BeautifulSoup(content, 'html.parser')
        results = []

        for result_element in soup.find_all('li'):
            title_element = result_element.find('h4')
            description_element = result_element.find('p')
            link_element = result_element.find('a')

            if title_element and description_element and link_element:
                title = title_element.text.strip()
                description = description_element.text.strip()
                url = BASE_URL + link_element['href']
                results.append({'title': title, 'description': description, 'url': url})

        return results

    return None


@app.route('/search', methods=['GET'])
def search():
    """
    Retrieves search results based on a query and returns them as JSON.
    """
    query = request.args.get('query')

    if not query:
        return "Error: No query parameter provided."

    results = scrape_enmu(query)

    if results:
        return jsonify(results)
    else:
        return "Error: Unable to fetch results."


if __name__ == '__main__':
    app.run(debug=True)
