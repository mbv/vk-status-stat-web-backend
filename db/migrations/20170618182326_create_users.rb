Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :vk_id, Numeric
      column :first_name, String
      column :last_name, String
      column :info, String
      column :access_token, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
