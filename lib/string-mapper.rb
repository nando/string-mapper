require 'active_support'

class String
  def self.add_mapper(name, mappings = {}, &def_val_block)
    accessor = "#{name}_mappings"
    cattr_accessor(accessor)
    self.send accessor + '=', mappings
    define_method "to_#{name}" do
      mapping = nil
      String.send(accessor).each do |key, value|
        regexp = if key.is_a?(Regexp)
          key
        else
          Regexp.new(key.to_s, Regexp::IGNORECASE)
        end
        (mapping = value) && break if self =~ regexp
      end
      mapping || (def_val_block && def_val_block.call(self))
    end
  end
end
