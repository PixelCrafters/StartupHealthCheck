# Startup HealthCheck

Startup HealthCheck is an open source project designed to power data collection and aggregation for local startup communities. The goal is to gather data around companies, people, events, and jobs.

## StartupGenome

The core of HealthCheck's backend curation around startup company data is powered by the StartupGenome API. We are working with Shane and the StartupGenome team to be a great stand alone client for SG, while also enabling gathering of extra data. In turn, SG provides bulk upload via CSV, map-based visualization, and integration / sync with Crunchbase, Angel List, and others.

## Goals

* turnkey hosting - easy for any community to install their own instance (e.g. Heroku / static web site / etc.)
* brandable - customize with your own community brand & design
* aggregation - limited "original content" creation; aggregation of title + link + limited other metadata for events and jobs -- i.e. not a blogging or content creation platform
* open data - connectivity and re-use of StartupGenome API, plugins for Salesforce, default license that makes data shareable by default


## Team

Startup HealthCheck is a project of the non-profit startup hub / co-working space, [Launch Academy](http://launchacademy.ca/), based out of Vancouver, BC, Canada. [PixelCrafters](http://www.pixelcrafters.ca) is an entrepreneur-led Vancouver tech community group.

Check the Contributors file for a list of the people & companies that are active contributors. We welcome pull requests!

## Collaborating

We are going to be designing and building this out in the open. We are collecting partners and have talked to startup communities in Vancouver, Seattle, Portland, Nanaimo, Victoria, and Toronto. If you are interested in participating, please get in touch or post an [issue](https://github.com/PixelCrafters/StartupHealthCheck/issues).


## QUICKSTART

Ensure you have ruby v 2.1.1p76

Install Elastic Search (using Homebrew or package manager of your choosing)
```
  brew install elasticsearch
```  

Clone the repository from git:
```
  git clone git@github.com:BrewhouseTeam/startuphealthcheck.git
```

Change directories into startuphealthcheck
```
  cd startuphealthcheck
```  

Run Bundler (http://bundler.io)
```  
  bundle
```  

Set up your database. 
Start by creating a config/database.yml file with your database settings (based on the config/database.yml.sample file). The following command will create the database, run the migrations and add the seed data to the application.
```
  bundle exec rake db:setup
```

Start the rails server
```  
  rails server
```  

### Running Tests

  
After you have your database schema set up, you can begin running tests with either RSpec (https://github.com/rspec/rspec) or Cucumber (http://cukes.info).


To run Cucumber
```
  cucumber
```

To run RSpec
```
  rspec spec
```
