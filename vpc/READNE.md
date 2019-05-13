# VPC
## VPCとサブネットを構築するテンプレート
- [vpc.yml](vpc.yml)
### 構成
- よくある、PublicSubnet->PrivateSubnetの構成です
- ap-northeast-1aとap-northeast-1cを使っています
- CIDRを変更したい場合はテンプレートを弄ってください
- パラメータにはプロジェクト名を渡すようにしてある

## NAT Gatewayを構築するテンプレート
- [natgw.yml](natgw.yml)
### 構成
- PublicSubnet1a上にNATGatewayを構築する
- PrivateRouteTable1aにNATGatewayへのルーティングを追加する
  - PrivateRouteTable1aに関連づいているサブネットにはデフォルトgateway（インターネットGateway）が存在していない想定です
- NAT Gatewayは課金されるため、使わない時には、このスタックは削除しておきましょう