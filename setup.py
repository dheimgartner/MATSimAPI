from setuptools import setup, find_packages

setup(
    name='MATSimAPI',
    version='0.0.1',
    install_requires=[
      "requests",
    ],
    packages=find_packages('.', exclude=['tests']),
    include_package_data=True,
    scripts=['bin/MATSimAPI'],
    entry_points={
      'console_scripts': [
         'install_Rapi = MATSimAPI.install:install_r_package',
         'uninstall_Rapi = MATSimAPI.install:uninstall_r_package' 
      ] ,
    },
)
