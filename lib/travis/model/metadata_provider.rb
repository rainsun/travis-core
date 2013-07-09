require "active_record"

class MetadataProvider < ActiveRecord::Base
  has_many :metadata

  serialize :api_key, Travis::Model::EncryptedColumn.new

  def self.authenticate_provider(username, key)
    provider = where(api_username: username).first

    provider && provider.api_key == key ? provider : nil
  end

  def metadata_for_job(job_id)
    metadata.where(job_id: job_id).first || metadata.build(job_id: job_id)
  end
end
