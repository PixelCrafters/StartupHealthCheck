# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create!([{name: 'Employee'}, {name: 'Founder'}])

Organization.create!([
  { name: "Example Startup", 
    slug: "example-startup", 
    headline: "This is the headline", 
    description: "Blue bullet for my valentine choleric chunky boots are too punk confusion hopeless plastic scene self portraits wailing drive a vespa Emo goth kids goth, but less dark and more harry potter hair should be straight, choppy, glossy and textured hearts and skulls inadequate industrial piercing lip piercing middle class more subtle than goth and punk overly emotional pale rites of spring saturnine i heart emo boys overly sensitive Blue care more about appearance than actual emotions discombobulated empty expressive lyrics heartbroken i don't want to be judge i wish my lawn was emo so it would cut itself long fringe melodramatic morose mutual support plastic scene pretending to be sad shy tears vexed vulnerable self-dramatization star tattoos on my hip i read poems to my emo soul mate", 
    hiring_url: nil, 
    active: true, 
    approved: nil, 
    startup_genome_slug: "example-software", 
    url: "http://startupgenome.co/example-software", 
    founded: Date.today, 
    startup_genome_id: nil, 
    claimed: false, 
    hiring: false },
  { name: "Example Startup2", 
    slug: "example-startup-2", 
    headline: "This is the headline", 
    description: "Blue bullet for my valentine choleric chunky boots are too punk confusion hopeless plastic scene self portraits wailing drive a vespa Emo goth kids goth, but less dark and more harry potter hair should be straight, choppy, glossy and textured hearts and skulls inadequate industrial piercing lip piercing middle class more subtle than goth and punk overly emotional pale rites of spring saturnine i heart emo boys overly sensitive Blue care more about appearance than actual emotions discombobulated empty expressive lyrics heartbroken i don't want to be judge i wish my lawn was emo so it would cut itself long fringe melodramatic morose mutual support plastic scene pretending to be sad shy tears vexed vulnerable self-dramatization star tattoos on my hip i read poems to my emo soul mate", 
    hiring_url: nil, 
    active: true, 
    approved: nil, 
    startup_genome_slug: "example-software-2", 
    url: "http://startupgenome.co/example-software-2", 
    founded: Date.today, 
    startup_genome_id: nil, 
    claimed: false, 
    hiring: false } 
])

Address.create!([
  { organization_id: 1,
    latitude: nil,
    longitude: nil,
    zip: "V1A2B3",
    address1: "123 Example Place", 
    address2: nil,
    state: "British Columbia",
    country: "Canada" },
  { organization_id: 2,
    latitude: nil,
    longitude: nil,
    zip: "V1A2B3",
    address1: "123 Example2 Place", 
    address2: nil,
    state: "British Columbia",
    country: "Canada" },
])
