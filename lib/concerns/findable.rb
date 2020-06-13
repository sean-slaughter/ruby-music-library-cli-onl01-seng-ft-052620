module Concerns::Findable

    def find_by_name(name)
        self.all.find {|i| i.name == name}
    end

    def find_or_create_by_name(name)
      output = nil
      self.find_by_name(name) ? output = self.find_by_name(name) : output = self.create(name)
      output
    end

end

    