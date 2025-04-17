#!/usr/bin/env python

"""
ProjectName
--
An empty skeleton project.
"""

__author__ = "Michael Thompson (actionscripted@gmail.com)"
__version__ = "1.0"
__copyright__ = "Copyright (c) Michael Thompson"
__license__ = "BSD-3-Clause"


import argparse
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.FileHandler(f"{__file__}.log"), logging.StreamHandler()],
    level=logging.DEBUG,
)


def main(todo: str) -> None:
    print(todo)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="TODO")
    parser.add_argument("--todo", help="TODO", required=True)

    args = parser.parse_args()
    main(args.todo)
