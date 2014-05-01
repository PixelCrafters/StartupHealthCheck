namespace :data do
  desc "import data from Startup Genome API and persist"
  task import: :environment do
    StartupGenome::ImportOrganizations.call
  end
end 
