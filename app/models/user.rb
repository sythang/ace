class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  extend Enumerize
  validates_presence_of :name
  enumerize :role, in: [:student, :teacher], default: :student
end
