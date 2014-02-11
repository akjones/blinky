require 'chicanery/jenkins'
require 'chicanery'

module Blinky
  module JenkinsServer
    include Chicanery
     
    def watch_jenkins_server url, options = {}    
      server Chicanery::Jenkins.new 'blinky build', url, options

      when_run do |current_state|
        current_state.has_failure? ? failure! : success!
      end
      
      begin
        run_every 15
      rescue => e
        warning!
        raise e
      end
    end
  end
end
