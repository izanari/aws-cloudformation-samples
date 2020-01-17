# IAM
## ポリシーを作ってロールにアタッチするテンプレート
- `AWS::IAM::Policy`はインライン用のリソースのため、`AWS::IAM::ManagedPolicy`を使う
```
AWSTemplateFormatVersion: 2010-09-09
Description: |
  
Parameters:
  Env:
    Type: String
    Default: dev 
    AllowedValues:
      - dev
      - stg
      - prod
  Prefix:
    Type: String
    Default: 'dev-v2'

Resources:
  TestRole:
    Type: "AWS::IAM::Role"
    Properties:
      AssumeRolePolicyDocument: {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Sid": "",
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ec2.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        }
      Description: "This is test"
      RoleName: !Sub ${Prefix}-TestRole

  TestPolicy:
    Type: "AWS::IAM::ManagedPolicy"
    Properties:
      #Groups:
      #  - String
      PolicyDocument: {
          "Version": "2012-10-17",
          "Statement": [
              {
                "Effect": "Allow",
                "Action":[ 
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:PutObjectAcl",
                    "s3:GetEncryptionConfiguration"
                ], 
                "Resource": "*"
              }
          ]
      }
      ManagedPolicyName: !Sub ${Prefix}-TestPolicy
      Roles:
        - !Ref TestRole
```