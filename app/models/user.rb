class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  extend Enumerize
  scope :student, -> {where(role: :student)}
  has_many :answers, dependent: :destroy
  has_many :tests, foreign_key: 'teacher_id', dependent: :destroy
  validates_presence_of :name
  enumerize :role, in: [:student, :teacher], default: :student

  def generate_api_token
    loop do
      self.api_token = SecureRandom.base64(64)
      break unless self.class.find_by(api_token: api_token)
    end
  end
end
