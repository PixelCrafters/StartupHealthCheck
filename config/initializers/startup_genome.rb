STARTUP_GENOME_CONFIG = YAML.load_file("#{::Rails.root}/config/startup_genome.yml")[::Rails.env]

# Location slug from Startup Genome
Rails.application.config.startup_genome_location_slug = "vancouver-britishcolumbia-can"
