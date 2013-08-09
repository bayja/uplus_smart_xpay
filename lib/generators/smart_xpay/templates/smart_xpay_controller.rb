#encoding: utf-8

module Uplus
  class SmartXpayController < ApplicationController
    skip_before_filter :verify_authenticity_token, except: :pay_req_cross_platform
    layout false

    def pay_req_cross_platform
      @lgd_custom_skin = "blue"
      @lgd_custom_processtype = "TWOTR"
      @cst_window_type = "submit"
      @lgd_custom_rollback = "Y"
      @lgd_kvpmispautoappyn = "Y"

      @uplus_order = UplusSmartXpay::UplusOrder.new({
        lgd_buyer: "개똥이",
        lgd_productinfo: 'test 상품 201',
        lgd_amount: '20100',
        lgd_buyeremail: 'abc@mintshop.com',
        lgd_buyerid: '1234',
        lgd_oid: "test_oid_201",
        lgd_buyerip: '2.2.1.1',
        lgd_custom_firstpay: "SC0010", #신용카드
      })

      @payment_data = {
        'CST_PLATFORM' =>               UplusSmartXpay.cst_platform,
        'CST_WINDOW_TYPE' =>            @cst_window_type,
        'CST_MID' =>                    UplusSmartXpay.cst_mid,
        'LGD_MID' =>                    UplusSmartXpay.lgd_mid,
        'LGD_OID' =>                    @uplus_order.lgd_oid,
        'LGD_BUYER' =>                  @uplus_order.lgd_buyer,
        'LGD_PRODUCTINFO' =>            @uplus_order.lgd_productinfo,
        'LGD_AMOUNT' =>                 @uplus_order.lgd_amount,
        'LGD_BUYEREMAIL' =>             @uplus_order.lgd_buyeremail,
        'LGD_CUSTOM_SKIN' =>            @lgd_custom_skin,
        'LGD_CUSTOM_PROCESSTYPE' =>     @lgd_custom_processtype,
        'LGD_TIMESTAMP' =>              @uplus_order.lgd_timestamp,
        'LGD_HASHDATA' =>               @uplus_order.lgd_hashdata,
        'LGD_RETURNURL' =>              uplus_smart_xpay_return_url_url,
        'LGD_VERSION' =>                "PHP_SmartXPay_1.0",
        'LGD_CUSTOM_FIRSTPAY' =>        @uplus_order.lgd_custom_firstpay,
        'LGD_CUSTOM_ROLLBACK' =>        @lgd_custom_rollback,
        'LGD_KVPMISPNOTEURL' =>         uplus_smart_xpay_note_url_url,
        'LGD_KVPMISPWAPURL' =>          uplus_smart_xpay_misp_wap_url_url("LGD_OID" => @uplus_order.lgd_oid),
        'LGD_KVPMISPCANCELURL' =>       uplus_smart_xpay_cancel_url_url,
        'LGD_KVPMISPAUTOAPPYN' =>       @lgd_kvpmispautoappyn,
        'LGD_CASNOTEURL' =>             uplus_smart_xpay_cas_note_url_url,
        'LGD_RESPCODE' =>               "",
        'LGD_RESPMSG' =>                "",
        'LGD_PAYKEY' =>                 "",
        'LGD_ENCODING' =>               "UTF-8",
        'LGD_ENCODING_RETURNURL' =>     "UTF-8",
        'LGD_ENCODING_NOTEURL' =>       "UTF-8",
      }

      session[:payment_data] = @payment_data
    end


    def pay_res
      uplus_return = UplusSmartXpay::Client.call(params)

      unless uplus_return.succeed?
        return # 결제 실패 처리
      end

      order_detail = uplus_return.parsed_resp
      my_order = MyOrder.new(order_detail)
      if my_order.save
        # 성공 처리
      else
        # 결제 성공, but local db 저장 실패
      end
    end

    def cas_note_url
      # 무통장 할당, 입금 통보 결과처리 페이지
      uplus_return = ::UplusSmartXpay::Return.new(UplusSmartXpay.lgd_mid, params)

      if !uplus_return.valid?
        return # 데이터 위변호 hash값 검증 실패
      end

      if !uplus_return.succeed?
        return # 거래 실패 처리
      end

      case uplus_return.cas_flag
      when "R"
        # 가상계좌 할당 처리
      when "I"
        # 가상계좌 입금확인 처리
      when "C"
        # 가상계좌 입금취소 처리
      end
    end

    def return_url
      puts params_dup = params.dup
      uplus_return = ::UplusSmartXpay::Return.new(UplusSmartXpay.lgd_mid, params_dup)
      if uplus_return.valid?
        @payment_data = session[:payment_data]
        @payment_data["LGD_RESPCODE"] = params["LGD_RESPCODE"]
        @payment_data["LGD_RESPMSG"] = params["LGD_RESPMSG"]
        @payment_data["LGD_PAYKEY"] = params["LGD_PAYKEY"]
        puts "pay_key: #{params['LGD_PAYKEY']}"
      else
        render text: uplus_return.lgd_respmsg
      end
    end


    #### START -- ISP 카드결제 연동중 모바일ISP방식(고객세션을 유지하지않는 비동기방식)의 경우 ###
    def note_url
      # hash data 검증
      uplus_return = ::UplusSmartXpay::Return.new(UplusSmartXpay.lgd_mid, params)
      if !uplus_return.valid?
        # return 데이터 위변호 hash값 검증 실패
        return render text: "NOT OK"
      end

      if !uplus_return.succeed?
        # return 거래 실패 처리
        return render text: "NOT OK"
      end

      # uplus_return.parsed_resp 으로 결제 성공 처리
      render text: "OK"
    end

    def misp_wap_url
      result_type = "1"
      redirect_to "mintshop://order_result?result_type=#{result_type}&order_number=#{params['LGD_OID']}"
    end

    def cancel_url
      result_type = "2"
      redirect_to "mintshop://order_result?result_type=#{result_type}"
    end
    #### END -- ISP 카드결제 연동중 모바일ISP방식(고객세션을 유지하지않는 비동기방식)의 경우 끝 ###

  end
end