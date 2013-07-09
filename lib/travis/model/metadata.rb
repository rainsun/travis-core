require "active_record"

class Metadata < ActiveRecord::Base
  include Travis::Event

  belongs_to :job

  attr_accessible :source_name, :description, :url, :job_id

  validates :job_id, presence: true
  validates :source_name, presence: true, uniqueness: true
  validates :description, presence: true

  after_create { notify(:create) }
  after_update { notify(:update) }
end
