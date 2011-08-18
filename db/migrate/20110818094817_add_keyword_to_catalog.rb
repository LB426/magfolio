class AddKeywordToCatalog < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :keywords, :text
  end

  def self.down
    remove_column :catalogs, :keywords
  end
end
