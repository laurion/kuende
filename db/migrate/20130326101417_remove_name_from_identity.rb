class RemoveNameFromIdentity < ActiveRecord::Migration
  def up
    remove_column :identities, :name
  end
  
  def down
    add_column :identities, :name
  end
end
