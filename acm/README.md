# CloudFormation template sample
Amazon Certificate Serviceを使ってサーバー証明書をリクエストする
## 作成されるリソース
- ACMCertificate

## 注意事項
- このテンプレートではリクエストのみを行う。戻り値でCNAMEを取得できないため、手動でRoute53等のDNSへ登録を行う必要があります。
