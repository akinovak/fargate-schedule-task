{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ecs:RunTask"
            ],
            "Effect": "Allow",
            "Resource": [
                "${resource}*"
            ]
        }
    ]
}
