# AWS CloudFormation Sample
CloudFormationのテンプレートサンプルです。

## Sample01：Cloudwatchイベント(cron)からLambdaを実行する
- [テンプレート](./template-01.yml)
- Lambda Function作成時に、バージョンとエイリアスの作成も行います。
### 作成するリソース
- Lambda Function
- IAM Role
- Cloudwatch Logs
- CloudWatch Event
### パラメータ
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
### 実行方法
```
aws cloudformation deploy --template-file template.yml --stack-name {your stacｋ name} --capabilities CAPABILITY_IAM --profile { your aws profile name} --parameter-overrides CodeBucket={your bucket name} CodeKey={your code key} Funcname={your func name} Environment=dev
```
## Sample02：SAMを使ってLambda関数を作成する
- [テンプレート](./template-02.yml)
### CloudFormationテンプレートとの違い
- Roleとポリシーが未定義でもデフォルトのロールが設定される
- バージョンとエイリアスを自動的に作ってくれる
- Tagsの書き方が違う
- コードの置き場所の書き方が違う

## Sample03：SAMを使ってLambda関数を作成する
- sample02にversionを追加したテンプレ。`AutoPublisAlias`を指定すると自動的にバージョンも生成されるため、このテンプレは使わない。

## Sample04: [SAMの場合] Cloundwatch Events(cron)からLambdaを実行する
### Cronからlambdaを実行するサンプル
- [テンプレート](./template-04.yml)
  - sample01よりも記述が少なくなっている。これはsamが自動的に生成してくれるからで、自動で生成されるのか嫌な場合はsample01のように記述しましょう