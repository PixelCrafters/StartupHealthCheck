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

First install Homebrew to install RVM.
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

Install RVM with homebrew.

```
\curl -sSL https://get.rvm.io | bash -s stable
```

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
  elasticsearch -D es.config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
```

If you get errors, ensure you have the latest version of Java 1.7. Ensure you have JDK, not the JRE of Java.

Clone the repository from git:
```
  git clone git@github.com:PixelCrafters/StartupHealthCheck.git
```

```
Install Postgree, the best thing since MySQL. You can install Postgres with brew
```
brew install postgresql
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

First you need to intialize the database if you are on a Mac. You must intitalize the database.
```
  initdb /DIRECTOR/YOU/WANT/TO/INSTALL/IT/data -E utf8
```

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

### Signing up for Auth0

Go to [https://auth0.com/] and create a free account.

Create a auth0 domain. You can use your sweet name or whatevs.

Turn on Facebook, Linked in, Twitter and Google. These are the four ways to sign in via Auth0.

Add a new application. Click on ruby on rails. The friendly name should be We Are YVR.

It will ask you for what you'd like to set up.

```
![The settings you want for Auth0](/app/themes/weareyvr/assets/images/weareyvr/Auth0SocialConnections.png)
```

The long explanation is already built in. You need to grab the keys out of this and put it into .env file.

Go to Applications, click on WeAreYVR and change the "CHANGE-TO-YOUR-PORT" to 3000.

```
![Settings for Port](/app/themes/weareyvr/assets/images/weareyvr/changeToYourPort.png)
```
Next update the .env file with Domain, Client Id, Callback_url, and Secret.

### Launching the first server

Next, open your browser of choice, and visit localhost:3000. The first thing to do is sign in with Twitter or Facebook.

### Running Tests

### Configuring the Application for Development and Test Environments

We use the [dotenv-rails gem](https://github.com/bkeepers/dotenv) to populate environment variables for development and test environments. To configure your application you will need to create a .env file in the root directory of your application. See the .env.example file to get started.

After you have your database schema set up and .evn file ready, you can begin running tests with either RSpec (https://github.com/rspec/rspec) or Cucumber (http://cukes.info).

To run Cucumber:
```
  cucumber
```

To run RSpec:
```
  rspec spec
```

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
