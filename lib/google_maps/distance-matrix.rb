# frozen_string_literal: true

require File.expand_path('api', __dir__)

module Google
  module Maps
    class DistanceMatrix
      attr_accessor :origins, :destinations, :options

      def initialize(origins, destinations, options = {})
        options = { language: options } unless options.is_a? Hash
        @origins = origins
        @destinations = destinations
        @options = { language: :en }.merge(options)
      end

      # def method_missing(method_name, *args, &block)
      #   if matrix.key?(method_name)
      #     matrix.send(method_name)
      #   else
      #     super
      #   end
      # end

      # def respond_to_missing?(method_name, include_private = false)
      #   matrix.key?(method_name) || super
      # end

      # def get_element(row_index, col_index)
      #   if (row = matrix[row_index]).present?
      #     row.elements&[col_index]
      #   end
      # end

      # private

      def matrix
        @matrix ||= API.query(:distance_matrix_service, @options.merge(
          origins: origins_string,
          destinations: destinations_string
        ))
      end

      private

      def origins_string
        if origins.is_a? String
          origins
        else
          origins.join('|')
        end
      end

      def destinations_string
        if destinations.is_a? String
          destinations
        else
          destinations.join('|')
        end
      end
    end
  end
end