class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.inherited(child)
    super

    child.instance_eval do
      @multitenant = true
      def check_if_multitenant?
        @multitenant
      end

      def mark_not_multitenant
        @multitenant = false
      end
    end
    trace = TracePoint.new(:end) do |tp|
      if tp.self == child
        trace.disable
        if !child.abstract_class? && child.check_if_multitenant?
          child.instance_eval do
            default_scope { where(hospital_id: Hospital.current_id) }
          end
        end
      end
    end
    trace.enable
  end
end
