# AWS CloudFormation Sample
CloudFormationのテンプレートサンプルです。

## 構成について
- S3+CloudFrontでコンテンツを配信する構成です
- サーバ証明書をACMでサーバで取得した場合とインポートした場合に対応させてあります

## 作成するリソース
- CloudFront
- CloudFront Origin Access Identity
- S3 Bucket
- S3 Bucket Policy

## パラメータ
- MyBucketName（必須）
  - コンテンツを置いてあるバケットのバケット名。先頭のs3://は不要です。
  - 例：mybucket
- AliaseURL
  - CloudFrontに設定するCNAME
- AcmArn
  - AWS Certificate Managerでサーバ証明書を取得した場合に入力する
  - 例：arn:aws:acm:us-east-1:1111111111111:certificate/xxxxxx-xxxx-xxxx-xxxx-xxxx
    - us-east-1で取得しましょう。
- IamCertificateId
  - サーバ証明書を自分で取得した場合に入力する
- LogBucket（必須）
  - ログを保存するバケット
  - 例：logs.hogehoge
- LogPrefix
  - ログを保存するバケットに付与するKey
  - 末尾のスラッシュは不要です。テンプレート内で付与しています。
  - デフォルト：CLOUDFRONT
- Environment
  - dev,stg,prodのどれかを入力する
  - デフォルト値はdev

### パラメータの制限事項
- AcmArn/IamCertificateIdを指定した場合、AliaseURLの設定をしてください。その逆もです。
 
## 実行方法
#### CNAME設定あり、サーバ証明書をACMで取得済の場合
```
aws cloudformation deploy --template-file template-01.yml \
--stack-name sample-s3-01-20190118 --capabilities CAPABILITY_IAM \
--profile {your aws profile } --parameter-overrides \
MyBucketName="{Bucket Name}"  AliaseURL="{your url}" \
AcmArn='{ACM ARN}' IamCertificateId="none" \
LogBucket="{Bucket name}" LogPrefix='{Key}' 
```
#### CNAME設定なし、CloudFrontの証明書を利用する場合
```
aws cloudformation deploy --template-file template-01.yml \
--stack-name sample-s3-01-20190118 --capabilities CAPABILITY_IAM \
--profile {your aws profile } --parameter-overrides \
MyBucketName="{Bucket Name}"  AliaseURL="none" \
AcmArn='none' IamCertificateId="none" \
LogBucket="{Bucket name}" LogPrefix='{Key}' 
```

### テンプレート
[テンプレート](./template-01.yml)

# 注意事項
- CloudFrontのenableはfalseにしているので、利用する場合は、trueにしてからdeployしてください
- LogBucketに指定したS3バケットには権限をつけておきましょう