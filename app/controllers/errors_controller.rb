class ErrorsController < ActionController::Base
  def not_found
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '404.html') }
      format.json { render :json => {:error => "404 Not found"}.to_json, :status => 404 }
    end
  end

  def exception
    respond_to do |format|
      format.html { render :file => File.join(Rails.root, 'public', '500.html') }
      format.json { render :json => {:error => "500 Internal Server Error"}.to_json, :status => 500 }
    end
  end
end