module Travis
  module Services
    class FindLinks < Base
      register :find_links

      def run
        if params[:ids]
          scope(:link).where(id: params[:ids])
        elsif params[:job_id]
          scope(:link).where(job_id: params[:job_id])
        else
          []
        end
      end
    end
  end
end
