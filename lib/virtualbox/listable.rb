module VirtualBox::Listable
  def self.included(base)
    base.extend ClassMethods
  end

  
  module ClassMethods
    def value_adapter(key, value, new_value)
      value_adapters[key] ||= {}
      value_adapters[key][value] = new_value
    end

    def value_adapters
      @@value_adapters ||= {}
    end
    
    def adapt_value(key, value)
      if value_adapters.has_key? key
        if value_adapters[key].has_key? value
          value = value_adapters[key][value]
        end
      end
      value
    end
    
    # Parses the raw output of virtualbox list into objects. #
    # **This method typically won't be used except internally.**
    #
    # @return [Array<Object>]
    def parse_raw(raw)
      parse_blocks(raw).collect { |v| new(v) }
    end

    # Parses the blocks of the output from virtualbox. VirtualBox outputs
    # listings in "blocks" which are then parsed down to their attributes.
    #
    # **This method typically won't be used except internally.**
    #
    # @return [Array<Hash>]
    def parse_blocks(raw)
      raw.split(/\n\n/).collect { |v| parse_block(v.chomp) }.compact
    end

    # Parses a single block from VirtualBox output.
    #
    # **This method typically won't be used except internally.**
    #
    # @return [Hash]
    def parse_block(block)
      return nil unless block =~ /^(.+?):\s+(.+?)$/
      obj = {}

      # Parses each line which should be in the format:
      # KEY: VALUE
      block.split("\n").each do |line|
        next unless line =~ /^(.+?):\s+(.+?)$/
        value = $2.to_s
        key = $1.downcase.to_sym
        value = adapt_value(key, value)
        obj[key] = value
      end

      # If we don't have a location but have a path, use that, as they
      # are equivalent but not consistent.
      obj[:location] = obj[:path] if obj.has_key?(:path)

      obj
    end
  end
end
