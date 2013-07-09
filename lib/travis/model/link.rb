require "active_record"

class Link < ActiveRecord::Base
  belongs_to :job

  attr_accessible :source_name, :description, :url, :job_id
end
