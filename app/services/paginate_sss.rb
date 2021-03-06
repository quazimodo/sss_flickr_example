class PaginateSss

  attr_accessor :page, :pages, :params, :path

  def initialize(obj, params = {}, path = "search", page_method = :page, pages_method = :pages)
    @obj = obj
    @params = params.except "action", "controller"
    @page = obj.send(page_method).to_i
    @pages = obj.send(pages_method).to_i
    @path = path
  end

  def url_for(p)

    case p
    when :last
      p = pages
    when :first
      p = 1
    end

    h1 = { "page" => p, "commit" => "paginate_#{p}" }
    h2 = params.merge(h1)

    "/#{path}?" + h2.to_query
  end

  def start_page
    [1, page - 5].max
  end

  def end_page
    [page + 5, pages].min
  end
end
