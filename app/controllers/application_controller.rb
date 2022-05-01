# frozen_string_literal: true

# Rails Application Controller
class ApplicationController < ActionController::Base
  def home
    # WibxRetrieveJob.perform_async
  end

  def select_method; end

  def create_products
    WibxProductCreatorJob.perform_async
  end

  def wibx_retriever
    puts params[:facebook]
    puts params[:master]
    WibxRetrieveJob.perform_async(params[:facebook], params[:master])
  end

  def wibx_farm
    puts params[:facebook]
    WibxFarmJob.perform_async(5000, params[:facebook])
  end

  def remove_cloned
    RemoveClonedLinksJob.perform_async
  end

  def delete_links
    LinksDeleteAllJob.perform_async
  end
end
