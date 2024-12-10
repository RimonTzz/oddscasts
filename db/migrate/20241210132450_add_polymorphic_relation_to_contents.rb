class AddPolymorphicRelationToContents < ActiveRecord::Migration[8.0]
  def change
    add_reference :contents, :contentable, polymorphic: true, null: false
  end
end
