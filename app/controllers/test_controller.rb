class TestController < ApplicationController
  # disable the CSRF token
  protect_from_forgery with: :null_session

  # disable the CSRF token
  skip_before_action :verify_authenticity_token
  #skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  #新建的方法
  def test
    user=UserBasic.new ({
      :wx_id=>"hellothemongoid"
    })
    user.save
    UserDetail.new_with_default_nickname({
                                             :email=>"hello@q.com"
                                         },user).save
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
