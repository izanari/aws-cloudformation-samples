# AWS CloudFormation template Samples
CloudFormation templateのサンプルです
## 環境
```
aws --version
aws-cli/1.16.90 Python/3.7.2 Darwin/17.7.0 botocore/1.12.80
```
## サンプル
- [Lambda+CloudWatch Event](./lambda/README.md)
  - CloudWatch EventからLambda関数をエイリアス付きで呼び出すサンプルです。
- [CloudFront+S3](./s3/README.md)
  - CloudFront -> s3 へ静的HTMLを配信するサンプルです。
- [Certificate Manager](./acm/README.md)
  - ACMへサーバ証明書の発行リクエストをするサンプルです。 