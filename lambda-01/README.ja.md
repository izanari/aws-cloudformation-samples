# AWS CloudFormation Sample
CloudFormationのテンプレートサンプルです。Lambda 関数とCloudwatchイベントを作成します。
## 作成するリソース
- Lambda Function
- IAM Role
- Cloudwatch Logs
- CloudWatch Event
## パラメータ
- CodeBucket（必須）
  - Lambdaのソースコードを置いてあるバケット。s3:// は不要です。例：mybucket
- CodeKey（必須）
  - LambdaのソースコードをZIP化したオブジェクトのKEY。先頭の/は不要です。例：work/sample.zip
- Funcname
  - Lambda Functionの名前
  - デフォルト値は、sample-cf-lambda01
- Environment
  - dev,stg,prodのどれかを入力する
  - デフォルト値はdev
## 実行方法
```
aws cloudformation deploy --template-file template.yml --stack-name {your stacj name} --capabilities CAPABILITY_IAM --profile { your aws profile name} --parameter-overrides CodeBucket={your bucket name} CodeKey={your code key} Funcname={your func name} Environment=dev