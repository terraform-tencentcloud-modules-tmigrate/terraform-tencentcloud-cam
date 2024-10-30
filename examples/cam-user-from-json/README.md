# CAM policy exmaple

Configuration in this directory creates CAM groups, users and policies.


## Usage

To run this example you need to execute:

> Prepare user information

```bash 

{
    "user1": {
        "email": "test_user1@abc.com", # email of user 
        "user_remark": "user1",
        "password": "Passw0rd!@#",   # password of user, if you want use a random password, comment this value
        "phone_num": "13800138000",
        "country_code": "86",
        "need_reset_password": true, # user will be forced resting password after the first login.
        "console_login": true,
        "use_api": true
    },
    "user2": {
        "email": "test_user2@abc.com",
        "user_remark": "user2",
        "password": "Passw0rd!@#",
        "phone_num": "13800138000",
        "country_code": "86",
        "need_reset_password": false,
        "console_login": true,
        "use_api": true
    }
}


```

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
