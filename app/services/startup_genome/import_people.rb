module StartupGenome
  class ImportPeople
    include Service

    def call
      offset = 0
      begin
        results = StartupGenome::API.new.get_people(offset)
        persist(JSON.parse(results.body))
        offset = offset + 100
      end while JSON.parse(results.body).count == 100
    end
  
    private

    def persist(users)
      users.each do |user|
        StartupGenome::StoreUser.call(user)
      end
    end
  end
end
