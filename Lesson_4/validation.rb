module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, type, *args)
      @validations ||= []
      @validations << { name: name.to_sym, type: type, args: args}
    end
  end

  module InstanceMethods
    def validate!
      #require 'pry'; binding.pry
      if self.class.superclass == Object
        src = self.class
      else
        src = self.class.superclass
      end    

      src.validations.each do |validation|
          name = validation[:name]
          type = validation[:type]
          args = validation[:args]
  
          send("validate_#{type}", name, *args)
      end
    end

    def validate_presence(name)
      #require 'pry'; binding.pry
      #puts name
      value = instance_variable_get("@#{name}".to_sym)
      #puts value
      raise 'Атрибут не может быть пустым!' if value == '' || value.nil?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}".to_sym)
      raise 'Атрибут должен соответствовать формату!' if value !~ format
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}".to_sym)
      raise "Тип не соответствует!" unless value.is_a?(type)
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end

