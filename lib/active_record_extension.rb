class ActiveRecord::Base
  def self.money_format(*fields)
    fields.each do |field|
      temp_field = field.to_s.sub(/(_in_cents)/,"")
      define_method("#{temp_field}=") do |value|
        money = value.kind_of?(Money) ? value : Money.new(value)
        return self.send("#{temp_field}_in_cents=",money.cents)
      end
      define_method("#{temp_field}") do
        return Money.create_from_cents(self.send("#{temp_field}_in_cents")) 
      end
    end
  end
end
