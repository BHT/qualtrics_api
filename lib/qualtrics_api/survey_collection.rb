module QualtricsAPI

  class SurveyCollection
    attr_accessor :scope_id, :surveys

    def initialize(options = {})
      @conn = options[:connection]
      @scope_id = options[:scope_id]
      @surveys = []
    end

    def fetch(options = {})
      update_query_attributes options
      parse_fetch_response(@conn.get('surveys', query_params))
      self
    end

    def query_attributes
      {
        :scope_id => @scope_id
      }
    end

    def update_query_attributes(new_attributes = {})
      @scope_id = new_attributes[:scope_id] if new_attributes.has_key? :scope_id
    end

    private

    def attributes_mapping
      {
        :scope_id => "scopeId"
      }
    end

    def query_params
      query_attributes.map do |k, v|
        [attributes_mapping[k], v] unless v.nil? || v.empty?
      end.compact.to_h
    end

    def parse_fetch_response(response)
      @surveys = response.body["result"].map do |result|
        QualtricsAPI::Survey.new result
      end
    end
  end

end
