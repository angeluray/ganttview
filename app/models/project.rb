class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates_presence_of :project_name
end
