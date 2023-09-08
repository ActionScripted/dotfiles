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


import http.client
import json
import os
import re
import urllib
from datetime import datetime, timedelta
from types import SimpleNamespace

ASANA_TOKEN = os.environ.get("ASANA_TOKEN")
ASANA_USER = os.environ.get("ASANA_USER")
ASANA_WORKSPACE = os.environ.get("ASANA_WORKSPACE")

# This can be programmatically found via:
# https://developers.asana.com/reference/getusertasklistforuser
ASANA_TASK_LIST = "1200507865494550"

# Get yesterday's date
yesterday = datetime.now() - timedelta(1)
start_date = yesterday.strftime("%Y-%m-%dT00:00:00Z")
end_date = yesterday.strftime("%Y-%m-%dT23:59:59Z")

# Connect to Asana
connection = http.client.HTTPSConnection("app.asana.com")
headers = {"Authorization": f"Bearer {ASANA_TOKEN}", "Content-Type": "application/json"}

args = urllib.parse.urlencode(
    {
        "completed_since": start_date,
        "completed_until": end_date,
        "limit": 100,
        "opt_fields": "name,completed,completed_at",
        "user_task_list": ASANA_TASK_LIST,
    }
)
url = f"/api/1.0/tasks?{args}"

connection.request("GET", url, headers=headers)
response = connection.getresponse()


def is_conventional_commit(string):
    return bool(re.match(r"^([\w-]+)(\(.+\))?: .+$", string))


def task_sorter(task):
    task_lower = task.lower()

    rank_conventional_commit = 1
    rank_type_meeting = 1
    rank_type_review = 1

    if is_conventional_commit(task_lower):
        rank_conventional_commit = 0

    if task_lower.startswith("meeting"):
        rank_type_meeting = 0

    if task_lower.startswith("review"):
        rank_type_review = 0

    return (rank_conventional_commit, rank_type_meeting, rank_type_review, task_lower)


if response.status == 200:
    data = json.loads(response.read().decode())

    tasks = sorted([d["name"] for d in data["data"] if d["completed"]], key=task_sorter)

    for task in tasks:
        print(task)

else:
    print(f"Error with status code: {response.status}: {response.read().decode()}")


connection.close()
