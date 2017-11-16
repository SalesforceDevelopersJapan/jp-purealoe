# ピュアアロエ - サンプルアプリケーション

ピュアアロエはモダンなアプリケーションを高速に開発できるSalesforce Platformのパワーを体感するためのデモアプリケーションです。Dreamforce 17 の Developer Keynoteで紹介されたデモンストレーションをベースに、誰でも利用できるようにしています。

## インストール手順

以下のコマンド内の \*アスタリスク\* で囲まれている箇所をダミーのテキストから、あなたのSalesforce DXでセットアップした値に置き換える必要があります。

1. Hub組織に認証を行います (まだ済んでない場合)
    ```
    sfdx force:auth:web:login -d -a *ハブ組織のエイリアス名*
    ```

1. ピュアアロエリポジトリをコピー:
    ```
    git clone https://github.com/mokamoto/purealoe
    cd purealoe
    ```

1. スクラッチ組織を生成し、エイリアス名を設定する (例: purealoe):
    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a *purealoe*
    ```

1. アプリをスクラッチ組織へプッシュする:
    ```
    sfdx force:source:push
    ```

1. purealoe 権限セットをデフォルトのユーザへアサインする:
    ```
    sfdx force:user:permset:assign -n purealoe
    ```

1. サンプルデータを読み込む:
    ```
    sfdx force:data:tree:import --plan ./data/Harvest_Field__c-plan.json
    sfdx force:data:tree:import --plan ./data/Merchandise__c-plan.json
    ```

1. スクラッチ組織を起動する:
    ```
    sfdx force:org:open
    ```