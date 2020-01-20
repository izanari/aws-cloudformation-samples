# EC2
## テンプレート
### 1.セキュリティグループを作成する
- ALBとEC2、EC2とRDSのそれぞれのセキュリティグループのテンプレート
  - [securitygroup.yml](./securitygroup.yml)
  - VPCは作成しておく必要があります
  - 開発やテスト中でALBに接続するIPを限定したい場合は、`InboundCidrIp`にIPアドレスを設定してください

### 2. テンプレートを作成する
- [launchtemplate.yml](./launchtemplate.yml)
  - VPCは作成しておく必要があります

## UserDataのサンプル
- パラメータがある時
  - ただし、パスワードをUserDataに渡すと、EC2インスタンス上にファイルが残ってしまうので、UserDataで渡すべきかどうか確認が必要
```
        UserData:
          Fn::Base64: 
            !Sub |
              #!/bin/bash
              timedatectl set-timezone 'Asia/Tokyo'
              yum -y install mariadb.x86_64;
              yum -y install mariadb-server.x86_64;
              systemctl start mariadb;
              echo "create database powercms character set utf8;" | mysql -u root;
              echo "grant all on ${Dbname}.* to ${DbUserName}@localhost identified by '${DbPassword}';" | mysql -u root;
              mysqladmin -u root password '${RootPassword}';
```
- パラメータが無い場合
```
        UserData:
          Fn::Base64: |
            #!/bin/bash
            timedatectl set-timezone Asia/Tokyo
```