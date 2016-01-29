class AddIndexSub < ActiveRecord::Migration
  def change
    add_index :subs, :moderator_id
    add_index :subs, :title
  end
end
