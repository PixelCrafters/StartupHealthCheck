module StartupGenome
  class StoreType
    include Service

    attr_reader :type_hash, :organization

    def initialize(type_hash, organization)
      @type_hash = type_hash
      @organization = organization
    end

    def call
      store_type(type_hash, organization)
    end

    private

    def store_type(type_hash, organization)
      type = map_type(type_hash['slug'])
      if type.present? && !organization.types.include?(type)
        organization.types << type
        puts "Successfully added type #{type.name} to #{organization.name}"
        type
      else
        nil
      end
    end

    def map_type(type_slug)
      case type_slug
      when "startups"
        Type.where(name: "Startup").first
      when "investors" || "venture_capital" || "angel_group" || "seed_fund" || "corporate_fund"
        Type.where(name: "Investors").first
      when "events"
        Type.where(name: "Events").first
      when "accelerator" || "incubator"
        Type.where(name: "Accelerator/Incubator").first
      when "community_enabler" || "coworking_space" || "hackerspace" || "non_profit" || "association" || "foundation" || "online_community" || "other"
        Type.where(name: "Community Enabler").first
      when "media_press"
        Type.where(name: "Media").first
      when "academic"
        Type.where(name: "Academic").first
      when "government"
        Type.where(name: "Government").first
      else
        nil
      end
    end

  end
end
