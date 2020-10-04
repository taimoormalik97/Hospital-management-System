ThinkingSphinx::Index.define :medicine, with: :active_record do
  indexes name
  has hospital_id,  type: :integer
end
