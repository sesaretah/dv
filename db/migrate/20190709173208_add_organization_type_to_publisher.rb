class AddOrganizationTypeToPublisher < ActiveRecord::Migration
  def change
    add_column :publishers, :organization_type, :integer
  end
end
