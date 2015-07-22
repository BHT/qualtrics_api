module QualtricsAPI
  class Panel < BaseModel

    attribute :id, String
    attribute :library_id, String
    attribute :name, String
    attribute :category, String

    def members(options = {})
      @members ||= QualtricsAPI::PanelMemberCollection.new(options.merge(id: id))
    end

    private

    def attributes_mappings
      {
        :id => "panelId",
        :library_id => "libraryId",
        :name => "name"
      }
    end
  end
end