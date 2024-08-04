require 'elasticsearch/rails/instrumentation'

Elasticsearch::Model.client = Elasticsearch::Client.new(log: true)
