class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name, null:false
      t.text :description
      t.string :branch, default: "master"
      t.string :id_from_branch, array:true, default:[]
      t.timestamps
    end
  end
end
