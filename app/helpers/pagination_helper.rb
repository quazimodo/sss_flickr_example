module PaginationHelper

  def paginate_links(obj, page_method = :page, pages_method = :pages)

    paginator = PaginateSss.new obj, params, page_method, pages_method

    render partial: "shared/pagination/link", locals: { paginator: paginator }

  end

end
