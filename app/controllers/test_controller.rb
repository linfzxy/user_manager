class TestController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable the CSRF token
  skip_before_action :verify_authenticity_token
  #skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def test

  end

  def test5
    render plain:FILE_PATH
  end

  #新建用户信息的方法
  def test6
    user=UserBasic.new ({
      :wx_id=>"hellothemongoid2"
      # :tag=>['hello','bby','good']
    })
    user.save
    user.new_detail({
                                             :email=>"hello@q2.com",
            :tags=>[1,2,3,4]
                                         }).save
    render plain:'h'
  end
  def test4
    user=UserBasic.find_by_autoId 2
    puts user.class
    puts user.inspect
    puts user[:wx_id]
    render plain:'h'
  end
  def test2
    user=UserBasic.find_by_autoId 47
    detail=UserDetail.find_by_autoId 17
    # puts detail.user_basic.inspect
    # user.user_detail=detail
    detail.user_basic=user
    detail.save
    # user.save
    render plain:'h'
  end
  def test3
    #render_failed and return
    user=UserBasic.new({
                 :wx_id=> 'hello2',
             })
    detail=UserDetail.new({
        :email=>'hello@qq.com'
                          })
    user.user_detail=detail
    user.save
    detail.save
    render plain:'test'
  end
  def post
    req = ActiveSupport::JSON.decode(request.body.string)
    puts req.class
    render json:req
  end
end
