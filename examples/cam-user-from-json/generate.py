#!/bin/python3

import json

users = {
    "user1": {
        "email": "test_user1@abc.com",
        "user_remark": "user1",
        "password": "Passw0rd!@#",
        "phone_num": "13800138000",
        "country_code": "86",
        "need_reset_password": True,
        "console_login": True,
        "use_api": True
    },
    "user2": {
        "email": "test_user2@abc.com",
        "user_remark": "user2",
        "password": "Passw0rd!@#",
        "phone_num": "13800138000",
        "country_code": "86",
        "need_reset_password": False,
        "console_login": True,
        "use_api": True
    }
}

print(json.dumps(users, indent=4))
