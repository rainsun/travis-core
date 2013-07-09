require "active_record"

class Metadata < ActiveRecord::Base
  include Travis::Event

  belongs_to :job
  belongs_to :metadata_provider

  attr_accessible :description, :url, :job_id

  validates :job_id, presence: true
  validates :description, presence: true

  after_create { notify(:create) }
  after_update { notify(:update) }
end
