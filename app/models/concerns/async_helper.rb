# Author: zengtao@gmail.com
# Time:   2020-04-09 20:00
#
module AsyncHelper

  extend ActiveSupport::Concern

  included do

  end

  class_methods do
    def async_helper(*methods)
      methods.map do |method|
        puts method
      end

      return nil
    end
  end
end
