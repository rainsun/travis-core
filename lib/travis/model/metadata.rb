require "active_record"

class Metadata < ActiveRecord::Base
  include Travis::Event

  belongs_to :job

  attr_accessible :source_name, :description, :url, :job_id

  after_create { notify(:create) }
  after_update { notify(:update) }

  after_commit(on: :create) do
    notify(:create)
  end

  after_commit(on: :update) do
    notify(:update)
  end
end
