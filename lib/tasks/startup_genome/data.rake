namespace :data do
  desc "import data from Startup Genome API and persist"
  task import: :environment do
    StartupGenome::ImportOrganizations.call
  end

  desc "push organization data to Startup Genome"
  task push: :environment do
    StartupGenome::PushOrganizationData.call
  end
end 
