# It's just a example of refactoring of validations

class AdTemplate < ApplicationRecord
  validate :placeholders_absence, if: :static?

  validates :expanded_ad_headline_2, :expanded_ad_headline_1, :expanded_ad_description, presence: true, existing_placeholders: true

  private

  def static?
    ad_type_name == "static"
  end

  def placeholders_absence
    %i(expanded_ad_headline_1 expanded_ad_headline_2 expanded_ad_description).each do |field|
      value = public_send(field)

      return unless value.present?

      errors.add(field, "shouldn't contain placeholders") if placeholders_present?(value)
    end
  end

  def placeholders_present?(value)
    value.scan(/<.*>/).present?
  end
end
