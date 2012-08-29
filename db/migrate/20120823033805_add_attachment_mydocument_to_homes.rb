class AddAttachmentMydocumentToHomes < ActiveRecord::Migration
  def self.up
    change_table :homes do |t|
      t.has_attached_file :mydocument
    end
  end

  def self.down
    drop_attached_file :homes, :mydocument
  end
end
