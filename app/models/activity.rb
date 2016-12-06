class Activity
  include Mongoid::Document
  include AutoId


  store_in database:'space_database'
  embeds_many :candidateInfos

  # 标题
  field :title, type: String
  # 正文
  field :mainbody, type: String
  # 详细信息
  field :detailurl, type: String
  # 最大人数，若为-1则无人数限制
  field :maximum, type: Integer
  # 当前通过人数
  #field :currentaccept, type: Integer
  # 状态
  # 1 已成功举办 2 招募中，不需审核 3 招募中-需要审核 4 招募中-需要706人员帮忙审核 5 活动是否通过待审核 6 活动被拒
  field :state, type: Integer
  # 起止时间
  field :begin_time, type: Time
  field :end_time, type: Time
  # 地点
  field :location, type: String
  # 活动标签
  field :tags, type: Array
end


# 参加人资料 一个数组 每个元素有三栏
# 1 _id 2 avater 头像 3 state 状态
# state: 1 发起人 2 报名成功 3 等待审核
class CandidateInfo
  include Mongoid::Document
  embedded_in :activity
  # 关联的
  field :user_detail_id, type: BSON::ObjectId
  #1 待审批 2 已通过 3 拒绝 4 志愿者/工作人员/嘉宾 5 owner
  field :states, type: Integer, default:"1"
  field :nickname, type: String, default: ""
  field :avater_address, type: String
  field :sign_up_time, type: Time
end
