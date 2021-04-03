module Merchant

  def pagination
    if params[:page] && params[:per_page]
                   Merchant.all.limit(params[:per_page].to_i).offset(params[:per_page].to_i * (@page - 1))
                 elsif params[:page] && !params[:per_page]
                    Merchant.all.limit(20).offset(20 * (@page.to_i - 1))
                 elsif !params[:page] && params[:per_page]
                    Merchant.all.limit(params[:per_page].to_i).offset(params[:per_page].to_i * 0)
                 else
                    Merchant.all.limit(20)
                 end
  end

end
