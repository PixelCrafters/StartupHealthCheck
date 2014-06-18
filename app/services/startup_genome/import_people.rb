module StartupGenome
  class ImportPeople
    include Service

    def call
      results = StartupGenome::API.new.get_people
      persist(JSON.parse(results.body))

      # TODO: Add Completion Summary "Inserted #{x} and updated #{y}"
    end
  
    private

    def persist(users)
      users.each do |user|
        StartupGenome::StoreUser.call(user)
      end
    end
  end
end
