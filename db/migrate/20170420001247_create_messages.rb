class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content

      t.timestamps
    end
  end
end

=begin

今までデータベースのテーブルを CREATE TABLE ... のように SQL を書いて実行していましたが、 Rails ではマイグレーションファイルというテーブル管理ファイルによって管理・実行することになります。

マイグレーションファイルとは、Rails からデータベースのテーブルを管理するためのファイルです。主に、テーブルを作成・削除したり、カラムを追加・削除に関することがファイル内に記述されます。Rails でテーブルの設定を変更したいときには、マイグレーションファイルを作成し、Rails からマイグレーションを実行します。レッスン後半で、マイグレーションのみを作成する方法も扱います。ここでは、Model を作成するときに同時に生成されるマイグレーションファイルを扱います。

今回 rails g model Message content:string コマンドによって、 db/migrate/20170201092919_create_messages.rb が作成されました。これが、 Message モデルのマイグレーションファイルとなります。

重要なのは、def change ... end 内に書かれているテーブル操作です。create_table :messages do |t| ... end とあります。これは messages というテーブルを作成する命令になります。テーブル名はモデル名の小文字かつ複数形になります。今回は Message モデルを作成したので、messages テーブルが作成されることになりました。この命名規則は Rails によって規定されたルールです。更に中を見ると、 t.string :content, t.timestamps とあります。これが messages テーブルのカラムになります。t.string :content によって content カラムが追加され、 t.timestamps によって created_at と updated_at カラムが追加されることになります。また、明示されていませんが、id カラムも自動的に作成されます。

=end
