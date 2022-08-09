class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :instructor_id
  belongs_to :instructor 
end
