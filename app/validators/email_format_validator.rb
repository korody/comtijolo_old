class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      object.errors.add(attribute, (options[:message] || :format))
    end
  end
end