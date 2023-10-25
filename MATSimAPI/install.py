import subprocess
import os


def get_r_package_dir(pkg_path):
    python_script_dir = os.path.dirname(os.path.abspath(__file__))
    r_package_path = os.path.join(python_script_dir, pkg_path)
    return r_package_path


def install_r_package(pkg_path="Rapi"):
    r_package_path = get_r_package_dir(pkg_path)
    try:
        subprocess.run(
            [
                "Rscript",
                "-e",
                f"library(devtools); devtools::install('{r_package_path}')",
            ],
            check=True,
        )
        print(f"R package '{r_package_path}' installed successfully.")
    except subprocess.CalledProcessError as e:
        print(
            f"Error installing the R package (do you have `devtools` installed?): {e}"
        )


def uninstall_r_package(pkg="MATSimAPI"):
    try:
        subprocess.run(["Rscript", "-e", f"remove.packages('{pkg}')"], check=True)
        print(f"Package {pkg} removed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error while removing package `{pkg}`: {e}")


if __name__ == "__main__":
    rpp = get_r_package_dir("Rapi")
    print(rpp)
