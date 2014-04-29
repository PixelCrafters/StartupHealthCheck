namespace :data do
  desc "import data from Startup Genome API and persist"
  task import: :environment do
    sg = StartupGenome::API.new
    results = sg.get_organizations
    orgs = JSON.parse results.body

    orgs.first[1].each do |org|
      params = { name: org[1]["name"],
                 headline: org[1]["headline"],
                 description: org[1]["description"],
                 hiring_url: org[1]["hiring_url"],
                 active: org[1]["active"],
                 approved: org[1]["approved"],
                 startup_genome_slug: org[1]["slug"],
                 url: org[1]["url"],
                 founded: org[1]["founded"].to_i,
                 startup_genome_id: org[1]["organization_id"] }

      organization = Organization.find_or_initialize_by(startup_genome_id: org[1]["organization_id"])

      if organization.update(params)
        puts "Successfully created/updated #{org[1]["name"]}"
      else
        puts "Failed to update #{org[1]["name"]}"
      end
    end
  end
end 
