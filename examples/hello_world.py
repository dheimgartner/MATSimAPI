#!/usr/bin/env python
"""
Example hello world
"""
import requests
from MATSimAPI.consume import RApiConsumer

PORT = 8000

url = f"http://localhost:{PORT}/echo?msg=hello world"

with RApiConsumer(port=PORT):
    response = requests.get(url)
    if response.status_code == 200:
        result = response.json()
        print(result)
    else:
        print(f"Request failed with status code: {response.status_code}")