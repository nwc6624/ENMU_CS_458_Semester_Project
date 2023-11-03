
#https://www.enmu.edu/robots.txt   --> Scraping guidlines via ENMU 
#10/31/2023
# Version 1.2
# Author@ Noah Caulfield
# API for enmu query results 

#TEST Query "Computer Science"
#http://127.0.0.1:5000/search?query=computer+science

#http://127.0.0.1:5000/search?query=pdfmap     (Template for retrieving campus .pdf)


#pip install chalice

################################################
# pip install chalice flask requests BeautifulSoup4
from flask import Flask, request, jsonify, Response
import requests
from bs4 import BeautifulSoup

app = Flask(__name__)

BASE_URL = "https://enmu.edu/"

def fetch_web_content(url, params=None):
    HEADERS = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"
    }

    try:
        response = requests.get(url, params=params, headers=HEADERS)

        if response.status_code == 200:
            return response.content

    except requests.RequestException:
        pass

    return None

def scrape_enmu(query):
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
    query = request.args.get('query')

    if not query:
        return "Error: No query parameter provided."

    # Check for "pdfmap" query
    if query.lower() == "pdfmap":
        map_pdf_url = "https://www.enmu.edu/images/admissions/campus-map-southeast-of-us70.pdf"
        pdf_content = fetch_web_content(map_pdf_url)

        if pdf_content:
            return Response(pdf_content, content_type='application/pdf')
        else:
            return "Error: Unable to fetch the campus map."

    results = scrape_enmu(query)

    if results:
        # Limit the results to top 5
        limited_results = results[:5]
        return jsonify(limited_results)
    else:
        return "Error: Unable to fetch results."

if __name__ == '__main__':
    app.run(debug=True)
