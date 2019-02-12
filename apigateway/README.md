# AWS CloudFormation Samples
## Sample01：API GatewayをSAMで作成します
- [テンプレート](template-01.yml)
### SAMを使った場合
- 1. Lambda FunctionとSAMテンプレートを用意します
- 2. Dockerを起動しておきます
- 3. ローカル環境でテストします
  - `sam local start-api -t template.yml --profile hogehoge`
- 4. デプロイの準備をします
  - `sam build -t template.yml --profile hogehoge`
    - `-b`を指定するとアーティファクトの保存先を指定できます。指定が無い場合は、`.aws-sam`に保存されます。
    - Pythonの場合は、`requirements.txt`が必要です
- 5. ソースコードをS3へアップロードします
  - `sam package --s3-bucket bucket-name --output-template outputtemplate.yml --profile hogehoge`
    - `--output-template`で出力されたymlにS3への保存先が書き込まれます
    - ここで作成されるoutput-templateはbuildして生成されたテンプレートファイルを元にしています。よって、buid後に、SAMテンプレートを書き換えた場合は、`sam build`からやり直しましょう。
- 6. デプロイをします
  - `aws cloudformation deploy --template-file outputtemplate.yml --stack-name hogestack --paramter-overrides 'param1=value1 param2=value2' --profile fork_y.izawa`


#### SAMのコマンドリファレンス
- [AWS SAM CLI Command Reference](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-command-reference.html)
