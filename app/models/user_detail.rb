class UserDetail
  include Mongoid::Document
  include AutoId


  store_in database:'space_database'
  embeds_many :activities
  #
  field :email,              type: String, default:""
  #0 undef 1 female 2 male
  field :gender,             type: Integer, default:""
  # 昵称
  field :nickname,           type: String, default:""
  # 头像
  field :avater_address,     type: String, default:""
  field :introduction,       type: String, default:""
  # 标签
  field :tags,               type: Array
  belongs_to :user_basic
  index({ user_basic_id: 1 }, { background: true })

  # # 新建user_detail 传入map 需要手动save
  # def self.new_with_default_nickname hash,user
  #   detail=UserDetail.new (hash)
  #   detail.nickname=user.wx_id if !user.nil? && !detail.nickname?
  #   user.user_detail=detail
  #   detail
  # end

  # 发起新活动
  def new_activity hash
    activity=Activity.new hash
    CandidateInfo

  end



end

class ActivityInfo
  include Mongoid::Document
  embedded_in :user_detail
  # 关联的
  field :activity_id, type: BSON::ObjectId
  #1 待审批 2 已通过 3 拒绝 4 志愿者/工作人员/嘉宾 5 owner
  field :states, type: Integer, default:"1"
  field :activity_title, type: String, default: ""
  field :activity_time, type: Time
end