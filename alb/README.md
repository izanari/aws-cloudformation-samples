# SAM template 

## 注意事項
- ログを出力するバケットには、事前にポリシーの設定をしておくこと。
  - [参考URL](https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/load-balancer-access-logs.html#access-logging-bucket-permissions)
```
        {
            "Sid": "Stmt1548404407531",
            "Action": [
                "s3:PutObject"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::{BucketName}/{prefix}/AWSLogs/{AccountID}/*",
            "Principal": {
                "AWS": [
                    "582318560864"
                ]
            }
        }

```


