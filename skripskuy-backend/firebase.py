import json

import requests

from skripskuy.settings import FIREBASE_KEY


def push_notification(device_token, title=None, body=None):
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=' + FIREBASE_KEY,
    }

    body = {
        'notification': {
            'title': title,
            'body': body
        },
        'to': device_token,
        'priority': 'high',
    }
    requests.post("https://fcm.googleapis.com/fcm/send", headers=headers, data=json.dumps(body))
