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

Startup HealthCheck requires ruby version 2.1.1.
To install ruby we like to use [RVM](http://rvm.io/rvm/install) (but you can use any version manager of your choosing).
```
  rvm install 2.1.1
```

We use [ElasticSearch](http://www.elasticsearch.org/) as our full-text search engine.
Install ElasticSearch (using [Homebrew](http://brew.sh/) or a package manager of your choosing).
```
  brew install elasticsearch
```  

To start ElasticSearch, try this:
```
  elasticsearch -f -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
```

Clone the repository from git:
```
  git clone git@github.com:PixelCrafters/StartupHealthCheck.git
```

Change directories into startuphealthcheck:
```
  cd startuphealthcheck
```  

Run Bundler (http://bundler.io):
```  
  bundle install
```  

Set up your database. 
Start by creating a config/database.yml file with your database settings (based on the config/database.yml.sample file). The following command will create the database, run the migrations and add the seed data to the application.
```
  bundle exec rake db:setup
```

After you've setup your database, you will have two example organizations in the database (Example Startup and Example Startup2). In order to access these organizations via search add data to the search index.
```
  bundle exec rake searchkick:reindex CLASS=Organization
```

Start the rails server:
```  
  rails server
```  

### Running Tests

  
After you have your database schema set up, you can begin running tests with either RSpec (https://github.com/rspec/rspec) or Cucumber (http://cukes.info).


To run Cucumber:
```
  cucumber
```

To run RSpec:
```
  rspec spec
```

### Configuring the Application for Development and Test Environments

Since Heroku requires us to commit secrets.yml, you can add your keys/sensitive information to: ```config/initializers/env/development.env```
```config/initializers/env/test.env``` 

See ```config/initializers/env/development.env.sample``` and ```config/initializers/env/test.env.sample``` to get started.

### Adding Custom Styling

We use the [Themes on Rails](https://github.com/yoolk/themes_on_rails) gem for multi-theme support.

Right now Startup HealthCheck has the following themes:
- Default (app/themes/default)
- WeAreYVR (app/themes/weareyvr)

To change the theme from 'Default' to 'WeAreYVR', replace the following line in app/controllers/application_controller.rb
```
  theme "default"
```
...with...
```
  theme "weareyvr"
```
After you've made this change, restart your server.

To override a view file simple recreate it within your theme directory and make any changes (ie. app/themes/{theme-name}/views/{file-name}).

To create custom themes have a look at the [Themes on Rails](https://github.com/yoolk/themes_on_rails) documentation.
