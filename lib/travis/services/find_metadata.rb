module Travis
  module Services
    class FindMetadata < Base
      register :find_metadata

      def run
        if params[:ids]
          scope(:metadata).where(id: params[:ids])
        elsif params[:job_id]
          scope(:metadata).where(job_id: params[:job_id])
        else
          []
        end
      end
    end
  end
end
