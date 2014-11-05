module SharingTags
  class Configuration

    NETWORKS = %i{ google facebook twitter }

    def initialize
      clear!
    end

    def context(name, &block)
      raise "please define context block params" unless block_given?
      (@contexts[name] ||= Context.new(name)).instance_exec(&block)
    end

    def switch_context(name = nil, *args)
      clean_params!
      @current_context_params = args
      @current_context =
        if name
           @contexts[name]
        else
          default_context
        end
    end

    def clear!
      @contexts = {}
      @default_context = Context.new(:default)
      @current_context = nil
      clean_params!
    end

    def params
      # @params ||= fetch_params
      @params = fetch_params
    end

    def clean_params!
      @params = nil
    end

    private

    def fetch_params
      default_context_params = default_context.params(@current_context_params)
      return default_context_params unless @current_context
      @current_context.params(@current_context_params, default_context_params)
    end

    def current_context
      @current_context || default_context
    end

    def method_missing(method_name, *arguments, &block)
      current_context.send(method_name, *arguments, &block)
    end

    def default_context
      @default_context
    end

  end
end