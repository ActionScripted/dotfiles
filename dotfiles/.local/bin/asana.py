#!/usr/bin/env python

"""
# Asana

This was a simple Asana script for tasks, but now is becoming a stand-up thing.

Todo:

- Account for weekends
- Add Confluence activity
- Add GitHub activity
- Add Jira activity

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
from itertools import groupby
from types import SimpleNamespace

ASANA_TOKEN = os.environ.get("ASANA_TOKEN")
ASANA_USER = os.environ.get("ASANA_USER")
ASANA_WORKSPACE = os.environ.get("ASANA_WORKSPACE")

# This can be programmatically found via:
# https://developers.asana.com/reference/getusertasklistforuser
ASANA_TASK_LIST = "1200507865494550"

# Get yesterday's date
today = datetime.now()
yesterday = today - timedelta(1)
start_date = yesterday.strftime("%Y-%m-%dT00:00:00Z")
end_date = today.strftime("%Y-%m-%dT23:59:59Z")

# Connect to Asana
connection = http.client.HTTPSConnection("app.asana.com")
headers = {"Authorization": f"Bearer {ASANA_TOKEN}", "Content-Type": "application/json"}

args = urllib.parse.urlencode(
    {
        "completed_since": start_date,
        "completed_until": end_date,
        "limit": 100,
        "opt_fields": "name,completed,completed_at,memberships,assignee_section.name",
        "user_task_list": ASANA_TASK_LIST,
    }
)
url = f"/api/1.0/tasks?{args}"

connection.request("GET", url, headers=headers)
response = connection.getresponse()


def is_conventional_commit(string):
    return bool(re.match(r"^([\w-]+)(\(.+\))?: .+$", string))


def is_today(date_str):
    today = datetime.today().date()
    task_date = datetime.fromisoformat(date_str).date()
    return task_date == today


def is_yesterday(date_str):
    yesterday = datetime.today().date() - timedelta(days=1)
    task_date = datetime.fromisoformat(date_str).date()
    return task_date == yesterday


def task_sorter(task):
    completed_at = task["completed_at"]
    name_lower = task["name"].lower().strip()

    rank_conventional_commit = 1
    rank_type_meeting = 1
    rank_type_review = 1

    rank_date = 2
    if not completed_at:
        rank_date = 2
    elif is_today(completed_at):
        rank_date = 1
    elif is_yesterday(completed_at):
        rank_date = 0

    if is_conventional_commit(name_lower):
        rank_conventional_commit = 0

    if name_lower.startswith("meeting"):
        rank_type_meeting = 0

    if name_lower.startswith("review"):
        rank_type_review = 0

    return (
        rank_date,
        rank_conventional_commit,
        rank_type_meeting,
        rank_type_review,
        name_lower,
    )


section_order = {"today": 0, "this week": 1, "next week": 2, "later": 3}


def normalized_section_name(task):
    """Returns the normalized section name."""
    return task["assignee_section"]["name"].strip().lower()


if response.status == 200:
    data = json.loads(response.read().decode())

    # First sort by your custom sorter
    tasks_sorted_by_custom = sorted(data["data"], key=task_sorter)

    # Then sort by section name, using section_order to dictate the section order
    sorted_tasks = sorted(
        tasks_sorted_by_custom,
        key=lambda task: section_order.get(normalized_section_name(task), 4),
    )

    # Group tasks by section
    grouped_tasks = groupby(sorted_tasks, key=normalized_section_name)

    if not grouped_tasks:
        print("No tasks found.")

    # Print tasks by group
    for section_name, tasks_in_section in grouped_tasks:
        # Capitalize the section name for display
        print(section_name.capitalize())
        for task in tasks_in_section:
            checkbox = "[X]" if task["completed"] else "[ ]"
            print(f"  {checkbox} {task['name'].strip()}")
        print()  # Add a blank line between sections

    print("---")
    print("This might help, also:")
    print(
        "https://github.com/search?q=is%3Apr+archived%3Afalse+involves%3A%40me+sort%3Aupdated-desc+user%3AStrataOncology+&type=pullrequests"
    )

else:
    print(f"Error with status code: {response.status}: {response.read().decode()}")


connection.close()
