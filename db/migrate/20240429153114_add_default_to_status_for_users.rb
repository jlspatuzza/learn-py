class AddDefaultToStatusForUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :status, from: nil, to: "visitor"
  end
end
