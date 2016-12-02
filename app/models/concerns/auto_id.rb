# from http://www.tuicool.com/articles/Ib6VZ3
#module Mongoid
  module AutoId
    extend ActiveSupport::Concern
    included do
      field :auto_id, type: Integer

      #
      # 每次调用 Model.new 时会自动填写 auto_id 列
      #
      after_initialize do
        puts 'hello'
        self.auto_id = IdBuilder.build(self.class.name) if auto_id.blank?
      end
    end
  end
#end