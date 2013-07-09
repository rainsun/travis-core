module Travis
  module Services
    class UpdateMetadata < Base
      register :update_metadata

      def run
        metadata.update_attributes!(attributes)

        metadata
      end

      private

      def metadata
        metadata_provider.metadata_for_job(params[:job_id])
      end

      def metadata_provider
        MetadataProvider.authenticate_provider(params[:username], params[:key])
      end

      def attributes
        params.slice(:description)
      end
    end
  end
end
