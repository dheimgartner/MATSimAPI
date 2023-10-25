import subprocess
import requests
import time


class RApiConsumer:
    def __init__(self, r_package_name="MATSimAPI", port=8000):
        self.r_package_name = r_package_name
        self.port = port

    def start_api(self):
        try:
            # Run the R script as a background process
            process = subprocess.Popen(
                [
                    "Rscript",
                    "-e",
                    f"library({self.r_package_name}); run(port={self.port})",
                ]
            )

            # Store the process object for later use or termination
            self.api_process = process
        except Exception as e:
            print(f"Error starting the R API: {e}")

    def stop_api(self):
        if self.api_process:
            self.api_process.terminate()
            self.api_process.wait()
            
    def wait_for_api(self, max_retries=10, retry_interval=2):
        for _ in range(max_retries):
            try:
                response = requests.get(f"http://localhost:{self.port}/echo?msg=wait_for_api") # without /echo 404 is returned -> echo to check connection
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