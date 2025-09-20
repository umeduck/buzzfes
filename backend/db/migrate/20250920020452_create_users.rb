class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, comment: "ユーザー名"
      t.string :email, null: false, index: { unique: true }, comment: "メールアドレス"
      t.integer :role, null: false, default: 0, comment: "ユーザー権限（0:一般, 1:管理者）"
      t.string :password_digest, null: false, comment: "パスワード（ハッシュ化）"
      t.integer :lock_version, null: false, default: 0
      t.datetime :activated_at, comment: "アクティベート日時"
      t.datetime :deleted_at, default: nil, index: true, comment: "削除日時（論理削除）"

      t.timestamps
    end
  end
end
