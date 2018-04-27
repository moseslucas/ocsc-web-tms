class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name, null:false
      t.string :description
      t.string :address
      t.string :contact, limit:30
      t.string :email
      t.integer :status, limit:1, default:1, null:false

      t.string :branch, array:true, default: ["master"]
      t.string :id_from_branch, array:true, default:[]

      t.timestamps
    end
  end
end
