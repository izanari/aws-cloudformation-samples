# AWS CloudFormation template Samples
CloudFormation templateのサンプルです
## 環境
```
aws --version
aws-cli/1.16.90 Python/3.7.2 Darwin/17.7.0 botocore/1.12.80
```

## テンプレートを記述時、よくみるページ
- パラメータ
  - [パラメータ](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html)
- 組み込み関数
  - [組み込み関数リファレンス](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)
- 出力
  - [出力](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/outputs-section-structure.html)


## サンプル
- [Lambda+CloudWatch Event](./lambda/README.md)
  - CloudWatch EventからLambda関数をエイリアス付きで呼び出すサンプルです。
- [CloudFront+S3](./s3/README.md)
  - CloudFront -> s3 へ静的HTMLを配信するサンプルです。
- [Certificate Manager](./acm/README.md)
  - ACMへサーバ証明書の発行リクエストをするサンプルです。 
- [API gateway + Lambda](./apigateway/README.md)
  - SAMを使ってAPI gatewayとLambdaを作成するサンプルです。
  - SAMのざっくりとした使い方もまとめてあります。

