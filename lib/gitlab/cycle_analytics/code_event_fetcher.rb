module Gitlab
  module CycleAnalytics
    class CodeEventFetcher < BaseEventFetcher
      include MergeRequestAllowed

      def initialize(*args)
        @projections = [mr_table[:title],
                        mr_table[:iid],
                        mr_table[:id],
                        mr_table[:created_at],
                        mr_table[:state],
                        mr_table[:author_id]]
        @order = mr_table[:created_at]

        super(*args)
      end

      private

      def serialize(event)
        AnalyticsMergeRequestSerializer.new(project: @project).represent(event)
      end
    end
  end
end
