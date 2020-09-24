class Appointment < ApplicationRecord
  include ActiveModel::Transitions

  state_machine :initial => :pending do
    state :pending
    state :approved
    state :completed
    state :cancle
    event :approve do
      transitions to: :approved, from: :pending
    end
    event :complete do
      transitions to: :completed, from: :approved
    end
    event :cancel do
      transitions to: :cancel, from: :pending
    end
  end

  sequenceid :hospital, :appointments
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :patient
  belongs_to :availability
  has_many :prescribed_medicines, dependent: :destroy
  has_many :medicines, through: :prescribed_medicines
  has_one :feedback, dependent: :destroy
  validates_uniqueness_of :date, scope: :availability_id
  default_scope { where(hospital_id: Hospital.current_id) }
end
