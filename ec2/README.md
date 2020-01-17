# EC2
## セキュリティグループを作成するテンプレート
- ALBとEC2、EC2とRDSのそれぞれのセキュリティグループのテンプレート
  - [securitygroup.yml](./securitygroup.yml)
  - VPCは作成しておく必要があります
  - 開発やテスト中でALBに接続するIPを限定したい場合は、`InboundCidrIp`にIPアドレスを設定してください
