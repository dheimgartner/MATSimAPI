Welcome to MATSimAPI's Documentation
====================================

The name is a little misleading. The package basically allows you to predict mobility tool ownership and home office access/frequency.
The models implemented here can be used to enrich a synthetic population in an enviornment characterised by telework...

Installation
------------

Before you begin, ensure that you have `R` installed. To install ``MATSimAPI``, use the following command:

.. code:: console

   pip install git+ssh://git@github.com/dheimgartner/MATSimAPI

``MATSimAPI`` also provides a utility cli. Install the ``R`` package:

.. code:: console

   MATSimAPI install  # this might take a while...

Usage
-----

After installation, you can use the ``MATSimAPI`` cli for various tasks.

  .. code:: console

    # view available commands
    MATSimAPI -h

    # start the API on port 8000 (default port)
    MATSimAPI start --port 8000

Once the API is running, you can access the Swagger UI at http://localhost:8000/__docs__/.

Don't forget to stop the API when you are done:

.. code:: console

   MATSimAPI stop --port 8000

``MATSimAPI`` also offers a Python object handler, the :py:class:`MATSimAPI.consume.RApiConsumer`. This handler allows you to interact with the API directly from Python. It starts the API in the background and performs clean-up when no longer in use. You can use it with the `with` keyword, as shown in the :ref:`examples` section.

Documentation
-------------

For detailed information and usage examples, refer to the following resources:

- :ref:`examples` section (also available in the ``MATSimAPI/examples`` directory).
- To understand the required variables, you can use the ``/doc`` endpoint.
- Example data is included in the package to illustrate the expected format and test the endpoints. You can access this data with Python using the following code:

  .. code:: python

     from MATSimAPI.utils import data, from_df

     # Load data as a pandas DataFrame
     data_ga = data("ga", pandas=True)
     data_ga_ = data("ga", pandas=False)

     # Cast a pandas DataFrame to the format expected by the API
     data_api = from_df(data_ga)

Remarks
-------

The core functionality of ``MATSimAPI`` is implemented in ``R`` and is available under ``MATSimAPI/Rapi``. This is an ``R`` package that is installed along with the utility mentioned above. You can start an ``R`` session and inspect the source code as well as its documentation using the following ``R`` command:

.. code:: R

   help(package = "MATSimAPI")
