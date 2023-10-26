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

## Documentation

See the `examples` repository. In particular the `examples/predict.py`. 
In order to understand what variables are required, you can use the `/doc` endpoint.


## Remarks

The main functionality is coded in `R` and available under `MATSim/Rapi`.
Of course, you can also start an R session and inspect the source aswell as its
documentation `help(package = "MATSimAPI")`.