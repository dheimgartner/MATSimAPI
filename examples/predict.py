#!/usr/bin/env python
"""
Example predicting the probability of owning a GA
"""

import requests
from MATSimAPI.consume import RApiConsumer
import MATSimAPI.utils as utils
import pandas as pd


class RApiException(Exception):
    pass


def ga_predictor(data: pd.DataFrame, port=8000) -> pd.DataFrame:
    """
    Wraps the API in a simple to use function
    
    Check out `MATSimAPI start` and then inspect the documentation endpoint `/doc`
    to understand what variables the predictor expects.
    """
    url = f"http://localhost:{port}/predict/ga"
    headers = {"Content-Type": "application/json"}
    
    data = utils.from_df(data) # use helper to cast to json-like format as expected by API

    with RApiConsumer(port=port):
        response = requests.post(url, json=data, headers=headers)

        if response.status_code == 200:
            result = response.json()
            return pd.DataFrame(result)
        else:
            raise RApiException(f"Request failed with status code: {response.status_code}")
            
            
if __name__ == "__main__":
    data = utils.data("ga", pandas=True)
    try:
        probs = ga_predictor(data)
    except RApiException as e:
        print(e)
    df = pd.concat([probs, data], axis=1)
    print(df)