namespace :data do
  desc "import organization data from Startup Genome API and persist"
  task import: :environment do
    StartupGenome::ImportOrganizations.call
  end

  desc "push organization data to Startup Genome"
  task push: :environment do
    StartupGenome::PushOrganizationData.call
  end

  desc "import person data from Startup Genome API and persist"
  task import_people: :environment do
    StartupGenome::ImportPeople.call
  end
end 
