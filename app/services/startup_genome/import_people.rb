module StartupGenome
  class ImportPeople
    include Service

    PER_PAGE = 100

    def call
      offset = 0
      begin
        results_json = StartupGenome::API.new.get_people(offset)
        results = JSON.parse(results_json.body)
        persist(results)
        offset += PER_PAGE
      end while fetch_more?(results)
    end
  
    private

    def fetch_more?(results)
      # fetch only the first page in test env
      results.count == PER_PAGE && !Rails.env.test?
    end
  
    private

    def persist(users)
      users.each do |user|
        StartupGenome::StoreUser.call(user)
      end
    end
  end
end
