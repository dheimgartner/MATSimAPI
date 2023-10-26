# MATSimAPI

## Installation + Usage

Make sure to have `R` installed.

```shell
pip install git+ssh://git@github.com/dheimgartner/MATSimAPI.git
```

This comes with a utility CLI.

```shell
MATSimAPI -h       # see available commands
MATSimAPI install  # might take a while...
MATSimAPI start    # start the API (default port 8000)
```

Optionally, you can specify a port `MATSimAPI start --port 8000`

Navigate to the swagger UI e.g. http://localhost:8000/__docs__/

Don't forget to stop the API.

```shell
MATSimAPI stop  # stop the api (if started on different port add --port <port>)
```

The `RApiConsumer` object handler is a wrapper around the API, such that you can consume it directly from python (i.e., the object starts the API automatically in the background and performs clean-up). You can use the object with the `with` keyword as shown in the `examples`.

## Documentation

See the `examples` repository. In particular the `examples/predict.py`. 
In order to understand what variables are required, you can use the `/doc` endpoint.

Further, I have added some example data to the package to illustrate the expected format and test the endpoints...

```python
from MATSimAPI.utils import data, from_df

data_ga = data("ga", pandas=True)
data_ga_ = data("ga", pandas=False)

# Cast a pandas DataFrame to format as expected by API
data_api = from_df(data_ga)
```


## Remarks

The main functionality is coded in `R` and available under `MATSim/Rapi`.
Of course, you can also start an R session and inspect the source aswell as its
documentation `help(package = "MATSimAPI")`.