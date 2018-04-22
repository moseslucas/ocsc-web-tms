class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null:false
      t.text :description
      t.string :branch, array:true, default: ["master"]
      t.string :id_from_branch, array:true, default:[]
      t.integer :status, limit:1, default:1

      t.timestamps
    end
  end
end
