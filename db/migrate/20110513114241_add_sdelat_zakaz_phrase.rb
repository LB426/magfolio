class AddSdelatZakazPhrase < ActiveRecord::Migration
  def self.up
    add_column :catalogs, :zakaz_phraze, :text
  end

  def self.down
    remove_column :catalogs, :zakaz_phraze
  end
end
