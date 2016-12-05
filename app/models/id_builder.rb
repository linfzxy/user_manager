#
# 用于管理其他 model 自动增长的 ID 的 model
# from http://www.tuicool.com/articles/Ib6VZ3
#
class IdBuilder
  include Mongoid::Document
  store_in database:'space_database'

  field :model
  field :current, type: Integer, default: 1

  validates :model, presence: true, uniqueness: true

  class << self
    #
    # 创建一个新的计数器，并将计数器加一
    #
    def build(model)
      item = find_entry(normalize_arg(model))
      id = item.current
      item.update(current: id + 1)
      id
    end

    #
    # 重置计数器为 1
    #
    def reset(model)
      find_entry(normalize_arg(model)).update(current: 1)
    end

    #
    # 返回当前计数器的值
    #
    def current(model)
      find_entry(normalize_arg(model)).current
    end

    #
    # 找到相应的记录，没找到则创建一个
    #
    def find_entry(model)
      find_or_create_by(model: normalize_arg(model))
    end

    #
    # 将参数统一转成大写字母开头的字符串
    #
    # normalize_arg(:post)	# => 'Post'
    #
    def normalize_arg(model)
      model.capitalize.to_s
    end
  end
end