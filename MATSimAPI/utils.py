import pkg_resources
import json
import pandas as pd
from typing import Union, Literal


Data = Union[dict, pd.DataFrame]


def data(
    data: Literal["ga", "ht", "re", "ca", "cs", "bi", "wfh"], pandas=False
) -> Data:
    """
    Load the MATSimAPI example model data
    """
    md = pkg_resources.resource_string("MATSimAPI", "data/model_data.json")
    md = json.loads(md)
    md = md[data]

    if pandas:
        md = pd.DataFrame(md["data"])

    return md


def from_df(df: pd.DataFrame) -> dict:
    """
    Creates the json data from a pandas.DataFrame as expected by the API
    """
    return {"data": df.to_dict(orient="list")}


if __name__ == "__main__":
    md = data("ga", pandas=True)
    print(md.head())
    print(from_df(md))
