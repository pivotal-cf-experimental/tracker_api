# TrackerApi

[![Gem Version](https://badge.fury.io/rb/tracker-api.png)](http://badge.fury.io/rb/tracker-api)
[![Build Status](https://travis-ci.org/dashofcode/tracker-api.png?branch=master)](https://travis-ci.org/dashofcode/tracker-api)
[![Code Climate](https://codeclimate.com/github/dashofcode/tracker-api.png)](https://codeclimate.com/github/dashofcode/tracker-api)
[![Coverage Status](https://coveralls.io/repos/dashofcode/tracker-api/badge.png?branch=master)](https://coveralls.io/r/dashofcode/tracker-api?branch=master)
[![Dependency Status](https://gemnasium.com/dashofcode/tracker-api.png)](https://gemnasium.com/dashofcode/tracker-api)

This gem allows you to easily use the [Pivotal Tracker v5 API](https://www.pivotaltracker.com/help/api/rest/v5).

It’s powered by [Faraday](https://github.com/lostisland/faraday) and [Virtus](https://github.com/solnic/virtus).


## Basic Usage

```ruby
Trackher.configure(api_token: 'my-awesome-api-token')                     # Configure with API Token

projects = Trackher::Project.all                                          # Get all projects
project  = Trackher::Project.find(123456)                                 # Find project with given ID

project.all                                                               # Get all stories for a project
project.stories.where(with_state: :unscheduled).limit(10)                 # Get 10 unscheduled stories for a project
project.stories.where(filter: 'requester:OWK label:"jedi stuff"')         # Get all stories that match the given filters
project.stories.find(847762630)                                           # Find a story with the given ID

epics = project.epics                                                     # Get all epics for a project
epic  = epics.first
label = epic.label                                                        # Get an epic's label
```

## Scopes & Eager Loading

```ruby
Trackher.with_token('my-special-api-token') do                            # Use a token for a specific block only
  epics = Trackher::Epic.for_project(@project.id)                         # Get all epics for a project
end

Trackher.configure(api_token: 'my-awesome-api-token')                     # Configure with API Token

Trackher::Iteration.current.for_project(@project.id).first                # Get current iteration for a project
Trackher::Iteration.done.for_project(@project.id)                         # Get all done iterations for a project
Trackher::Iteration.done.offset(-2).for_project(@project.id)              # Get last 2 done iterations for a project

Trackher::Project.where(fields: ':default,labels(name)').find(project_id) # Eagerly get labels with a project
Trackher::Project.where(fields: ':default,epics').find(project_id)        # Eagerly get epics with a project
```

## Contributing

Currently this client only supports read-only access to Pivotal Tracker.
I will be extending it as my use cases require, but am happy to accept contributions.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
