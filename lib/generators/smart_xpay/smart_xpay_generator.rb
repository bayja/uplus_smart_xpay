class SmartXpayGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_initializer
    copy_file "initialize_file.rb", "config/initializers/uplus_smart_xpay.rb"
  end

  def generate_routes
    route <<-RUBY
  ## routes for uplus_smart_xpay
  namespace :uplus do
    post "smart_xpay_pay_req_cross_platform" => "smart_xpay#pay_req_cross_platform"
    post "smart_xpay_pay_res" => "smart_xpay#pay_res", as: 'smart_xpay_pay_res'

    match 'cas_note_url' => 'smart_xpay#cas_note_url', as: 'smart_xpay_cas_note_url'
    post 'return_url' => 'smart_xpay#return_url', as: 'smart_xpay_return_url'

    post 'kvpmisp_note_url' => 'smart_xpay#note_url', as: 'smart_xpay_note_url'
    get 'kvpmisp_wap_url' => 'smart_xpay#misp_wap_url', as: 'smart_xpay_misp_wap_url'
    get 'kvpmisp_cancel_url' => 'smart_xpay#cancel_url', as: 'smart_xpay_cancel_url'
  end
RUBY
  end

  def generate_controller
    copy_file "smart_xpay_controller.rb", "app/controllers/uplus_test/smart_xpay_controller.rb"
  end

  def generate_views
    directory "views/uplus", "app/views/uplus"
  end
end
