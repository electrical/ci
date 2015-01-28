require "mustache"

class LogstashPluginJenkinsJob
  attr_accessor :plugin_name
  attr_accessor :plugin_type

  def initialize(type, name)
    @plugin_type = type.downcase
    @plugin_name = name.downcase
  end

  def job_name
    "Logstash Plugin #{plugin_type.capitalize} #{plugin_name.capitalize} Commit"
  end

  def repo_name
    "logstash-#{plugin_type}-#{plugin_name}"
  end
  alias_method :relative_target_dir, :repo_name

  def project_url
    "https://github.com/logstash-plugins/#{repo_name}"
  end

  def git_url
    "#{project_url}.git"
  end

end

class JobRenderer
  def self.template_path
    File.join(File.dirname(__FILE__), "..", "templates/config.xml")
  end

  def self.render(job)
    template = File.read(template_path)
    Mustache.render(template, job)
  end
end


