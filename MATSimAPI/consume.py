"""
.. Could be improved with custom exceptions (?)
"""

import subprocess
import requests
import time
import psutil
import os


class RApiConsumer:
    """
    Handler for R plumber API.

    Starts the API as a background process on a specified port (defaults to 8000)
    """
    def __init__(self, r_package_name: str = "MATSimAPI", port: int = 8000) -> None:
        self.api_process = None
        self.r_package_name = r_package_name
        self.port = port

    def start_api(self, silence: bool = True) -> None:
        try:
            # Run the R script as a background process
            with open(os.devnull, 'w') as devnull:
                std_ = devnull if silence is True else None
                process = subprocess.Popen(
                    [
                        "Rscript",
                        "-e",
                        f"library({self.r_package_name}); run(port={self.port})",
                    ],
                    stdout=std_,
                    stderr=std_
                )

            # Store the process object for later use or termination
            self.api_process = process
        except Exception as e:
            print(f"Error starting the R API: {e}")

    def stop_api(self) -> None:
        if self.api_process:
            self.api_process.terminate()
            self.api_process.wait()

    @classmethod
    def stop_api_by_port(cls, port: int) -> None:
        """
        If the full API process is not handled by one RApiConsumer instance,
        we have to be able to kill the process by specifying the port.

        This function searches for R processes on the specified port and
        kills them.
        """
        for proc in psutil.process_iter(attrs=["pid", "name", "connections"]):
            try:
                if proc.info.get("connections") is not None:
                    for conn in proc.info["connections"]:
                        if conn.laddr.port == port and proc.info["name"] == "R":
                            psutil.Process(proc.info["pid"]).terminate()
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass

    def wait_for_api(self, max_retries: int = 10, retry_interval: int =2) -> None:
        """
        Before we can interact with the API, make sure it is up and running!
        """
        for _ in range(max_retries):
            try:
                response = requests.get(
                    f"http://localhost:{self.port}/echo?msg=wait_for_api"
                )  # without /echo 404 is returned -> echo to check connection
                if response.status_code == 200:
                    return
            except requests.exceptions.RequestException:
                time.sleep(retry_interval)

        print("Unable to connect to the API after multiple retries. Exiting.")

    def __enter__(self):
        self.start_api()
        self.wait_for_api()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.stop_api()


if __name__ == "__main__":
    url = "http://localhost:8000"

    with RApiConsumer(port=8000) as api:
        try:
            response = requests.get(f"{url}/doc?model=all")

            if response.status_code == 200:
                data = response.json()
                print(data)
            else:
                print(f"Request failed with status code: {response.status_code}")
        except requests.exceptions.RequestException as e:
            print(f"Request error: {e}")
