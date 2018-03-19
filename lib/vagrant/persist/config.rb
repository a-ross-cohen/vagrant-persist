module Vagrant
  module Persist
    class Config < Vagrant.plugin(2, :config)
      
      attr_accessor :path
      
      attr_accessor :size
      
      attr_accessor :mount
      
      attr_accessor :user
      
      def path= relative
        @path = File.expand_path relative
      end
      
    end
  end
end