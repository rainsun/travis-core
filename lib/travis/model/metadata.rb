require "active_record"

class Metadata < ActiveRecord::Base
  belongs_to :job

  attr_accessible :source_name, :description, :url, :job_id
end
