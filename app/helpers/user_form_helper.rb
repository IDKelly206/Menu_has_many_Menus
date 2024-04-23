module UserFormHelper
  def setup_user(user)
    user.dietary_restrictions ||= DietaryRestriction.new
    (Health.all - user.healths).each do |health|
      user.dietary_restrictions.build(health: health)
    end
    #  user.dietary_restrictions.sort_by { |dr| dr.health.parameter }
    user
  end
end
