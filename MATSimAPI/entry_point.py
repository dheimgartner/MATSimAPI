#!/usr/bin/env python
"""
::

    usage: MATSimAPI [-h] [--port PORT] cmd

    Entry point to interact with the API

    positional arguments:
        cmd          Command to run {install|uninstall|start|stop}

    options:
        -h, --help   show this help message and exit
        --port PORT  Port where the API should run
"""

import argparse

from . import install
from .consume import RApiConsumer


def create_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="MATSimAPI", description="Entry point to interact with the API"
    )

    parser.add_argument("cmd", help="Command to run {install|uninstall|start|stop}")
    parser.add_argument(
        "--port", type=int, default=8000, help="Port where the API should run"
    )

    return parser


def run() -> None:
    p = create_parser()
    a = p.parse_args()

    api = RApiConsumer(port=a.port)

    if a.cmd == "install":
        install.install_r_package()
    elif a.cmd == "uninstall":
        install.uninstall_r_package()
    elif a.cmd == "start":
        api.start_api(silence=False)
        api.wait_for_api()
    elif a.cmd == "stop":
        api.stop_api_by_port(port=a.port)
    else:
        p.print_help()


if __name__ == "__main__":
    run()
