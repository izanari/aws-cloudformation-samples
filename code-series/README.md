# codeシリーズ
## EC2（非LB環境）へのdeploy
- roleは事前に作成しておくこと
- S3などのバケットも事前に作成しておくこと
### テンプレート
- [roleを作成する](./1/iam-role.yml)
- [codedeploy+codepipeline](./1/codepipeline.yml)
### 参考ドキュメント
- [CodeDeploy でデプロイグループのインスタンスにタグを付ける](https://docs.aws.amazon.com/ja_jp/codedeploy/latest/userguide/instances-tagging.html)
  - タグの指定方法はこのドキュメントを参考にすること