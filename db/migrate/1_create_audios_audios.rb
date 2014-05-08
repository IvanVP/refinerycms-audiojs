class CreateAudiosAudios < ActiveRecord::Migration

  def up
    create_table "refinery_audios", :force => true do |t|
      t.integer  "position"
      t.string   "config"
      t.string   "title"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-audios"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/audios/audios"})
    end

    drop_table :refinery_audios

  end

end
