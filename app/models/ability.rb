# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, Patient, hospital_id: user.hospital_id
      can :manage, Doctor, hospital_id: user.hospital_id
      can :manage, Medicine, hospital_id: user.hospital_id
      can :manage, Bill, hospital_id: user.hospital_id
      can %i[create read], PurchaseOrder, hospital_id: user.hospital_id
      can %i[update add_medicine get_medicine remove_medicine], PurchaseOrder do |purchase_order|
        purchase_order.hospital_id == user.hospital_id && purchase_order.drafted?
      end
      can :confirm, PurchaseOrder do |purchase_order|
        purchase_order.hospital_id == user.hospital_id && purchase_order.drafted? && purchase_order.medicines.present?
      end
      can :deliver, PurchaseOrder do |purchase_order|
        purchase_order.hospital_id == user.hospital_id && purchase_order.confirmed? && purchase_order.medicines.present?
      end

      can :destroy, PurchaseOrder do |purchase_order|
        purchase_order.drafted?
      end
      #ability to not delete a medicine if it exists in a purchase detail
      cannot :destroy, Medicine do |medicine|
        PurchaseDetail.where(medicine_id: medicine.id).exists? || BillDetail.where(billable: medicine).exists?
      end
      
      can %i[read update], Admin, hospital_id: user.hospital_id, id: user.id
      can :read, Appointment, hospital_id: user.hospital_id
      can :approve, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.pending?
      end
      can :cancel, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && (appointment.pending? || appointment.approved?)
      end
      can :complete, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.approved?
      end
      can %i[create index read], Prescription do |prescription|
        prescription.hospital_id == user.hospital_id
      end
      can %i[edit update destroy search_medicine], Prescription do |prescription|
        prescription.hospital_id == user.hospital_id && (prescription.appointment.pending? || prescription.appointment.approved? || prescription.appointment.canceled?)
      end
      can :manage, PrescribedMedicine, hospital_id: user.hospital_id
    elsif user.doctor?
      can :index, Patient, Patient.doctor_only(user) do |patient|
        patient
      end
      can :show, Patient do |patient|
        patient.hospital_id == user.hospital_id && patient.appointments.find_by(doctor_id: user.id)
      end
      can :show, Doctor, hospital_id: user.hospital_id, id: user.id
      can :update, Doctor, hospital_id: user.hospital_id, id: user.id
      can %i[new create index destroy], Availability, hospital_id: user.hospital_id, doctor_id: user.id
      can :read, Appointment, hospital_id: user.hospital_id, doctor_id: user.id
      can :approve, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.doctor_id == user.id && appointment.pending?
      end
      can :cancel, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.doctor_id == user.id && (appointment.pending? || appointment.approved?)
      end
      can :complete, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.doctor_id == user.id && appointment.approved?
      end
      can :create, Prescription do |prescription|
        prescription.hospital_id == user.hospital_id
      end
      can %i[index read], Prescription do |prescription|
        prescription.hospital_id == user.hospital_id && prescription.appointment.doctor_id == user.id
      end
      can %i[edit update destroy search_medicine], Prescription do |prescription|
        prescription.hospital_id == user.hospital_id && prescription.appointment.doctor_id == user.id && (prescription.appointment.pending? || prescription.appointment.approved?)
      end
      can :manage, PrescribedMedicine, hospital_id: user.hospital_id
    elsif user.patient?
      can :show, Patient, hospital_id: user.hospital_id, id: user.id
      can :update, Patient, hospital_id: user.hospital_id, id: user.id
      can %i[read speciality_filter], Doctor, hospital_id: user.hospital_id
      can %i[read create show_availabilities], Appointment, hospital_id: user.hospital_id, patient_id: user.id
      can :cancel, Appointment do |appointment|
        appointment.hospital_id == user.hospital_id && appointment.patient_id == user.id && appointment.pending?
      end
      can :read, Prescription do |prescription|
        prescription.hospital_id == user.hospital_id && prescription.appointment.patient_id == user.id
      end
      can :read, PrescribedMedicine, hospital_id: user.hospital_id
      can :read, Bill, hospital_id: user.hospital_id, patient_id: user.id
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
