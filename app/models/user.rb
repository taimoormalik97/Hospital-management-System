class User < ApplicationRecord
	sequenceid :hospital , :users
  belongs_to :hospital
end
