module DoctorHelper

  def profile_picture(doctor)
    if doctor.profile_picture.present?
      image_tag doctor.profile_picture.url, class: 'block'
    else
      image_pack_tag 'default_avatar.png', class: 'block'
    end
  end
end
