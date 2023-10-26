from setuptools import setup, find_packages

setup(
    name='MATSimAPI',
    version='0.0.1',
    install_requires=[
      "requests",
      "psutil",
    ],
    packages=find_packages('.', exclude=['tests']),
    include_package_data=True,
    package_data={'MATSimAPI': ['data/*']},
    entry_points={
      'console_scripts': [
        'MATSimAPI = MATSimAPI.entry_point:run'
      ],
    },
)
