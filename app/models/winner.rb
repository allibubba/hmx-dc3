class Winner

  def self.all
    locales = ['United States', 'France', 'Great Britan', 'India']
    full_list = []
    
    locales.each do |locale|
      full_list << {locale => by_locale(locale)}
    end
    full_list
  end

  def self.by_locale locale
    n = User.where(:country => locale).map{|u| u.winners}
    n.flatten!
  end
end

