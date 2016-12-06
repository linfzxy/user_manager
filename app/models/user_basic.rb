class UserBasic
  include Mongoid::Document
  #include Mongoid::AutoId
  include AutoId

  store_in database:'space_database'

  has_one :user_detail

  ## Database authenticatable
  field :wx_id,              type: String, default: ""
  #field :encrypted_password, type: String, default: ""
  #field :auth_token,         type: String, default: ""

  ## Recoverable
  #field :reset_password_token,   type: String
  #field :reset_password_sent_at, type: Time

  # 0 被封禁 1 查看活动的权限 2 查看用户的权限 3 参加活动的权限 4 能够发起活动 但需要管理员手动审批的权限 5 能够发起活动 不需要管理员手动审批的权限
  # 6 跨发起者审批用户通过报名的权限 7 可以审批活动 关闭活动的权限 8 管理用户 给予用户0-5状态的权限 9 root权限 给予用户0-8权限的权限
  field :authority,          type: Array, default: ["1","2"]

  # 维护上次访问时间和创建时间
  field :last_access,        type: Time
  field :creation_date,      type: Time
  after_initialize do
    self.creation_date = Time.now if creation_date.blank?
    self.last_access = Time.now
  end

  #设定token 2周后过期
  def token_json
    expire_date=Time.now+1209600
    self.last_access=Time.now
    token={:wx_id=> self.wx_id, :expire_date=> expire_date}
    Token.encode token
  end

  # 新建user_detail 传入map 需要手动save
  def new_detail hash
    detail=UserDetail.new (hash)
    detail.nickname=self.wx_id if !detail.nickname?
    self.user_detail=detail
    detail
  end


end
