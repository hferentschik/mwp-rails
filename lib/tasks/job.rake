namespace :job do
  desc "Run a job the mwp-rails application"
  task :run do
    # Your job code would go here

    Rake::Task["job:notify"].invoke
  end

  desc "Notify Prometheus of a job"
  task :notify do
    mp = MetricsPush.new
    mp.counter(:test, "A test counter for a job").increment({ service: 'mwp-rails-deploy', deployment_time: Time.now })
    mp.push
  end
end