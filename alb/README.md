# Application Load Balancer SAM template 
## ALBを作成するテンプレート
- Application Load Balancerを作成します
- CNAMEで登録され、SSL証明書を関連づけます
- Targetグループはデフォルトで1つだけにしてあります
- ALBのリスナーは80と443/portです
- Route53を利用していることを前提です

### 事前準備
- VPN,Subnetは作成しておく
- EC2インスタンは登録しておく
- セキュリティグループを作成しておく->[alb_ec2_securitygroup.yml](alb/alb_ec2_securitygroup.yml)
  - EC2用のセキュリティグループはEC2に付与しておく
- ALBのCNAMEに対応したSSL証明書を登録しておく
  - Certificate Managerの証明書でかまいません 
- ALBのログを保存するログバケットおよびポリシーの設定をしておく

### 実行方法
- alb_ec2_securitygroup.yml
  - パラメータ
    - ProjectName
      - リソースの接頭辞として使います
    - VpcID
      - リソースを作成するVPCIDを指定する
```
#/bin/sh

aws cloudformation deploy \
 --template-file alb_ec2_securitygroup.yml \
 --stack-name TestALBEC2SG \
 --parameter-overrides ProjectName=project VpcID=vpc-xxxxxxxxxx \
 --profile hogehoge

```
- alb_ec2.yml
  - パラメータ
    - ProjectName
      - リソースの接頭辞に利用します
    - Subnets
      - 異なるゾーンのサブネットIDをカンマ区切りで指定します
      - パブリックとプライベートサブネットが存在する場合は、パブリックサブネットを指定します
    - VpcID
    - LogBucket
      - Logを保存するバケット名を指定します。s3://は不要です。
    - LogPrefix
      - ログを保存するキーを指定します
    - TargetInstance0
      - ターゲットインスタンスを指定します
    - CNAME
      - ALBのCNAMEを指定します
    - HostZoneId
      - CNAMEを登録するRoute53のZoneIDを指定します
    - SSLArn
      - Certificate Managerに登録したSSL証明書を指定します
    - ALBSG
      - ALBのSGのIDを指定します
```
#/bin/sh

aws cloudformation deploy \
 --template-file alb_ec2.yml \
 --stack-name TestALBEC2 \
 --parameter-overrides \
  ProjectName=project \
  Subnets=subnet-xxxx,subnet-xxxx \ 
  VpcID=vpc-xxxx \
  LogBucket='logs.hogebucket' \
  LogPrefix='ALB/project' \
  TargetInstance0=i-xxxxx \
  CNAME=secure.hogehoge.com \
  HostZoneId=XXXXXX  \
  SSLArn=arn:aws:acm:ap-northeast-1:yourid:certificate/xxxxxx \
  ALBSG=sg-xxxx \
--profile fork_y.izawa
```


#### 
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
- {}は各自の環境に応じて変更してください

```

## 参考ドキュメント
- [CloudFormationでALBを構築する](https://dev.classmethod.jp/cloud/aws/cloudformation-alb/)