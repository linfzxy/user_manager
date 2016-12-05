# from http://www.tuicool.com/articles/Ib6VZ3
#module Mongoid
  module AutoId
    extend ActiveSupport::Concern
    included do
      field :auto_id, type: Integer
      index({ auto_id: 1 }, { background: true })

      #
      # 每次调用 Model.new 时会自动填写 auto_id 列
      #
      after_initialize do
        self.auto_id = IdBuilder.build(self.class.name) if auto_id.blank?
      end
      #通用方法 根据autoid查询
      def self.find_by_autoId aid
        self.find_by(auto_id:aid)
      end
    end
  end
#end